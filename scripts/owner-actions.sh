#!/usr/bin/env bash
# owner-actions.sh -- HUMAN-RUN helper for the owner-side actions that the
# Beryllium Project Manager records (outbox/component-requests.md, HANDOFF.md)
# but never performs: reviewing the commits a push would publish, fast-forward
# pushing component branches to their private remotes, backing up this
# repository and the parent, opt-in creation of one backup remote, and the
# fetch that lets the next coordination turn observe the result.
#
# This script is never executed by the Project Manager agent, in any mode:
# fetch, push, remote creation, and gh are outside its execution boundary
# (AGENT-INTERFACE.md "Execution boundary"). You run it, as component owner and
# responsible human. It never forces a push, never rewrites history, and never
# changes a worktree: it reads, fetches, and fast-forward pushes only.
#
# usage:
#   bash ./scripts/owner-actions.sh [--plan] [--yes] [--full-diff] [--no-log]
#                                   [--only step[,step...]] [--skip step[,step...]]
#                                   [--fvr-backup] [--helium-branches]
#                                   [--helium-only name[,name...]]
#
# default steps, in order (preflight always runs):
#   preflight       resolve topology; gh auth status; remote reachability table
#   review          list the commits each selected push would publish
#   push_awb        analysis-workbook          main -> origin
#   push_tm         threat-modeler             main -> origin        (PMR-005)
#   push_xrv        xrv-research-repo          main -> origin        (PMR-013; skipped while
#                   origin is in the unreachable jamorris_microsoft namespace)
#   push_pm         project-manager main -> origin; parent main -> backup
#   fetch_snapshot  fetch every reachable remote of every registered entry, then
#                   run the Project Manager restart snapshot (read-only)
# opt-in steps (never run without their flag):
#   push_fvr        --fvr-backup: gh repo create beryllium-project/formal-verification-research
#                   --private (if absent), add remote "backup" (origin untouched),
#                   push -u backup main                              (PMR-001)
#   push_helium     --helium-branches: push -u origin every helium-te-poc local
#                   branch that has no upstream; --helium-only a,b restricts to
#                   the named branches                              (PMR-018)
#
#   --plan       print what would run; perform only read-only checks
#   --yes        answer every prompt yes (a dirty worktree is still skipped)
#   --full-diff  full patches in the review step instead of --stat
#   --no-log     do not write the log under scratch/owner-actions/ (ignored by Git)
#
# exit status: 0 when every selected step completed or was skipped by you;
# 1 when a push, verification, or precondition failed; 2 on a usage error.

set -euo pipefail
export LC_ALL=C
export GIT_TERMINAL_PROMPT=0

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
if ! pm_root=$(git -C "$script_dir" rev-parse --show-toplevel 2>/dev/null); then
    printf 'owner-actions: ERROR: %s is not inside a Git repository\n' "$script_dir" >&2
    exit 2
fi
ws_root=$(cd -- "$pm_root/.." && pwd -P)

YES=0
PLAN=0
FULL_DIFF=0
FVR=0
HELIUM=0
NOLOG=0
STOP=0
helium_only=''
only=''
skip=''
log_file=''
tee_pid=''

all_steps=(preflight review push_awb push_tm push_xrv push_fvr push_helium push_pm fetch_snapshot)
all_csv=$(IFS=,; printf '%s' "${all_steps[*]}")

done_list=()
planned_list=()
skipped_list=()
failed_list=()

declare -A RH=()
declare -A RH_RC=()

usage() {
    sed -n '2,/^set -euo pipefail$/p' "${BASH_SOURCE[0]}" | grep -E '^#' | sed -E 's/^# ?//'
}

usage_error() {
    printf 'owner-actions: ERROR: %s\n\n' "$*" >&2
    usage >&2
    exit 2
}

note() { printf 'owner-actions: %s\n' "$*"; }
warn() { printf 'owner-actions: WARNING: %s\n' "$*"; }
die()  { printf 'owner-actions: ERROR: %s\n' "$*"; exit 1; }
hr()   { printf '\n== %s ==\n' "$*"; }
short() { printf '%s' "${1:0:7}"; }
list_has() { [[ ",$1," == *",$2,"* ]]; }

# --- arguments ---------------------------------------------------------------

