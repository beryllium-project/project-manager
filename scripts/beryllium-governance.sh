#!/usr/bin/env bash
# HUMAN-RUN installer/checker for Beryllium user-level Copilot CLI governance.
# The Project Manager agent never runs install or uninstall against the real
# user configuration. Maintained tests use only a sandbox COPILOT_HOME.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  beryllium-governance.sh install
  beryllium-governance.sh check
  beryllium-governance.sh uninstall

install copies the Beryllium scope reviewer, scope-management skill, task
hook, and rendered hook configuration into ${COPILOT_HOME:-$HOME/.copilot}.
check is read-only. uninstall removes only exact matching managed files.

Configuration, matcher, and environment changes require a new Copilot CLI
session. A registered command hook executes the installed script path for each
matching call, so replacing that script body can affect an already-running
governed session at its next matching call; that session keeps its loaded
matcher and environment. Agent and skill reread behavior in running sessions
is unknown. Install, reinstall, and uninstall while governed sessions are
idle. Uninstall can leave an already-running registered session pointing at
removed hook or configuration paths.

The script never edits settings.json. User settings must provide a session
default of max reasoning effort and long_context, with plan-specific values
either unset (inherit the session defaults) or explicitly max/long_context.
User hooks must not be disabled. Repository, local, command-line, and live
session overrides are checked by later per-workspace verification.
EOF
}

die() {
    printf 'beryllium-governance: ERROR: %s\n' "$*" >&2
    exit 1
}

ok() {
    printf 'ok   %s\n' "$*"
}

