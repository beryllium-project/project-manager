#!/usr/bin/env bash
# Scaffold a Project Manager decision record with a collision-safe UTC
# identifier. Writes only under records/decisions/.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  new-record.sh decision <slug> [--title "<title>"]

Creates records/decisions/PMD-YYYYMMDD-NNN-<slug>.md from
templates/decision.md using today's UTC date and the next free sequence
number for that date. The slug is lowercase words separated by single
hyphens, at most 48 characters. Prints the created path.
EOF
}

die() {
    printf 'new-record: ERROR: %s\n' "$*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
repository_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve repository root"

(($# >= 2)) || { usage; exit 2; }
kind=$1
slug=$2
shift 2
title=

while (($# > 0)); do
    case $1 in
    --title)
        (($# >= 2)) || { usage; exit 2; }
        title=$2
        shift 2
        ;;
    *)
        usage
        exit 2
        ;;
    esac
done

[[ $kind == decision ]] || die "unsupported record kind: $kind"
[[ $slug =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] ||
    die "slug must be lowercase words separated by single hyphens: $slug"
((${#slug} <= 48)) || die "slug exceeds 48 characters: $slug"

template=$repository_root/templates/decision.md
target_dir=$repository_root/records/decisions
[[ -f $template ]] || die "template is absent: ${template#"$repository_root/"}"
[[ -d $target_dir ]] || die "directory is absent: ${target_dir#"$repository_root/"}"

utc_date=$(date -u +%Y%m%d)
iso_date=$(date -u +%Y-%m-%d)

next_sequence() {
    local max=0 path base seq
    for path in "$target_dir/PMD-$utc_date-"[0-9][0-9][0-9]-*.md; do
        [[ -e $path ]] || continue
        base=${path##*/}
        seq=${base#PMD-"$utc_date"-}
        seq=${seq%%-*}
        [[ $seq =~ ^[0-9]{3}$ ]] || continue
        ((10#$seq > max)) && max=$((10#$seq))
    done
    ((max < 999)) || die "sequence exhausted for $utc_date"
    printf '%03d' $((max + 1))
}

sequence=$(next_sequence)
record_id=PMD-$utc_date-$sequence
target=$target_dir/$record_id-$slug.md
[[ ! -e $target ]] || die "record already exists: ${target#"$repository_root/"}"

if [[ -z $title ]]; then
    title=$(printf '%s' "$slug" | tr '-' ' ')
fi

# Refuse characters that would break the Markdown title line.
[[ $title =~ ^[[:print:]]+$ && $title != *$'\n'* ]] || die "title must be printable"

escaped_title=$(printf '%s' "$title" | sed 's/[&|\\]/\\&/g')
sed -e "s|@@TITLE@@|$escaped_title|" \
    -e "s|@@ID@@|$record_id|" \
    -e "s|@@DATE@@|$iso_date|" \
    "$template" >"$target.tmp" || die "cannot write record"
mv -- "$target.tmp" "$target"
printf '%s\n' "${target#"$repository_root/"}"