while (($#)); do
    case $1 in
        --yes) YES=1 ;;
        --plan) PLAN=1 ;;
        --full-diff) FULL_DIFF=1 ;;
        --fvr-backup) FVR=1 ;;
        --helium-branches) HELIUM=1 ;;
        --no-log) NOLOG=1 ;;
        --helium-only)
            if (($# < 2)); then usage_error "--helium-only needs a value"; fi
            helium_only=$2
            shift
            ;;
        --only)
            if (($# < 2)); then usage_error "--only needs a value"; fi
            only=$2
            shift
            ;;
        --skip)
            if (($# < 2)); then usage_error "--skip needs a value"; fi
            skip=$2
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *) usage_error "unknown argument: $1" ;;
    esac
    shift
done

validate_step_list() {
    local csv=$1 flag=$2 s
    local -a arr=()
    IFS=',' read -r -a arr <<<"$csv"
    for s in "${arr[@]}"; do
        if ! list_has "$all_csv" "$s"; then
            usage_error "$flag: unknown step '$s' (steps: $all_csv)"
        fi
        if [[ $flag == --only && $s == push_fvr && $FVR == 0 ]]; then
            usage_error "--only push_fvr needs --fvr-backup"
        fi
        if [[ $flag == --only && $s == push_helium && $HELIUM == 0 ]]; then
            usage_error "--only push_helium needs --helium-branches"
        fi
    done
    return 0
}

if [[ -n $only ]]; then validate_step_list "$only" --only; fi
if [[ -n $skip ]]; then validate_step_list "$skip" --skip; fi
if [[ -n $helium_only && $HELIUM == 0 ]]; then
    usage_error "--helium-only needs --helium-branches"
fi

selected=()
for s in "${all_steps[@]}"; do
    case $s in
        preflight) continue ;;
        push_fvr) if ((FVR == 0)); then continue; fi ;;
        push_helium) if ((HELIUM == 0)); then continue; fi ;;
    esac
    if [[ -n $only ]] && ! list_has "$only" "$s"; then continue; fi
    if [[ -n $skip ]] && list_has "$skip" "$s"; then continue; fi
    selected+=("$s")
done

# --- log ---------------------------------------------------------------------

if ((NOLOG == 0)); then
    log_dir=$pm_root/scratch/owner-actions
    mkdir -p "$log_dir"
    log_file=$log_dir/owner-actions-$(date -u +%Y%m%dT%H%M%SZ).log
    exec > >(tee -a "$log_file") 2>&1
    tee_pid=${!:-}
fi

cleanup() {
    local rc=$?
    if [[ -n $tee_pid ]]; then
        exec >&- 2>&-
        wait "$tee_pid" 2>/dev/null || true
    fi
    exit "$rc"
}
trap cleanup EXIT

# --- helpers -----------------------------------------------------------------

# Print a remote as owner/repo, without protocol, host, embedded credentials,
# or the .git suffix.
remote_slug() {
    printf '%s' "$1" | sed -E 's#^[a-z+]+://([^@/]+@)?[^/]+/##; s#^[^@/]+@[^:]+:##; s#^/+##; s#\.git/?$##'
}

# remote_head <dir> <remote> <branch>: prints the live remote head.
# exit 0 found, 2 branch absent on a reachable remote, 1 unreachable/timeout.
remote_head() {
    local out='' rc=0
    out=$(timeout 45 git -C "$1" ls-remote --exit-code --heads "$2" "refs/heads/$3" 2>/dev/null) || rc=$?
    case $rc in
        0) printf '%s' "${out%%[[:space:]]*}"; return 0 ;;
        2) return 2 ;;
        *) return 1 ;;
    esac
}

# prime_remote_head <dir> <remote> <branch>: queries once (in the parent
# shell, so the cache persists) and stores the result in RH / RH_RC.
prime_remote_head() {
    local key="$1|$2|$3"
    if [[ -n ${RH_RC[$key]+x} ]]; then return 0; fi
    local sha='' rc=0
    sha=$(remote_head "$1" "$2" "$3") || rc=$?
    RH[$key]=$sha
    RH_RC[$key]=$rc
    return 0
}

# cached_remote_head <dir> <remote> <branch>: prints the cached live head with
# remote_head's exit status; call prime_remote_head first when used in $(...).
cached_remote_head() {
    local key="$1|$2|$3"
    prime_remote_head "$1" "$2" "$3"
    printf '%s' "${RH[$key]}"
    return "${RH_RC[$key]}"
}

