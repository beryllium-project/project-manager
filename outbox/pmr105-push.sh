#!/usr/bin/env bash

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
    printf 'ERROR: run this script with bash; do not source it\n' >&2
    return 2 2>/dev/null || exit 2
fi

set -euo pipefail
export LC_ALL=C
export GIT_TERMINAL_PROMPT=0
umask 077

usage() {
    cat >&2 <<'EOF'
Usage:
  pmr105-push.sh --plan
  pmr105-push.sh --execute

--plan     run every read-only preflight and print the exact eligible push
--execute  rerun every preflight, require an interactive confirmation, push
           only the exact PMR-105 topic ref, and verify containment

This human-run script is not push authority. Run --execute only after the
Project Manager records a fresh same-turn responsible-human confirmation.
EOF
}

die() {
    printf 'pmr105-push: ERROR: %s\n' "$*" >&2
    exit 1
}

(($# == 1)) || { usage; exit 2; }
case $1 in
--plan) mode=plan ;;
--execute) mode=execute ;;
--help|-h) usage; exit 0 ;;
*) usage; exit 2 ;;
esac

expected_component=cheri-riscv-notes
expected_request=PMR-105
expected_slug=agentic-os-research/cheri-riscv-notes
expected_branch=docs/reconcile-project-status
expected_ref=refs/heads/docs/reconcile-project-status
expected_upstream=origin/docs/reconcile-project-status
expected_old=9a4c5effef3b87fc7529ec7ff265179ad1130d58
expected_new=34a8b508eb68f0b61b463bd0f75d55b348c844d1

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
target_url=https://github.com/$expected_slug.git

mkdir -p -- "$scratch_root" "$lock_root"
timestamp=$(date -u +%Y%m%dT%H%M%SZ)
log_file=$scratch_root/pmr105-push-$timestamp.log
exec > >(tee -a "$log_file") 2>&1
tee_pid=${!:-}

cleanup() {
    local rc=$?
    trap - EXIT INT TERM HUP
    if [[ -n ${tee_pid:-} ]]; then
        exec >&- 2>&-
        wait "$tee_pid" 2>/dev/null || true
    fi
    exit "$rc"
}
trap cleanup EXIT INT TERM HUP

printf 'pmr105-log=%s\n' "$log_file"
printf 'pmr105-start=%s mode=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$mode"

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

remote_slug() {
    printf '%s' "$1" |
        sed -E 's#^[a-z+]+://([^@/]+@)?[^/]+/##; s#^[^@/]+@[^:]+:##; s#^/+##; s#\.git/?$##'
}

sanitize_remote_output() {
    sed "s#$target_url#$expected_slug#g"
}

[[ -f $workspace_root/SOT.md && -f $workspace_root/COMPONENTS.md ]] ||
    die "workspace root lacks SOT.md or COMPONENTS.md"
