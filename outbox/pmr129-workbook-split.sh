#!/usr/bin/env bash

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
    printf 'ERROR: run this script with bash; do not source it\n' >&2
    return 2 2>/dev/null || exit 2
fi

set -euo pipefail
export LC_ALL=C
export GIT_TERMINAL_PROMPT=0
export GH_PROMPT_DISABLED=1
umask 077

usage() {
    cat >&2 <<'EOF'
Usage:
  pmr129-workbook-split.sh --plan
  pmr129-workbook-split.sh --execute

--plan     run every read-only preflight and print the exact split
--execute  rerun every preflight, require an interactive confirmation, then
           create the private repository, copy main and the private branch
           into it, verify both repositories, delete the private branch from
           the existing repository, and re-point the l1 checkout

This human-run script is not publication authority. Run --execute only after
the Project Manager records a fresh same-turn responsible-human confirmation.
It never changes repository visibility, rewrites history, or changes the
checked-out branch; its only change to the existing repository is deleting
the private branch. A rerun resumes from the first incomplete step.
EOF
}

die() {
    printf 'pmr129-split: ERROR: %s\n' "$*" >&2
    exit 1
}

(($# == 1)) || { usage; exit 2; }
case $1 in
--plan) mode=plan ;;
--execute) mode=execute ;;
--help|-h) usage; exit 0 ;;
*) usage; exit 2 ;;
esac

expected_component=analysis-workbook
expected_account=xjamesmorris
source_slug=beryllium-project/analysis-workbook
dest_slug=beryllium-project/analysis-workbook-private
main_branch=main
private_branch=analysis/k3-a100-service-design-private
push_disabled=DISABLED-PMR-129-publication-gate
lx2_checkout='~/src/l1/src/beryllium-project/analysis-workbook'

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
pm_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve Project Manager root"
workspace_root=$(CDPATH= cd -- "$pm_root/.." && pwd -P) ||
    die "cannot resolve workspace root"
tasking=$pm_root/scripts/project-tasking.sh
component_entry=$workspace_root/$expected_component
scratch_root=$pm_root/scratch/owner-actions
session_scratch=${PM_OWNER_SESSION_SCRATCH:-$pm_root/scratch/owner-sessions}
lock_root=$session_scratch/locks
source_url=https://github.com/$source_slug.git
dest_url=https://github.com/$dest_slug.git
work_dir=

mkdir -p -- "$scratch_root" "$lock_root"
timestamp=$(date -u +%Y%m%dT%H%M%SZ)
log_file=$scratch_root/pmr129-workbook-split-$timestamp.log
exec > >(tee -a "$log_file") 2>&1
tee_pid=${!:-}

cleanup() {
    local rc=$?
    trap - EXIT INT TERM HUP
    if [[ -n ${work_dir:-} && -d $work_dir ]]; then
        rm -rf -- "$work_dir"
    fi
    if [[ -n ${tee_pid:-} ]]; then
        exec >&- 2>&-
        wait "$tee_pid" 2>/dev/null || true
    fi
    exit "$rc"
}
trap cleanup EXIT INT TERM HUP

printf 'pmr129-log=%s\n' "$log_file"
printf 'pmr129-start=%s mode=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$mode"

command -v flock >/dev/null 2>&1 || die "flock is required"
lock_file=$lock_root/$expected_component.lock
exec {lock_fd}>"$lock_file"
flock -n "$lock_fd" ||
    die "another owner session holds the writer reservation: $expected_component"

git_safe() {
    env GIT_OPTIONAL_LOCKS=0 GIT_PAGER=cat PAGER=cat \
        git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c credential.helper= -c protocol.allow=never -c diff.external= \
        -c pager.status=false -c pager.log=false -c pager.show=false \
        -c pager.diff=false "$@"
}

git_github() {
    git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c push.followTags=false -c credential.helper= \
        -c credential.helper='!gh auth git-credential' "$@"
}