is_repo() {
    [[ -d $1 ]] && git -C "$1" rev-parse --show-toplevel >/dev/null 2>&1
}

confirm() {
    if ((YES)); then
        printf 'owner-actions: auto-confirmed (--yes): %s\n' "$1"
        return 0
    fi
    if [[ ! -t 0 ]]; then
        die "stdin is not a terminal; use --yes or --plan"
    fi
    local reply=''
    read -r -p "$1 [y/N] " reply
    [[ $reply == [yY] || $reply == [yY][eE][sS] ]]
}

run() {
    printf '+ %s\n' "$*"
    if ((PLAN)); then return 0; fi
    "$@"
}

# step | label | dir | remote | branch | set-upstream
targets=(
    "push_awb|analysis-workbook|$ws_root/analysis-workbook|origin|main|0"
    "push_tm|threat-modeler|$ws_root/threat-modeler|origin|main|0"
    "push_xrv|xrv-research-repo|$ws_root/xrv-research-repo|origin|main|0"
    "push_fvr|formal-verification-research|$ws_root/formal-verification-research|backup|main|1"
    "push_pm|project-manager|$pm_root|origin|main|0"
    "push_pm|parent coordination repository|$ws_root|backup|main|0"
)

target_selected() {
    local step=$1
    case $step in
        push_fvr) if ((FVR == 0)); then return 1; fi ;;
    esac
    if [[ -n $only ]] && ! list_has "$only" "$step"; then return 1; fi
    if [[ -n $skip ]] && list_has "$skip" "$step"; then return 1; fi
    return 0
}

helium_local_only_branches() {
    local name head up
    while IFS=' ' read -r name head up; do
        if [[ -n $up ]]; then continue; fi
        if [[ -n $helium_only ]] && ! list_has "$helium_only" "$name"; then continue; fi
        printf '%s %s\n' "$name" "$head"
    done < <(git -C "$ws_root/helium-te-poc" for-each-ref \
        --format='%(refname:short) %(objectname) %(upstream)' refs/heads)
    return 0
}

# --- do_push <step> <label> <dir> <remote> <branch> <set-upstream> -----------

