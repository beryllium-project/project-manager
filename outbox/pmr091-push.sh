#!/usr/bin/env bash

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  printf 'ERROR: run this script with bash; do not source it\n' >&2
  return 2 2>/dev/null || exit 2
fi

set -euo pipefail
export LC_ALL=C

expected_old="1ab289c066b69acdd8b55c9f77055b0145be1316"
expected_new="f928aac5979b6166f3f68a76a9acf1fc916161d8"
prior_user="$(gh api user --jq '.login')"

restore_account() {
  local status=$?
  trap - EXIT INT TERM HUP

  if [[ "$(gh api user --jq '.login' 2>/dev/null || true)" == "$prior_user" ]]; then
    printf 'restored-active-account=%s\n' "$prior_user"
    exit "$status"
  fi

  if gh auth switch --hostname github.com --user "$prior_user" >/dev/null 2>&1 &&
     [[ "$(gh api user --jq '.login')" == "$prior_user" ]]; then
    printf 'restored-active-account=%s\n' "$prior_user"
  else
    printf 'ERROR: account not restored; run: gh auth switch --hostname github.com --user %s\n' \
      "$prior_user" >&2
    status=1
  fi

  exit "$status"
}

trap restore_account EXIT INT TERM HUP

printf 'pmr091-push-start=%s prior-active-account=%s\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$prior_user"

if [[ "$prior_user" != "xjamesmorris" ]]; then
  gh auth switch --hostname github.com --user xjamesmorris
fi

[[ "$(gh api user --jq '.login')" == "xjamesmorris" ]] || {
  printf 'ERROR: xjamesmorris is not active\n' >&2
  exit 1
}

repo_fields="$(
  gh repo view beryllium-project/helium-te-poc-historical \
    --json 'nameWithOwner,visibility,isArchived,viewerPermission' \
    --jq '[.nameWithOwner, .visibility, .isArchived, .viewerPermission] | @tsv'
)"
IFS=$'\t' read -r target_identity target_visibility target_archived \
  target_permission <<<"$repo_fields"
printf 'target=%s visibility=%s archived=%s permission=%s\n' \
  "$target_identity" "$target_visibility" "$target_archived" "$target_permission"
[[ "$target_identity" == "beryllium-project/helium-te-poc-historical" ]] || {
  printf 'ERROR: unexpected target identity\n' >&2
  exit 1
}
[[ "$target_visibility" == "PRIVATE" ]] || {
  printf 'ERROR: target is not private\n' >&2
  exit 1
}
[[ "$target_archived" == "false" ]] || {
  printf 'ERROR: target is archived\n' >&2
  exit 1
}
case "$target_permission" in
  ADMIN|MAINTAIN|WRITE) ;;
  *)
    printf 'ERROR: xjamesmorris lacks write permission\n' >&2
    exit 1
    ;;
esac

cd /home/jmorris/src/beryllium-project/helium-te-poc

origin_url="$(git remote get-url origin)"
printf '%s\n' "$origin_url" | grep -Eq \
  '^https://github\.com/beryllium-project/helium-te-poc-historical(\.git)?/?$' || {
  printf 'ERROR: origin is not the expected GitHub HTTPS target\n' >&2
  exit 1
}

credential_helpers="$(
  {
    git config --get-all 'credential.https://github.com.helper' || true
    git config --get-all credential.helper || true
  }
)"
printf '%s\n' "$credential_helpers" | grep -q 'gh auth git-credential' || {
  printf 'ERROR: GitHub HTTPS is not using gh auth git-credential\n' >&2
  exit 1
}

branch="$(git symbolic-ref --quiet --short HEAD || true)"
[[ "$branch" == "for-review" ]] || {
  printf 'ERROR: expected attached for-review branch\n' >&2
  exit 1
}

local_oid="$(git rev-parse --verify refs/heads/for-review)"
[[ "$local_oid" == "$expected_new" ]] || {
  printf 'ERROR: for-review tip moved\n' >&2
  exit 1
}

dirty="$(GIT_OPTIONAL_LOCKS=0 git status --porcelain)"
[[ -z "$dirty" ]] || {
  printf 'ERROR: Helium worktree is dirty\n' >&2
  exit 1
}

if ! refs_before="$(git ls-remote --heads --tags origin 2>/dev/null)"; then
  printf 'ERROR: unable to query origin under xjamesmorris\n' >&2
  exit 1
fi

heads_before="$(
  printf '%s\n' "$refs_before" |
    awk '$2 ~ /^refs\/heads\// { count++ } END { print count + 0 }'
)"
tags_before="$(
  printf '%s\n' "$refs_before" |
    awk '$2 ~ /^refs\/tags\// { count++ } END { print count + 0 }'
)"
[[ "$heads_before" -eq 23 && "$tags_before" -eq 0 ]] || {
  printf 'ERROR: expected 23 heads and zero tags before push; got %s heads and %s tags\n' \
    "$heads_before" "$tags_before" >&2
  exit 1
}

remote_old="$(
  printf '%s\n' "$refs_before" |
    awk '$2 == "refs/heads/for-review" { print $1 }'
)"
[[ "$remote_old" == "$expected_old" ]] || {
  printf 'ERROR: remote for-review moved; expected %s, got %s\n' \
    "$expected_old" "${remote_old:-absent}" >&2
  exit 1
}

git cat-file -e "${remote_old}^{commit}" || {
  printf 'ERROR: remote tip %s is not present locally\n' "$remote_old" >&2
  exit 1
}
git merge-base --is-ancestor "$remote_old" "$local_oid" || {
  printf 'ERROR: update is not a fast-forward\n' >&2
  exit 1
}

other_refs_before="$(
  printf '%s\n' "$refs_before" |
    awk '$2 != "refs/heads/for-review"' |
    sort
)"

printf 'pre-push account=xjamesmorris branch=%s old=%s new=%s heads=%s tags=%s clean=yes\n' \
  "$branch" "$remote_old" "$local_oid" "$heads_before" "$tags_before"

git -c push.followTags=false \
  -c credential.helper= \
  -c credential.helper='!gh auth git-credential' push \
  origin refs/heads/for-review:refs/heads/for-review

if ! refs_after="$(git ls-remote --heads --tags origin 2>/dev/null)"; then
  printf 'ERROR: push returned but post-push inventory failed\n' >&2
  exit 1
fi

heads_after="$(
  printf '%s\n' "$refs_after" |
    awk '$2 ~ /^refs\/heads\// { count++ } END { print count + 0 }'
)"
tags_after="$(
  printf '%s\n' "$refs_after" |
    awk '$2 ~ /^refs\/tags\// { count++ } END { print count + 0 }'
)"
remote_new="$(
  printf '%s\n' "$refs_after" |
    awk '$2 == "refs/heads/for-review" { print $1 }'
)"
other_refs_after="$(
  printf '%s\n' "$refs_after" |
    awk '$2 != "refs/heads/for-review"' |
    sort
)"

[[ "$remote_new" == "$expected_new" ]] || {
  printf 'ERROR: remote for-review is not at the expected new tip\n' >&2
  exit 1
}
[[ "$heads_after" -eq "$heads_before" && "$tags_after" -eq "$tags_before" ]] || {
  printf 'ERROR: head or tag counts changed unexpectedly\n' >&2
  exit 1
}
[[ "$other_refs_after" == "$other_refs_before" ]] || {
  printf 'ERROR: a ref other than for-review changed\n' >&2
  exit 1
}

printf 'pmr091-push-complete=%s remote-for-review=%s other-refs-preserved=yes heads=%s tags=%s\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$remote_new" "$heads_after" "$tags_after"
