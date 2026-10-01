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
  inspect-components.sh fingerprint <component|workspace|project-manager>
  inspect-components.sh refs <component|workspace|project-manager> [<ref>...]
  inspect-components.sh state <component|workspace|project-manager>
  inspect-components.sh symlinks
  inspect-components.sh status
  inspect-components.sh registry-check [components-file]
  inspect-components.sh quiescence

components      one TSV row per registered entry: name, integration, worktree,
                branch, head
fingerprint     exact HEAD/status plus SHA-256 of the tracked full-index
                binary diff for one entry; refuses untracked or restricted
                OS-security paths
refs            local refs, remote-tracking refs as of the last fetch, tags,
                unmerged collab/* branches relative to main, and optional
                commit-ref checks for one entry
state           branch, head, worktree, upstream, ahead/behind, and porcelain
                status for one entry
symlinks        readlink, resolution, and Git root for every tracked component symlink
status          the restart snapshot: parent, symlinks, components, upstreams
registry-check  compare each component row in ../COMPONENTS.md with the live
                HEAD or an explicit leading **Absent** marker; exit 1 on drift
quiescence      PMR-108 automated preconditions: parent and every registered
                entry present and clean (untracked included), every linked
                worktree of each listed repository present, not prunable,
                and clean, registry-check exact, queue and tasking checks
                passing, and no owner-session writer lock held; exit 1 on any
                failure, including a global maintenance reservation held
                without this session's PM_MAINTENANCE_RESERVATION marker; a
                free reservation is reported but does not fail. Exit 0 does
                not establish quiescence: active-session reports, a held
                reservation, and same-turn human confirmation remain required.

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
    beryllium-hypervisor
    helium-te-poc
    formal-verification-research
    osr-claude
    provenance-review
    analysis-workbook
    threat-modeler
    security-reviewer
)
registered_symlinks=(
    cheri-riscv-notes
    cheri-hypervisor-research
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

print_fingerprint() {
    local requested=$1 status untracked_count diff_sha
    open_entry "$requested"
    status=$("${component_git[@]}" status --porcelain=v1 --untracked-files=all)
    [[ -n $status ]] || die "entry is clean: $requested"
    if [[ $requested == osr-claude &&
          $status == *"sources/restricted-microsoft/"* ]]; then
        die "fingerprint refuses restricted OS-security paths"
    fi
    untracked_count=$(printf '%s\n' "$status" | awk 'substr($0, 1, 2) == "??" { n++ } END { print n + 0 }')
    ((untracked_count == 0)) ||
        die "fingerprint requires a tracked-only dirty state: $requested"
    diff_sha=$(
        "${component_git[@]}" diff --binary --full-index --no-ext-diff --no-textconv HEAD -- |
            sha256sum | awk '{ print $1 }'
    ) || die "cannot fingerprint tracked diff: $requested"
    printf 'entry\t%s\n' "$requested"
    printf 'branch\t%s\n' "$(git_branch)"
    printf 'head\t%s\n' "$(git_head)"
    printf 'tracked-diff-sha256\t%s\n' "$diff_sha"
    printf 'status-count\t%s\n' "$(printf '%s\n' "$status" | awk 'END { print NR }')"
    while IFS= read -r line; do
        printf 'status\t%s\n' "$line"
    done <<<"$status"
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
                    hash = token
                    break
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

quiescence_failures=0

quiescence_row() {
    # check, subject, result, detail
    printf '%s\t%s\t%s\t%s\n' "$1" "$2" "$3" "$4"
    [[ $3 == pass || $3 == manual || $3 == free ]] ||
        quiescence_failures=$((quiescence_failures + 1))
}

quiescence_worktree_one() {
    local name=$1 path=$2 prunable=$3 key porcelain
    local -a wt_git
    key=$path
    if [[ -d $path ]]; then
        key=$(CDPATH= cd -- "$path" 2>/dev/null && pwd -P) || key=$path
    fi
    [[ ${quiescence_seen[$key]:-} == 1 ]] && return 0
    quiescence_seen[$key]=1
    if ((prunable)); then
        quiescence_row worktree "$name:$path" fail prunable
    elif [[ ! -d $path ]]; then
        quiescence_row worktree "$name:$path" fail absent
    else
        wt_git=("${clean_environment[@]}" "${safe_git_options[@]}" -C "$key")
        if ! porcelain=$("${wt_git[@]}" status --porcelain --untracked-files=normal 2>/dev/null); then
            quiescence_row worktree "$name:$path" fail "status failed"
        elif [[ -n $porcelain ]]; then
            quiescence_row worktree "$name:$path" fail \
                "dirty ($(printf '%s\n' "$porcelain" | grep -c .) entries)"
        else
            quiescence_row worktree "$name:$path" pass clean
        fi
    fi
}

quiescence_worktrees() {
    # Check every worktree listed by one repository; its own entry root was
    # already checked and is skipped through quiescence_seen. The listing is
    # captured once so the inspected enumeration is the one whose exit status
    # was checked.
    local name=$1 record path= prunable=0 listing_file
    listing_file=$(mktemp "${TMPDIR:-/tmp}/pm-quiescence.XXXXXX") || {
        quiescence_row worktree-list "$name" fail "cannot create temporary file"
        return 0
    }
    if ! "${component_git[@]}" worktree list --porcelain -z >"$listing_file" 2>/dev/null; then
        rm -f -- "$listing_file"
        quiescence_row worktree-list "$name" fail "git worktree list failed"
        return 0
    fi
    while IFS= read -r -d '' record; do
        if [[ -n $record ]]; then
            case $record in
            "worktree "*) path=${record#worktree } ;;
            prunable*) prunable=1 ;;
            esac
            continue
        fi
        [[ -n $path ]] && quiescence_worktree_one "$name" "$path" "$prunable"
        path=
        prunable=0
    done <"$listing_file"
    rm -f -- "$listing_file"
    [[ -n $path ]] && quiescence_worktree_one "$name" "$path" "$prunable"
    return 0
}

print_quiescence() {
    local name path porcelain lock_root lock_file lock_fd held=0 global_lock global_fd
    local -A quiescence_seen=()
    printf '# PMR-108 quiescence preconditions (check, subject, result, detail)\n'
    printf '# workspace root: %s\n' "$workspace_root"
    printf '# checked: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    for name in workspace "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        path=$(entry_path "$name")
        if [[ ! -e $path ]]; then
            quiescence_row entry "$name" fail absent
            continue
        fi
        if ! (open_entry "$name") >/dev/null 2>&1; then
            quiescence_row entry "$name" fail unresolvable
            continue
        fi
        open_entry "$name"
        quiescence_seen[$component_root]=1
        if ! porcelain=$("${component_git[@]}" status --porcelain --untracked-files=normal 2>/dev/null); then
            quiescence_row entry "$name" fail "status failed"
        elif [[ -n $porcelain ]]; then
            quiescence_row entry "$name" fail \
                "dirty ($(printf '%s\n' "$porcelain" | grep -c .) entries)"
        else
            quiescence_row entry "$name" pass clean
        fi
    done

    for name in workspace "${registered_direct[@]}" "${registered_symlinks[@]}"; do
        [[ -e $(entry_path "$name") ]] || continue
        (open_entry "$name") >/dev/null 2>&1 || continue
        open_entry "$name"
        quiescence_worktrees "$name"
    done

    if (registry_check) >/dev/null 2>&1; then
        quiescence_row registry-check COMPONENTS.md pass exact
    else
        quiescence_row registry-check COMPONENTS.md fail drift
    fi
    # Sibling checks run in the sanitized environment so inherited tasking
    # or Git overrides cannot redirect them.
    if "${clean_environment[@]}" bash "$script_dir/pull-queues.sh" check >/dev/null 2>&1; then
        quiescence_row queues pull-queues.sh pass check
    else
        quiescence_row queues pull-queues.sh fail check
    fi
    if "${clean_environment[@]}" bash "$script_dir/project-tasking.sh" check >/dev/null 2>&1; then
        quiescence_row tasking project-tasking.sh pass current
    else
        quiescence_row tasking project-tasking.sh fail "missing or stale"
    fi

    lock_root=${PM_OWNER_SESSION_SCRATCH:-$repository_root/scratch/owner-sessions}/locks
    if ! command -v flock >/dev/null 2>&1; then
        quiescence_row writer-locks owner-sessions fail "flock unavailable"
    elif [[ -L $lock_root || -L ${lock_root%/locks} ]]; then
        quiescence_row writer-locks owner-sessions fail "lock root is a symbolic link"
    elif [[ -e $lock_root && ! -d $lock_root ]]; then
        quiescence_row writer-locks owner-sessions fail "lock root is not a directory"
    elif [[ -d $lock_root ]]; then
        local lock_list
        if ! lock_list=$(mktemp "${TMPDIR:-/tmp}/pm-quiescence.XXXXXX"); then
            quiescence_row writer-locks owner-sessions fail "cannot create temporary file"
        elif ! find "$lock_root" -mindepth 1 -maxdepth 1 -name '*.lock' -print0 \
            >"$lock_list" 2>/dev/null; then
            rm -f -- "$lock_list"
            quiescence_row writer-locks owner-sessions fail "lock scan failed"
        else
            while IFS= read -r -d '' lock_file; do
                if [[ -L $lock_file || ! -f $lock_file ]]; then
                    quiescence_row writer-lock "$(basename -- "$lock_file")" fail unsupported
                    held=1
                    continue
                fi
                if ! exec {lock_fd}<"$lock_file"; then
                    quiescence_row writer-lock "$(basename -- "$lock_file")" fail unreadable
                    held=1
                    continue
                fi
                if flock -n -s "$lock_fd"; then
                    flock -u "$lock_fd"
                else
                    quiescence_row writer-lock "$(basename -- "$lock_file")" fail held
                    held=1
                fi
                exec {lock_fd}<&-
            done <"$lock_list"
            rm -f -- "$lock_list"
            ((held)) || quiescence_row writer-locks owner-sessions pass "none held"
        fi
    else
        quiescence_row writer-locks owner-sessions pass "no lock directory"
    fi

    global_lock=${PM_OWNER_SESSION_SCRATCH:-$repository_root/scratch/owner-sessions}/global/maintenance.lock
    if [[ -L $global_lock || -L ${global_lock%/maintenance.lock} ]]; then
        quiescence_row global-reservation maintenance fail unsupported
    elif [[ ! -e $global_lock ]]; then
        quiescence_row global-reservation maintenance free \
            "not held; rollout requires maintenance-reservation.sh hold"
    elif [[ ! -f $global_lock ]]; then
        quiescence_row global-reservation maintenance fail unsupported
    elif ! command -v flock >/dev/null 2>&1 || ! exec {global_fd}<"$global_lock"; then
        quiescence_row global-reservation maintenance fail "cannot probe"
    elif flock -n -s "$global_fd"; then
        flock -u "$global_fd"
        exec {global_fd}<&-
        quiescence_row global-reservation maintenance free \
            "not held; rollout requires maintenance-reservation.sh hold"
    else
        exec {global_fd}<&-
        if [[ ${PM_MAINTENANCE_RESERVATION:-} == held ]]; then
            quiescence_row global-reservation maintenance pass \
                "held; environment marker present (holder not verified)"
        else
            quiescence_row global-reservation maintenance fail \
                "held by another holder or an owner launch"
        fi
    fi
    quiescence_row active-session-reports handoffs-returns-runtime manual \
        "not machine-checked: review handoffs, owner returns, runtime and hidden owner-worker reservations"
    quiescence_row human-confirmation same-turn manual \
        "required: responsible human confirms no non-instrumented session"

    if ((quiescence_failures == 0)); then
        printf 'automated-preconditions\tpass\n'
    else
        printf 'automated-preconditions\tfail\t%s failing checks\n' "$quiescence_failures"
    fi
    printf 'quiescence\tnot established by this check; manual items, a held global reservation, and an immediate pre-write recheck remain required; no gate is granted\n'
    ((quiescence_failures == 0))
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
fingerprint)
    (($# == 1)) || { usage; exit 2; }
    print_fingerprint "$1"
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
quiescence)
    (($# == 0)) || { usage; exit 2; }
    print_quiescence
    ;;
*)
    usage
    exit 2
    ;;
esac
