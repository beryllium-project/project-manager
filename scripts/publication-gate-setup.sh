#!/usr/bin/env bash
# HUMAN-RUN installer/checker for the Beryllium publication gate
# (PMD-20261108-001). The Project Manager agent never runs install or
# uninstall against the real user configuration; maintained tests use only a
# sandbox copy of the Project Manager scripts under a sandbox parent, with
# sandbox HOME, XDG_CONFIG_HOME, COPILOT_HOME, and GIT_CONFIG_GLOBAL.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  publication-gate-setup.sh install
  publication-gate-setup.sh check
  publication-gate-setup.sh uninstall

install copies the publication gate, its Git hook dispatcher, the
beryllium-publication-gate skill, and the private denylist from the parent
repository's .publication-gate/denylist (mode 0600) into
${XDG_CONFIG_HOME:-$HOME/.config}/beryllium/publication-gate and
${COPILOT_HOME:-$HOME/.copilot}/skills, then adds global Git includeIf entries
that set core.hooksPath to the gate's hooks directory only for repositories
under the Beryllium workspace roots or with a remote in the beryllium-project
or agentic-os-research organisations. It refuses while a global
core.hooksPath is set, and ends by running check.

check is read-only. It verifies every installed file against its source by
SHA-256 and mode, the includeIf entries, that every repository directly under
the workspace roots resolves core.hooksPath to the gate (no repository-local
override), that none relies on a hook the dispatcher does not chain, and the
gate's denylist validation and self-test.

uninstall removes the gate's includeIf entries, the managed directory, and an
exact-match skill copy.

A private remote is never scanned. A push to a public remote is scanned for
the private denylist's entries in every encoding the gate derives, and is
refused on any finding or when visibility cannot be determined. Passing the
gate is not publication approval. git push --no-verify skips every hook and
is prohibited for public remotes.

Every run writes a timestamped log under the Project Manager's ignored
scratch/publication-gate-setup/ and prints its path last, so the Project
Manager reads the log instead of asking for pasted output.
EOF
}

