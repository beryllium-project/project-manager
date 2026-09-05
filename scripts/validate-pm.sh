#!/usr/bin/env bash
# Structural validation of the Project Manager artifacts: handoff contract,
# ledger and request tables, decision records, wording and path discipline,
# and the parent-root redirect stubs. Read-only.

set -u
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  validate-pm.sh [--no-parent] [root]

Validates the project-manager repository at <root> (default: the repository
containing this script). --no-parent skips the checks of the parent-root
artifacts (../HANDOFF.md, ../formal-verification/..., ../COMPONENTS.md,
../SOT.md, ../.gitignore); use it for fixtures. Exit 1 on any failure.
EOF
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) || {
    printf 'validate-pm: ERROR: cannot resolve script directory\n' >&2
    exit 2
}
root=$(CDPATH= cd -- "$script_dir/.." && pwd -P)
check_parent=1

while (($# > 0)); do
    case $1 in
    --no-parent)
        check_parent=0
        shift
        ;;
    -h | --help)
        usage
        exit 0
        ;;
    -*)
        usage
        exit 2
        ;;
    *)
        root=$(CDPATH= cd -- "$1" && pwd -P) || {
            printf 'validate-pm: ERROR: bad root: %s\n' "$1" >&2
            exit 2
        }
        shift
        ;;
    esac
done

pass_count=0
fail_count=0

pass() {
    pass_count=$((pass_count + 1))
    printf 'ok   %s\n' "$*"
}

fail() {
    fail_count=$((fail_count + 1))
    printf 'FAIL %s\n' "$*"
}

rel() {
    printf '%s' "${1#"$root/"}"
}

require_file() {
    if [[ -f $1 ]]; then pass "file exists: $(rel "$1")"; else fail "file is missing: $(rel "$1")"; fi
}

require_text() {
    if [[ -f $1 ]] && grep -Fq -- "$2" "$1"; then
        pass "$(rel "$1") states: $2"
    else
        fail "$(rel "$1") does not state: $2"
    fi
}

# --- required files -------------------------------------------------------

handoff=$root/HANDOFF.md
roster=$root/AGENT-ROSTER.md
ledger=$root/queue/LEDGER.md
requests=$root/outbox/component-requests.md
for f in "$handoff" "$roster" "$ledger" "$requests" "$root/records/README.md" \
    "$root/queue/README.md" "$root/templates/decision.md" \
    "$root/templates/ledger-row.md" "$root/templates/request-row.md"; do
    require_file "$f"
done

card_count=$(find "$root/components" -maxdepth 1 -name '*.md' -type f 2>/dev/null | wc -l)
if ((card_count >= 1)); then
    pass "components/ holds $card_count knowledge card(s)"
else
    fail "components/ holds no knowledge card"
fi

# --- handoff contract -----------------------------------------------------

for marker in '**Last updated:**' '## Fast resume' '### Overall position' \
    '### One recommended next action' '### Minimal restart commands' \
    '## Pending coordination'; do
    require_text "$handoff" "$marker"
done
if [[ -f $handoff ]] && grep -Eq '^\*\*Last updated:\*\* [0-9]{4}-[0-9]{2}-[0-9]{2}' "$handoff"; then
    pass "HANDOFF.md carries an ISO last-updated date"
else
    fail "HANDOFF.md lacks an ISO last-updated date"
fi

# --- table helpers --------------------------------------------------------

header_line() {
    # First table header line of a file (the line starting with "| " that is
    # followed by a separator line).
    awk 'prev ~ /^\|/ && $0 ~ /^\| *---/ { print prev; exit } { prev = $0 }' "$1"
}

table_rows() {
    local file=$1 prefix=$2
    awk -F'|' -v prefix="$prefix" '
        function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
        /^\|/ {
            first = trim($2)
            if (index(first, prefix "-") != 1) next
            out = ""
            for (i = 2; i < NF; i++) out = out (i > 2 ? "\t" : "") trim($i)
            print out
        }' "$file"
}

