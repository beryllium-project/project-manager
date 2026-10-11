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
  pmr128-visibility-audit.sh --run

--run  report the GitHub visibility of every repository identity named in
       REHYDRATE.md and of every active github.com remote of the registered
       checkouts, then the analysis-workbook exposure facts

This human-run script is read-only. It changes no repository, remote,
setting, or visibility, and Git makes no network call. Report the printed
log path to the Project Manager.
EOF
}

die() {
    printf 'pmr128-audit: ERROR: %s\n' "$*" >&2
    exit 1
}

(($# == 1)) || { usage; exit 2; }
case $1 in
--run) ;;
--help|-h) usage; exit 0 ;;
*) usage; exit 2 ;;
esac

expected_account=xjamesmorris
expected_visibility=PRIVATE
workbook_slug=beryllium-project/analysis-workbook
# Documented inactive remotes (REHYDRATE.md section 3); never queried.
inactive_remotes=' msft-downstream legacy-personal legacy-backup msft-inactive gim-inactive '

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
pm_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve Project Manager root"
workspace_root=$(CDPATH= cd -- "$pm_root/.." && pwd -P) ||
    die "cannot resolve workspace root"
rehydrate=$pm_root/REHYDRATE.md
scratch_root=$pm_root/scratch/owner-actions

mkdir -p -- "$scratch_root"
timestamp=$(date -u +%Y%m%dT%H%M%SZ)
log_file=$scratch_root/pmr128-visibility-audit-$timestamp.log
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

printf 'pmr128-log=%s\n' "$log_file"
printf 'pmr128-start=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

