#!/usr/bin/env bash
# HUMAN-RUN launcher for an ordinary component owner session. It creates a
# revision-bound packet under ignored Project Manager scratch space and starts
# Copilot with a short initial prompt that points to that packet.

set -euo pipefail
export LC_ALL=C
umask 077

preflight_log=
preflight_log_finalized=0
owner_stage=not-started
owner_result=in-progress
owner_reason=none
packet=
packet_cleanup=0
bootstrap_review_id=resume-threat-owner-rollout-20261002-06
bootstrap_review_verdict=adjust
bootstrap_review_authority=steering_only_no_approval_or_human_gate
bootstrap_review_source_request_blob=9c289ab88a4202efb20e5e88ae994f6572c59a75
bootstrap_applied_request_blob=78681ba5f4645db4d0b717e250871a3f42fb816c
bootstrap_review_sot_sha=5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68
bootstrap_review_component_head=c4126b6d77f7cd14f7477795e3b8b971b6b58b37

write_preflight_log() {
    [[ -n $preflight_log ]] || return 0
    {
        printf 'schema=OWNER_SESSION_PREFLIGHT_V1\n'
        printf 'timestamp=%s\n' "$timestamp"
        printf 'mode=%s\n' "$mode"
        printf 'component=%s\n' "$component"
        printf 'agent=%s\n' "$selected_agent"
        printf 'requests=%s\n' "$requests_value"
        printf 'tasking_bootstrap=%s\n' "$bootstrap_value"
        printf 'stage=%s\n' "$owner_stage"
        printf 'result=%s\n' "$owner_result"
        printf 'reason=%s\n' "$owner_reason"
    } >"$preflight_log"
}

owner_session_exit() {
    local status=$?
    if [[ -n $preflight_log && $preflight_log_finalized == 0 ]]; then
        owner_result=error
        owner_reason=unexpected-exit
        write_preflight_log || true
        preflight_log_finalized=1
    fi
    if ((packet_cleanup)) && [[ -n $packet ]]; then
        rm -f -- "$packet"
    fi
    return "$status"
}

usage() {
    cat >&2 <<'EOF'
Usage:
  owner-session.sh [--tasking-bootstrap] [--agent <component-agent>] prepare <component> <PMR-NNN>...
  owner-session.sh [--tasking-bootstrap] [--agent <component-agent>] launch  <component> <PMR-NNN>...

prepare  validate tasking and component state, write the ignored owner packet,
         and print its path and hash without launching Copilot or reserving a
         writer
launch   perform the same fail-closed preparation, then start an interactive
         `copilot --no-auto-update --yolo` session with the packet preloaded;
         hold one per-component writer reservation until Copilot exits

This is a human-run ordinary-owner path. It does not invoke a hidden owner
worker, grant a human gate, push, or write inside the component before Copilot
starts. Each selected PMR must be open and directly assigned to the component.
After syntactically valid component/PMR parsing, each attempt maintains one
private fixed-field state log under `scratch/owner-sessions/preflight/`.
It records preflight stage/result only, never command output or a Copilot
transcript. No log means the launcher did not reach validated preflight
logging, for example because it stopped during usage/argument parsing or
could not create the private scratch path.

--tasking-bootstrap is a one-time repair admitted only for exact
`--agent threat-model-maintainer ... threat-modeler PMR-120`. It
uses the launcher's already validated, embedded tasking because the current
component policy does not yet permit the resolver command during hidden-owner
adoption. It grants no general resolver bypass or authority for another
request.
EOF
}