# Prints owner/name for a github.com URL; any other URL prints nothing.
github_slug() {
    local url=$1
    if [[ $url =~ ^[a-z+]+://([^@/]+@)?github\.com(:[0-9]+)?/([^/]+)/([^/]+)/?$ ]]; then
        printf '%s/%s\n' "${BASH_REMATCH[3]}" "${BASH_REMATCH[4]%.git}"
    elif [[ $url =~ ^[^@/:]+@github\.com:/?([^/]+)/([^/]+)/?$ ]]; then
        printf '%s/%s\n' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]%.git}"
    else
        return 1
    fi
}

sanitize_remote_output() {
    sed -E 's#https://github\.com/([A-Za-z0-9._-]+/[A-Za-z0-9_-]+)(\.git)?#\1#g'
}

# Prints the lower-case identity of a remote's single fetch or push URL, or
# the disabled marker; fails on zero, several, or unrecognized URLs.
single_identity() {
    local urls count
    if [[ $2 == push ]]; then
        urls=$(git_safe -C "$component_root" remote get-url --push --all "$1" 2>/dev/null) ||
            return 1
    else
        urls=$(git_safe -C "$component_root" remote get-url --all "$1" 2>/dev/null) ||
            return 1
    fi
    count=$(printf '%s\n' "$urls" | awk 'NF { c++ } END { print c + 0 }')
    ((count == 1)) || return 1
    if [[ $urls == "$push_disabled" ]]; then
        printf '%s\n' "$push_disabled"
        return 0
    fi
    github_slug "$urls" | tr '[:upper:]' '[:lower:]'
}

list_refs() {
    git_github -C "$component_root" ls-remote --heads --tags "$1" 2>/dev/null |
        awk '{ print $1 " " $2 }' | sort -k2
}

ref_sha() {
    printf '%s\n' "$1" | awk -v ref="$2" '$2 == ref { print $1 }'
}

head_names() {
    printf '%s\n' "$1" |
        awk '$2 ~ /^refs\/heads\// { sub(/^refs\/heads\//, "", $2); print $2 }' |
        sort
}

tag_count() {
    printf '%s\n' "$1" | awk '$2 ~ /^refs\/tags\// { c++ } END { print c + 0 }'
}

[[ -f $workspace_root/SOT.md && -f $workspace_root/COMPONENTS.md ]] ||
    die "workspace root lacks SOT.md or COMPONENTS.md"
[[ $(git_safe -C "$pm_root" rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
    die "Project Manager repository is invalid"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree is dirty"
[[ -f $tasking && -r $tasking ]] ||
    die "project-tasking helper is unavailable"
env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" check >/dev/null ||
    die "generated Project Manager tasking is stale"

tasking_view=$pm_root/outbox/tasking/$expected_component.md
[[ -f $tasking_view ]] || die "analysis-workbook tasking view is unavailable"
grep -Eq '^\| `PMR-129` \|' "$tasking_view" ||
    die "PMR-129 is not visible in the analysis-workbook tasking view"
grep -Eq '^\| PMR-129 \| [^|]* \| analysis-workbook \|.*\| open \| P2 \|' \
    "$pm_root/outbox/component-requests.md" ||
    die "PMR-129 is not visibly open at P2"

[[ -e $component_entry ]] ||
    die "analysis-workbook workspace entry is unavailable"
component_root=$(CDPATH= cd -- "$component_entry" 2>/dev/null && pwd -P) ||
    die "cannot resolve the analysis-workbook repository root"
[[ $(git_safe -C "$component_root" rev-parse --show-toplevel 2>/dev/null || true) == "$component_root" ]] ||
    die "analysis-workbook entry is not a repository root"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "analysis-workbook worktree is dirty"
checked_out=$(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true)
[[ -n $checked_out ]] || die "analysis-workbook HEAD is detached"
head_before=$(git_safe -C "$component_root" rev-parse --verify HEAD)
local_main=$(git_safe -C "$component_root" rev-parse --verify --quiet "refs/heads/$main_branch") ||
    die "local $main_branch is missing"
local_private=$(git_safe -C "$component_root" rev-parse --verify --quiet "refs/heads/$private_branch") ||
    die "local $private_branch is missing"

mapfile -t remotes < <(git_safe -C "$component_root" remote | sort)
remote_list=${remotes[*]-}
case $remote_list in
origin)
    origin_fetch=$(single_identity origin fetch) ||
        die "origin must have exactly one github.com fetch URL"
    origin_push=$(single_identity origin push) ||
        die "origin must have exactly one github.com push URL"
    [[ $origin_fetch == "$source_slug" && $origin_push == "$source_slug" ]] ||
        die "origin does not identify $source_slug"
    layout=pre-split
    ;;
public)
    public_fetch=$(single_identity public fetch) ||
        die "public must have exactly one github.com fetch URL"
    [[ $public_fetch == "$source_slug" ]] ||
        die "public does not identify $source_slug"
    layout=renamed
    ;;
"origin public")
    origin_fetch=$(single_identity origin fetch) ||
        die "origin must have exactly one github.com fetch URL"
    public_fetch=$(single_identity public fetch) ||
        die "public must have exactly one github.com fetch URL"
    [[ $origin_fetch == "$dest_slug" && $public_fetch == "$source_slug" ]] ||
        die "origin and public do not match the split layout"
    layout=split
    ;;