git_safe() {
    env GIT_OPTIONAL_LOCKS=0 GIT_PAGER=cat PAGER=cat \
        git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c credential.helper= -c protocol.allow=never "$@"
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

command -v gh >/dev/null 2>&1 || die "gh is required"
active_account=$(gh api user --jq '.login') ||
    die "cannot resolve the active GitHub account"
printf 'account active=%s expected=%s\n' "$active_account" "$expected_account"
if [[ $active_account != "$expected_account" ]]; then
    printf 'WARNING: results reflect %s, not %s; repositories that account cannot see report unresolved\n' \
        "$active_account" "$expected_account"
fi

pm_head=$(git_safe -C "$pm_root" rev-parse --verify HEAD) ||
    die "cannot resolve the Project Manager HEAD"
pm_clean=yes
if [[ -n $(git_safe -C "$pm_root" status --porcelain 2>/dev/null) ]]; then
    pm_clean=no
fi
printf 'project-manager head=%s clean=%s\n' "$pm_head" "$pm_clean"

[[ -f $rehydrate ]] || die "REHYDRATE.md is unavailable"
mapfile -t coordination_slugs < <(
    sed -n 's#^gh[ ]repo[ ]clone[ ]\([A-Za-z0-9._-]*/[A-Za-z0-9._-]*\)\( .*\)\{0,1\}$#\1#p' \
        "$rehydrate"
)
mapfile -t component_specs < <(
    sed -n 's#^ *\([A-Za-z0-9._/-]*\)=\([A-Za-z0-9._-]*/[A-Za-z0-9._-]*\)\( \\\)\{0,1\}$#\1=\2#p' \
        "$rehydrate"
)
((${#coordination_slugs[@]} > 0 && ${#component_specs[@]} > 0)) ||
    die "cannot read repository identities from REHYDRATE.md"
printf 'rehydrate coordination=%s components=%s\n' \
    "${#coordination_slugs[@]}" "${#component_specs[@]}"

slugs=()
declare -A slug_sources=()
add_slug() {
    local slug=$1 source=$2 key=${1,,}
    if [[ -z ${slug_sources[$key]+set} ]]; then
        slugs+=("$slug")
        slug_sources[$key]=$source
    else
        slug_sources[$key]+=",$source"
    fi
}

for slug in "${coordination_slugs[@]}"; do
    add_slug "$slug" rehydrate:coordination
done
checkouts=("parent=$workspace_root" "project-manager=$pm_root")
for spec in "${component_specs[@]}"; do
    add_slug "${spec#*=}" "rehydrate:${spec%%=*}"
    checkouts+=("${spec%%=*}=$workspace_root/${spec%%=*}")
done

for checkout in "${checkouts[@]}"; do
    label=${checkout%%=*}
    dir=${checkout#*=}
    if [[ ! -d $dir ]]; then
        printf 'checkout entry=%s state=absent\n' "$label"
        continue
    fi
    real_dir=$(CDPATH= cd -- "$dir" && pwd -P) || {
        printf 'checkout entry=%s state=unreadable\n' "$label"
        continue
    }
    top=$(git_safe -C "$real_dir" rev-parse --show-toplevel 2>/dev/null || true)
    if [[ $top != "$real_dir" ]]; then
        printf 'checkout entry=%s state=not-a-repository-root\n' "$label"
        continue
    fi
    dir=$real_dir
    mapfile -t remotes < <(git_safe -C "$dir" remote 2>/dev/null || true)
    printf 'checkout entry=%s remotes=%s\n' "$label" "${#remotes[@]}"
    for remote in "${remotes[@]}"; do
        if [[ $inactive_remotes == *" $remote "* ]]; then
            printf 'remote entry=%s name=%s skipped=documented-inactive\n' \
                "$label" "$remote"
            continue
        fi
        fetch_keys=' '
        for kind in fetch push; do
            if [[ $kind == fetch ]]; then
                mapfile -t urls < <(
                    git_safe -C "$dir" remote get-url --all "$remote" 2>/dev/null || true
                )
            else
                mapfile -t urls < <(
                    git_safe -C "$dir" remote get-url --push --all "$remote" 2>/dev/null || true
                )
            fi
            for url in "${urls[@]}"; do
                if slug=$(github_slug "$url"); then
                    if [[ $kind == fetch ]]; then
                        fetch_keys+="${slug,,} "
                    elif [[ $fetch_keys == *" ${slug,,} "* ]]; then
                        continue
                    fi
                    printf 'remote entry=%s name=%s kind=%s identity=%s\n' \
                        "$label" "$remote" "$kind" "$slug"
                    add_slug "$slug" "remote:$label/$remote:$kind"
                else
                    printf 'remote entry=%s name=%s kind=%s identity=none skipped=not-github.com\n' \
                        "$label" "$remote" "$kind"
                fi
            done
        done
    done
done

matched=0
mismatched=0
unresolved=0
for slug in "${slugs[@]}"; do
    key=${slug,,}
    if fields=$(
        gh repo view "$slug" \
            --json 'nameWithOwner,visibility,isArchived,isFork,viewerPermission' \
            --jq '[.nameWithOwner, .visibility, .isArchived, .isFork, .viewerPermission] | @tsv' \
            2>/dev/null
    ); then
        IFS=$'\t' read -r name visibility archived fork permission <<<"$fields"
        if [[ $visibility == "$expected_visibility" ]]; then
            result=match
            matched=$((matched + 1))
        else
            result=MISMATCH
            mismatched=$((mismatched + 1))
        fi
        resolves=
        if [[ ${name,,} != "$key" ]]; then
            resolves=" resolves-to=$name"
        fi
        printf 'visibility identity=%s actual=%s expected=%s result=%s archived=%s fork=%s permission=%s%s sources=%s\n' \
            "$slug" "$visibility" "$expected_visibility" "$result" "$archived" \
            "$fork" "${permission:-none}" "$resolves" "${slug_sources[$key]}"
    else
        unresolved=$((unresolved + 1))
        printf 'visibility identity=%s actual=unknown expected=%s result=unresolved reason=absent-not-visible-to-%s-or-query-failed sources=%s\n' \
            "$slug" "$expected_visibility" "$active_account" "${slug_sources[$key]}"
    fi
done
printf 'visibility-summary identities=%s match=%s mismatch=%s unresolved=%s\n' \
    "${#slugs[@]}" "$matched" "$mismatched" "$unresolved"

printf 'workbook identity=%s\n' "$workbook_slug"
if fields=$(
    gh repo view "$workbook_slug" \
        --json 'visibility,createdAt,pushedAt,isEmpty,defaultBranchRef' \
        --jq '[.visibility, .createdAt, .pushedAt, .isEmpty, (.defaultBranchRef.name // "")] | @tsv' \
        2>/dev/null
); then
    IFS=$'\t' read -r visibility created pushed empty default_branch <<<"$fields"
    printf 'workbook-repository visibility=%s created=%s pushed=%s empty=%s default-branch=%s\n' \
        "$visibility" "$created" "$pushed" "$empty" "${default_branch:-none}"
else
    printf 'workbook-repository unavailable\n'
fi

if out=$(
    gh api --paginate "repos/$workbook_slug/branches?per_page=100" \
        --jq '.[] | [.name, .commit.sha, .protected] | @tsv' 2>/dev/null
); then
    count=0
    while IFS=$'\t' read -r name sha protected; do
        [[ -n $name ]] || continue
        count=$((count + 1))
        printf 'workbook-branch name=%s sha=%s protected=%s\n' "$name" "$sha" "$protected"
    done <<<"$out"
    printf 'workbook-branches count=%s\n' "$count"
else
    printf 'workbook-branches unavailable\n'
fi

if out=$(
    gh api --paginate "repos/$workbook_slug/tags?per_page=100" \
        --jq '.[] | [.name, .commit.sha] | @tsv' 2>/dev/null
); then
    count=0
    while IFS=$'\t' read -r name sha; do
        [[ -n $name ]] || continue
        count=$((count + 1))
        printf 'workbook-tag name=%s sha=%s\n' "$name" "$sha"
    done <<<"$out"
    printf 'workbook-tags count=%s\n' "$count"
else
    printf 'workbook-tags unavailable\n'
fi

# Fork heads are third-party names, so only same-repository heads print.
if out=$(
    gh pr list --repo "$workbook_slug" --state all --limit 1000 \
        --json 'number,state,isCrossRepository,headRefName' \
        --jq '.[] | [.number, .state, .isCrossRepository, .headRefName] | @tsv' \
        2>/dev/null
); then
    total=0 open=0 cross=0
    while IFS=$'\t' read -r number state is_cross head; do
        [[ -n $number ]] || continue
        total=$((total + 1))
        if [[ $state == OPEN ]]; then
            open=$((open + 1))
        fi
        if [[ $is_cross == true ]]; then
            cross=$((cross + 1))
            head=fork
        fi
        printf 'workbook-pull-request number=%s state=%s cross-repository=%s head=%s\n' \
            "$number" "$state" "$is_cross" "$head"
    done <<<"$out"
    printf 'workbook-pull-requests total=%s open=%s cross-repository=%s\n' \
        "$total" "$open" "$cross"
else
    printf 'workbook-pull-requests unavailable\n'
fi

if out=$(
    gh api --paginate "repos/$workbook_slug/forks?per_page=100" \
        --jq '.[] | .visibility' 2>/dev/null
); then
    listed=0 public=0 private=0
    while read -r visibility; do
        [[ -n $visibility ]] || continue
        listed=$((listed + 1))
        case $visibility in
        public) public=$((public + 1)) ;;
        private) private=$((private + 1)) ;;
        esac
    done <<<"$out"
    printf 'workbook-forks listed=%s public=%s private=%s note=public-forks-detach-when-a-repository-becomes-private-and-are-not-listed\n' \
        "$listed" "$public" "$private"
else
    printf 'workbook-forks unavailable\n'
fi

for kind in clones views; do
    if out=$(
        gh api "repos/$workbook_slug/traffic/$kind" \
            --jq "\"total\t\(.count)\t\(.uniques)\", (.${kind}[] | \"day\t\(.timestamp)\t\(.count)\t\(.uniques)\")" \
            2>/dev/null
    ); then
        while IFS=$'\t' read -r record first second third; do
            case $record in
            total)
                printf 'workbook-traffic-%s window=14-days count=%s uniques=%s\n' \
                    "$kind" "$first" "$second"
                ;;
            day)
                printf 'workbook-traffic-%s-day date=%s count=%s uniques=%s\n' \
                    "$kind" "$first" "$second" "$third"
                ;;
            esac
        done <<<"$out"
    else
        printf 'workbook-traffic-%s unavailable\n' "$kind"
    fi
done

printf 'audit-log optional: in the beryllium-project organization settings, open Audit log and filter "action:repo.access repo:%s"; report only the dates and actions\n' \
    "$workbook_slug"
printf 'pmr128-complete=%s identities=%s match=%s mismatch=%s unresolved=%s no-write=yes\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "${#slugs[@]}" "$matched" "$mismatched" "$unresolved"