[[ $(git_safe -C "$pm_root" rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
    die "Project Manager repository is invalid"
[[ -z $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]] ||
    die "Project Manager worktree is dirty"
[[ -x $tasking ]] || die "project-tasking helper is unavailable"
env PM_TASKING_ROOT="$pm_root" PM_TASKING_WORKSPACE="$workspace_root" \
    bash "$tasking" check >/dev/null ||
    die "generated Project Manager tasking is stale"

tasking_view=$pm_root/outbox/tasking/$expected_component.md
[[ -f $tasking_view ]] || die "CHERI tasking view is unavailable"
mapfile -t visible_requests < <(
    sed -n 's/^| `\(PMR-[0-9][0-9][0-9]\)` |.*/\1/p' "$tasking_view"
)
((${#visible_requests[@]} == 1)) ||
    die "expected exactly one visible CHERI request"
[[ ${visible_requests[0]} == "$expected_request" ]] ||
    die "visible CHERI request is not PMR-105"
grep -Eq '^\| PMR-105 \|.*\| open \| P2 \|' \
    "$pm_root/outbox/component-requests.md" ||
    die "PMR-105 is not visibly open at P2"

[[ -e $component_entry ]] ||
    die "logical CHERI workspace entry is unavailable"
component_root=$(CDPATH= cd -- "$component_entry" 2>/dev/null && pwd -P) ||
    die "cannot resolve CHERI repository root"
[[ $(git_safe -C "$component_root" rev-parse --show-toplevel 2>/dev/null || true) == "$component_root" ]] ||
    die "CHERI entry is not a repository root"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "CHERI worktree is dirty"

branch=$(git_safe -C "$component_root" symbolic-ref --quiet --short HEAD 2>/dev/null || true)
[[ $branch == "$expected_branch" ]] ||
    die "expected attached branch $expected_branch"
local_head=$(git_safe -C "$component_root" rev-parse --verify "refs/heads/$expected_branch")
[[ $local_head == "$expected_new" ]] ||
    die "local CHERI topic tip moved"
upstream=$(git_safe -C "$component_root" rev-parse \
    --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)
[[ $upstream == "$expected_upstream" ]] ||
    die "unexpected CHERI upstream: ${upstream:-none}"
origin_url=$(git_safe -C "$component_root" remote get-url origin)
[[ $(remote_slug "$origin_url") == "$expected_slug" ]] ||
    die "origin does not identify $expected_slug"

command -v gh >/dev/null 2>&1 || die "gh is required"
active_account=$(gh api user --jq '.login') ||
    die "cannot resolve the active GitHub account"
repo_fields=$(
    gh repo view "$expected_slug" \
        --json 'nameWithOwner,visibility,isArchived,viewerPermission' \
        --jq '[.nameWithOwner, .visibility, .isArchived, .viewerPermission] | @tsv'
) || die "cannot inspect the private target repository"
IFS=$'\t' read -r target_identity target_visibility target_archived \
    target_permission <<<"$repo_fields"
[[ $target_identity == "$expected_slug" ]] ||
    die "unexpected target repository identity"
[[ $target_visibility == PRIVATE ]] ||
    die "target repository is not private"
[[ $target_archived == false ]] ||
    die "target repository is archived"
case $target_permission in
ADMIN|MAINTAIN|WRITE) ;;
*) die "active account lacks write permission" ;;
esac

effective_url=$(git_github -C "$component_root" ls-remote --get-url "$target_url") ||
    die "cannot resolve the effective target URL"
[[ $effective_url == "$target_url" ]] ||
    die "Git URL rewriting changes the exact target"

if ! refs_before=$(git_github -C "$component_root" \
    ls-remote --heads --tags "$target_url" 2>/dev/null); then
    die "cannot inventory the target under the active GitHub account"
fi
remote_old=$(
    printf '%s\n' "$refs_before" |
        awk -v ref="$expected_ref" '$2 == ref { print $1 }'
)
if [[ $remote_old == "$expected_new" ]]; then
    die "remote topic is already at the expected new tip; reconcile the external action"
fi
[[ $remote_old == "$expected_old" ]] ||
    die "remote topic moved from the expected predecessor"
git_safe -C "$component_root" cat-file -e "${expected_old}^{commit}" ||
    die "expected remote predecessor is not present locally"
git_safe -C "$component_root" merge-base --is-ancestor "$expected_old" "$expected_new" ||
    die "PMR-105 update is not a fast-forward"

heads_before=$(
    printf '%s\n' "$refs_before" |
        awk '$2 ~ /^refs\/heads\// { count++ } END { print count + 0 }'
)
tags_before=$(
    printf '%s\n' "$refs_before" |
        awk '$2 ~ /^refs\/tags\// { count++ } END { print count + 0 }'
)
other_refs_before=$(
    printf '%s\n' "$refs_before" |
        awk -v ref="$expected_ref" '$2 != ref' |
        sort
)

printf 'preflight account=%s target=%s visibility=%s permission=%s branch=%s old=%s new=%s heads=%s tags=%s clean=yes tasking=current lock=held\n' \
    "$active_account" "$expected_slug" "$target_visibility" "$target_permission" \
    "$expected_branch" "$expected_old" "$expected_new" "$heads_before" "$tags_before"
printf 'excluded=force,tags,mirror,remote-mutation,merge,main,pages,publication,visibility-change,d5,redistribution,sibling-write\n'

if [[ $mode == plan ]]; then
    printf 'pmr105-plan-complete=%s eligible=yes no-remote-write=yes\n' \
        "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    exit 0
fi

[[ -t 0 ]] || die "--execute requires an interactive terminal"
confirmation=
read -r -p "Type PMR-105 to execute the exact private fast-forward: " confirmation
[[ $confirmation == PMR-105 ]] || die "execution confirmation did not match"

push_output=
if ! push_output=$(
    git_github -C "$component_root" push --porcelain "$target_url" \
        "$expected_ref:$expected_ref" 2>&1
); then
    printf '%s\n' "$push_output" | sanitize_remote_output
    die "exact topic push failed"
fi
printf '%s\n' "$push_output" | sanitize_remote_output

if ! refs_after=$(git_github -C "$component_root" \
    ls-remote --heads --tags "$target_url" 2>/dev/null); then
    die "push returned but post-push inventory failed"
fi
remote_new=$(
    printf '%s\n' "$refs_after" |
        awk -v ref="$expected_ref" '$2 == ref { print $1 }'
)
[[ $remote_new == "$expected_new" ]] ||
    die "remote topic is not at the expected new tip"
heads_after=$(
    printf '%s\n' "$refs_after" |
        awk '$2 ~ /^refs\/heads\// { count++ } END { print count + 0 }'
)
tags_after=$(
    printf '%s\n' "$refs_after" |
        awk '$2 ~ /^refs\/tags\// { count++ } END { print count + 0 }'
)
other_refs_after=$(
    printf '%s\n' "$refs_after" |
        awk -v ref="$expected_ref" '$2 != ref' |
        sort
)
[[ $heads_after -eq $heads_before && $tags_after -eq $tags_before ]] ||
    die "remote head or tag counts changed unexpectedly"
[[ $other_refs_after == "$other_refs_before" ]] ||
    die "a remote ref outside the PMR-105 topic changed"

fetch_output=
if ! fetch_output=$(
    git_github -C "$component_root" fetch --no-tags "$target_url" \
        "$expected_ref:refs/remotes/origin/$expected_branch" 2>&1
); then
    printf '%s\n' "$fetch_output" | sanitize_remote_output
    die "post-push target-ref fetch failed"
fi
printf '%s\n' "$fetch_output" | sanitize_remote_output

final_head=$(git_safe -C "$component_root" rev-parse --verify "refs/heads/$expected_branch")
[[ $final_head == "$expected_new" ]] || die "local topic tip changed"
[[ -z $(git_safe -C "$component_root" status --porcelain 2>/dev/null) ]] ||
    die "CHERI worktree became dirty"
read -r behind ahead < <(
    git_safe -C "$component_root" rev-list --left-right --count \
        "$expected_upstream...$expected_branch"
)
[[ $behind == 0 && $ahead == 0 ]] ||
    die "final branch/upstream state is not 0 behind / 0 ahead"

printf 'pmr105-push-complete=%s account=%s target=%s branch=%s old=%s new=%s other-refs-preserved=yes heads=%s tags=%s behind=%s ahead=%s clean=yes\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$active_account" "$expected_slug" \
    "$expected_branch" "$expected_old" "$expected_new" "$heads_after" \
    "$tags_after" "$behind" "$ahead"