*)
    die "unexpected analysis-workbook remote layout: ${remote_list:-none}"
    ;;
esac

command -v gh >/dev/null 2>&1 || die "gh is required"
active_account=$(gh api user --jq '.login') ||
    die "cannot resolve the active GitHub account"
[[ $active_account == "$expected_account" ]] ||
    die "active GitHub account is not $expected_account"

source_fields=$(
    gh repo view "$source_slug" \
        --json 'nameWithOwner,visibility,isArchived,viewerPermission,defaultBranchRef' \
        --jq '[.nameWithOwner, .visibility, .isArchived, .viewerPermission, (.defaultBranchRef.name // "")] | @tsv'
) || die "cannot inspect the source repository"
IFS=$'\t' read -r source_identity source_visibility source_archived \
    source_permission source_default <<<"$source_fields"
[[ $source_identity == "$source_slug" ]] ||
    die "unexpected source repository identity"
[[ $source_visibility == PRIVATE ]] ||
    die "source repository is not private"
[[ $source_archived == false ]] || die "source repository is archived"
[[ $source_permission == ADMIN ]] ||
    die "active account lacks admin permission on the source repository"
[[ $source_default == "$main_branch" ]] ||
    die "source default branch is not $main_branch"

for url in "$source_url" "$dest_url"; do
    effective_url=$(git_github -C "$component_root" ls-remote --get-url "$url") ||
        die "cannot resolve an effective repository URL"
    [[ $effective_url == "$url" ]] ||
        die "Git URL rewriting changes the exact target"
done

source_refs=$(list_refs "$source_url") ||
    die "cannot inventory the source repository"
[[ $(tag_count "$source_refs") == 0 ]] ||
    die "the source repository has tags; this split moves branches only"
source_main=$(ref_sha "$source_refs" "refs/heads/$main_branch")
source_private=$(ref_sha "$source_refs" "refs/heads/$private_branch")
[[ -n $source_main ]] || die "the source repository has no $main_branch"
both_heads=$(printf '%s\n' "$main_branch" "$private_branch" | sort)
source_heads=$(head_names "$source_refs")
if [[ $source_heads == "$both_heads" ]]; then
    source_state=both
elif [[ $source_heads == "$main_branch" ]]; then
    source_state=main-only
else
    die "the source repository has heads other than $main_branch and $private_branch"
fi
printf '%s\n' "$source_refs" | sed 's#^#source-ref #'

open_prs=$(gh pr list --repo "$source_slug" --state open --limit 1000 \
    --json number --jq 'length') || die "cannot list open pull requests"
[[ $open_prs == 0 ]] || die "the source repository has open pull requests"
all_prs=$(gh pr list --repo "$source_slug" --state all --limit 1000 \
    --json number --jq 'length') || die "cannot list pull requests"
private_prs=$(gh pr list --repo "$source_slug" --state all --limit 1000 \
    --head "$private_branch" --json number --jq 'length') ||
    die "cannot list pull requests from the private branch"

