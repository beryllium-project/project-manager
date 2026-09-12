#!/usr/bin/env bash
# Read-only, sanitized Git inspection of the Beryllium workspace and its
# registered components for the Project Manager. Every mode is read-only:
# no hooks, credentials, network access, or worktree changes.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  inspect-components.sh components
  inspect-components.sh refs <component|workspace|project-manager> [<ref>...]
  inspect-components.sh state <component|workspace|project-manager>
  inspect-components.sh symlinks
  inspect-components.sh status
  inspect-components.sh registry-check [components-file]

components      one TSV row per registered entry: name, integration, worktree,
                branch, head
refs            local refs, remote-tracking refs as of the last fetch, tags,
                unmerged collab/* branches relative to main, and optional
                commit-ref checks for one entry
state           branch, head, worktree, upstream, ahead/behind, and porcelain
                status for one entry
symlinks        readlink, resolution, and Git root for every tracked *-repo link
status          the restart snapshot: parent, symlinks, components, upstreams
registry-check  compare each component row in ../COMPONENTS.md with the live
                HEAD or an explicit leading **Absent** marker; exit 1 on drift

"workspace" is the parent coordination repository. Registered names are the
component rows maintained in ../COMPONENTS.md.
EOF
}

die() {
    printf 'inspect-components: ERROR: %s\n' "$*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
repository_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve repository root"
workspace_root=${PM_WORKSPACE_ROOT:-$(CDPATH= cd -- "$repository_root/.." && pwd -P)} ||
    die "cannot resolve workspace root"

# Registered entries. Keep in step with the component rows of ../COMPONENTS.md;
# registry-check reports any difference in either direction.
registered_direct=(
    project-manager
    helium-te-poc
    formal-verification-research
    osr-claude
    provenance-review
    analysis-workbook
    threat-modeler
    security-reviewer
)
registered_symlinks=(
    beryllium-repo
    cheri-riscv-notes-repo
    xrv-research-repo
)

clean_environment=(
    env -i
    "PATH=$PATH"
    "HOME=/nonexistent"
    "XDG_CONFIG_HOME=/nonexistent"
    "LC_ALL=C"
    "GIT_TERMINAL_PROMPT=0"
    "GIT_ASKPASS=/bin/false"
    "SSH_ASKPASS=/bin/false"
    "GIT_CONFIG_NOSYSTEM=1"
    "GIT_OPTIONAL_LOCKS=0"
    "GIT_PAGER=cat"
    "PAGER=cat"
)

safe_git_options=(
    git
    -c core.hooksPath=/dev/null
    -c core.fsmonitor=false
    -c core.attributesFile=/dev/null
    -c core.autocrlf=false
    -c credential.helper=
    -c protocol.allow=never
    -c diff.external=
    -c pager.status=false
    -c pager.log=false
    -c pager.show=false
    -c pager.diff=false
)

is_registered() {
    local requested=$1 candidate
    [[ $requested == workspace ]] && return 0
    for candidate in "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        [[ $requested == "$candidate" ]] && return 0
    done
    return 1
}

integration_of() {
    local name=$1 candidate
    [[ $name == workspace ]] && { printf 'workspace'; return; }
    for candidate in "${registered_symlinks[@]}"; do
        [[ $name == "$candidate" ]] && { printf 'symlink'; return; }
    done
    printf 'direct'
}

entry_path() {
    local name=$1
    if [[ $name == workspace ]]; then
        printf '%s' "$workspace_root"
    else
        printf '%s/%s' "$workspace_root" "$name"
    fi
}

component_git=()
component_root=

open_entry() {
    local requested=$1 requested_path resolved root
    is_registered "$requested" || die "unregistered entry: $requested"
    requested_path=$(entry_path "$requested")
    [[ -e $requested_path ]] || die "entry is absent: $requested"
    resolved=$(CDPATH= cd -- "$requested_path" 2>/dev/null && pwd -P) ||
        die "cannot resolve entry: $requested"
    component_git=(
        "${clean_environment[@]}"
        "${safe_git_options[@]}"
        -C "$resolved"
    )
    "${component_git[@]}" rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
        die "not a Git work tree: $requested"
    root=$("${component_git[@]}" rev-parse --show-toplevel) ||
        die "cannot resolve Git root: $requested"
    component_root=$(CDPATH= cd -- "$root" && pwd -P) ||
        die "cannot canonicalize Git root: $requested"
    [[ $component_root == "$resolved" ]] ||
        die "entry is nested inside another repository: $requested ($component_root)"
}

git_head() {
    local out
    if out=$("${component_git[@]}" rev-parse --verify --quiet HEAD 2>/dev/null) &&
        [[ -n $out ]]; then
        printf '%s' "$out"
    else
        printf 'unborn'
    fi
}

git_branch() {
    local out
    if out=$("${component_git[@]}" symbolic-ref --quiet --short HEAD 2>/dev/null) &&
        [[ -n $out ]]; then
        printf '%s' "$out"
    else
        printf 'detached'
    fi
}

git_porcelain() {
    "${component_git[@]}" status --porcelain 2>/dev/null || true
}

git_upstream() {
    "${component_git[@]}" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' \
        2>/dev/null || printf 'none'
}

git_ahead_behind() {
    # Prints "<behind> <ahead>" relative to the upstream, or "- -".
    local upstream=$1 counts
    [[ $upstream != none ]] || { printf -- '- -'; return; }
    counts=$("${component_git[@]}" rev-list --left-right --count \
        "$upstream...HEAD" 2>/dev/null) || { printf -- '- -'; return; }
    printf '%s' "$counts" | tr '\t' ' '
}

worktree_state() {
    if [[ -n $(git_porcelain) ]]; then printf 'dirty'; else printf 'clean'; fi
}

print_components_table() {
    local name path
    printf '# registered entries (name, integration, worktree, branch, head)\n'
    printf '# workspace root: %s\n' "$workspace_root"
    printf '# checked: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    for name in workspace "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        path=$(entry_path "$name")
        if [[ ! -e $path ]]; then
            printf '%s\t%s\tabsent\t-\t-\n' "$name" "$(integration_of "$name")"
            continue
        fi
        if ! open_entry "$name" 2>/dev/null; then
            printf '%s\t%s\tunresolvable\t-\t-\n' "$name" "$(integration_of "$name")"
            continue
        fi
        printf '%s\t%s\t%s\t%s\t%s\n' "$name" "$(integration_of "$name")" \
            "$(worktree_state)" "$(git_branch)" "$(git_head)"
    done
}

print_state() {
    local name=$1 head branch porcelain worktree changed upstream counts
    open_entry "$name"
    head=$(git_head)
    branch=$(git_branch)
    porcelain=$(git_porcelain)
    if [[ -n $porcelain ]]; then
        worktree=dirty
        changed=$(printf '%s\n' "$porcelain" | grep -c .)
    else
        worktree=clean
        changed=0
    fi
    upstream=$(git_upstream)
    counts=$(git_ahead_behind "$upstream")
    printf 'entry\t%s\n' "$name"
    printf 'integration\t%s\n' "$(integration_of "$name")"
    printf 'git-root\t%s\n' "$component_root"
    printf 'head\t%s\n' "$head"
    printf 'branch\t%s\n' "$branch"
    printf 'worktree\t%s\n' "$worktree"
    printf 'changed-entries\t%s\n' "$changed"
    printf 'upstream\t%s\n' "$upstream"
    printf 'behind\t%s\n' "${counts% *}"
    printf 'ahead\t%s\n' "${counts#* }"
    printf 'checked\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    if [[ -n $porcelain ]]; then
        printf '%s\n' "$porcelain" | sed 's/^/status\t/'
    fi
}

join_lines() {
    local first=1 line
    while IFS= read -r line; do
        [[ -n $line ]] || continue
        if ((first)); then
            printf '%s' "$line"
            first=0
        else
            printf ',%s' "$line"
        fi
    done
    ((first)) && printf 'none'
    return 0
}

print_containing_branches() {
    local kind=$1 object=$2
    if [[ $kind == local ]]; then
        { "${component_git[@]}" branch --contains "$object" \
            --format='%(refname:short)' 2>/dev/null || true; } | sort | join_lines
    else
        { "${component_git[@]}" branch --remotes --contains "$object" \
            --format='%(refname:short)' 2>/dev/null || true; } | sort | join_lines
    fi
}

print_refs() {
    local name=$1 ref ref_arg head branch line local_name object upstream track
    local ahead behind tag_name peeled target main_ref main_head collab collab_head
    local ahead_behind resolution full_sha subject local_contains remote_contains
    shift
    open_entry "$name"
    head=$(git_head)
    printf '# refs for entry: %s\n' "$name"
    printf '# git-root: %s\n' "$component_root"
    printf '# head: %s\n' "$head"
    printf '# checked: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    printf '# local branches (name, head, upstream, ahead, behind)\n'
    while IFS=$'\t' read -r local_name object upstream track; do
        [[ -n $local_name ]] || continue
        if [[ -z $upstream ]]; then
            upstream=none
            ahead=-
            behind=-
        elif [[ $track == *gone* ]]; then
            ahead=unknown
            behind=unknown
        else
            ahead=0
            behind=0
            if [[ $track =~ ahead[[:space:]]+([0-9]+) ]]; then
                ahead=${BASH_REMATCH[1]}
            fi
            if [[ $track =~ behind[[:space:]]+([0-9]+) ]]; then
                behind=${BASH_REMATCH[1]}
            fi
        fi
        printf '%s\t%s\t%s\t%s\t%s\n' "$local_name" "$object" "$upstream" \
            "$ahead" "$behind"
    done < <("${component_git[@]}" for-each-ref \
        --format=$'%(refname:short)\t%(objectname)\t%(upstream:short)\t%(upstream:track)' \
        refs/heads)

    printf '# remote-tracking branches (name, head) -- as of the last fetch; not a live remote check\n'
    while IFS=$'\t' read -r branch object; do
        [[ -n $branch ]] || continue
        printf '%s\t%s\n' "$branch" "$object"
    done < <("${component_git[@]}" for-each-ref \
        --format=$'%(refname:short)\t%(objectname)' refs/remotes)

    printf '# tags (name, target)\n'
    while IFS=$'\t' read -r tag_name object peeled; do
        [[ -n $tag_name ]] || continue
        target=${peeled:-$object}
        printf '%s\t%s\n' "$tag_name" "$target"
    done < <("${component_git[@]}" for-each-ref \
        --format=$'%(refname:short)\t%(objectname)\t%(*objectname)' refs/tags)

    printf '# unmerged collab/* branches relative to main (name, head, commits-ahead)\n'
    if ! main_head=$("${component_git[@]}" rev-parse --verify --quiet \
        refs/heads/main^{commit} 2>/dev/null); then
        printf '# main branch absent; unmerged collab/* listing omitted\n'
    else
        while IFS=$'\t' read -r collab collab_head; do
            [[ -n $collab ]] || continue
            ahead_behind=$("${component_git[@]}" for-each-ref \
                --format='%(ahead-behind:refs/heads/main)' "refs/heads/$collab")
            printf '%s\t%s\t%s\n' "$collab" "$collab_head" \
                "${ahead_behind##* }"
        done < <("${component_git[@]}" branch --no-merged "$main_head" \
            --list 'collab/*' --format=$'%(refname:short)\t%(objectname)' || true)
    fi

    printf '# ref checks (ref, resolution, full-sha, on-local-branches, on-remote-tracking-branches, subject)\n'
    for ref_arg in "$@"; do
        resolution=absent
        full_sha=-
        subject=-
        local_contains=none
        remote_contains=none
        if [[ $ref_arg =~ ^[0-9a-fA-F]{4,39}$ ]]; then
            line=$({ "${component_git[@]}" rev-parse --disambiguate="$ref_arg" 2>/dev/null || true; } |
                while IFS= read -r ref; do
                    if "${component_git[@]}" cat-file -e "$ref^{commit}" 2>/dev/null; then
                        printf '%s\n' "$ref"
                    fi
                done | sort -u)
            if [[ $(printf '%s\n' "$line" | grep -c .) -gt 1 ]]; then
                resolution=ambiguous
            elif [[ -n $line ]]; then
                full_sha=$line
                resolution=exists
            fi
        elif full_sha=$("${component_git[@]}" rev-parse --verify --quiet \
            "$ref_arg^{commit}" 2>/dev/null); then
            if "${component_git[@]}" cat-file -e "$full_sha^{commit}" 2>/dev/null; then
                resolution=exists
            else
                resolution=absent
                full_sha=-
            fi
        fi
        if [[ $resolution == exists ]]; then
            local_contains=$(print_containing_branches local "$full_sha")
            remote_contains=$(print_containing_branches remote "$full_sha")
            subject=$("${component_git[@]}" log -1 --format=%s "$full_sha")
        fi
        printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$ref_arg" "$resolution" \
            "$full_sha" "$local_contains" "$remote_contains" "$subject"
    done
}

print_symlinks() {
    local name path target resolved
    printf '# tracked symlink entries (name, link-target, resolution, git-root, head)\n'
    for name in "${registered_symlinks[@]}"; do
        path=$workspace_root/$name
        if [[ ! -L $path ]]; then
            if [[ -e $path ]]; then
                printf '%s\t-\tnot-a-symlink\t-\t-\n' "$name"
            else
                printf '%s\t-\tabsent\t-\t-\n' "$name"
            fi
            continue
        fi
        target=$(readlink -- "$path")
        if ! resolved=$(CDPATH= cd -- "$path" 2>/dev/null && pwd -P); then
            printf '%s\t%s\tunresolved\t-\t-\n' "$name" "$target"
            continue
        fi
        if open_entry "$name" 2>/dev/null; then
            printf '%s\t%s\tresolved\t%s\t%s\n' "$name" "$target" \
                "$component_root" "$(git_head)"
        else
            printf '%s\t%s\tresolved-not-git\t%s\t-\n' "$name" "$target" "$resolved"
        fi
    done
}

print_status() {
    local name upstream counts
    printf '== Project Manager restart snapshot ==\n'
    printf 'workspace root: %s\n' "$workspace_root"
    printf 'checked: %s\n\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    printf '== parent coordination repository ==\n'
    print_state workspace | grep -Ev '^(entry|integration)\b'
    printf '\n== tracked symlinks ==\n'
    print_symlinks
    printf '\n== registered components (name, integration, worktree, branch, head, upstream, behind, ahead) ==\n'
    for name in "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        if [[ ! -e $(entry_path "$name") ]]; then
            printf '%s\t%s\tabsent\t-\t-\t-\t-\t-\n' "$name" "$(integration_of "$name")"
            continue
        fi
        if ! open_entry "$name" 2>/dev/null; then
            printf '%s\t%s\tunresolvable\t-\t-\t-\t-\t-\n' "$name" "$(integration_of "$name")"
            continue
        fi
        upstream=$(git_upstream)
        counts=$(git_ahead_behind "$upstream")
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$name" "$(integration_of "$name")" \
            "$(worktree_state)" "$(git_branch)" "$(git_head)" "$upstream" \
            "${counts% *}" "${counts#* }"
    done
    if [[ -x $script_dir/pull-queues.sh ]]; then
        printf '\n== component queues ==\n'
        "$script_dir/pull-queues.sh" summary || printf 'queue summary unavailable\n'
    fi
}

registry_check() {
    local file=${1:-$workspace_root/COMPONENTS.md} drift=0 name recorded live
    local -A recorded_hash=() seen=()
    [[ -f $file ]] || die "registry file is absent: $file"

    # Component rows: first cell is a backticked entry name; the third cell is
    # the observed state whose first 7-40 hex token is the observed HEAD, or
    # begins with **Absent** when a registered path is deliberately unavailable.
    while IFS=$'\t' read -r name recorded; do
        [[ -n $name ]] || continue
        recorded_hash[$name]=$recorded
    done < <(awk -F'|' '
        /^\| *`[A-Za-z0-9._-]+\/?` *\|/ {
            name = $2
            gsub(/[` \/]/, "", name)
            state = $4
            hash = "unparsed"
            if (state ~ /^[[:space:]]*\*\*Absent\*\*/) {
                hash = "absent"
            } else {
                while (match(state, /`[0-9a-f]{7,40}`/)) {
                    token = substr(state, RSTART + 1, RLENGTH - 2)
                    if (token ~ /[0-9]/ || length(token) >= 12) { hash = token; break }
                    state = substr(state, RSTART + RLENGTH)
                }
            }
            printf "%s\t%s\n", name, hash
        }' "$file")

    printf '# registry check against %s\n' "${file#"$workspace_root/"}"
    printf '# (name, recorded, live, result)\n'
    for name in "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        seen[$name]=1
        if [[ -z ${recorded_hash[$name]:-} ]]; then
            printf '%s\t-\t-\tmissing-row\n' "$name"
            drift=1
            continue
        fi
        recorded=${recorded_hash[$name]}
        if [[ ! -e $(entry_path "$name") ]]; then
            if [[ $recorded == absent ]]; then
                printf '%s\tabsent\tabsent\tmatch\n' "$name"
            else
                printf '%s\t%s\t-\tunresolvable\n' "$name" "$recorded"
                drift=1
            fi
            continue
        fi
        if ! open_entry "$name" 2>/dev/null; then
            printf '%s\t%s\t-\tunresolvable\n' "$name" "$recorded"
            drift=1
            continue
        fi
        live=$(git_head)
        if [[ $recorded == unparsed ]]; then
            printf '%s\t%s\t%s\tunparsed\n' "$name" "$recorded" "$live"
            drift=1
        elif [[ $live == "$recorded"* ]]; then
            printf '%s\t%s\t%s\tmatch\n' "$name" "$recorded" "$live"
        else
            printf '%s\t%s\t%s\tdrift\n' "$name" "$recorded" "$live"
            drift=1
        fi
    done
    for name in "${!recorded_hash[@]}"; do
        if [[ -z ${seen[$name]:-} ]]; then
            printf '%s\t%s\t-\tunregistered-row\n' "$name" "${recorded_hash[$name]}"
            drift=1
        fi
    done
    return "$drift"
}

(($# >= 1)) || {
    usage
    exit 2
}

mode=$1
shift

case $mode in
components)
    (($# == 0)) || { usage; exit 2; }
    print_components_table
    ;;
refs)
    (($# >= 1)) || { usage; exit 2; }
    print_refs "$@"
    ;;
state)
    (($# == 1)) || { usage; exit 2; }
    print_state "$1"
    ;;
symlinks)
    (($# == 0)) || { usage; exit 2; }
    print_symlinks
    ;;
status)
    (($# == 0)) || { usage; exit 2; }
    print_status
    ;;
registry-check)
    (($# <= 1)) || { usage; exit 2; }
    registry_check "$@"
    ;;
*)
    usage
    exit 2
    ;;
esac