do_push() {
    local step=$1 label=$2 dir=$3 remote=$4 branch=$5 setu=$6
    local id="$label: $branch -> $remote"
    hr "$step: $id"
    if ! is_repo "$dir"; then
        warn "no Git repository at $dir; skipping"
        skipped_list+=("$id: no repository")
        return 0
    fi
    local url=''
    if ! url=$(git -C "$dir" remote get-url "$remote" 2>/dev/null); then
        warn "remote '$remote' is not configured; skipping"
        skipped_list+=("$id: remote '$remote' not configured")
        return 0
    fi
    local slug
    slug=$(remote_slug "$url")
    if [[ $url == *jamorris_microsoft* ]]; then
        warn "remote '$remote' ($slug) is in the unreachable jamorris_microsoft namespace; skipping. Decide the remote first."
        skipped_list+=("$id: unreachable namespace")
        return 0
    fi
    local local_head=''
    if ! local_head=$(git -C "$dir" rev-parse --verify --quiet "refs/heads/$branch"); then
        warn "no local branch '$branch'; skipping"
        skipped_list+=("$id: no local branch")
        return 0
    fi
    local dirty
    dirty=$(git -C "$dir" status --porcelain | wc -l)
    local rhead='' rc=0
    prime_remote_head "$dir" "$remote" "$branch"
    rhead=$(cached_remote_head "$dir" "$remote" "$branch") || rc=$?
    local range_desc count
    case $rc in
        1)
            warn "remote '$remote' ($slug) is unreachable or not authenticated from here (ls-remote failed); skipping. Check: gh auth status; gh auth setup-git"
            skipped_list+=("$id: unreachable or unauthenticated")
            return 0
            ;;
        2)
            note "remote '$remote' ($slug) has no branch '$branch' yet; the push creates it"
            count=$(git -C "$dir" rev-list --count "$local_head")
            range_desc="new branch, $count commit(s) up to $(short "$local_head")"
            ;;
        0)
            if [[ $rhead == "$local_head" ]]; then
                note "already up to date: $remote/$branch is at $(short "$local_head")"
                if ((setu)) && ! git -C "$dir" rev-parse --abbrev-ref --symbolic-full-name \
                    "$branch@{upstream}" >/dev/null 2>&1; then
                    note "no upstream configured; to track it: git -C $dir branch -u $remote/$branch $branch"
                fi
                skipped_list+=("$id: up to date at $(short "$local_head")")
                return 0
            fi
            if ! git -C "$dir" merge-base --is-ancestor "$rhead" "$local_head" 2>/dev/null; then
                warn "remote head $(short "$rhead") is not an ancestor of local $branch ($(short "$local_head")): not a fast-forward. Fetch and reconcile it yourself; nothing is forced."
                failed_list+=("$id: not a fast-forward")
                return 1
            fi
            count=$(git -C "$dir" rev-list --count "$rhead..$local_head")
            range_desc="$count commit(s), $(short "$rhead")..$(short "$local_head")"
            ;;
    esac
    note "target $slug ($remote/$branch): $range_desc"
    if ((dirty)); then
        warn "worktree has $dirty changed entr(y/ies); another session may be active here. A push publishes committed history only."
        if ((YES)); then
            warn "--yes does not cover a dirty worktree; skipping (run without --yes to decide)"
            skipped_list+=("$id: dirty worktree")
            return 0
        fi
    fi
    local -a cmd=(git -C "$dir" push)
    if ((setu)); then cmd+=(-u); fi
    cmd+=("$remote" "$branch")
    if ((PLAN)); then
        printf 'would run: %s\n' "${cmd[*]}"
        planned_list+=("$id: $range_desc")
        return 0
    fi
    if ! confirm "Push $id ($range_desc)?"; then
        note "skipped by you"
        skipped_list+=("$id: declined")
        return 0
    fi
    if ! run "${cmd[@]}"; then
        warn "push failed. Credentials: gh auth status; gh auth setup-git. Nothing is forced."
        failed_list+=("$id: push failed")
        return 1
    fi
    local vhead='' vrc=0
    vhead=$(remote_head "$dir" "$remote" "$branch") || vrc=$?
    if ((vrc == 0)) && [[ $vhead == "$local_head" ]]; then
        note "verified with ls-remote: $remote/$branch is at $(short "$local_head")"
        done_list+=("$id: pushed $range_desc; verified $(short "$local_head")")
        return 0
    fi
    warn "verification failed: ls-remote reports '${vhead:-none}' (rc=$vrc)"
    failed_list+=("$id: pushed but not verified")
    return 1
}

# --- steps -------------------------------------------------------------------

step_preflight() {
    hr "preflight"
    note "project-manager: $pm_root"
    note "workspace root: $ws_root"
    if [[ ! -f $ws_root/SOT.md || ! -f $ws_root/COMPONENTS.md ]]; then
        die "$ws_root lacks SOT.md or COMPONENTS.md: not the Beryllium workspace root"
    fi
    if [[ $(git -C "$ws_root" rev-parse --show-toplevel 2>/dev/null) != "$ws_root" ]]; then
        die "$ws_root is not the top of the parent coordination repository"
    fi
    local mode=execute prompts='per step'
    if ((PLAN)); then mode=plan; fi
    if ((YES)); then prompts='auto-yes'; fi
    note "mode: $mode; prompts: $prompts"
    note "steps: ${selected[*]:-none}"
    if [[ -n $log_file ]]; then note "log: $log_file"; fi
    printf '\n-- gh auth status --\n'
    if command -v gh >/dev/null 2>&1; then
        if ! gh auth status 2>&1; then
            warn "gh is not authenticated. HTTPS pushes need a credential helper: gh auth login; gh auth setup-git"
        fi
    else
        warn "gh is not installed: --fvr-backup is unavailable and HTTPS pushes need another credential helper"
    fi
    printf '\n-- push targets (label, branch, local head, dirty entries, remote, slug, live remote head) --\n'
    local t tstep label dir remote branch setu
    for t in "${targets[@]}"; do
        IFS='|' read -r tstep label dir remote branch setu <<<"$t"
        if ! target_selected "$tstep"; then continue; fi
        local lhead='(no repo)' dirty='-' url='' slug='(none)' live='' rc=0
        if is_repo "$dir"; then
            lhead=$(git -C "$dir" rev-parse --verify --quiet --short "refs/heads/$branch" 2>/dev/null || printf '(no %s)' "$branch")
            dirty=$(git -C "$dir" status --porcelain | wc -l)
            if url=$(git -C "$dir" remote get-url "$remote" 2>/dev/null); then
                slug=$(remote_slug "$url")
                if [[ $url == *jamorris_microsoft* ]]; then
                    live='unreachable namespace'
                else
                    prime_remote_head "$dir" "$remote" "$branch"
                    live=$(cached_remote_head "$dir" "$remote" "$branch") || rc=$?
                    case $rc in
                        0) live=$(short "$live") ;;
                        2) live='absent' ;;
                        *) live='unreachable/unauthenticated' ;;
                    esac
                fi
            else
                live='remote not configured'
            fi
        fi
        printf '%-32s %-6s %-9s %-5s %-7s %-48s %s\n' "$label" "$branch" "$lhead" "$dirty" "$remote" "$slug" "$live"
    done
    return 0
}

