#!/usr/bin/env bash
# Ledger-first consumption of component pm-queue files for the Project Manager.
# Reads sibling outbox/pm-queue.md files, the read-only-tracked
# analysis-workbook/outbox/helium-transfer-queue.md, and this repository's
# queue/LEDGER.md. Never writes anywhere.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  pull-queues.sh [--workspace <dir>] [--ledger <file>] list
  pull-queues.sh [--workspace <dir>] [--ledger <file>] check
  pull-queues.sh [--workspace <dir>] [--ledger <file>] edits
  pull-queues.sh [--workspace <dir>] [--ledger <file>] summary

list     every component queue row awaiting a Project Manager disposition,
         with its ledger row or "missing"
check    exit 1 when a source row has no ledger row, a ledger row has no
         source row, or a ledger row claims an applied status the source file
         does not show
edits    the exact status-column edits due in each component queue file (applied
         by the Project Manager as carried writes or by the user) for ledger
         rows with a final disposition
summary  per-source counts

Sources are ../analysis-workbook/outbox/pm-queue.md (PMQ-NNN rows),
../threat-modeler/outbox/pm-queue.md (DISC-NNN rows), and
../analysis-workbook/outbox/helium-transfer-queue.md (HET-NNN rows,
read-only tracking only). The ledger is queue/LEDGER.md. Every mode is
read-only.
EOF
}

die() {
    printf 'pull-queues: ERROR: %s\n' "$*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
repository_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve repository root"
workspace_root=$(CDPATH= cd -- "$repository_root/.." && pwd -P) ||
    die "cannot resolve workspace root"
ledger_file=$repository_root/queue/LEDGER.md

while (($# > 0)); do
    case $1 in
    --workspace)
        (($# >= 2)) || { usage; exit 2; }
        workspace_root=$(CDPATH= cd -- "$2" && pwd -P) || die "bad workspace: $2"
        shift 2
        ;;
    --ledger)
        (($# >= 2)) || { usage; exit 2; }
        ledger_file=$2
        shift 2
        ;;
    --)
        shift
        break
        ;;
    -*)
        usage
        exit 2
        ;;
    *)
        break
        ;;
    esac
done

(($# == 1)) || { usage; exit 2; }
mode=$1

# Source definitions: name, relative file, id prefix, and 1-based column
# numbers for id, raised-on, title, suggested owner, and status.
source_names=(analysis-workbook threat-modeler analysis-workbook-transfer)
declare -A source_file=(
    [analysis-workbook]=analysis-workbook/outbox/pm-queue.md
    [threat-modeler]=threat-modeler/outbox/pm-queue.md
    [analysis-workbook-transfer]=analysis-workbook/outbox/helium-transfer-queue.md
)
declare -A source_prefix=(
    [analysis-workbook]=PMQ
    [threat-modeler]=DISC
    [analysis-workbook-transfer]=HET
)
declare -A col_id=([analysis-workbook]=1 [threat-modeler]=1 [analysis-workbook-transfer]=1)
declare -A col_raised=([analysis-workbook]=2 [threat-modeler]=0 [analysis-workbook-transfer]=2)
declare -A col_title=([analysis-workbook]=5 [threat-modeler]=3 [analysis-workbook-transfer]=4)
declare -A col_owner=([analysis-workbook]=7 [threat-modeler]=5 [analysis-workbook-transfer]=5)
declare -A col_status=([analysis-workbook]=10 [threat-modeler]=6 [analysis-workbook-transfer]=6)
declare -A source_status_column_name=(
    [analysis-workbook]=Status
    [threat-modeler]=Status
    [analysis-workbook-transfer]=Status
)
# Statuses written by the component that await the Project Manager.
declare -A awaiting_pattern=(
    [analysis-workbook]='^(new|unconfirmed)$'
    [threat-modeler]='^new$'
    [analysis-workbook-transfer]='^new$'
)

# Ledger PM status -> status to write in each source file (by the Project
# Manager as a carried write, or by the user).
# An empty mapping means no edit is due for that PM status.
map_status() {
    local source=$1 pm_status=$2
    case $source:$pm_status in
    analysis-workbook:accepted) printf 'accepted' ;;
    analysis-workbook:duplicate) printf 'duplicate' ;;
    analysis-workbook:rejected) printf 'rejected' ;;
    analysis-workbook:deferred) printf 'deferred' ;;
    threat-modeler:routed) printf 'routed' ;;
    threat-modeler:accepted) printf 'integrated' ;;
    threat-modeler:duplicate | threat-modeler:rejected) printf 'declined' ;;
    threat-modeler:deferred) printf 'acknowledged' ;;
    # The transfer queue is outside class 1 of PMD-20260904-003; the workbook
    # maintainer mirrors lifecycle changes after observing the owner-side record.
    analysis-workbook-transfer:*) printf '' ;;
    *) printf '' ;;
    esac
}

