#!/usr/bin/env bash
# HUMAN-RUN launcher for one exact Project Manager-recorded dirty owner
# recovery. It writes only ignored Project Manager scratch before Copilot
# starts and never modifies, stages, commits, pushes, or cleans the component.

set -euo pipefail
export LC_ALL=C
umask 077

usage() {
    cat >&2 <<'EOF'
Usage:
  owner-recovery.sh prepare <component> <PMR-NNN>
  owner-recovery.sh launch  <component> <PMR-NNN>

prepare  validate committed tasking and the exact recorded dirty state, then
         write and print the private recovery packet without reserving a writer
launch   perform the same checks, hold the shared component writer lock, and
         start interactive `copilot --no-auto-update --yolo` with the recovery
         packet preloaded and a transcript/state log under ignored PM scratch

Recovery is allowed only when outbox/owner-recovery/<PMR-NNN>.tsv is committed,
names the same component/request, records the prior owner session as closed,
and exactly matches the current branch, HEAD, and porcelain status. A clean
component uses owner-session.sh instead.
EOF
}

die() {
    printf 'owner-recovery: ERROR: %s\n' "$*" >&2
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
spec_dir=${PM_OWNER_RECOVERY_SPEC_DIR:-$pm_root/outbox/owner-recovery}
scratch_root=${PM_OWNER_RECOVERY_SCRATCH:-$pm_root/scratch/owner-recoveries}
lock_root=${PM_OWNER_SESSION_SCRATCH:-$pm_root/scratch/owner-sessions}/locks
copilot_bin=${COPILOT_BIN:-copilot}
copilot_bin_explicit=${COPILOT_BIN+x}

git_safe() {
    env -i "PATH=$PATH" HOME=/nonexistent XDG_CONFIG_HOME=/nonexistent \
        LC_ALL=C GIT_CONFIG_NOSYSTEM=1 GIT_OPTIONAL_LOCKS=0 \
        GIT_TERMINAL_PROMPT=0 GIT_ASKPASS=/bin/false SSH_ASKPASS=/bin/false \
        GIT_PAGER=cat PAGER=cat \
        git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c core.attributesFile=/dev/null -c core.autocrlf=false \
        -c core.quotePath=true -c credential.helper= -c protocol.allow=never \
        -c diff.external= -c pager.status=false -c pager.log=false \
        -c pager.show=false -c pager.diff=false "$@"
}

git_pm() {
    git_safe -C "$pm_root" "$@"
}

tracked_diff_sha256() {
    git_safe -C "$component_root" diff \
        --binary --full-index --no-ext-diff --no-textconv HEAD -- |
        sha256sum | awk '{ print $1 }'
}

(($# == 3)) || { usage; exit 2; }
mode=$1
component=$2
request=$3
case $mode in
prepare|launch) ;;
*) usage; exit 2 ;;
esac
[[ $component =~ ^[a-z0-9][a-z0-9-]*$ ]] ||
    die "invalid component name: $component"
[[ $component != project-manager ]] ||
    die "project-manager is self-managed and has no owner recovery"
[[ $request =~ ^PMR-[0-9][0-9][0-9]$ ]] ||
    die "invalid request ID: $request"
[[ -f $tasking && -r $tasking ]] ||
    die "project-tasking helper is unavailable"

spec=$spec_dir/$request.tsv
[[ -f $spec && -r $spec ]] ||
    die "committed recovery specification is unavailable: $request"

declare -A metadata=()
expected_status_lines=()
while IFS=$'\t' read -r key value extra || [[ -n ${key:-} ]]; do
    [[ -n ${key:-} ]] || continue
    [[ -z ${extra:-} ]] || die "recovery specification has too many fields: $key"
    case $key in
    component|request|branch|head|prior-session|tracked-diff-sha256)
        [[ -z ${metadata[$key]+x} ]] ||
            die "recovery specification repeats metadata: $key"
        metadata[$key]=$value
        ;;
    status)
        expected_status_lines+=("$value")
        ;;
    *)
        die "recovery specification has an unknown key: $key"
        ;;
    esac
done <"$spec"

for key in component request branch head prior-session tracked-diff-sha256; do
    [[ -n ${metadata[$key]:-} ]] ||
        die "recovery specification lacks metadata: $key"
