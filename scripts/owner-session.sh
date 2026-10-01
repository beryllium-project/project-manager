#!/usr/bin/env bash
# HUMAN-RUN launcher for an ordinary component owner session. It creates a
# revision-bound packet under ignored Project Manager scratch space and starts
# Copilot with a short initial prompt that points to that packet.

set -euo pipefail
export LC_ALL=C
umask 077

usage() {
    cat >&2 <<'EOF'
Usage:
  owner-session.sh [--agent <component-agent>] prepare <component> <PMR-NNN>...
  owner-session.sh [--agent <component-agent>] launch  <component> <PMR-NNN>...

prepare  validate tasking and component state, write the ignored owner packet,
         and print its path and hash without launching Copilot or reserving a
         writer
launch   perform the same fail-closed preparation, then start an interactive
         `copilot --no-auto-update --yolo` session with the packet preloaded;
         hold one per-component writer reservation until Copilot exits

This is a human-run ordinary-owner path. It does not invoke a hidden owner
worker, grant a human gate, push, or write inside the component before Copilot
starts. Each selected PMR must be open and directly assigned to the component.
EOF
}

die() {
    printf 'owner-session: ERROR: %s\n' "$*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
default_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve Project Manager root"
pm_root=${PM_TASKING_ROOT:-$default_root}
pm_root=$(CDPATH= cd -- "$pm_root" 2>/dev/null && pwd -P) ||
    die "Project Manager repository is unreachable"
workspace_root=${PM_TASKING_WORKSPACE:-$(CDPATH= cd -- "$pm_root/.." && pwd -P)}
workspace_root=$(CDPATH= cd -- "$workspace_root" 2>/dev/null && pwd -P) ||
    die "workspace root is unreachable"
tasking=$pm_root/scripts/project-tasking.sh
scratch_root=${PM_OWNER_SESSION_SCRATCH:-$pm_root/scratch/owner-sessions}
copilot_bin=${COPILOT_BIN:-copilot}
copilot_bin_explicit=${COPILOT_BIN+x}

git_safe() {
    git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c credential.helper= -c protocol.allow=never -c diff.external= \
        -c pager.status=false -c pager.log=false -c pager.show=false \
        -c pager.diff=false "$@"
}

owner_agent=
if (($# >= 2)) && [[ $1 == --agent ]]; then
    owner_agent=$2
    shift 2
    [[ $owner_agent =~ ^[a-z0-9][a-z0-9-]*$ ]] ||
        die "invalid component agent name: $owner_agent"
fi

(($# >= 3)) || { usage; exit 2; }
mode=$1
component=$2
shift 2
case $mode in
prepare|launch) ;;
*) usage; exit 2 ;;
esac

[[ $component =~ ^[a-z0-9][a-z0-9-]*$ ]] ||
    die "invalid component name: $component"
[[ $component != project-manager ]] ||
    die "project-manager is self-managed and has no ordinary owner launch"
[[ -f $tasking && -r $tasking ]] ||
    die "project-tasking helper is unavailable"

declare -A seen=()
pmrs=()
for pmr in "$@"; do
    [[ $pmr =~ ^PMR-[0-9][0-9][0-9]$ ]] ||
        die "invalid request ID: $pmr"
    [[ -z ${seen[$pmr]+x} ]] || die "duplicate request ID: $pmr"
    seen[$pmr]=1
    pmrs+=("$pmr")
done

component_entry=$workspace_root/$component
[[ -e $component_entry ]] || die "component entry is unreachable: $component"
component_root=$(CDPATH= cd -- "$component_entry" 2>/dev/null && pwd -P) ||
    die "component repository is unreachable: $component"
mkdir -p -- "$scratch_root"
if [[ $mode == launch ]]; then
    command -v flock >/dev/null 2>&1 ||
        die "flock is required for one-writer owner sessions"
    [[ ! -L $scratch_root/global ]] ||
        die "the global maintenance lock directory is a symbolic link"
    mkdir -p -- "$scratch_root/global"
    [[ ! -L $scratch_root/global/maintenance.lock ]] ||
        die "the global maintenance lock is a symbolic link"
    [[ ! -e $scratch_root/global/maintenance.lock ||
        -f $scratch_root/global/maintenance.lock ]] ||
        die "the global maintenance lock is not a regular file"
    exec {global_fd}>>"$scratch_root/global/maintenance.lock"
    flock -n -s "$global_fd" ||
        die "the PMR-108 global maintenance reservation is held"
    mkdir -p -- "$scratch_root/locks"
    lock_file=$scratch_root/locks/$component.lock
    exec {lock_fd}>"$lock_file"
    flock -n "$lock_fd" ||
        die "another owner session holds the writer reservation: $component"
fi
[[ $(git_safe -C "$component_root" rev-parse --show-toplevel 2>/dev/null || true) == "$component_root" ]] ||
    die "component entry is not a repository root: $component"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "component worktree is dirty; another owner session may be active"
if [[ -n $owner_agent ]]; then
    [[ -f $component_root/.github/agents/$owner_agent.agent.md ]] ||
        die "selected component agent is unavailable: $owner_agent"
fi

[[ $(git_safe -C "$pm_root" rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
    die "Project Manager repository is invalid"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree is dirty; wait for its commit and regenerated tasking"

env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" check >/dev/null ||
    die "generated Project Manager tasking is stale"

pm_head=$(git_safe -C "$pm_root" rev-parse --verify HEAD) ||
    die "cannot resolve Project Manager HEAD"
request_blob=$(git_safe -C "$pm_root" rev-parse --verify \
    HEAD:outbox/component-requests.md) ||
    die "cannot resolve committed request table"
component_head=$(git_safe -C "$component_root" rev-parse --verify HEAD) ||
    die "cannot resolve component HEAD"
component_branch=$(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true)
[[ -n $component_branch ]] || component_branch=detached
component_upstream=$(git_safe -C "$component_root" rev-parse \
    --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)
[[ -n $component_upstream ]] || component_upstream=none

timestamp=$(date -u +%Y%m%dT%H%M%SZ)
pmr_slug=$(IFS=-; printf '%s' "${pmrs[*]}")
packet=$(mktemp "$scratch_root/$timestamp-$component-$pmr_slug.XXXXXX.md") ||
    die "cannot create owner packet"
temp=$packet
trap 'rm -f -- "$packet"' EXIT HUP INT TERM

{
    printf '# Human-started component owner session packet v1\n\n'
    printf -- '- **Component:** `%s`\n' "$component"
    printf -- '- **Logical workspace entry:** `%s`\n' "$component_entry"
    printf -- '- **Physical repository root:** `%s`\n' "$component_root"
    printf -- '- **Expected component branch:** `%s`\n' "$component_branch"
    printf -- '- **Expected component HEAD:** `%s`\n' "$component_head"
    printf -- '- **Observed upstream:** `%s`\n' "$component_upstream"
    printf -- '- **Source Project Manager commit:** `%s`\n' "$pm_head"
    printf -- '- **Source request blob:** `%s`\n' "$request_blob"
    if [[ -n $owner_agent ]]; then
        printf -- '- **Selected component agent:** `%s`\n' "$owner_agent"
    else
        printf -- '- **Selected component agent:** ordinary default context\n'
    fi
    printf -- '- **Selected requests:**'
    printf ' `%s`' "${pmrs[@]}"
    printf '\n\n'
    cat <<EOF
## Project Manager coordination inputs

- Component card: \`$pm_root/components/$component.md\`
- Generated current tasking: \`$pm_root/outbox/tasking/$component.md\`
- Authoritative request table: \`$pm_root/outbox/component-requests.md\`

## Session contract

This packet was generated by a human-run launcher so the responsible human
does not copy or reconstruct agent instructions. It selects work; it does not
grant or infer implementation authorization, source admission, exact-target
acceptance, review approval, risk acceptance, sign-off, licensing,
redistribution, publication, release, formal verification, hardware
validation, a push, or a remote change.

1. Work only in \`$component_root\`. Treat every sibling repository and this
   packet as read-only tasking evidence.
2. Before editing, report \`pwd\` and \`pwd -P\`; verify the branch and exact
   HEAD above, a clean worktree, local owner instructions, the component
   handoff, and absence of another writer. Stop on any mismatch.
3. Run the exact fail-closed resolver below. Its PM commit and request blob
   must match this packet. Never fall back to session history, task databases,
   background agents, prior chat, or memory.

   \`\`\`sh
   PM_TASKING_ROOT=$pm_root \\
   PM_TASKING_WORKSPACE=$workspace_root \\
   bash $tasking resolve $component
   \`\`\`

4. Complete only the selected PMRs. Keep their scopes and evidence distinct,
   even if one human-started owner session handles them sequentially.
5. If a selected PMR needs a responsible-human decision, ask one short stable
   question at a time with a safe defer choice. Never infer an unanswered gate.
6. Load \`cross-repo-collaboration\` before substantively consuming,
   incorporating, qualifying, or applying sibling research or analysis.
   Pointer-only record/decline/defer does not trigger it. A missing or
   read-only source ledger grants no source write.
7. Do not perform another PMR, push, fetch, add/change a remote, tag, publish,
   release, or modify a sibling repository.
8. Use the component's maintained validation. Review the exact diff and
   changed paths. Commit validated owner work locally with the relevant PMR
   identifiers and the Copilot co-author trailer.
9. Append or refresh the component handoff's structured
   \`## Project Manager return\` with result, exact work/return commits and
   paths, validation and known failures, branch/upstream/ahead-behind state,
   backup state, active-session state, released reservation, and requested PM
   action. A blocked or partial result is valid; never create success-shaped
   fallback evidence.

## Local instructions to inspect when present

EOF
    for instruction in \
        .github/copilot-instructions.md \
        CLAUDE.md \
        AGENT-INTERFACE.md \
        HANDOFF.md \
        meta/handoff.md \
        COLLAB.md \
        CONTRIBUTING.md \
        README.md \
        review-log.md; do
        [[ -e $component_root/$instruction ]] &&
            printf -- '- `%s`\n' "$instruction"
    done
    printf '\n## Exact Project Manager request packets\n\n'
} >"$temp"

for pmr in "${pmrs[@]}"; do
    env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
        bash "$tasking" dispatch "$component" "$pmr" >>"$temp" ||
        die "cannot select $pmr for $component"
    printf '\n---\n\n' >>"$temp"
done

final_pm_head=$(git_safe -C "$pm_root" rev-parse --verify HEAD) ||
    die "cannot re-resolve Project Manager HEAD"
final_request_blob=$(git_safe -C "$pm_root" rev-parse --verify \
    HEAD:outbox/component-requests.md) ||
    die "cannot re-resolve committed request table"
[[ $final_pm_head == "$pm_head" ]] ||
    die "Project Manager HEAD changed while preparing the owner packet"
[[ $final_request_blob == "$request_blob" ]] ||
    die "request table changed while preparing the owner packet"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree changed while preparing the owner packet"
final_component_head=$(git_safe -C "$component_root" rev-parse --verify HEAD) ||
    die "cannot re-resolve component HEAD"
[[ $final_component_head == "$component_head" ]] ||
    die "component HEAD changed while preparing the owner packet"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "component worktree changed while preparing the owner packet"

trap - EXIT HUP INT TERM
packet_sha=$(sha256sum -- "$packet")
packet_sha=${packet_sha%% *}

printf 'owner-session packet: %s\n' "$packet"
printf 'owner-session sha256: %s\n' "$packet_sha"
printf 'owner-session component: %s at %s\n' "$component" "$component_head"
printf 'owner-session requests:'
printf ' %s' "${pmrs[@]}"
printf '\n'

[[ $mode == prepare ]] && exit 0
if [[ $pm_root != "$default_root" && -z $copilot_bin_explicit ]]; then
    die "non-default PM_TASKING_ROOT launch requires an explicit COPILOT_BIN"
fi
command -v "$copilot_bin" >/dev/null 2>&1 ||
    die "Copilot CLI is unavailable: $copilot_bin"

[[ $(git_safe -C "$pm_root" rev-parse --verify HEAD) == "$pm_head" ]] ||
    die "Project Manager HEAD changed before Copilot launch"
[[ $(git_safe -C "$component_root" rev-parse --verify HEAD) == "$component_head" ]] ||
    die "component HEAD changed before Copilot launch"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree changed before Copilot launch"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "component worktree changed before Copilot launch"

initial_prompt="Read the complete owner-session packet at $packet. First verify its SHA-256 is $packet_sha and this repository HEAD is $component_head. If either check fails, stop. Then follow only that packet, stay interactive, and ask the human only for genuine unresolved gates."

printf 'owner-session launch: copilot --no-auto-update --yolo -C %s -i <packet locator>\n' \
    "$component_entry"
copilot_args=(--no-auto-update --yolo)
[[ -n $owner_agent ]] && copilot_args+=(--agent "$owner_agent")
copilot_args+=(-C "$component_entry" -i "$initial_prompt")
exec "$copilot_bin" "${copilot_args[@]}"