bad() {
    printf 'FAIL %s\n' "$*" >&2
    check_failures=$((check_failures + 1))
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
pm_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve Project Manager root"
parent_root=$(CDPATH= cd -- "$pm_root/.." && pwd -P) ||
    die "cannot resolve canonical parent root"

agent_source=$pm_root/.github/agents/beryllium-scope-review.agent.md
skill_source=$pm_root/.github/skills/beryllium-scope-management/SKILL.md
hook_source=$pm_root/scripts/beryllium-governance-hook.sh
hook_config_source=$pm_root/scripts/beryllium-governance-hook.json.in

copilot_home=${COPILOT_HOME:-${HOME:?HOME is not set}/.copilot}
[[ $copilot_home == /* ]] || die "COPILOT_HOME must be an absolute path"

agent_dest=$copilot_home/agents/beryllium-scope-review.agent.md
skill_dir=$copilot_home/skills/beryllium-scope-management
skill_dest=$skill_dir/SKILL.md
hook_dest=$copilot_home/hooks/beryllium-governance-hook.sh
hook_config_dest=$copilot_home/hooks/beryllium-governance.json
settings=$copilot_home/settings.json

git_parent() {
    env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE \
        -u GIT_OBJECT_DIRECTORY -u GIT_ALTERNATE_OBJECT_DIRECTORIES \
        git -C "$parent_root" "$@"
}

require_tools() {
    local tool
    for tool in jq sha256sum install git realpath mktemp stat; do
        command -v "$tool" >/dev/null 2>&1 ||
            die "required command is unavailable: $tool"
    done
}

require_sources() {
    local source
    for source in "$agent_source" "$skill_source" "$hook_source" \
        "$hook_config_source"; do
        [[ -f $source && ! -L $source ]] ||
            die "managed source is absent or not a regular file: $source"
    done
    [[ -f $parent_root/SOT.md ]] ||
        die "canonical parent root lacks SOT.md: $parent_root"
    git_parent rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
        die "canonical parent root is not a Git worktree: $parent_root"
}

tracked_targets_json() {
    local listing entry metadata path mode target
    local -a targets=()

    listing=$(git_parent ls-files -s --) ||
        die "cannot enumerate tracked parent paths"
    while IFS= read -r entry; do
        [[ -n $entry ]] || continue
        [[ $entry == *$'\t'* ]] ||
            die "malformed tracked-path output from parent repository"
        metadata=${entry%%$'\t'*}
        path=${entry#*$'\t'}
        mode=${metadata%% *}
        [[ $mode == 120000 ]] || continue
        target=$(realpath -e -- "$parent_root/$path") ||
            die "tracked symlink does not resolve: $path"
        targets+=("$target")
    done <<<"$listing"

    if ((${#targets[@]} == 0)); then
        printf '[]\n'
    else
        printf '%s\n' "${targets[@]}" |
            jq -Rsc 'split("\n") | map(select(length > 0)) | unique'
    fi
}

render_hook_config() {
    local targets
    targets=$(tracked_targets_json)
    jq --arg hook "$hook_dest" --arg root "$parent_root" \
        --arg targets "$targets" '
        .hooks.preToolUse[0].exec = $hook |
        .hooks.preToolUse[0].env.BERYLLIUM_PARENT_ROOT = $root |
        .hooks.preToolUse[0].env.BERYLLIUM_TRACKED_TARGETS = $targets
    ' "$hook_config_source"
}

sha_file() {
    sha256sum "$1" | awk '{ print $1 }'
}

sha_text() {
    sha256sum | awk '{ print $1 }'
}

file_mode() {
    stat -c '%a' "$1"
}

check_settings() {
    local disabled_count
    [[ -f $settings ]] || {
        bad "settings file is absent or not readable as a file: $settings"
        return
    }
    if ! jq -e 'type == "object"' "$settings" >/dev/null 2>&1; then
        bad "settings file is not a valid JSON object: $settings"
        return
    fi

    if jq -e '.disableAllHooks == true' "$settings" >/dev/null; then
        bad "disableAllHooks is true"
    else
        ok "disableAllHooks is not enabled"
    fi

    if ! jq -e '(.disabledHooks // []) | type == "array"' \
        "$settings" >/dev/null; then
        bad "disabledHooks is not an array"
    else
        disabled_count=$(jq '(.disabledHooks // []) | length' "$settings")
        if ((disabled_count == 0)); then
            ok "disabledHooks is empty"
        else
            bad "disabledHooks is non-empty; exact hook enablement cannot be proven"
        fi
    fi

    if jq -e '.effortLevel == "max"' "$settings" >/dev/null; then
        ok "user session reasoning default is max"
    else
        bad "user effortLevel must be max"
    fi
    if jq -e '.contextTier == "long_context"' "$settings" >/dev/null; then
        ok "user session context default is long_context"
    else
        bad "user contextTier must be long_context"
    fi
    if jq -e '(.planEffortLevel // .effortLevel) == "max"' \
        "$settings" >/dev/null; then
        ok "user plan reasoning default or fallback is max"
    else
        bad "user plan effort default or fallback must be max"
    fi
    if jq -e '(.planContextTier // .contextTier) == "long_context"' \
        "$settings" >/dev/null; then
        ok "user plan context default or fallback is long_context"
    else
        bad "user plan context default or fallback must be long_context"
    fi
}

check_regular_copy() {
    local label=$1 expected_hash=$2 destination=$3 executable=${4:-0}
    if [[ ! -f $destination || -L $destination ]]; then
        bad "$label is absent or not a copied regular file: $destination"
        return
    fi
    if [[ $(sha_file "$destination") == "$expected_hash" ]]; then
        ok "$label SHA-256 matches"
    else
        bad "$label SHA-256 drift detected"
    fi
    if ((executable)); then
        if [[ -x $destination ]]; then
            ok "$label is executable"
        else
            bad "$label is not executable"
        fi
    fi
}

check_installation() {
    local rendered_config agent_hash skill_hash hook_hash config_hash
    check_failures=0
    require_tools
    require_sources

    rendered_config=$(render_hook_config)
    agent_hash=$(sha_file "$agent_source")
    skill_hash=$(sha_file "$skill_source")
    hook_hash=$(sha_file "$hook_source")
    config_hash=$(printf '%s\n' "$rendered_config" | sha_text)

    check_settings
    check_regular_copy "scope reviewer" "$agent_hash" "$agent_dest"
    check_regular_copy "scope-management skill" "$skill_hash" "$skill_dest"
    check_regular_copy "governance hook" "$hook_hash" "$hook_dest" 1
    check_regular_copy "hook configuration" "$config_hash" "$hook_config_dest"

    if ((check_failures > 0)); then
        printf 'beryllium-governance: %d check(s) failed\n' \
            "$check_failures" >&2
        return 1
    fi
    printf 'beryllium-governance: all checks passed\n'
}

rollback_committed_files() {
    local rollback_i rollback_failed=0
    for ((rollback_i = ${#destinations[@]} - 1;
        rollback_i >= 0; rollback_i--)); do
        ((committed[rollback_i])) || continue
        if ((had_backup[rollback_i])); then
            if mv -f -- "${backups[$rollback_i]}" \
                "${destinations[$rollback_i]}"; then
                printf 'beryllium-governance: rollback restored %s\n' \
                    "${labels[$rollback_i]}" >&2
            else
                printf 'beryllium-governance: ERROR: rollback could not restore %s: %s\n' \
                    "${labels[$rollback_i]}" \
                    "${destinations[$rollback_i]}" >&2
                rollback_failed=1
            fi
        elif rm -f -- "${destinations[$rollback_i]}"; then
            printf 'beryllium-governance: rollback removed newly installed %s\n' \
                "${labels[$rollback_i]}" >&2
        else
            printf 'beryllium-governance: ERROR: rollback could not remove newly installed %s: %s\n' \
                "${labels[$rollback_i]}" \
                "${destinations[$rollback_i]}" >&2
            rollback_failed=1
        fi
    done
    ((rollback_failed == 0))
}

verify_committed_files() {
    local i
    check_failures=0
    check_settings
    for i in "${!destinations[@]}"; do
        if [[ ! -f ${destinations[$i]} || -L ${destinations[$i]} ]]; then
            bad "installed ${labels[$i]} is absent or not a regular file"
            continue
        fi
        if [[ $(sha_file "${destinations[$i]}") == \
            "${expected_hashes[$i]}" ]]; then
            ok "installed ${labels[$i]} SHA-256 matches"
        else
            bad "installed ${labels[$i]} SHA-256 mismatch"
        fi
        if [[ $(file_mode "${destinations[$i]}") == \
            "${expected_modes[$i]}" ]]; then
            ok "installed ${labels[$i]} permissions match"
        else
            bad "installed ${labels[$i]} permissions mismatch"
        fi
    done
    if ((check_failures > 0)); then
        printf 'beryllium-governance: %d post-install check(s) failed\n' \
            "$check_failures" >&2
        return 1
    fi
    printf 'beryllium-governance: post-install checks passed\n'
}

install_governance() {
    local rendered_config stage stage_device destination_dir
    local destination_device i
    local -a destinations staged backups labels expected_hashes
    local -a expected_modes had_backup committed
    check_failures=0
    require_tools
    require_sources
    check_settings
    ((check_failures == 0)) ||
        die "settings preflight failed; no managed file was installed"

    mkdir -p -- "$copilot_home/agents" "$skill_dir" "$copilot_home/hooks"
    destinations=("$agent_dest" "$skill_dest" "$hook_dest" "$hook_config_dest")
    labels=("scope reviewer" "scope-management skill" "governance hook" \
        "hook configuration")
    for i in "${!destinations[@]}"; do
        if [[ -e ${destinations[$i]} || -L ${destinations[$i]} ]]; then
            [[ -f ${destinations[$i]} && ! -L ${destinations[$i]} ]] ||
                die "refusing to replace non-regular ${labels[$i]}: ${destinations[$i]}"
        fi
    done

    stage=$(mktemp -d "$copilot_home/.beryllium-governance.XXXXXX") ||
        die "cannot create installation staging directory"
    staged=("$stage/new.0" "$stage/new.1" "$stage/new.2" "$stage/new.3")
    backups=("$stage/backup.0" "$stage/backup.1" "$stage/backup.2" \
        "$stage/backup.3")
    had_backup=(0 0 0 0)
    committed=(0 0 0 0)

    if ! install -m 0644 "$agent_source" "${staged[0]}" ||
        ! install -m 0644 "$skill_source" "${staged[1]}" ||
        ! install -m 0755 "$hook_source" "${staged[2]}"; then
        rm -rf -- "$stage"
        die "cannot stage managed governance files"
    fi
    if ! rendered_config=$(render_hook_config); then
        rm -rf -- "$stage"
        die "cannot render hook configuration"
    fi
    if ! printf '%s\n' "$rendered_config" >"${staged[3]}" ||
        ! chmod 0644 "${staged[3]}"; then
        rm -rf -- "$stage"
        die "cannot stage rendered hook configuration"
    fi

    expected_hashes=(
        "$(sha_file "$agent_source")"
        "$(sha_file "$skill_source")"
        "$(sha_file "$hook_source")"
        "$(printf '%s\n' "$rendered_config" | sha_text)"
    )
    expected_modes=(644 644 755 644)
    for i in "${!staged[@]}"; do
        if [[ ! -f ${staged[$i]} || -L ${staged[$i]} ]] ||
            [[ $(sha_file "${staged[$i]}") != "${expected_hashes[$i]}" ]] ||
            [[ $(file_mode "${staged[$i]}") != "${expected_modes[$i]}" ]]; then
            rm -rf -- "$stage"
            die "staged ${labels[$i]} failed content or permission verification"
        fi
    done

    if ! stage_device=$(stat -Lc '%d' -- "$stage"); then
        rm -rf -- "$stage"
        die "cannot resolve installation staging filesystem"
    fi
    for i in "${!destinations[@]}"; do
        destination_dir=${destinations[$i]%/*}
        if ! destination_device=$(stat -Lc '%d' -- "$destination_dir"); then
            rm -rf -- "$stage"
            die "cannot resolve destination filesystem for ${labels[$i]}: $destination_dir"
        fi
        if [[ $destination_device != "$stage_device" ]]; then
            rm -rf -- "$stage"
            die "cannot atomically install ${labels[$i]} across filesystems"
        fi
    done
    for i in "${!destinations[@]}"; do
        if [[ -e ${destinations[$i]} ]]; then
            if ! cp -p -- "${destinations[$i]}" "${backups[$i]}" ||
                [[ ! -f ${backups[$i]} || -L ${backups[$i]} ]] ||
                [[ $(sha_file "${backups[$i]}") != \
                    $(sha_file "${destinations[$i]}") ]] ||
                [[ $(file_mode "${backups[$i]}") != \
                    $(file_mode "${destinations[$i]}") ]]; then
                rm -rf -- "$stage"
                die "cannot make a verified backup copy of ${labels[$i]}"
            fi
            had_backup[$i]=1
        fi
    done

    for i in "${!destinations[@]}"; do
        if ! mv -f -- "${staged[$i]}" "${destinations[$i]}"; then
            if rollback_committed_files; then
                rm -rf -- "$stage"
                die "cannot install ${labels[$i]}; previous files were restored"
            fi
            die "cannot install ${labels[$i]}; rollback was incomplete and backups remain at $stage"
        fi
        committed[$i]=1
    done

    if ! verify_committed_files; then
        if rollback_committed_files; then
            rm -rf -- "$stage"
            die "installed files failed verification; previous files were restored"
        fi
        die "installed files failed verification; rollback was incomplete and backups remain at $stage"
    fi

    rm -rf -- "$stage"
    printf '%s\n' \
        "Installed user-level governance. Configuration, matcher, and environment changes require a new Copilot CLI session. A registered hook may execute this replaced script body at its next matching call while retaining its loaded matcher and environment. Agent and skill reread behavior in running sessions is unknown; reinstall while governed sessions are idle."
}

verify_removable() {
    local label=$1 expected_hash=$2 destination=$3
    [[ -e $destination || -L $destination ]] || {
        return
    }
    [[ -f $destination && ! -L $destination ]] ||
        die "refusing to remove non-regular managed path: $destination"
    [[ $(sha_file "$destination") == "$expected_hash" ]] ||
        die "refusing to remove drifted $label: $destination"
}

remove_managed() {
    local label=$1 destination=$2
    if [[ -e $destination || -L $destination ]]; then
        rm -f -- "$destination"
        ok "removed $label"
    else
        ok "$label is already absent"
    fi
}

uninstall_governance() {
    local rendered_config agent_hash skill_hash hook_hash config_hash
    require_tools
    require_sources
    rendered_config=$(render_hook_config)
    agent_hash=$(sha_file "$agent_source")
    skill_hash=$(sha_file "$skill_source")
    hook_hash=$(sha_file "$hook_source")
    config_hash=$(printf '%s\n' "$rendered_config" | sha_text)

    verify_removable "scope reviewer" "$agent_hash" "$agent_dest"
    verify_removable "scope-management skill" "$skill_hash" "$skill_dest"
    verify_removable "governance hook" "$hook_hash" "$hook_dest"
    verify_removable "hook configuration" "$config_hash" "$hook_config_dest"

    remove_managed "scope reviewer" "$agent_dest"
    remove_managed "scope-management skill" "$skill_dest"
    remove_managed "governance hook" "$hook_dest"
    remove_managed "hook configuration" "$hook_config_dest"
    rmdir -- "$skill_dir" 2>/dev/null || true
    printf '%s\n' \
        "Removed exact managed governance files. Already-running registered sessions may still point at removed hook or configuration paths; uninstall while governed sessions are idle."
}

(($# == 1)) || {
    usage
    exit 2
}

case $1 in
install)
    install_governance
    ;;
check)
    check_installation
    ;;
uninstall)
    uninstall_governance
    ;;
-h | --help)
    usage
    ;;
*)
    usage
    exit 2
    ;;
esac
