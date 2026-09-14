#!/usr/bin/env bash
# Generate and resolve local per-component views of the authoritative
# Project Manager request table. Never writes inside a component repository.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  project-tasking.sh generate
  project-tasking.sh check
  project-tasking.sh resolve [<component>|<workspace-entry-path>]

generate  write ignored outbox/tasking/<component>.md views from the committed
          outbox/component-requests.md at the current Project Manager HEAD
check     reject any generated view whose PM commit or request blob is stale
resolve   identify a registered component by name or workspace path, validate
          its generated view, then print it

Run generate after each Project Manager commit. Resolve stops rather than
showing tasking when the Project Manager repository, view, source commit, or
request-table snapshot is missing or stale.
EOF
}

die() {
    printf 'project-tasking: ERROR: %s\n' "$*" >&2
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
requests_rel=outbox/component-requests.md
requests_file=$pm_root/$requests_rel
tasking_dir=$pm_root/outbox/tasking

git_pm() {
    git -c core.hooksPath=/dev/null -c core.fsmonitor=false \
        -c credential.helper= -c protocol.allow=never -c diff.external= \
        -c pager.status=false -c pager.log=false -c pager.show=false \
        -c pager.diff=false -C "$pm_root" "$@"
}

require_repository() {
    [[ $(git_pm rev-parse --show-toplevel 2>/dev/null || true) == "$pm_root" ]] ||
        die "Project Manager repository is invalid: $pm_root"
    [[ -f $requests_file ]] || die "authoritative request table is absent"
}

component_names() {
    local card name
    printf '%s\n' project-manager
    for card in "$pm_root"/components/*.md; do
        [[ -f $card ]] || continue
        name=$(basename -- "$card" .md)
        [[ $name == README ]] && continue
        [[ $name =~ ^[a-z0-9][a-z0-9-]*$ ]] ||
            die "invalid component card name: $name"
        printf '%s\n' "$name"
    done
}

is_component() {
    local requested=$1 candidate
    while IFS= read -r candidate; do
        [[ $requested == "$candidate" ]] && return 0
    done < <(component_names)
    return 1
}

render_view() {
    local component=$1 destination=$2 source_commit=$3 source_blob=$4 source_file=$5
    local rows
    rows=$(mktemp "${TMPDIR:-/tmp}/project-tasking-rows.XXXXXX") ||
        die "cannot create row workspace"
    awk -F'|' -v target="$component" '
        function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
        /^\| PMR-[0-9][0-9][0-9] / {
            id = trim($2)
            owner = trim($4)
            request = trim($5)
            basis = trim($6)
            status = trim($7)
            priority = trim($8)
            note = trim($10)
            cross_named = index(request, "`" target "`") ||
                index(note, "`" target "`")
            if (status == "open" && (owner == target || cross_named))
                printf "%s\t%s\t%s\t%s\t%s\n", id, priority, request, basis, note
        }
    ' "$source_file" | sort -t $'\t' -k2,2 -k1,1 >"$rows"

    {
        printf '# Project Manager tasking: %s\n\n' "$component"
        printf 'Generated file. Do not edit; regenerate from the authoritative request table.\n\n'
        printf -- '- **Source Project Manager commit:** `%s`\n' "$source_commit"
        printf -- '- **Source request blob:** `%s`\n' "$source_blob"
        printf -- '- **Authoritative source:** `outbox/component-requests.md`\n'
        printf -- '- **Component:** `%s`\n\n' "$component"
        if [[ -s $rows ]]; then
            printf '| Request | Priority | Action | Basis | Note |\n'
            printf '| --- | --- | --- | --- | --- |\n'
            while IFS=$'\t' read -r id priority request basis note; do
                printf '| `%s` | %s | %s | %s | %s |\n' \
                    "$id" "$priority" "$request" "$basis" "$note"
            done <"$rows"
        else
            printf 'No open Project Manager requests for this component.\n'
        fi
        printf '\nOwner results return through the component handoff protocol in `PMD-20260914-002`.\n'
        printf 'This view grants no approval, authorization, acceptance, publication, or release gate.\n'
    } >"$destination"
    rm -f -- "$rows"
}

generate_views() {
    local source_commit source_blob temp_dir source_snapshot component file
    require_repository
    git_pm diff --quiet -- "$requests_rel" ||
        die "request table has unstaged changes; commit it before generating"
    git_pm diff --cached --quiet -- "$requests_rel" ||
        die "request table has staged changes; commit it before generating"
    source_commit=$(git_pm rev-parse --verify HEAD) ||
        die "cannot resolve Project Manager HEAD"
    source_blob=$(git_pm rev-parse --verify "HEAD:$requests_rel") ||
        die "request table is not committed"
    temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/project-tasking.XXXXXX") ||
        die "cannot create generation workspace"
    trap 'rm -rf -- "$temp_dir"' EXIT HUP INT TERM
    source_snapshot=$temp_dir/component-requests.md
    git_pm show "HEAD:$requests_rel" >"$source_snapshot" ||
        die "cannot read committed request table"

    while IFS= read -r component; do
        render_view "$component" "$temp_dir/$component.md" \
            "$source_commit" "$source_blob" "$source_snapshot"
    done < <(component_names | sort -u)
    rm -f -- "$source_snapshot"

    mkdir -p -- "$tasking_dir"
    for file in "$tasking_dir"/*.md; do
        [[ -e $file ]] || continue
        [[ $(basename -- "$file") == README.md ]] && continue
        rm -f -- "$file"
    done
    for file in "$temp_dir"/*.md; do
        mv -- "$file" "$tasking_dir/"
    done
    rmdir -- "$temp_dir"
    trap - EXIT HUP INT TERM
    printf 'generated tasking views at %s from %s\n' \
        "$tasking_dir" "$source_commit"
}

view_metadata() {
    local file=$1 label=$2
    awk -F'`' -v label="$label" \
        'index($0, label) { print $2; found = 1; exit } END { if (!found) exit 1 }' \
        "$file"
}

validate_view() {
    local component=$1 file=$tasking_dir/$component.md
    local recorded_component source_commit source_blob current_head current_blob
    [[ -f $file ]] || die "tasking view is unreachable for $component; run generate"
    recorded_component=$(view_metadata "$file" '**Component:**') ||
        die "tasking view lacks component metadata: $component"
    [[ $recorded_component == "$component" ]] ||
        die "tasking view component mismatch: $component"
    source_commit=$(view_metadata "$file" '**Source Project Manager commit:**') ||
        die "tasking view lacks source commit: $component"
    source_blob=$(view_metadata "$file" '**Source request blob:**') ||
        die "tasking view lacks request blob: $component"
    git_pm cat-file -e "$source_commit^{commit}" 2>/dev/null ||
        die "tasking source commit is unavailable: $source_commit"
    current_head=$(git_pm rev-parse --verify HEAD) ||
        die "cannot resolve current Project Manager HEAD"
    [[ $source_commit == "$current_head" ]] ||
        die "tasking view is stale for $component: source $source_commit, current $current_head"
    git_pm diff --quiet -- "$requests_rel" ||
        die "tasking is stale: request table has unstaged changes"
    git_pm diff --cached --quiet -- "$requests_rel" ||
        die "tasking is stale: request table has staged changes"
    current_blob=$(git_pm rev-parse --verify "HEAD:$requests_rel") ||
        die "cannot resolve current request blob"
    [[ $source_blob == "$current_blob" ]] ||
        die "tasking request snapshot is stale for $component"
}

resolve_component() {
    local requested=${1:-.} candidate candidate_path target
    if is_component "$requested"; then
        printf '%s' "$requested"
        return
    fi
    target=$(CDPATH= cd -- "$requested" 2>/dev/null && pwd -P) ||
        die "component path is unreachable: $requested"
    while IFS= read -r candidate; do
        if [[ $candidate == project-manager ]]; then
            candidate_path=$pm_root
        else
            candidate_path=$workspace_root/$candidate
        fi
        [[ -e $candidate_path ]] || continue
        candidate_path=$(CDPATH= cd -- "$candidate_path" 2>/dev/null && pwd -P) ||
            continue
        if [[ $target == "$candidate_path" ]]; then
            printf '%s' "$candidate"
            return
        fi
    done < <(component_names)
    die "path is not a registered component: $requested"
}

check_views() {
    local file component
    require_repository
    while IFS= read -r component; do
        validate_view "$component"
    done < <(component_names | sort -u)
    for file in "$tasking_dir"/*.md; do
        [[ -e $file ]] || continue
        [[ $(basename -- "$file") == README.md ]] && continue
        component=$(basename -- "$file" .md)
        is_component "$component" ||
            die "tasking view names an unregistered component: $component"
    done
    printf 'tasking views are current at %s\n' "$(git_pm rev-parse --verify HEAD)"
}

require_repository
(($# >= 1)) || { usage; exit 2; }
mode=$1
shift
case $mode in
generate)
    (($# == 0)) || { usage; exit 2; }
    generate_views
    ;;
check)
    (($# == 0)) || { usage; exit 2; }
    check_views
    ;;
resolve)
    (($# <= 1)) || { usage; exit 2; }
    component=$(resolve_component "${1:-.}")
    validate_view "$component"
    cat -- "$tasking_dir/$component.md"
    ;;
*)
    usage
    exit 2
    ;;
esac
