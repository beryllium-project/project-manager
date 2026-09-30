#!/usr/bin/env bash
# User-level Copilot CLI preToolUse hook. It emits only pass-through or deny
# JSON and writes no telemetry, state, or database.

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

within_path() {
    [[ $1 == "$2" || $1 == "$2/"* ]]
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

[[ $tool_name == task ]] || pass_through

if ! cwd=$(jq -er '.cwd | select(type == "string" and length > 0)' \
    <<<"$payload" 2>/dev/null); then
    deny "Beryllium governance hook input is missing cwd."
fi

parent_root=${BERYLLIUM_PARENT_ROOT:-}
[[ -n $parent_root ]] ||
    deny "Beryllium governance hook is missing BERYLLIUM_PARENT_ROOT."

if ! canonical_cwd=$(realpath -e -- "$cwd" 2>/dev/null); then
    deny "Beryllium governance hook cannot resolve the task working directory."
fi

in_scope=0
tracked_targets_json=${BERYLLIUM_TRACKED_TARGETS:-[]}
if ! jq -e '
    type == "array" and
    all(.[]; type == "string" and startswith("/"))
' >/dev/null 2>&1 <<<"$tracked_targets_json"; then
    deny "Beryllium governance hook has malformed tracked-target configuration."
fi
mapfile -t configured_targets < <(jq -r '.[]' <<<"$tracked_targets_json")
for configured_target in "${configured_targets[@]}"; do
    if target=$(realpath -e -- "$configured_target" 2>/dev/null) &&
        within_path "$canonical_cwd" "$target"; then
        in_scope=1
        break
    fi
done

if canonical_root=$(realpath -e -- "$parent_root" 2>/dev/null); then
    [[ -f $canonical_root/SOT.md && -e $canonical_root/project-manager ]] ||
        deny "Beryllium governance hook parent root is not the canonical workspace."
    git_parent rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
        deny "Beryllium governance hook parent root is not a Git worktree."

    if within_path "$canonical_cwd" "$canonical_root"; then
        in_scope=1
    fi

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

((in_scope == 1)) || pass_through

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

if ! effort=$(jq -er \
    '.reasoning_effort | select(type == "string" and length > 0)' \
    <<<"$tool_args" 2>/dev/null); then
    deny "Beryllium task launch must set reasoning_effort to high, xhigh, or max."
fi

case $effort in
high | xhigh | max) ;;
*)
    deny "Beryllium task launch reasoning_effort is below the required high floor."
    ;;
esac

agent_type=$(jq -r '.agent_type? // ""' <<<"$tool_args")
task_name=$(jq -r '.name? // ""' <<<"$tool_args")
if [[ $task_name == beryllium-scope-review &&
    $agent_type != beryllium-scope-review ]]; then
    deny "beryllium-scope-review must use agent_type beryllium-scope-review."
fi

if [[ $agent_type == beryllium-scope-review ]]; then
    model=$(jq -r '.model? // ""' <<<"$tool_args")
    context_tier=$(jq -r '.context_tier? // ""' <<<"$tool_args")
    [[ $model == claude-opus-5.5 ]] ||
        deny "beryllium-scope-review requires model claude-opus-5.5."
    [[ $effort == max ]] ||
        deny "beryllium-scope-review requires reasoning_effort max."
    [[ $context_tier == long_context ]] ||
        deny "beryllium-scope-review requires context_tier long_context."
    if jq -e '
        (.background? == true) or
        (.run_in_background? == true) or
        ((.mode? != null) and (.mode != "sync"))
    ' >/dev/null <<<"$tool_args"; then
        deny "beryllium-scope-review must run synchronously."
    fi
fi

pass_through