die() {
    printf 'publication-gate-setup: ERROR: %s\n' "$*" >&2
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

gate_source=$pm_root/scripts/publication-gate.py
dispatch_source=$pm_root/scripts/publication-gate-hook.sh
skill_source=$pm_root/user-assets/skills/beryllium-publication-gate/SKILL.md
denylist_source=$parent_root/.publication-gate/denylist

home=${HOME:?HOME is not set}
config_home=${XDG_CONFIG_HOME:-$home/.config}
[[ $config_home == /* ]] || die "XDG_CONFIG_HOME must be an absolute path"
copilot_home=${COPILOT_HOME:-$home/.copilot}
[[ $copilot_home == /* ]] || die "COPILOT_HOME must be an absolute path"
base=$config_home/beryllium/publication-gate
include_file=$base/gitconfig
skill_dest=$copilot_home/skills/beryllium-publication-gate/SKILL.md
marker_name=.managed-by-publication-gate-setup
marker_text='publication-gate-setup PMD-20261108-001'

# Hooks that core.hooksPath would otherwise disable and the dispatcher chains.
chained_hooks=(applypatch-msg pre-applypatch post-applypatch pre-commit
    pre-merge-commit prepare-commit-msg commit-msg post-commit pre-rebase
    post-checkout post-merge pre-push pre-receive update post-receive
    post-update pre-auto-gc post-rewrite sendemail-validate p4-changelist
    p4-prepare-changelist p4-post-changelist p4-pre-submit)
# Hooks whose mere presence changes Git behavior or that run very often; the
# dispatcher does not provide them, so check fails if a repository has one.
unchained_hooks=(reference-transaction post-index-change push-to-checkout
    proc-receive)
gated_orgs=(beryllium-project agentic-os-research)

git_parent() {
    env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE \
        -u GIT_OBJECT_DIRECTORY -u GIT_ALTERNATE_OBJECT_DIRECTORIES \
        git -C "$parent_root" "$@"
}

git_in() {
    local dir=$1
    shift
    env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE \
        -u GIT_OBJECT_DIRECTORY -u GIT_ALTERNATE_OBJECT_DIRECTORIES \
        GIT_OPTIONAL_LOCKS=0 git -C "$dir" "$@"
}

require_tools() {
    local tool version major minor
    for tool in git python3 sha256sum install realpath mktemp stat readlink \
        grep awk; do
        command -v "$tool" >/dev/null 2>&1 ||
            die "required command is unavailable: $tool"
    done
    version=$(git version | awk '{ print $3 }')
    major=${version%%.*}
    minor=${version#*.}
    minor=${minor%%.*}
    [[ $major =~ ^[0-9]+$ && $minor =~ ^[0-9]+$ ]] ||
        die "cannot parse the Git version: $version"
    ((major > 2 || (major == 2 && minor >= 36))) ||
        die "Git 2.36 or later is required for includeIf hasconfig: $version"
    python3 -c 'import sys; sys.exit(sys.version_info < (3, 8))' ||
        die "Python 3.8 or later is required"
}

require_sources() {
    local source
    for source in "$gate_source" "$dispatch_source" "$skill_source"; do
        [[ -f $source && ! -L $source ]] ||
            die "managed source is absent or not a regular file: $source"
    done
    [[ -f $denylist_source && ! -L $denylist_source ]] ||
        die "the private parent denylist is absent: $denylist_source"
    [[ -f $parent_root/SOT.md ]] ||
        die "canonical parent root lacks SOT.md: $parent_root"
    git_parent rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
        die "canonical parent root is not a Git worktree: $parent_root"
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

# The parent root, plus the directory holding each tracked symlink target
# that lies outside it.
scope_roots() {
    local listing entry metadata path mode target root
    local -A seen=([$parent_root]=1)
    printf '%s\n' "$parent_root"
    listing=$(git_parent ls-files -s --) ||
        die "cannot enumerate tracked parent paths"
    while IFS= read -r entry; do
        [[ -n $entry && $entry == *$'\t'* ]] || continue
        metadata=${entry%%$'\t'*}
        path=${entry#*$'\t'}
        mode=${metadata%% *}
        [[ $mode == 120000 ]] || continue
        target=$(realpath -e -- "$parent_root/$path") ||
            die "tracked symlink does not resolve: $path"
        root=${target%/*}
        [[ $root == "$parent_root" || $root == "$parent_root"/* ]] && continue
        [[ -n ${seen[$root]:-} ]] && continue
        seen[$root]=1
        printf '%s\n' "$root"
    done <<<"$listing"
}

conditions() {
    local root org
    while IFS= read -r root; do
        printf 'gitdir:%s/\n' "$root"
    done < <(scope_roots)
    for org in "${gated_orgs[@]}"; do
        printf 'hasconfig:remote.*.url:https://github.com/%s/**\n' "$org"
        printf 'hasconfig:remote.*.url:git@github.com:%s/**\n' "$org"
        printf 'hasconfig:remote.*.url:ssh://git@github.com/%s/**\n' "$org"
    done
}

# Git repositories directly under each scope root, the parent included.
scoped_repositories() {
    local root dir
    printf '%s\n' "$parent_root"
    while IFS= read -r root; do
        for dir in "$root"/*; do
            [[ -d $dir && -e $dir/.git ]] || continue
            [[ $dir == "$parent_root" ]] && continue
            printf '%s\n' "$(realpath -e -- "$dir")"
        done
    done < <(scope_roots) | awk '!seen[$0]++'
}

render_include() {
    printf '# Managed by project-manager/scripts/publication-gate-setup.sh (PMD-20261108-001).\n'
    printf '[core]\n\thooksPath = %s\n' "$base/hooks"
}

check_copy() {
    local label=$1 expected_hash=$2 destination=$3 expected_mode=$4
    if [[ ! -f $destination || -L $destination ]]; then
        bad "$label is absent or not a regular file: $destination"
        return
    fi
    if [[ $(sha_file "$destination") == "$expected_hash" ]]; then
        ok "$label SHA-256 matches its source"
    else
        bad "$label SHA-256 differs from its source: $destination"
    fi
    if [[ $(file_mode "$destination") == "$expected_mode" ]]; then
        ok "$label mode is $expected_mode"
    else
        bad "$label mode is $(file_mode "$destination"), expected $expected_mode"
    fi
}

check_installation() {
    local name link entry condition repo resolved common hooks_path
    check_failures=0
    require_tools
    require_sources

    if [[ -d $base && ! -L $base && -f $base/$marker_name ]]; then
        ok "managed directory is present: $base"
    else
        bad "managed directory is absent or unmanaged: $base"
    fi
    check_copy "gate" "$(sha_file "$gate_source")" \
        "$base/bin/publication-gate" 755
    check_copy "hook dispatcher" "$(sha_file "$dispatch_source")" \
        "$base/bin/hook-dispatch" 755
    check_copy "include file" "$(render_include | sha_text)" \
        "$include_file" 644
    check_copy "installed denylist" "$(sha_file "$denylist_source")" \
        "$base/denylist" 600
    check_copy "publication-gate skill" "$(sha_file "$skill_source")" \
        "$skill_dest" 644
    local link_failures=0
    for name in "${chained_hooks[@]}"; do
        link=$base/hooks/$name
        if [[ ! -L $link || $(readlink -- "$link") != ../bin/hook-dispatch ]]; then
            bad "hook link is absent or wrong: $link"
            link_failures=$((link_failures + 1))
        fi
    done
    if [[ -d $base/hooks ]]; then
        while IFS= read -r entry; do
            [[ -n $entry ]] || continue
            if ! printf '%s\n' "${chained_hooks[@]}" | grep -Fxq -- "$entry"; then
                bad "unexpected entry in the hooks directory: $entry"
                link_failures=$((link_failures + 1))
            fi
        done < <(ls -A -- "$base/hooks")
    fi
    ((link_failures > 0)) || ok "all ${#chained_hooks[@]} chained hook links are present"

    hooks_path=$(git config --global --get core.hooksPath 2>/dev/null || true)
    if [[ -z $hooks_path ]]; then
        ok "no global core.hooksPath overrides the scoped includes"
    else
        bad "a global core.hooksPath is set: $hooks_path"
    fi
    while IFS= read -r condition; do
        if git config --global --get-all "includeIf.$condition.path" \
            2>/dev/null | grep -Fxq -- "$include_file"; then
            ok "includeIf $condition"
        else
            bad "missing includeIf $condition"
        fi
    done < <(conditions)

    while IFS= read -r repo; do
        resolved=$(git_in "$repo" config --get core.hooksPath 2>/dev/null || true)
        if [[ $resolved == "$base/hooks" ]]; then
            ok "gate hooks apply in ${repo#"$parent_root"/}"
        else
            bad "gate hooks do not apply in $repo (core.hooksPath resolves to '${resolved:-unset}')"
        fi
        common=$(git_in "$repo" rev-parse --path-format=absolute \
            --git-common-dir 2>/dev/null || true)
        [[ -n $common ]] || continue
        for name in "${unchained_hooks[@]}"; do
            if [[ -f $common/hooks/$name && -x $common/hooks/$name ]]; then
                bad "$repo relies on the $name hook, which the dispatcher does not chain"
            fi
        done
    done < <(scoped_repositories)

    if python3 -I -B "$base/bin/publication-gate" validate-denylist \
        >/dev/null 2>&1; then
        ok "installed denylist is valid"
    else
        bad "installed denylist fails validation"
    fi
    if python3 -I -B "$base/bin/publication-gate" self-test >/dev/null 2>&1; then
        ok "gate self-test passes"
    else
        bad "gate self-test fails"
    fi

    if ((check_failures > 0)); then
        printf 'publication-gate-setup: %d check(s) failed\n' \
            "$check_failures" >&2
        return 1
    fi
    printf 'publication-gate-setup: all checks passed\n'
}

install_gate() {
    local hooks_path stage old name condition staged_skill
    require_tools
    require_sources
    python3 -I -B "$gate_source" validate-denylist \
        --denylist "$denylist_source" >/dev/null ||
        die "the private parent denylist fails validation; nothing was installed"
    hooks_path=$(git config --global --get core.hooksPath 2>/dev/null || true)
    [[ -z $hooks_path ]] ||
        die "a global core.hooksPath is set ($hooks_path); resolve it first; nothing was installed"
    if [[ -e $base || -L $base ]]; then
        [[ -d $base && ! -L $base && -f $base/$marker_name ]] ||
            die "refusing to replace an unmanaged path: $base"
    fi
    if [[ -e $skill_dest || -L $skill_dest ]]; then
        [[ -f $skill_dest && ! -L $skill_dest ]] ||
            die "refusing to replace a non-regular skill path: $skill_dest"
    fi

    mkdir -p -- "${base%/*}" "${skill_dest%/*}"
    stage=$(mktemp -d "${base%/*}/.publication-gate.XXXXXX") ||
        die "cannot create a staging directory"
    if ! {
        mkdir -- "$stage/bin" "$stage/hooks" &&
            install -m 0755 "$gate_source" "$stage/bin/publication-gate" &&
            install -m 0755 "$dispatch_source" "$stage/bin/hook-dispatch" &&
            install -m 0600 "$denylist_source" "$stage/denylist" &&
            render_include >"$stage/gitconfig" &&
            chmod 0644 "$stage/gitconfig" &&
            printf '%s\n' "$marker_text" >"$stage/$marker_name"
    }; then
        rm -rf -- "$stage"
        die "cannot stage the gate; nothing was installed"
    fi
    for name in "${chained_hooks[@]}"; do
        ln -s ../bin/hook-dispatch "$stage/hooks/$name" || {
            rm -rf -- "$stage"
            die "cannot stage hook links; nothing was installed"
        }
    done
    if [[ $(sha_file "$stage/bin/publication-gate") != $(sha_file "$gate_source") ||
        $(sha_file "$stage/bin/hook-dispatch") != $(sha_file "$dispatch_source") ||
        $(sha_file "$stage/denylist") != $(sha_file "$denylist_source") ||
        $(file_mode "$stage/denylist") != 600 ]]; then
        rm -rf -- "$stage"
        die "staged files failed verification; nothing was installed"
    fi

    old=
    if [[ -d $base ]]; then
        old=$stage.previous
        mv -- "$base" "$old" || {
            rm -rf -- "$stage"
            die "cannot move the previous installation aside; nothing changed"
        }
    fi
    if ! mv -- "$stage" "$base"; then
        if [[ -n $old ]]; then mv -- "$old" "$base" || true; fi
        rm -rf -- "$stage"
        die "cannot install the gate; the previous installation was restored"
    fi
    if [[ -n $old ]]; then rm -rf -- "$old"; fi

    staged_skill=$(mktemp "${skill_dest%/*}/.SKILL.XXXXXX") ||
        die "cannot stage the skill"
    install -m 0644 "$skill_source" "$staged_skill" &&
        mv -f -- "$staged_skill" "$skill_dest" || {
        rm -f -- "$staged_skill"
        die "cannot install the skill"
    }

    while IFS= read -r condition; do
        if ! git config --global --get-all "includeIf.$condition.path" \
            2>/dev/null | grep -Fxq -- "$include_file"; then
            git config --global --add "includeIf.$condition.path" \
                "$include_file" ||
                die "cannot add includeIf $condition"
        fi
    done < <(conditions)

    printf 'Installed the publication gate under %s. Every new Git command in a scoped repository uses it; no Copilot session restart is needed.\n' "$base"
    check_installation
}

uninstall_gate() {
    local entry key value
    require_tools
    while IFS= read -r -d '' entry; do
        key=${entry%%$'\n'*}
        value=${entry#*$'\n'}
        [[ $value == "$include_file" ]] || continue
        git config --global --fixed-value --unset-all "$key" "$include_file" ||
            die "cannot remove $key"
        ok "removed $key"
    done < <(git config --global -z --get-regexp '^includeif\..*\.path$' \
        2>/dev/null || true)
    if [[ -e $base || -L $base ]]; then
        [[ -d $base && ! -L $base && -f $base/$marker_name ]] ||
            die "refusing to remove an unmanaged path: $base"
        rm -rf -- "$base" || die "cannot remove $base"
        ok "removed $base"
    else
        ok "managed directory is already absent"
    fi
    if [[ -f $skill_dest && ! -L $skill_dest ]]; then
        if [[ -f $skill_source &&
            $(sha_file "$skill_dest") == $(sha_file "$skill_source") ]]; then
            rm -f -- "$skill_dest"
            rmdir -- "${skill_dest%/*}" 2>/dev/null || true
            ok "removed the publication-gate skill"
        else
            printf 'publication-gate-setup: the skill copy differs from its source and was left in place: %s\n' \
                "$skill_dest" >&2
        fi
    fi
    printf 'Removed the publication gate. Public pushes from scoped repositories are no longer scanned.\n'
}

(($# == 1)) || {
    usage
    exit 2
}

log_file=''
tee_pid=''

finish_log() {
    local rc=$?
    printf 'exit %s; log: %s\n' "$rc" "$log_file"
    exec >&- 2>&-
    if [[ -n $tee_pid ]]; then wait "$tee_pid" 2>/dev/null || true; fi
    exit "$rc"
}

case $1 in
install | check | uninstall)
    log_dir=$pm_root/scratch/publication-gate-setup
    mkdir -p "$log_dir" || die "cannot create the log directory: $log_dir"
    log_file=$log_dir/publication-gate-setup-$1-$(date -u +%Y%m%dT%H%M%SZ).log
    exec > >(tee -a "$log_file") 2>&1
    tee_pid=${!:-}
    trap finish_log EXIT
    printf 'publication-gate-setup %s on %s at %s\n' "$1" "$(uname -n)" \
        "$(date -u +%FT%TZ)"
    ;;
esac

case $1 in
install)
    install_gate
    ;;
check)
    check_installation
    ;;
uninstall)
    uninstall_gate
    ;;
-h | --help)
    usage
    ;;
*)
    usage
    exit 2
    ;;
esac