protected=not-applicable
rules=not-applicable
if [[ $source_state == both ]]; then
    protected=$(gh api "repos/$source_slug/branches/$private_branch" --jq '.protected') ||
        die "cannot inspect the source private branch"
    [[ $protected == false ]] ||
        die "the source private branch is protected; its deletion would be refused"
    if rules=$(gh api "repos/$source_slug/rules/branches/$private_branch" \
        --jq '[.[].type] | unique | join(",")' 2>/dev/null); then
        [[ ,$rules, != *,deletion,* ]] ||
            die "a ruleset blocks deletion of the source private branch"
        rules=${rules:-none}
    else
        rules=unknown
    fi
fi

dest_probe_rc=0
dest_probe=$(gh repo view "$dest_slug" --json nameWithOwner --jq '.nameWithOwner' 2>&1) ||
    dest_probe_rc=$?
dest_private=
if ((dest_probe_rc != 0)); then
    [[ $dest_probe == *"Could not resolve to a Repository"* ]] ||
        die "cannot determine whether the destination repository exists"
    dest_state=absent
else
    dest_fields=$(
        gh repo view "$dest_slug" \
            --json 'nameWithOwner,visibility,isArchived,viewerPermission' \
            --jq '[.nameWithOwner, .visibility, .isArchived, .viewerPermission] | @tsv'
    ) || die "cannot inspect the destination repository"
    IFS=$'\t' read -r dest_identity dest_visibility dest_archived \
        dest_permission <<<"$dest_fields"
    [[ $dest_identity == "$dest_slug" ]] ||
        die "unexpected destination repository identity"
    [[ $dest_visibility == PRIVATE ]] ||
        die "destination repository exists and is not private"
    [[ $dest_archived == false ]] || die "destination repository is archived"
    [[ $dest_permission == ADMIN ]] ||
        die "active account lacks admin permission on the destination repository"
    dest_refs=$(list_refs "$dest_url") ||
        die "cannot inventory the destination repository"
    if [[ -z $dest_refs ]]; then
        dest_state=empty
    else
        dest_state=copied
    fi
fi

# A copy holds exactly main and the private branch, no tags, the source main,
# and, while the source still has it, the source private tip.
validate_copy() {
    [[ $(head_names "$1") == "$both_heads" ]] || return 1
    [[ $(tag_count "$1") == 0 ]] || return 1
    [[ $(ref_sha "$1" "refs/heads/$main_branch") == "$source_main" ]] || return 1
    if [[ $source_state == both ]]; then
        [[ $(ref_sha "$1" "refs/heads/$private_branch") == "$source_private" ]] ||
            return 1
    fi
}

if [[ $dest_state == copied ]]; then
    validate_copy "$dest_refs" ||
        die "destination repository is not empty and does not match the source"
    dest_private=$(ref_sha "$dest_refs" "refs/heads/$private_branch")
fi
if [[ $source_state == main-only && $dest_state != copied ]]; then
    die "the private branch is in neither repository; report this to the Project Manager"
fi
if [[ $layout != pre-split && $source_state == both ]]; then
    die "the checkout is re-pointed but the source still holds the private branch"
fi

actions=()
if [[ $dest_state == absent ]]; then
    actions+=(create-private-repository)
fi
if [[ $dest_state != copied ]]; then
    actions+=(copy-main-and-private-branch)
fi
if [[ $source_state == both ]]; then
    actions+=(delete-private-branch-from-source)
fi
actions+=(repoint-and-verify-checkout)

printf 'preflight account=%s source=%s visibility=%s permission=%s default-branch=%s source-state=%s main=%s private=%s tags=0 open-prs=0 all-prs=%s private-branch-prs=%s protected=%s rules=%s\n' \
    "$active_account" "$source_slug" "$source_visibility" "$source_permission" \
    "$source_default" "$source_state" "$source_main" "${source_private:-absent}" \
    "$all_prs" "$private_prs" "$protected" "$rules"
printf 'preflight destination=%s destination-state=%s checkout-branch=%s checkout-head=%s local-main=%s local-private=%s layout=%s clean=yes tasking=current lock=held\n' \
    "$dest_slug" "$dest_state" "$checked_out" "$head_before" "$local_main" \
    "$local_private" "$layout"
printf 'actions=%s\n' "$(IFS=,; printf '%s' "${actions[*]}")"
printf 'excluded=visibility-change,source-main-or-tag-change,force,history-rewrite,branch-switch,publication,lx2-write\n'
if ((private_prs > 0)); then
    printf 'NOTE: %s pull request(s) from the private branch keep its commits reachable in the source repository through pull-request refs; the publication decision must account for them\n' \
        "$private_prs"