# Emit the table rows of a Markdown file whose first cell starts with PREFIX-
# as TAB-separated trimmed cells.
table_rows() {
    local file=$1 prefix=$2
    awk -F'|' -v prefix="$prefix" '
        function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
        /^\|/ {
            first = trim($2)
            if (index(first, prefix "-") != 1) next
            out = ""
            for (i = 2; i < NF; i++) {
                cell = trim($i)
                out = out (i > 2 ? "\t" : "") cell
            }
            print out
        }' "$file"
}

field() {
    # field <tsv-line> <1-based column>; column 0 yields "unknown".
    local line=$1 column=$2
    ((column > 0)) || { printf 'unknown'; return; }
    printf '%s' "$line" | awk -F'\t' -v c="$column" '{ print $c }'
}

normalize_cell() {
    local value=$1
    if [[ $value == '`'*'`' ]]; then
        value=${value#'`'}
        value=${value%'`'}
    fi
    printf '%s' "$value"
}

# Load the ledger: key "source<TAB>source-id" -> fields.
declare -A ledger_id=() ledger_pm_status=() ledger_applied=() ledger_seen_source=()
ledger_rows=0
load_ledger() {
    local line id source sid pm_status applied key
    [[ -f $ledger_file ]] || die "ledger is absent: $ledger_file"
    while IFS= read -r line; do
        [[ -n $line ]] || continue
        id=$(field "$line" 1)
        source=$(field "$line" 2)
        sid=$(field "$line" 3)
        pm_status=$(field "$line" 7)
        applied=$(field "$line" 8)
        key=$source$'\t'$sid
        ledger_id[$key]=$id
        ledger_pm_status[$key]=$pm_status
        ledger_applied[$key]=$applied
        ledger_rows=$((ledger_rows + 1))
    done < <(table_rows "$ledger_file" PML)
}

# Load every source row: key -> TSV line; also remember which keys exist.
declare -A source_line=() source_status=()
declare -a source_keys=()
load_sources() {
    local source file line sid status key
    for source in "${source_names[@]}"; do
        file=$workspace_root/${source_file[$source]}
        if [[ ! -f $file ]]; then
            printf 'pull-queues: WARNING: source queue is absent: %s\n' \
                "${source_file[$source]}" >&2
            continue
        fi
        while IFS= read -r line; do
            [[ -n $line ]] || continue
            sid=$(field "$line" "${col_id[$source]}")
            sid=$(normalize_cell "$sid")
            [[ $sid != None ]] || continue
            status=$(field "$line" "${col_status[$source]}")
            status=$(normalize_cell "$status")
            key=$source$'\t'$sid
            source_line[$key]=$line
            source_status[$key]=$status
            source_keys+=("$key")
        done < <(table_rows "$file" "${source_prefix[$source]}")
    done
}

load_ledger
load_sources

case $mode in
list)
    printf '# component queue rows awaiting a Project Manager disposition\n'
    printf '# (source, source-id, source-status, ledger, pm-status, suggested-owner, title)\n'
    for key in "${source_keys[@]}"; do
        source=${key%%$'\t'*}
        sid=${key#*$'\t'}
        status=${source_status[$key]}
        [[ $status =~ ${awaiting_pattern[$source]} ]] || continue
        line=${source_line[$key]}
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$source" "$sid" "$status" \
            "${ledger_id[$key]:-missing}" "${ledger_pm_status[$key]:--}" \
            "$(field "$line" "${col_owner[$source]}")" \
            "$(field "$line" "${col_title[$source]}")"
    done
    ;;

check)
    failures=0
    for key in "${source_keys[@]}"; do
        source=${key%%$'\t'*}
        sid=${key#*$'\t'}
        if [[ -z ${ledger_id[$key]:-} ]]; then
            printf 'FAIL %s %s has no ledger row\n' "$source" "$sid"
            failures=$((failures + 1))
        fi
    done
    for key in "${!ledger_id[@]}"; do
        source=${key%%$'\t'*}
        sid=${key#*$'\t'}
        if [[ -z ${source_line[$key]:-} ]]; then
            printf 'FAIL %s references %s %s, which is not in the source queue\n' \
                "${ledger_id[$key]}" "$source" "$sid"
            failures=$((failures + 1))
            continue
        fi
        expected=$(map_status "$source" "${ledger_pm_status[$key]}")
        applied=${ledger_applied[$key]}
        if [[ $source == analysis-workbook-transfer ]]; then
            if [[ ${ledger_pm_status[$key]} == accepted ]]; then
                printf 'FAIL %s uses PM status accepted for transfer source %s\n' \
                    "${ledger_id[$key]}" "$sid"
                failures=$((failures + 1))
            fi
            if [[ $applied == yes* ]]; then
                printf 'FAIL %s claims a transfer source status was applied, but transfer queues are never edited by the PM\n' \
                    "${ledger_id[$key]}"
                failures=$((failures + 1))
                continue
            fi
        fi
        if [[ $applied == yes* ]]; then
            if [[ -z $expected ]]; then
                printf 'FAIL %s claims an applied status but PM status %s maps to no source edit\n' \
                    "${ledger_id[$key]}" "${ledger_pm_status[$key]}"
                failures=$((failures + 1))
            elif [[ ${source_status[$key]} != "$expected" ]]; then
                printf 'FAIL %s claims %s applied, but %s %s shows status %s\n' \
                    "${ledger_id[$key]}" "$expected" "$source" "$sid" \
                    "${source_status[$key]}"
                failures=$((failures + 1))
            fi
        fi
    done
    if ((failures == 0)); then
        printf 'ok   %d source rows, %d ledger rows, every source row has a ledger row\n' \
            "${#source_keys[@]}" "$ledger_rows"
        exit 0
    fi
    printf '%d failure(s)\n' "$failures"
    exit 1
    ;;

edits)
    pending=0
    for key in "${source_keys[@]}"; do
        source=${key%%$'\t'*}
        sid=${key#*$'\t'}
        [[ -n ${ledger_id[$key]:-} ]] || continue
        expected=$(map_status "$source" "${ledger_pm_status[$key]}")
        [[ -n $expected ]] || continue
        [[ ${source_status[$key]} != "$expected" ]] || continue
        pending=$((pending + 1))
        printf -- '--- edit %d ---\n' "$pending"
        printf 'file:      %s\n' "${source_file[$source]}"
        printf 'row:       %s\n' "$sid"
        printf 'column:    %s\n' "${source_status_column_name[$source]}"
        printf 'current:   %s\n' "${source_status[$key]}"
        printf 'new value: %s\n' "$expected"
        printf 'ledger:    %s (PM status %s)\n' "${ledger_id[$key]}" \
            "${ledger_pm_status[$key]}"
        if [[ $source == analysis-workbook ]]; then
            printf 'also set:  Resolved on = today (YYYY-MM-DD); Resolution note = owning component and reason\n'
        fi
        printf 'then:      record "yes YYYY-MM-DD" under "Source status applied" for %s\n' \
            "${ledger_id[$key]}"
    done
    if ((pending == 0)); then
        printf 'no source edits are due\n'
    else
        printf -- '--- %d edit(s) due; apply them in the owning component, never from project-manager ---\n' \
            "$pending"
    fi
    ;;

summary)
    printf '# (source, rows, awaiting-pm, ledgered, missing-ledger)\n'
    for source in "${source_names[@]}"; do
        total=0
        awaiting=0
        ledgered=0
        missing=0
        for key in "${source_keys[@]}"; do
            [[ ${key%%$'\t'*} == "$source" ]] || continue
            total=$((total + 1))
            if [[ ${source_status[$key]} =~ ${awaiting_pattern[$source]} ]]; then
                awaiting=$((awaiting + 1))
            fi
            if [[ -n ${ledger_id[$key]:-} ]]; then
                ledgered=$((ledgered + 1))
            else
                missing=$((missing + 1))
            fi
        done
        printf '%s\t%d\t%d\t%d\t%d\n' "$source" "$total" "$awaiting" "$ledgered" "$missing"
    done
    ;;

*)
    usage
    exit 2
    ;;
esac