die() {
    if [[ -n $preflight_log ]]; then
        owner_result=error
        owner_reason=preflight-failed
        write_preflight_log || true
        preflight_log_finalized=1
    fi
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
tasking_bootstrap=0
while (($# >= 1)); do
    case $1 in
    --agent)
        (($# >= 2)) || die "--agent requires a component agent name"
        [[ -z $owner_agent ]] || die "--agent was specified more than once"
        owner_agent=$2
        shift 2
        [[ $owner_agent =~ ^[a-z0-9][a-z0-9-]*$ ]] ||
            die "invalid component agent name: $owner_agent"
        ;;
    --tasking-bootstrap)
        ((tasking_bootstrap == 0)) ||
            die "--tasking-bootstrap was specified more than once"
        tasking_bootstrap=1
        shift
        ;;
    *) break ;;
    esac
done

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

mkdir -p -- "$scratch_root/preflight"
timestamp=$(date -u +%Y%m%dT%H%M%SZ)
pmr_slug=$(IFS=-; printf '%s' "${pmrs[*]}")
requests_value=$(IFS=,; printf '%s' "${pmrs[*]}")
selected_agent=${owner_agent:-ordinary-default}
if ((tasking_bootstrap)); then
    bootstrap_value=yes
else
    bootstrap_value=no
fi
preflight_log=$(mktemp \
    "$scratch_root/preflight/$timestamp-$component-$pmr_slug.XXXXXX.log") ||
    die "cannot create owner preflight log"
owner_stage=arguments-validated
write_preflight_log
trap owner_session_exit EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

if ((tasking_bootstrap)); then
    owner_stage=bootstrap-admission
    write_preflight_log
    [[ $owner_agent == threat-model-maintainer ]] ||
        die "--tasking-bootstrap requires --agent threat-model-maintainer"
    [[ $component == threat-modeler ]] ||
        die "--tasking-bootstrap is admitted only for threat-modeler"
    ((${#pmrs[@]} == 1)) && [[ ${pmrs[0]} == PMR-120 ]] ||
        die "--tasking-bootstrap requires exact request PMR-120"
fi

owner_stage=component-entry
write_preflight_log
component_entry=$workspace_root/$component
[[ -e $component_entry ]] || die "component entry is unreachable: $component"
component_root=$(CDPATH= cd -- "$component_entry" 2>/dev/null && pwd -P) ||
    die "component repository is unreachable: $component"
if [[ $mode == launch ]]; then
    owner_stage=acquire-locks
    write_preflight_log
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
owner_stage=component-state
write_preflight_log
[[ $(git_safe -C "$component_root" rev-parse --show-toplevel 2>/dev/null || true) == "$component_root" ]] ||
    die "component entry is not a repository root: $component"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "component worktree is dirty; another owner session may be active"
if [[ -n $owner_agent ]]; then
    [[ -f $component_root/.github/agents/$owner_agent.agent.md ]] ||
        die "selected component agent is unavailable: $owner_agent"
fi

owner_stage=project-manager-state
write_preflight_log
[[ $(git_safe -C "$pm_root" rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
    die "Project Manager repository is invalid"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree is dirty; wait for its commit and regenerated tasking"

owner_stage=tasking-current
write_preflight_log
env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" check >/dev/null ||
    die "generated Project Manager tasking is stale"

owner_stage=capture-fingerprints
write_preflight_log
pm_head=$(git_safe -C "$pm_root" rev-parse --verify HEAD) ||
    die "cannot resolve Project Manager HEAD"
request_blob=$(git_safe -C "$pm_root" rev-parse --verify \
    HEAD:outbox/component-requests.md) ||
    die "cannot resolve committed request table"
tasking_view=$pm_root/outbox/tasking/$component.md
[[ -f $tasking_view && -r $tasking_view ]] ||
    die "generated component tasking view is unavailable"
tasking_sot_sha=$(awk -F'`' \
    '/^\- \*\*Global startup\/status SHA-256:\*\*/ { print $2; exit }' \
    "$tasking_view")
[[ $tasking_sot_sha =~ ^[0-9a-f]{64}$ ]] ||
    die "generated component tasking lacks a valid SOT SHA-256"
component_head=$(git_safe -C "$component_root" rev-parse --verify HEAD) ||
    die "cannot resolve component HEAD"
component_branch=$(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true)
[[ -n $component_branch ]] || component_branch=detached
component_upstream=$(git_safe -C "$component_root" rev-parse \
    --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)
[[ -n $component_upstream ]] || component_upstream=none

if ((tasking_bootstrap)); then
    owner_stage=bootstrap-review-binding
    write_preflight_log
    [[ $request_blob == "$bootstrap_applied_request_blob" ]] ||
        die "tasking-bootstrap applied request blob no longer matches"
    [[ $tasking_sot_sha == "$bootstrap_review_sot_sha" ]] ||
        die "tasking-bootstrap scope review SOT SHA-256 no longer matches"
    [[ $component_head == "$bootstrap_review_component_head" ]] ||
        die "tasking-bootstrap scope review component HEAD no longer matches"
fi

owner_stage=packet-create
write_preflight_log
packet=$(mktemp "$scratch_root/$timestamp-$component-$pmr_slug.XXXXXX.md") ||
    die "cannot create owner packet"
temp=$packet
packet_cleanup=1

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
    if ((tasking_bootstrap)); then
        printf -- '- **Tasking bootstrap:** `threat-modeler/PMR-120`\n'
        printf -- '- **Bound SOT SHA-256:** `%s`\n\n' "$tasking_sot_sha"
    fi
    cat <<EOF
## Project Manager coordination inputs

- Component card: \`$pm_root/components/$component.md\`
- Generated current tasking: \`$pm_root/outbox/tasking/$component.md\`
- Authoritative request table: \`$pm_root/outbox/component-requests.md\`

EOF
    if ((tasking_bootstrap)); then
        cat <<EOF
## Exact bootstrap scope steering

This is the scope-management skill's already-reviewed, non-expanding
continuation for this one revision-bound owner-maintenance envelope. It is
steering, not approval, authorization, risk acceptance, publication, release,
or another human gate.

- **Review ID:** \`$bootstrap_review_id\`
- **Verdict:** \`$bootstrap_review_verdict\`
- **Authority:** \`$bootstrap_review_authority\`
- **Reviewed source request blob:** \`$bootstrap_review_source_request_blob\`
- **Applied request blob:** \`$bootstrap_applied_request_blob\`
- **Reviewed SOT SHA-256:** \`$bootstrap_review_sot_sha\`
- **Reviewed threat-modeler HEAD:** \`$bootstrap_review_component_head\`
- **Applied open request:** \`PMR-120\`

The review assessed the threat-modeler-only hidden-owner adoption plan against
the source request blob above before PMR-120 existed. It did not review or
approve exact row bytes, component edit bytes, implementation, or a human
gate. The Project Manager applied the required changes, allocated PMR-120,
and bound the resulting exact request table with the applied blob above.

The exact scope envelope is only maintenance registration through these
paths: \`.github/agents/threat-modeler-owner.agent.md\`,
\`.github/copilot-instructions.md\`, \`AGENT-INTERFACE.md\`, \`README.md\`,
\`tests/validate-agent.sh\`, and \`HANDOFF.md\`. Add a hidden
\`threat-modeler-owner\` that is \`gpt-5.6-sol\` with \`max\` /
\`long_context\`, model-invocable, not user-invocable, has no \`ask_user\`,
delegation, web, or threat-modeling skill, and handles one exact PMR under a
repository-only write boundary. Its only maintained executable is
\`tests/validate-agent.sh\`; narrow local Git inspection, exact-path staging,
and validated local work/return commits are separate. It verifies packet-bound
tasking and SOT identity and returns \`OWNER_AGENT_RESPONSE_V1\` plus a
durable handoff. Preserve both existing user-facing profiles unchanged beyond
registering the hidden owner.

Do not scaffold or inspect threat packages, discover threat material, invoke a
specialist, use web, change resolver/SOT entry-point behavior, perform
PMR-064/117, or modify a model, package, queue, outbox, target, sibling,
remote, risk disposition, or human gate. The stop conditions below are the
recorded scope risks. Implementation choices wholly inside this envelope are
execution detail under the applied review steering, not a new non-trivial
plan.

Allowed owner inputs are this packet, its Project Manager coordination and
tasking files, the workspace SOT, and this threat-modeler repository. Under
PMD-20260917-001 disposition 6, this coordination-only maintenance does not
substantively consume sibling research or analysis, so
\`cross-repo-collaboration\` is not triggered and must not be loaded.

Do not invoke another scope reviewer for unchanged execution of this exact
already-reviewed envelope. If no scope-review task runner or
\`cross-repo-collaboration\` skill exists in this session, that absence is not
a blocker for this packet. Stop and return a blocked result before editing if
there is a material reassessment or replan; new human steering, requirements,
priorities, constraints, acceptance criteria, or any other material direction
change; any path or deliverable outside the envelope; any substantive sibling
research or analysis use; or any mismatch in the applied request blob,
reviewed SOT SHA-256, reviewed component HEAD, or open PMR set.
PMR-120 permits only validated local work/return commits and explicitly
excludes push; do not perform step 6 of the component's bundled
commit-and-push contract.
Stricter component-local instructions remain controlling.

EOF
    fi
    cat <<EOF
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
EOF
    if ((tasking_bootstrap)); then
        cat <<EOF
3. This is the exact one-time tasking bootstrap for
   \`threat-modeler PMR-120\`. The human-run launcher already validated
   current generated tasking and embedded the exact dispatch packet. Do not
   execute a parent or sibling script or Git command. Using
   read-only file tools, compare \`$tasking_view\` with this packet and stop
   unless its Project Manager commit is \`$pm_head\`, request blob is
   \`$request_blob\`, SOT SHA-256 is \`$tasking_sot_sha\`, component is
   \`threat-modeler\`, and PMR-120 is open and directly assigned while
   PMR-064 and PMR-117 remain separate and unselected. This exception is
   unusable after PMR-120 closes and is not a
   resolver fallback or precedent for another component or request.
EOF
    else
        cat <<EOF
3. Run the exact fail-closed resolver below. Its PM commit and request blob
   must match this packet. Never fall back to session history, task databases,
   background agents, prior chat, or memory.

   \`\`\`sh
   PM_TASKING_ROOT=$pm_root \\
   PM_TASKING_WORKSPACE=$workspace_root \\
   bash $tasking resolve $component
   \`\`\`
EOF
    fi
    cat <<EOF
4. Complete only the selected PMRs. Keep their scopes and evidence distinct,
   even if one human-started owner session handles them sequentially.
5. If a selected PMR needs a responsible-human decision, ask one short stable
   question at a time with a safe defer choice. Never infer an unanswered gate.
EOF
    if ((tasking_bootstrap)); then
        cat <<EOF
6. This packet does not trigger \`cross-repo-collaboration\`. Any substantive
   sibling research or analysis use is outside the reviewed envelope: stop and
   return blocked. The collaboration skill's absence is not a blocker for this
   coordination-only maintenance.
EOF
    else
        cat <<EOF
6. Load \`cross-repo-collaboration\` before substantively consuming,
   incorporating, qualifying, or applying sibling research or analysis.
   Pointer-only record/decline/defer does not trigger it. A missing or
   read-only source ledger grants no source write.
EOF
    fi
    cat <<EOF
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

owner_stage=dispatch-packets
write_preflight_log
for pmr in "${pmrs[@]}"; do
    env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
        bash "$tasking" dispatch "$component" "$pmr" >>"$temp" ||
        die "cannot select $pmr for $component"
    printf '\n---\n\n' >>"$temp"
done

owner_stage=final-state
write_preflight_log
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

packet_cleanup=0
packet_sha=$(sha256sum -- "$packet")
packet_sha=${packet_sha%% *}

printf 'owner-session packet: %s\n' "$packet"
printf 'owner-session sha256: %s\n' "$packet_sha"
printf 'owner-session component: %s at %s\n' "$component" "$component_head"
printf 'owner-session requests:'
printf ' %s' "${pmrs[@]}"
printf '\n'

if [[ $mode == prepare ]]; then
    owner_stage=complete
    owner_result=prepared
    owner_reason=none
    write_preflight_log
    preflight_log_finalized=1
    exit 0
fi
owner_stage=copilot-availability
write_preflight_log
if [[ $pm_root != "$default_root" && -z $copilot_bin_explicit ]]; then
    die "non-default PM_TASKING_ROOT launch requires an explicit COPILOT_BIN"
fi
command -v "$copilot_bin" >/dev/null 2>&1 ||
    die "Copilot CLI is unavailable: $copilot_bin"

owner_stage=prelaunch-state
write_preflight_log
[[ $(git_safe -C "$pm_root" rev-parse --verify HEAD) == "$pm_head" ]] ||
    die "Project Manager HEAD changed before Copilot launch"
[[ $(git_safe -C "$component_root" rev-parse --verify HEAD) == "$component_head" ]] ||
    die "component HEAD changed before Copilot launch"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree changed before Copilot launch"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "component worktree changed before Copilot launch"

if ((tasking_bootstrap)); then
    initial_prompt="Read the complete owner-session packet at $packet using read-only file tools. This human-run launcher already verified its SHA-256 is $packet_sha; do not execute a parent or sibling command to rehash or resolve tasking. Verify this repository HEAD is $component_head using repository-local read-only Git, then compare the packet's PM commit, request blob, SOT SHA-256, component, and selected request row with its read-only generated tasking view. Stop on any mismatch. Follow only that packet, stay interactive, and ask the human only for genuine unresolved gates."
else
    initial_prompt="Read the complete owner-session packet at $packet. First verify its SHA-256 is $packet_sha and this repository HEAD is $component_head. If either check fails, stop. Then follow only that packet, stay interactive, and ask the human only for genuine unresolved gates."
fi

printf 'owner-session launch: copilot --no-auto-update --yolo -C %s -i <packet locator>\n' \
    "$component_entry"
copilot_args=(--no-auto-update --yolo)
[[ -n $owner_agent ]] && copilot_args+=(--agent "$owner_agent")
copilot_args+=(-C "$component_entry" -i "$initial_prompt")
owner_stage=complete
owner_result=launching
owner_reason=none
write_preflight_log
preflight_log_finalized=1
exec "$copilot_bin" "${copilot_args[@]}"
