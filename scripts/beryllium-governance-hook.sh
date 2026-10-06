#!/usr/bin/env bash
# User-level Copilot CLI preToolUse hook for the Beryllium single-model SOP
# (PMD-20261006-001). Every in-scope task launch, whatever its agent_type,
# must use model claude-opus-5.5, reasoning_effort max, and context_tier
# long_context: absent, null, or empty fields are filled through modifiedArgs
# without a permission decision, and any other explicit value is denied.
# In-scope run_dynamic_workflow is denied; out-of-scope calls pass through.
# It emits pass-through, deny, or argument-rewrite JSON and writes no
# telemetry, state, or database.

set -euo pipefail
export LC_ALL=C

static_missing_jq_denial() {
    printf '%s\n' \
        '{"permissionDecision":"deny","permissionDecisionReason":"Beryllium governance hook requires jq and cannot validate this task launch."}'
    exit 0
}

command -v jq >/dev/null 2>&1 || static_missing_jq_denial

deny() {
    jq -cn --arg reason "$1" \
        '{permissionDecision:"deny",permissionDecisionReason:$reason}'
    exit 0
}

pass_through() {
    printf '{}\n'
    exit 0
}

rewrite_args() {
    jq -cn --argjson args "$1" '{modifiedArgs:$args}'
    exit 0
}

within_path() {
    [[ $1 == "$2" || $1 == "$2/"* ]]
}

find_marker_root() {
    local candidate=$1
    while :; do
        if [[ -f $candidate/SOT.md && -d $candidate/project-manager ]]; then
            printf '%s\n' "$candidate"
            return 0
        fi
        [[ $candidate == / ]] && return 1
        candidate=${candidate%/*}
        [[ -n $candidate ]] || candidate=/
    done
}

git_parent() {
    env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE \
        -u GIT_OBJECT_DIRECTORY -u GIT_ALTERNATE_OBJECT_DIRECTORIES \
        git -C "$canonical_root" "$@"
}

payload=$(cat) || deny "Beryllium governance hook could not read its input."
if ! jq -e 'type == "object"' >/dev/null 2>&1 <<<"$payload"; then
    deny "Beryllium governance hook received malformed JSON input."
fi

if ! tool_name=$(jq -er '.toolName | select(type == "string" and length > 0)' \
    <<<"$payload" 2>/dev/null); then
    deny "Beryllium governance hook input is missing toolName."
fi

case $tool_name in
task | run_dynamic_workflow) ;;
*) pass_through ;;
esac

if ! cwd=$(jq -er '.cwd | select(type == "string" and length > 0)' \
    <<<"$payload" 2>/dev/null); then
    deny "Beryllium governance hook input is missing cwd."
fi

if ! canonical_cwd=$(realpath -e -- "$cwd" 2>/dev/null); then
    deny "Beryllium governance hook cannot resolve the task working directory."
fi

in_scope=0
configured_targets=()
tracked_targets_json=${BERYLLIUM_TRACKED_TARGETS:-[]}
tracked_targets_valid=1
if ! jq -e '
    type == "array" and
    all(.[]; type == "string" and startswith("/"))
' >/dev/null 2>&1 <<<"$tracked_targets_json"; then
    tracked_targets_valid=0
else
    mapfile -t configured_targets < <(jq -r '.[]' <<<"$tracked_targets_json")
    for configured_target in "${configured_targets[@]}"; do
        if target=$(realpath -e -- "$configured_target" 2>/dev/null) &&
            within_path "$canonical_cwd" "$target"; then
            in_scope=1
            break
        fi
    done
fi

parent_root=${BERYLLIUM_PARENT_ROOT:-}
root_usable=0
if [[ $parent_root == /* ]] &&
    canonical_root=$(realpath -e -- "$parent_root" 2>/dev/null) &&
    [[ -f $canonical_root/SOT.md && -d $canonical_root/project-manager ]] &&
    git_parent rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    root_usable=1
fi

if ((root_usable == 1)); then
    if within_path "$canonical_cwd" "$canonical_root"; then
        in_scope=1
    fi

    if ((in_scope == 0)); then
        if ! tracked_listing=$(git_parent ls-files -s -- 2>/dev/null); then
            deny "Beryllium governance hook cannot enumerate tracked symlinks."
        fi
        while IFS= read -r entry; do
            [[ -n $entry ]] || continue
            [[ $entry == *$'\t'* ]] ||
                deny "Beryllium governance hook received malformed Git index output."
            metadata=${entry%%$'\t'*}
            path=${entry#*$'\t'}
            mode=${metadata%% *}
            [[ $mode == 120000 ]] || continue
            if target=$(realpath -e -- "$canonical_root/$path" 2>/dev/null) &&
                within_path "$canonical_cwd" "$target"; then
                in_scope=1
                break
            fi
        done <<<"$tracked_listing"
    fi
elif marker_root=$(find_marker_root "$canonical_cwd"); then
    deny "Beryllium governance configuration is broken: BERYLLIUM_PARENT_ROOT is unset or unusable inside canonical workspace $marker_root."
fi

((in_scope == 1)) || pass_through

((tracked_targets_valid == 1)) ||
    deny "Beryllium governance hook has malformed tracked-target configuration."

if [[ $tool_name == run_dynamic_workflow ]]; then
    deny "Beryllium governance denies in-scope run_dynamic_workflow because its nested agents are not command-hook enforceable."
fi

tool_args_type=$(jq -r '.toolArgs | type' <<<"$payload")
case $tool_args_type in
object)
    tool_args=$(jq -c '.toolArgs' <<<"$payload")
    ;;
string)
    if ! tool_args=$(jq -ce \
        '.toolArgs | fromjson | select(type == "object")' \
        <<<"$payload" 2>/dev/null); then
        deny "Beryllium task launch has malformed toolArgs."
    fi
    ;;
*)
    deny "Beryllium task launch is missing object toolArgs."
    ;;
esac

effective_args=$tool_args
args_modified=0

# One rule for every agent_type: fill an absent, null, or empty field with the
# required value; deny any other explicit value, including non-strings.
require_task_field() {
    local field=$1 required=$2 reason=$3
    if jq -e --arg field "$field" '
        (has($field) | not) or (.[$field] == null) or (.[$field] == "")
    ' >/dev/null <<<"$effective_args"; then
        effective_args=$(jq -c --arg field "$field" --arg value "$required" \
            '.[$field] = $value' <<<"$effective_args") ||
            deny "Beryllium governance hook could not rewrite task arguments."
        args_modified=1
    elif ! jq -e --arg field "$field" --arg value "$required" \
        '.[$field] == $value' >/dev/null <<<"$effective_args"; then
        deny "$reason"
    fi
}

require_task_field model claude-opus-5.5 \
    "Beryllium SOP PMD-20261006-001 requires model claude-opus-5.5 for every task; other models are denied."
require_task_field reasoning_effort max \
    "Beryllium SOP PMD-20261006-001 requires reasoning_effort max for every task; lower or other values are denied."
require_task_field context_tier long_context \
    "Beryllium SOP PMD-20261006-001 requires context_tier long_context for every task; other values are denied."

((args_modified == 0)) || rewrite_args "$effective_args"

pass_through