review_target() {
    local label=$1 dir=$2 remote=$3 branch=$4
    printf '\n-- %s: %s -> %s --\n' "$label" "$branch" "$remote"
    if ! is_repo "$dir"; then
        warn "no Git repository at $dir"
        return 0
    fi
    local url=''
    if ! url=$(git -C "$dir" remote get-url "$remote" 2>/dev/null); then
        note "remote '$remote' is not configured; nothing to compare against"
        return 0
    fi
    local local_head=''
    if ! local_head=$(git -C "$dir" rev-parse --verify --quiet "refs/heads/$branch"); then
        warn "no local branch '$branch'"
        return 0
    fi
    local base='' rhead='' rc=0
    if [[ $url == *jamorris_microsoft* ]]; then
        note "remote '$remote' is the unreachable namespace; comparing with the local remote-tracking ref"
    else
        prime_remote_head "$dir" "$remote" "$branch"
        rhead=$(cached_remote_head "$dir" "$remote" "$branch") || rc=$?
        case $rc in
            0) base=$rhead; note "live $remote/$branch: $(short "$rhead")" ;;
            2) note "live remote has no '$branch' yet" ;;
            *) note "remote unreachable or not authenticated; comparing with the local remote-tracking ref" ;;
        esac
    fi
    if [[ -z $base ]]; then
        base=$(git -C "$dir" rev-parse --verify --quiet "refs/remotes/$remote/$branch" 2>/dev/null) || base=''
    fi
    local -a logargs=(log --date=short --format='%h  %ad  %an  %s')
    if ((FULL_DIFF)); then logargs+=(-p); else logargs+=(--stat); fi
    local -a rangeargs=()
    if [[ -n $base ]] && git -C "$dir" merge-base --is-ancestor "$base" "$local_head" 2>/dev/null; then
        local n
        n=$(git -C "$dir" rev-list --count "$base..$local_head")
        note "$n outgoing commit(s): $(short "$base")..$(short "$local_head")"
        if ((n == 0)); then return 0; fi
        rangeargs=("$base..$local_head")
    elif [[ -n $base ]]; then
        warn "base $(short "$base") is not an ancestor of $branch ($(short "$local_head")): not a fast-forward; reconcile it yourself"
        return 0
    else
        note "no base to compare with; showing the newest 20 commits of $branch"
        rangeargs=(-n 20 "$local_head")
    fi
    git -C "$dir" "${logargs[@]}" "${rangeargs[@]}"
    local carried
    carried=$(git -C "$dir" log --format='%h  %s' "${rangeargs[@]}" | grep -E 'PMR-[0-9]{3}|PML-[0-9]{4}' || true)
    if [[ -n $carried ]]; then
        printf 'Project Manager-carried commits in this range (subject names a PMR/PML identifier):\n%s\n' "$carried"
    fi
    return 0
}

review_helium() {
    local dir=$ws_root/helium-te-poc
    printf '\n-- helium-te-poc: local branches without an upstream (PMR-018) --\n'
    if ! is_repo "$dir"; then
        warn "no Git repository at $dir"
        return 0
    fi
    local name head rhead rc state
    while read -r name head; do
        rc=0
        prime_remote_head "$dir" origin "$name"
        rhead=$(cached_remote_head "$dir" origin "$name") || rc=$?
        case $rc in
            0)
                if [[ $rhead == "$head" ]]; then
                    state="origin/$name already at this head"
                else
                    state="origin/$name at $(short "$rhead") (differs)"
                fi
                ;;
            2) state='absent on origin: a push creates it' ;;
            *) state='origin unreachable/unauthenticated' ;;
        esac
        printf '%-40s %s  %s\n' "$name" "$(short "$head")" "$state"
    done < <(helium_local_only_branches)
    return 0
}