done
((${#expected_status_lines[@]} > 0)) ||
    die "recovery specification has no dirty status"
[[ ${metadata[component]} == "$component" ]] ||
    die "recovery component does not match the specification"
[[ ${metadata[request]} == "$request" ]] ||
    die "recovery request does not match the specification"
[[ ${metadata[branch]} =~ ^[A-Za-z0-9._/-]+$ ]] ||
    die "recovery specification has an invalid branch"
[[ ${metadata[head]} =~ ^[0-9a-f]{40}$ ]] ||
    die "recovery specification has an invalid HEAD"
[[ ${metadata[tracked-diff-sha256]} =~ ^[0-9a-f]{64}$ ]] ||
    die "recovery specification has an invalid tracked diff SHA-256"
[[ ${metadata[prior-session]} == closed ]] ||
    die "prior owner session is not recorded closed"
for line in "${expected_status_lines[@]}"; do
    [[ $line != '?? '* ]] ||
        die "recovery specifications cannot include untracked paths"
done

component_entry=$workspace_root/$component
[[ -e $component_entry ]] || die "component entry is unreachable: $component"
component_root=$(CDPATH= cd -- "$component_entry" 2>/dev/null && pwd -P) ||
    die "component repository is unreachable: $component"
[[ $(git_safe -C "$component_root" rev-parse --show-toplevel 2>/dev/null || true) == "$component_root" ]] ||
    die "component entry is not a repository root: $component"
[[ $(git_pm rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
    die "Project Manager repository is invalid"
[[ -z $(git_pm status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree is dirty; wait for its commit and regenerated tasking"

spec_rel=${spec#"$pm_root/"}
[[ $spec_rel != "$spec" ]] ||
    die "recovery specification is outside the Project Manager repository"
git_pm cat-file -e "HEAD:$spec_rel" 2>/dev/null ||
    die "recovery specification is not committed at Project Manager HEAD"
git_pm diff --quiet -- "$spec_rel" ||
    die "recovery specification has unstaged changes"
git_pm diff --cached --quiet -- "$spec_rel" ||
    die "recovery specification has staged changes"

env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" check >/dev/null ||
    die "generated Project Manager tasking is stale"
view=$pm_root/outbox/tasking/$component.md
[[ -f $view ]] ||
    die "recovery tasking view is unavailable: $component"
mapfile -t visible_requests < <(
    sed -n 's/^| `\(PMR-[0-9][0-9][0-9]\)` |.*/\1/p' "$view"
)
if ((${#visible_requests[@]} == 0)); then
    die "recovery tasking view has no visible component request"
elif ((${#visible_requests[@]} != 1)); then
    die "recovery requires exactly one visible component request"
fi
[[ ${visible_requests[0]} == "$request" ]] ||
    die "visible component request does not match recovery request"

pm_head=$(git_pm rev-parse --verify HEAD) ||
    die "cannot resolve Project Manager HEAD"
request_blob=$(git_pm rev-parse --verify HEAD:outbox/component-requests.md) ||
    die "cannot resolve committed request table"
component_head=$(git_safe -C "$component_root" rev-parse --verify HEAD) ||
    die "cannot resolve component HEAD"
component_branch=$(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true)
[[ -n $component_branch ]] || component_branch=detached
[[ $component_head == "${metadata[head]}" ]] ||
    die "component HEAD does not match the recovery specification"
[[ $component_branch == "${metadata[branch]}" ]] ||
    die "component branch does not match the recovery specification"
expected_status=$(printf '%s\n' "${expected_status_lines[@]}")
actual_status=$(git_safe -C "$component_root" status --porcelain=v1 --untracked-files=all)
[[ -n $actual_status ]] ||
    die "component is clean; use owner-session.sh instead"
[[ $actual_status == "$expected_status" ]] ||
    die "component dirty state does not match the recovery specification"
[[ -z $(git_safe -C "$component_root" diff --name-only --diff-filter=U) ]] ||
    die "component has unresolved merge conflicts"
actual_diff_sha=$(
    tracked_diff_sha256
) || die "cannot calculate component tracked diff fingerprint"
[[ $actual_diff_sha == "${metadata[tracked-diff-sha256]}" ]] ||
    die "component tracked diff does not match the recovery specification"

mkdir -p -- "$scratch_root"
if [[ $mode == launch ]]; then
    command -v flock >/dev/null 2>&1 ||
        die "flock is required for one-writer owner recovery"
    command -v script >/dev/null 2>&1 ||
        die "util-linux script is required for the recovery transcript"
    script --help 2>&1 | grep -Fq -- '--command' ||
        die "the available script command is not the required util-linux implementation"
    mkdir -p -- "$lock_root"
    lock_file=$lock_root/$component.lock
    exec {lock_fd}>"$lock_file"
    flock -n "$lock_fd" ||
        die "another owner session holds the writer reservation: $component"
fi

dispatch=$(env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" dispatch "$component" "$request") ||
    die "cannot select $request for $component"

timestamp=$(date -u +%Y%m%dT%H%M%SZ)
packet=$(mktemp "$scratch_root/$timestamp-$component-$request.XXXXXX.md") ||
    die "cannot create recovery packet"
incomplete=$packet
runner=
cleanup_incomplete() {
    [[ -z $incomplete ]] || rm -f -- "$incomplete"
    [[ -z $runner ]] || rm -f -- "$runner"
}
trap cleanup_incomplete EXIT HUP INT TERM

{
    printf '# Human-started dirty owner recovery packet v1\n\n'
    printf -- '- **Component:** `%s`\n' "$component"
    printf -- '- **Logical workspace entry:** `%s`\n' "$component_entry"
    printf -- '- **Physical repository root:** `%s`\n' "$component_root"
    printf -- '- **Expected component branch:** `%s`\n' "$component_branch"
    printf -- '- **Expected component HEAD:** `%s`\n' "$component_head"
    printf -- '- **Source Project Manager commit:** `%s`\n' "$pm_head"
    printf -- '- **Source request blob:** `%s`\n' "$request_blob"
    printf -- '- **Recovery request:** `%s`\n' "$request"
    printf -- '- **Prior owner session:** `closed`\n\n'
    printf -- '- **Expected tracked diff SHA-256:** `%s`\n\n' \
        "${metadata[tracked-diff-sha256]}"
    cat <<EOF
## Expected preserved dirty state

\`\`\`text
$expected_status
\`\`\`

## Recovery contract

This packet recovers one exact preserved dirty owner state after the
responsible human recorded the prior owner session closed. It selects work;
it does not retroactively authorize any dirty content or grant source
admission, D4 or D5 approval, licensing, redistribution, publication, release,
formal verification, hardware validation, a push, or a remote change.
The terminal transcript is private ignored scratch and may contain sensitive
interactive output; do not quote secrets or private locators into durable
records.

1. Work only in \`$component_root\`. Treat every sibling and this packet as
   read-only tasking evidence.
2. Verify the branch, HEAD, and complete dirty status above before editing.
   The dirty state is expected only at that exact fingerprint. Stop on any
   extra, missing, renamed, staged, conflicted, or otherwise changed path.
3. Run the exact fail-closed resolver below and require its Project Manager
   commit and request blob to match this packet:

   \`\`\`sh
   PM_TASKING_ROOT=$pm_root \\
   PM_TASKING_WORKSPACE=$workspace_root \\
   bash $tasking resolve $component
   \`\`\`

4. Complete only $request. Read the component's local instructions and
   \`$pm_root/templates/owner-return.md\`. Identify and justify every retained
   path under component authority. If any required authority, provenance,
   D4/D5, licensing, or scope decision is missing, return a precise
   \`blocked\` result instead of inferring it.
5. Run maintained component validation and review the exact diff. Commit only
   validated, authorized component work locally with $request and the Copilot
   co-author trailer. Do not push, fetch, merge, change a remote, tag, publish,
   enable Pages, perform another PMR, or modify a sibling.
6. Append the structured Project Manager return to the component handoff,
   including exact commits and paths, validation and known failures,
   branch/upstream/backup state, and final active-session/reservation state.
   A blocked return is valid; never create success-shaped fallback evidence.

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
    printf '\n## Exact Project Manager request packet\n\n%s\n' "$dispatch"
} >"$packet"

[[ $(git_pm rev-parse --verify HEAD) == "$pm_head" ]] ||
    die "Project Manager HEAD changed while preparing recovery"
[[ $(git_pm rev-parse --verify HEAD:outbox/component-requests.md) == "$request_blob" ]] ||
    die "request table changed while preparing recovery"
[[ -z $(git_pm status --porcelain) ]] ||
    die "Project Manager worktree changed while preparing recovery"
[[ $(git_safe -C "$component_root" rev-parse --verify HEAD) == "$component_head" ]] ||
    die "component HEAD changed while preparing recovery"
[[ $(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true) == "$component_branch" ]] ||
    die "component branch changed while preparing recovery"
[[ $(git_safe -C "$component_root" status --porcelain=v1 --untracked-files=all) == "$expected_status" ]] ||
    die "component dirty state changed while preparing recovery"
[[ $(
    tracked_diff_sha256
) == "${metadata[tracked-diff-sha256]}" ]] ||
    die "component tracked diff changed while preparing recovery"

incomplete=
trap - EXIT HUP INT TERM
packet_sha=$(sha256sum -- "$packet")
packet_sha=${packet_sha%% *}
printf 'owner-recovery packet: %s\n' "$packet"
printf 'owner-recovery sha256: %s\n' "$packet_sha"
printf 'owner-recovery component: %s at %s\n' "$component" "$component_head"
printf 'owner-recovery request: %s\n' "$request"

[[ $mode == prepare ]] && exit 0
if [[ $pm_root != "$default_root" && -z $copilot_bin_explicit ]]; then
    die "non-default PM_TASKING_ROOT launch requires an explicit COPILOT_BIN"
fi
command -v "$copilot_bin" >/dev/null 2>&1 ||
    die "Copilot CLI is unavailable: $copilot_bin"

[[ $(git_pm rev-parse --verify HEAD) == "$pm_head" ]] ||
    die "Project Manager HEAD changed before Copilot launch"
[[ $(git_pm rev-parse --verify HEAD:outbox/component-requests.md) == "$request_blob" ]] ||
    die "request table changed before Copilot launch"
[[ -z $(git_pm status --porcelain) ]] ||
    die "Project Manager worktree changed before Copilot launch"
[[ $(git_safe -C "$component_root" rev-parse --verify HEAD) == "$component_head" ]] ||
    die "component HEAD changed before Copilot launch"
[[ $(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true) == "$component_branch" ]] ||
    die "component branch changed before Copilot launch"
[[ $(git_safe -C "$component_root" status --porcelain=v1 --untracked-files=all) == "$expected_status" ]] ||
    die "component dirty state changed before Copilot launch"
[[ $(
    tracked_diff_sha256
) == "${metadata[tracked-diff-sha256]}" ]] ||
    die "component tracked diff changed before Copilot launch"

log=$scratch_root/$timestamp-$component-$request.log
transcript=$scratch_root/$timestamp-$component-$request.typescript
runner=$(mktemp "$scratch_root/$timestamp-$component-$request.runner.XXXXXX")
cleanup_runner() {
    [[ -z $runner ]] || rm -f -- "$runner"
}
trap cleanup_runner EXIT HUP INT TERM
initial_prompt="Read the complete owner-recovery packet at $packet. First verify its SHA-256 is $packet_sha and this repository HEAD is $component_head. If either check fails, stop. Then follow only that packet and return $request durably through the component handoff."
{
    printf '#!/usr/bin/env bash\n'
    printf 'exec '
    printf '%q ' "$copilot_bin" --no-auto-update --yolo -C "$component_entry" -i "$initial_prompt"
    printf '\n'
} >"$runner"
chmod 700 "$runner"

{
    printf 'owner-recovery started: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf 'component: %s\nrequest: %s\n' "$component" "$request"
    printf 'pm-head: %s\nrequest-blob: %s\n' "$pm_head" "$request_blob"
    printf 'component-branch: %s\ncomponent-head: %s\n' "$component_branch" "$component_head"
    printf 'tracked-diff-sha256: %s\n' "${metadata[tracked-diff-sha256]}"
    printf 'packet: %s\npacket-sha256: %s\n' "$packet" "$packet_sha"
    printf 'transcript: %s\npre-status:\n%s\n' "$transcript" "$expected_status"
} >"$log"
printf 'owner-recovery log: %s\n' "$log"
printf 'owner-recovery transcript: %s\n' "$transcript"
printf 'owner-recovery launch: copilot --no-auto-update --yolo -C %s -i <packet locator>\n' \
    "$component_entry"

runner_command=$(printf '%q' "$runner")
set +e
script --quiet --flush --return --command "$runner_command" "$transcript"
copilot_status=$?
set -e
post_head=$(git_safe -C "$component_root" rev-parse --verify HEAD 2>/dev/null || printf unknown)
post_status=$(git_safe -C "$component_root" status --porcelain=v1 --untracked-files=all 2>/dev/null || printf unknown)
{
    printf 'owner-recovery finished: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf 'copilot-exit: %s\npost-head: %s\npost-status:\n' "$copilot_status" "$post_head"
    [[ -n $post_status ]] && printf '%s\n' "$post_status" || printf '<clean>\n'
} >>"$log"
rm -f -- "$runner"
runner=
trap - EXIT HUP INT TERM
exit "$copilot_status"