fi

if [[ $mode == plan ]]; then
    printf 'lx2-first: before --execute, run on lx2 exactly: git -C %s remote set-url --push origin %s\n' \
        "$lx2_checkout" "$push_disabled"
    printf 'pmr129-plan-complete=%s eligible=yes no-remote-write=yes\n' \
        "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    exit 0
fi

[[ -t 0 ]] || die "--execute requires an interactive terminal"
confirmation=
read -r -p "Type PMR-129 to execute the workbook split: " confirmation
[[ $confirmation == PMR-129 ]] || die "execution confirmation did not match"

if [[ $dest_state == absent ]]; then
    printf 'step=create-private-repository\n'
    if ! output=$(gh repo create "$dest_slug" --private 2>&1); then
        printf '%s\n' "$output" | sanitize_remote_output
        die "private repository creation failed"
    fi
    printf '%s\n' "$output" | sanitize_remote_output
    created_fields=$(gh repo view "$dest_slug" --json 'visibility,isEmpty' \
        --jq '[.visibility, .isEmpty] | @tsv') ||
        die "cannot inspect the new repository"
    [[ $created_fields == $'PRIVATE\ttrue' ]] ||
        die "the new repository is not private and empty"
    dest_state=empty
fi

if [[ $dest_state == empty ]]; then
    printf 'step=copy-main-and-private-branch\n'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/pmr129-split.XXXXXX") ||
        die "cannot create a temporary directory"
    bare=$work_dir/source.git
    if ! output=$(git_github clone --bare --quiet "$source_url" "$bare" 2>&1); then
        printf '%s\n' "$output" | sanitize_remote_output
        die "bare clone of the source repository failed"
    fi
    clone_refs=$(
        git_safe -C "$bare" for-each-ref --format='%(objectname) %(refname)' \
            refs/heads refs/tags | sort -k2
    )
    [[ $clone_refs == "$source_refs" ]] ||
        die "the bare clone does not match the source refs"
    if ! output=$(
        git_github -C "$bare" push --atomic --porcelain "$dest_url" \
            "refs/heads/$main_branch:refs/heads/$main_branch" \
            "refs/heads/$private_branch:refs/heads/$private_branch" 2>&1
    ); then
        printf '%s\n' "$output" | sanitize_remote_output
        die "copy to the private repository failed"
    fi
    printf '%s\n' "$output" | sanitize_remote_output
    dest_refs=$(list_refs "$dest_url") ||
        die "cannot inventory the private repository after the copy"
    validate_copy "$dest_refs" ||
        die "the private repository does not match the source after the copy"
    dest_private=$(ref_sha "$dest_refs" "refs/heads/$private_branch")
    dest_state=copied
fi

if [[ $source_state == both ]]; then
    printf 'step=delete-private-branch-from-source\n'
    source_now=$(list_refs "$source_url") ||
        die "cannot re-inventory the source repository"
    [[ $source_now == "$source_refs" ]] ||
        die "the source repository changed during the split"
    [[ $dest_private == "$source_private" ]] ||
        die "the copied private branch does not match the source"
    # The lease deletes the branch only while its tip is the copied commit.
    if ! output=$(
        git_github -C "$component_root" push --porcelain \
            --force-with-lease="refs/heads/$private_branch:$source_private" \
            "$source_url" ":refs/heads/$private_branch" 2>&1
    ); then
        printf '%s\n' "$output" | sanitize_remote_output
        die "deleting the private branch from the source repository failed"
    fi
    printf '%s\n' "$output" | sanitize_remote_output
    source_after=$(list_refs "$source_url") ||
        die "cannot inventory the source repository after the deletion"
    [[ $(head_names "$source_after") == "$main_branch" ]] ||
        die "the source repository does not hold only $main_branch"
    [[ $(ref_sha "$source_after" "refs/heads/$main_branch") == "$source_main" ]] ||
        die "source $main_branch changed"
    [[ $(tag_count "$source_after") == 0 ]] || die "source tags appeared"
    source_state=main-only