step_review() {
    hr "review: commits each selected push would publish"
    local t tstep label dir remote branch setu
    for t in "${targets[@]}"; do
        IFS='|' read -r tstep label dir remote branch setu <<<"$t"
        if ! target_selected "$tstep"; then continue; fi
        review_target "$label" "$dir" "$remote" "$branch"
    done
    if ((HELIUM)) && target_selected push_helium; then review_helium; fi
    if ((PLAN == 0 && YES == 0)); then
        if ! confirm "Reviewed the commits above; continue to the pushes?"; then
            note "stopped after review by you"
            STOP=1
        fi
    fi
    return 0
}

run_targets() {
    local step=$1 rc=0 t tstep label dir remote branch setu
    for t in "${targets[@]}"; do
        IFS='|' read -r tstep label dir remote branch setu <<<"$t"
        if [[ $tstep != "$step" ]]; then continue; fi
        do_push "$tstep" "$label" "$dir" "$remote" "$branch" "$setu" || rc=1
    done
    return "$rc"
}

step_push_fvr() {
    local dir=$ws_root/formal-verification-research
    local slug=beryllium-project/formal-verification-research
    local want_url="https://github.com/$slug.git"
    hr "push_fvr: private backup remote for formal-verification-research (PMR-001)"
    if ! is_repo "$dir"; then
        warn "no Git repository at $dir; skipping"
        skipped_list+=("formal-verification-research: no repository")
        return 0
    fi
    if ! command -v gh >/dev/null 2>&1; then
        warn "gh is not installed; cannot create or check $slug"
        failed_list+=("push_fvr: gh missing")
        return 1
    fi
    if gh repo view "$slug" --json name >/dev/null 2>&1; then
        note "repository $slug exists and is visible to the gh account"
    else
        note "repository $slug does not exist or is not visible to the gh account"
        if ((PLAN)); then
            printf 'would run: gh repo create %s --private\n' "$slug"
        else
            if ! confirm "Create the private repository $slug with gh?"; then
                note "skipped by you"
                skipped_list+=("push_fvr: repository creation declined")
                return 0
            fi
            if ! run gh repo create "$slug" --private; then
                failed_list+=("push_fvr: gh repo create failed")
                return 1
            fi
        fi
    fi
    local url=''
    if url=$(git -C "$dir" remote get-url backup 2>/dev/null); then
        if [[ $(remote_slug "$url") != "$slug" ]]; then
            warn "remote 'backup' already points at $(remote_slug "$url"), not $slug; not changing it"
            failed_list+=("push_fvr: remote 'backup' points elsewhere")
            return 1
        fi
        note "remote 'backup' is already configured for $slug"
    else
        if ((PLAN)); then
            printf 'would run: git -C %s remote add backup %s\n' "$dir" "$want_url"
            printf 'would run: git -C %s push -u backup main\n' "$dir"
            planned_list+=("formal-verification-research: main -> backup (new remote $slug)")
            return 0
        fi
        if ! confirm "Add remote 'backup' -> $slug in formal-verification-research (origin untouched)?"; then
            note "skipped by you"
            skipped_list+=("push_fvr: remote addition declined")
            return 0
        fi
        if ! run git -C "$dir" remote add backup "$want_url"; then
            failed_list+=("push_fvr: remote add failed")
            return 1
        fi
    fi
    do_push push_fvr formal-verification-research "$dir" backup main 1
}

