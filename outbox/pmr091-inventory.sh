#!/usr/bin/env bash

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  printf 'ERROR: run this script with bash; do not source it\n' >&2
  return 2 2>/dev/null || exit 2
fi

set -euo pipefail
export LC_ALL=C

stamp() {
  date -u +%Y-%m-%dT%H:%M:%SZ
}

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

printf 'pmr091-start=%s gh=%s prior-active-account=%s\n' \
  "$(stamp)" "$(gh --version | head -n1)" "$prior_user"

if [[ "$prior_user" != "xjamesmorris" ]]; then
  gh auth switch --hostname github.com --user xjamesmorris
fi

active_user="$(gh api user --jq '.login')"
[[ "$active_user" == "xjamesmorris" ]] || {
  printf 'ERROR: xjamesmorris is not active\n' >&2
  exit 1
}
printf 'inventory-active-account=%s\n' "$active_user"

gh repo view beryllium-project/helium-te-poc-historical \
  --json 'nameWithOwner,visibility,isEmpty,defaultBranchRef,isFork,parent,isArchived,viewerPermission,pushedAt'

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

head_oid="$(git rev-parse --verify refs/heads/for-review)"
[[ "$head_oid" == "f928aac5979b6166f3f68a76a9acf1fc916161d8" ]] || {
  printf 'ERROR: for-review tip moved\n' >&2
  exit 1
}

dirty="$(GIT_OPTIONAL_LOCKS=0 git status --porcelain)"
[[ -z "$dirty" ]] || {
  printf 'ERROR: Helium worktree is dirty\n' >&2
  exit 1
}

if ! remote_refs="$(git ls-remote --heads --tags origin 2>/dev/null)"; then
  printf 'ERROR: unable to inventory origin under xjamesmorris\n' >&2
  exit 1
fi

ref_count="$(
  printf '%s\n' "$remote_refs" |
    awk 'NF { count++ } END { print count + 0 }'
)"

printf 'local-branch=%s local-head=%s clean=yes remote-ref-count=%s\n' \
  "$branch" "$head_oid" "$ref_count"
printf '%s\n' "$remote_refs"

remote_for_review="$(
  printf '%s\n' "$remote_refs" |
    awk '$2 == "refs/heads/for-review" { print $1 }'
)"

if [[ -n "$remote_for_review" ]]; then
  if git cat-file -e "${remote_for_review}^{commit}" 2>/dev/null &&
     git merge-base --is-ancestor "$remote_for_review" "$head_oid"; then
    printf 'remote-for-review=%s fast-forward-from-local=yes\n' \
      "$remote_for_review"
  else
    printf 'remote-for-review=%s fast-forward-from-local=no-or-object-absent\n' \
      "$remote_for_review"
  fi
else
  printf 'remote-for-review=absent\n'
fi

printf 'pmr091-end=%s\n' "$(stamp)"