check_table() {
    # check_table <file> <template> <prefix> <id-regex> <status-col> <status-regex>
    local file=$1 template=$2 prefix=$3 id_regex=$4 status_col=$5 status_regex=$6
    local expected actual columns previous=0 line id status n bad=0 rows=0 fields
    [[ -f $file && -f $template ]] || return
    expected=$(header_line "$template")
    actual=$(header_line "$file")
    if [[ $expected == "$actual" ]]; then
        pass "$(rel "$file") header matches $(rel "$template")"
    else
        fail "$(rel "$file") header differs from $(rel "$template")"
    fi
    columns=$(printf '%s' "$expected" | awk -F'|' '{ print NF - 2 }')
    while IFS= read -r line; do
        [[ -n $line ]] || continue
        rows=$((rows + 1))
        fields=$(printf '%s' "$line" | awk -F'\t' '{ print NF }')
        id=${line%%$'\t'*}
        if ((fields != columns)); then
            fail "$(rel "$file") row $id has $fields cells, expected $columns"
            bad=1
        fi
        if [[ ! $id =~ $id_regex ]]; then
            fail "$(rel "$file") row identifier is malformed: $id"
            bad=1
            continue
        fi
        n=${id##*-}
        if ((10#$n <= previous)); then
            fail "$(rel "$file") identifiers are not strictly increasing at $id"
            bad=1
        fi
        previous=$((10#$n))
        status=$(printf '%s' "$line" | awk -F'\t' -v c="$status_col" '{ print $c }')
        if [[ ! $status =~ $status_regex ]]; then
            fail "$(rel "$file") row $id has an invalid status: $status"
            bad=1
        fi
    done < <(table_rows "$file" "$prefix")
    ((bad == 0)) && pass "$(rel "$file") rows are well formed ($rows row(s))"
}

check_table "$ledger" "$root/templates/ledger-row.md" PML \
    '^PML-[0-9]{4}$' 7 '^(pending|routed|accepted|duplicate|rejected|deferred)$'
check_table "$requests" "$root/templates/request-row.md" PMR \
    '^PMR-[0-9]{3}$' 6 '^(open|closed|withdrawn|superseded)$'

# Ledger-specific cells.
if [[ -f $ledger ]]; then
    bad=0
    while IFS=$'\t' read -r id source sid _raised _title _owner _status applied _decided _note; do
        [[ -n $id ]] || continue
        if [[ ! $source =~ ^(analysis-workbook|threat-modeler|analysis-workbook-transfer)$ ]]; then
            fail "queue/LEDGER.md $id names an unknown source component: $source"
            bad=1
        fi
        case $source in
        analysis-workbook)
            [[ $sid =~ ^PMQ-[0-9]{3}$ ]] || {
                fail "queue/LEDGER.md $id has an invalid analysis-workbook source ID: $sid"
                bad=1
            }
            ;;
        threat-modeler)
            [[ $sid =~ ^DISC-[0-9]{3}$ ]] || {
                fail "queue/LEDGER.md $id has an invalid threat-modeler source ID: $sid"
                bad=1
            }
            ;;
        analysis-workbook-transfer)
            [[ $sid =~ ^HET-[0-9]{3}$ ]] || {
                fail "queue/LEDGER.md $id has an invalid transfer source ID: $sid"
                bad=1
            }
            ;;
        esac
        if [[ $source == analysis-workbook-transfer ]]; then
            if [[ $applied != 'Not applicable' ]]; then
                fail "queue/LEDGER.md $id transfer row must mark applied as Not applicable: $applied"
                bad=1
            fi
        elif [[ ! $applied =~ ^(no|yes\ [0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
            fail "queue/LEDGER.md $id has an invalid applied value: $applied"
            bad=1
        fi
    done < <(table_rows "$ledger" PML)
    ((bad == 0)) && pass "queue/LEDGER.md source and applied cells are valid"
fi

# --- transfer queue (HET) tracking ---------------------------------------

pull=$root/scripts/pull-queues.sh
if [[ -f $pull ]]; then
    require_text "$pull" 'analysis-workbook/outbox/helium-transfer-queue.md'
    require_text "$pull" 'outside class 1 of PMD-20260904-003'
    bad=0
    while IFS= read -r line; do
        if [[ $line == *analysis-workbook-transfer:* && $line != *"printf ''"* ]]; then
            fail "scripts/pull-queues.sh maps a transfer PM status to a source edit: $line"
            bad=1
        fi
    done <"$pull"
    ((bad == 0)) && pass "scripts/pull-queues.sh has no non-empty transfer status mapping"
else
    pass "scripts/pull-queues.sh transfer mapping check skipped for fixture without scripts"
fi
require_text "$root/queue/README.md" 'accepted is never used for transfer rows'
if [[ -f $ledger ]]; then
    bad=0
    while IFS=$'\t' read -r id source _sid _raised _title _owner status applied _decided _note; do
        [[ $source == analysis-workbook-transfer ]] || continue
        if [[ $status == accepted ]]; then
            fail "queue/LEDGER.md $id transfer row uses accepted"
            bad=1
        fi
        if [[ $applied != 'Not applicable' ]]; then
            fail "queue/LEDGER.md $id transfer row applied value is not Not applicable: $applied"
            bad=1
        fi
    done < <(table_rows "$ledger" PML)
    ((bad == 0)) && pass "queue/LEDGER.md transfer rows are read-only tracked"
fi

# --- decision records -----------------------------------------------------

decision_count=0
for record in "$root"/records/decisions/*.md; do
    [[ -e $record ]] || continue
    decision_count=$((decision_count + 1))
    base=${record##*/}
    if [[ $base =~ ^(PMD-[0-9]{8}-[0-9]{3})-[a-z0-9]+(-[a-z0-9]+)*\.md$ ]]; then
        id=${BASH_REMATCH[1]}
        pass "records/decisions/$base is well named"
    else
        fail "records/decisions/$base is misnamed"
        continue
    fi
    require_text "$record" "**Record ID:** \`$id\`"
    if grep -Eq '^- \*\*Status:\*\* (proposed|recorded|superseded)$' "$record"; then
        pass "records/decisions/$base has a valid status"
    else
        fail "records/decisions/$base lacks a valid status"
    fi
    for section in '## Scope' '## Inputs' '## Disposition' \
        '## What this record does not decide' '## Follow-up' '## Provenance'; do
        require_text "$record" "$section"
    done
    if grep -Fq '@@' "$record"; then
        fail "records/decisions/$base still contains template placeholders"
    else
        pass "records/decisions/$base has no template placeholders"
    fi
    # Prompt lines emitted by templates/decision.md that a filled record must
    # replace; tests/validate-agent.sh checks that the template still emits them.
    if grep -Eq -- '<(component|path|commit)>|^State the (coordination question|Project Manager disposition)|^- One specific next action, with the exact path or command\.$' "$record"; then
        fail "records/decisions/$base still contains unfilled scaffold prompts"
    else
        pass "records/decisions/$base has no unfilled scaffold prompts"
    fi
done
pass "records/decisions/ holds $decision_count record(s)"

# --- wording, path, and secret discipline ------------------------------------

markdown_files=()
while IFS= read -r -d '' f; do
    markdown_files+=("$f")
done < <(find "$root" -path "$root/.git" -prune -o -path "$root/tests/fixtures" -prune -o \
    -path "$root/inbox" -prune -o -path "$root/scratch" -prune -o \
    -type f -name '*.md' -print0 | sort -z)

grant_pattern='\b(Project Manager|agent|automation|orchestrator|auditor|tool) (grants|approves|accepts|signs off|publishes|releases|authorizes)\b'
negation_pattern='\b(never|not|no|without|cannot|must not|neither|nor)\b'

paragraphs() {
    # Join wrapped Markdown lines so that a negation earlier in the same
    # paragraph is seen together with the claim it qualifies.
    awk '
        /^[[:space:]]*$/ { if (buf != "") print buf; buf = ""; next }
        { line = $0; sub(/^[[:space:]]+/, "", line); buf = (buf == "" ? line : buf " " line) }
        END { if (buf != "") print buf }' "$1"
}

bad=0
for f in "${markdown_files[@]}"; do
    while IFS= read -r para; do
        if [[ ! $para =~ $negation_pattern ]]; then
            fail "$(rel "$f") appears to grant a human gate: ${para:0:100}"
            bad=1
        fi
    done < <(paragraphs "$f" | grep -Ei -- "$grant_pattern" || true)
    while IFS= read -r para; do
        if [[ ! $para =~ $negation_pattern ]]; then
            fail "$(rel "$f") claims formal verification or hardware validation: ${para:0:100}"
            bad=1
        fi
    done < <(paragraphs "$f" | grep -Ei -- '\b(formally verified|hardware validated)\b' || true)
done
((bad == 0)) && pass "no Markdown file grants a human gate or claims verification"

allowed_root=
if [[ -f $root/../COMPONENTS.md ]]; then
    allowed_root=$(grep -Eo '^\*\*Current workstation root:\*\* `[^`]+`' "$root/../COMPONENTS.md" |
        sed 's/.*`\(.*\)`/\1/')
fi
bad=0
for f in "${markdown_files[@]}"; do
    while IFS= read -r line; do
        if [[ -n $allowed_root && $line == *"$allowed_root"* ]]; then
            continue
        fi
        fail "$(rel "$f") records an absolute workstation path: $line"
        bad=1
    done < <(grep -E -- '(/home/|/Users/|[A-Za-z]:\\)' "$f" || true)
done
((bad == 0)) && pass "no Markdown file records an absolute workstation path outside the registered root"

bad=0
for f in "${markdown_files[@]}"; do
    if grep -Eq -- '(gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,})' "$f"; then
        fail "$(rel "$f") appears to contain a credential"
        bad=1
    fi
done
((bad == 0)) && pass "no Markdown file appears to contain a credential"

bad=0
for f in "${markdown_files[@]}"; do
    if grep -Eq -- '[[:blank:]]+$' "$f"; then
        fail "$(rel "$f") has trailing whitespace"
        bad=1
    fi
done
((bad == 0)) && pass "no Markdown file has trailing whitespace"

# --- parent-root artifacts ---------------------------------------------------

if ((check_parent)); then
    parent=$(CDPATH= cd -- "$root/.." && pwd -P)
    require_text "$parent/HANDOFF.md" 'project-manager/HANDOFF.md'
    require_text "$parent/formal-verification/helium-te-fv-pathfinder.md" \
        'project-manager/records/assurance/helium-te-fv-pathfinder.md'
    require_text "$parent/COMPONENTS.md" '`project-manager/`'
    require_text "$parent/SOT.md" 'project-manager/'
    require_text "$parent/README.md" 'project-manager/'
    require_text "$parent/.github/copilot-instructions.md" '/agent project-manager'
    if [[ -f $parent/.gitignore ]] && grep -Fxq -- '/project-manager/' "$parent/.gitignore"; then
        pass "parent .gitignore ignores /project-manager/"
    else
        fail "parent .gitignore does not ignore /project-manager/"
    fi
fi

# --- inspect-components refs mode -------------------------------------------

inspect=$root/scripts/inspect-components.sh
if [[ -f $inspect ]]; then
    if bash "$inspect" 2>&1 |
        grep -Fq 'inspect-components.sh refs <component|workspace|project-manager> [<ref>...]'; then
        pass "scripts/inspect-components.sh usage lists refs mode"
    else
        fail "scripts/inspect-components.sh usage does not list refs mode"
    fi
    if bash -n "$inspect"; then
        pass "scripts/inspect-components.sh passes bash -n"
    else
        fail "scripts/inspect-components.sh fails bash -n"
    fi
    if sed 's/#.*//' "$inspect" |
        grep -Eq '(^|[[:space:]])(fetch|checkout|switch|stash|reset|push)([[:space:]]|$)|remote[[:space:]]+add|branch[[:space:]]+-[dDmM]'; then
        fail "scripts/inspect-components.sh contains a prohibited refs-mode write subcommand"
    else
        pass "scripts/inspect-components.sh contains no prohibited refs-mode write subcommand"
    fi
else
    pass "scripts/inspect-components.sh refs-mode checks skipped for fixture without scripts"
fi

# --- owner-actions (human-run) ----------------------------------------------
# The script is never executed here or by the agent; these are static guards:
# it must declare itself human-run, parse, and contain no history-rewriting,
# forced, or worktree-changing Git subcommand outside comments.

owner=$root/scripts/owner-actions.sh
if [[ -f $owner ]]; then
    if grep -Fq 'never executed by the Project Manager agent' "$owner"; then
        pass "scripts/owner-actions.sh declares itself human-run"
    else
        fail "scripts/owner-actions.sh does not declare itself human-run"
    fi
    if bash -n "$owner"; then
        pass "scripts/owner-actions.sh passes bash -n"
    else
        fail "scripts/owner-actions.sh fails bash -n"
    fi
    if grep -Ev '^[[:space:]]*#' "$owner" |
        grep -Eq -- '(^|[^[:alnum:]_-])(reset|rebase|checkout|switch|stash|filter-branch|update-ref)([^[:alnum:]_-]|$)|--force|--mirror|--delete|--prune|\+refs/|branch[[:space:]]+-[dDmM]'; then
        fail "scripts/owner-actions.sh contains a forced, deleting, or history-rewriting Git token"
    else
        pass "scripts/owner-actions.sh contains no forced, deleting, or history-rewriting Git token"
    fi
    if grep -Ev '^[[:space:]]*#' "$owner" | grep -Eq 'git -C "\$dir" (push|fetch|remote add)'; then
        pass "scripts/owner-actions.sh pushes, fetches, and adds a remote only through its guarded helpers"
    else
        fail "scripts/owner-actions.sh has lost its guarded push/fetch/remote-add lines"
    fi
else
    pass "scripts/owner-actions.sh checks skipped for fixture without scripts"
fi

printf '\n%d passed, %d failed\n' "$pass_count" "$fail_count"
((fail_count == 0))