step_push_helium() {
    local dir=$ws_root/helium-te-poc rc=0
    hr "push_helium: helium-te-poc local branches without an upstream -> origin (PMR-018)"
    if ! is_repo "$dir"; then
        warn "no Git repository at $dir; skipping"
        skipped_list+=("helium-te-poc: no repository")
        return 0
    fi
    note "Candidate and approved assurance refs are review-visible. Pushing them to the private origin is your decision as owner; nothing becomes public."
    local -a names=()
    local name head
    while read -r name head; do
        names+=("$name")
    done < <(helium_local_only_branches)
    if [[ -n $helium_only ]]; then
        local -a want=()
        local w names_csv
        names_csv=$(IFS=,; printf '%s' "${names[*]:-}")
        IFS=',' read -r -a want <<<"$helium_only"
        for w in "${want[@]}"; do
            if ! list_has "$names_csv" "$w"; then
                warn "--helium-only: '$w' is not a local branch without an upstream; ignored"
            fi
        done
    fi
    if ((${#names[@]} == 0)); then
        note "no matching branch; nothing to push"
        return 0
    fi
    for name in "${names[@]}"; do
        do_push push_helium helium-te-poc "$dir" origin "$name" 1 || rc=1
    done
    return "$rc"
}

step_fetch_snapshot() {
    hr "fetch_snapshot: fetch every reachable remote, then the Project Manager restart snapshot"
    local -a entries=("$ws_root" "$pm_root")
    local e dir r url
    for e in helium-te-poc formal-verification-research osr-claude provenance-review \
        analysis-workbook threat-modeler beryllium-repo cheri-riscv-notes-repo xrv-research-repo; do
        entries+=("$ws_root/$e")
    done
    for dir in "${entries[@]}"; do
        if ! is_repo "$dir"; then
            warn "skipping $dir: not a Git repository"
            continue
        fi
        for r in $(git -C "$dir" remote); do
            url=$(git -C "$dir" remote get-url "$r" 2>/dev/null) || continue
            if [[ $url == *jamorris_microsoft* ]]; then
                note "$(basename "$dir"): remote '$r' is the unreachable namespace; not fetched"
                continue
            fi
            if ((PLAN)); then
                printf 'would run: git -C %s fetch %s\n' "$dir" "$r"
                continue
            fi
            printf '+ git -C %s fetch %s\n' "$dir" "$r"
            if ! timeout 120 git -C "$dir" fetch "$r" 2>&1; then
                warn "$(basename "$dir"): fetch '$r' failed or timed out"
            fi
        done
    done
    printf '\n-- Project Manager restart snapshot (read-only) --\n'
    bash "$pm_root/scripts/inspect-components.sh" status || warn "inspect-components.sh status exited non-zero"
    bash "$pm_root/scripts/inspect-components.sh" registry-check \
        || warn "registry-check reports drift; run a Project Manager coordination turn"
    return 0
}

print_list() {
    local title=$1
    shift
    if (($# == 0)); then return 0; fi
    printf '%s (%d):\n' "$title" "$#"
    local i
    for i in "$@"; do printf '  - %s\n' "$i"; done
    return 0
}

summary() {
    hr "summary"
    print_list "done" "${done_list[@]+"${done_list[@]}"}"
    print_list "planned (--plan)" "${planned_list[@]+"${planned_list[@]}"}"
    print_list "skipped" "${skipped_list[@]+"${skipped_list[@]}"}"
    print_list "failed" "${failed_list[@]+"${failed_list[@]}"}"
    printf '\nStill yours (not scriptable):\n'
    printf '  - PMR-016: triage HET-001 (../analysis-workbook/outbox/helium-transfer-queue.md) under Beryllium planning controls; planning input, not authorization\n'
    printf '  - Decide the lost retained PM artifacts (HANDOFF.md "Retained PM session artifacts")\n'
    printf '  - PMR-009 (cheri-riscv-notes-repo pointers, gate D4); PMR-014 (formal-verification-research owner alignment); PMR-002 (osr-claude handoff); PMR-003 (beryllium-repo planning wording)\n'
    printf '\nNext: in %s start Copilot CLI, select /agent project-manager, and tell it what this run did; the coordination turn records it from your statement and the observed remote state.\n' "$pm_root"
    if [[ -n $log_file ]]; then printf 'Log: %s\n' "$log_file"; fi
    return 0
}

main() {
    local rc=0 s
    step_preflight
    for s in "${selected[@]+"${selected[@]}"}"; do
        if ((STOP)); then break; fi
        case $s in
            review) step_review || rc=1 ;;
            push_awb|push_tm|push_xrv|push_pm) run_targets "$s" || rc=1 ;;
            push_fvr) step_push_fvr || rc=1 ;;
            push_helium) step_push_helium || rc=1 ;;
            fetch_snapshot) step_fetch_snapshot || rc=1 ;;
        esac
    done
    summary
    if ((${#failed_list[@]} > 0)); then rc=1; fi
    return "$rc"
}

main