fi

printf 'step=repoint-and-verify-checkout\n'
if [[ $layout == pre-split ]]; then
    git_safe -C "$component_root" remote rename origin public
    layout=renamed
fi
if [[ $layout == renamed ]]; then
    git_safe -C "$component_root" remote add origin "$dest_url"
    layout=split
fi
git_safe -C "$component_root" remote set-url --push public "$push_disabled"
for remote in origin public; do
    if ! output=$(git_github -C "$component_root" fetch --prune "$remote" 2>&1); then
        printf '%s\n' "$output" | sanitize_remote_output
        die "fetch from $remote failed"
    fi
    printf '%s\n' "$output" | sanitize_remote_output
done
for branch in "$main_branch" "$private_branch"; do
    git_safe -C "$component_root" branch --set-upstream-to="origin/$branch" "$branch"
done

mapfile -t remotes < <(git_safe -C "$component_root" remote | sort)
[[ ${remotes[*]-} == "origin public" ]] || die "unexpected final remote layout"
[[ $(single_identity origin fetch) == "$dest_slug" ]] ||
    die "origin does not fetch from $dest_slug"
[[ $(single_identity origin push) == "$dest_slug" ]] ||
    die "origin does not push to $dest_slug"
[[ $(single_identity public fetch) == "$source_slug" ]] ||
    die "public does not fetch from $source_slug"
[[ $(single_identity public push) == "$push_disabled" ]] ||
    die "the public push URL is not disabled"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "analysis-workbook worktree became dirty"
[[ $(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true) == "$checked_out" ]] ||
    die "the checked-out branch changed"
[[ $(git_safe -C "$component_root" rev-parse --verify HEAD) == "$head_before" ]] ||
    die "HEAD changed"
[[ $(git_safe -C "$component_root" rev-parse --verify "refs/heads/$main_branch") == "$local_main" ]] ||
    die "local $main_branch changed"
[[ $(git_safe -C "$component_root" rev-parse --verify "refs/heads/$private_branch") == "$local_private" ]] ||
    die "local $private_branch changed"
push_config=$(
    git_safe -C "$component_root" config --get-regexp \
        '^(remote\.pushdefault|branch\..*\.pushremote)$' 2>/dev/null || true
)
if [[ -n $push_config ]]; then
    printf '%s\n' "$push_config" | sed 's#^#push-config #'
    if printf '%s\n' "$push_config" | awk '$2 == "public" { found = 1 } END { exit !found }'; then
        die "a push default names public"
    fi
fi
for branch in "$main_branch" "$private_branch"; do
    upstream=$(git_safe -C "$component_root" rev-parse --abbrev-ref \
        --symbolic-full-name "$branch@{upstream}" 2>/dev/null || true)
    [[ $upstream == "origin/$branch" ]] ||
        die "$branch does not track origin/$branch"
    read -r behind ahead < <(
        git_safe -C "$component_root" rev-list --left-right --count \
            "origin/$branch...$branch"
    )
    printf 'branch name=%s upstream=%s behind=%s ahead=%s\n' \
        "$branch" "$upstream" "$behind" "$ahead"
done

dest_default=$(gh repo view "$dest_slug" --json defaultBranchRef \
    --jq '.defaultBranchRef.name // ""' 2>/dev/null || true)
if [[ $dest_default != "$main_branch" ]]; then
    printf 'NOTE: the private repository default branch is %s, not %s; change it in its settings if you want %s\n' \
        "${dest_default:-unknown}" "$main_branch" "$main_branch"
fi

printf 'lx2-check: if not already done before --execute, run on lx2 exactly: git -C %s remote set-url --push origin %s\n' \
    "$lx2_checkout" "$push_disabled"
printf 'pmr129-split-complete=%s account=%s origin=%s origin-default-branch=%s public=%s public-push=disabled source-heads=%s destination-heads=%s,%s main=%s private=%s checkout-branch=%s head-unchanged=yes clean=yes visibility-unchanged=yes\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$active_account" "$dest_slug" \
    "${dest_default:-unknown}" "$source_slug" "$main_branch" "$main_branch" \
    "$private_branch" "$source_main" "$dest_private" "$checked_out"
