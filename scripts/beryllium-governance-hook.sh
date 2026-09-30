#!/usr/bin/env bash
# User-level Copilot CLI preToolUse hook. It emits pass-through, deny, or
# argument-rewrite JSON and writes no telemetry, state, or database.

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
effort_injected=0
if jq -e '
    (has("reasoning_effort") | not) or
    (.reasoning_effort == null) or
    (.reasoning_effort == "")
' >/dev/null <<<"$tool_args"; then
    effective_args=$(jq -c '. + {reasoning_effort:"max"}' <<<"$tool_args")
    effort=max
    effort_injected=1
elif ! effort=$(jq -er \
    '.reasoning_effort | select(type == "string" and length > 0)' \
    <<<"$tool_args" 2>/dev/null); then
    deny "Beryllium task launch reasoning_effort must be high, xhigh, or max; lower or unknown values are denied."
fi

case $effort in
high | xhigh | max) ;;
*)
    deny "Beryllium task launch reasoning_effort is below the required high floor or is unknown; allowed values are high, xhigh, or max."
    ;;
esac

agent_type=$(jq -r \
    'if (.agent_type? | type) == "string" then .agent_type else "" end' \
    <<<"$effective_args")
task_name=$(jq -r \
    'if (.name? | type) == "string" then .name else "" end' \
    <<<"$effective_args")
model=$(jq -r \
    'if (.model? | type) == "string" then .model else "" end' \
    <<<"$effective_args")

security_model_blocked=0
case $agent_type in
security-evidence | security-research | security-finding-review)
    security_model_blocked=1
    ;;
esac
if [[ $model == gpt-5.3-codex || $security_model_blocked == 1 ]]; then
    deny "Beryllium deep/adversarial security review is blocked because Copilot CLI 1.0.90-5 does not advertise the required max reasoning and long_context for gpt-5.3-codex; responsible-human model selection is pending."
fi

if [[ $task_name == beryllium-scope-review &&
    $agent_type != beryllium-scope-review ]]; then
    deny "beryllium-scope-review must use agent_type beryllium-scope-review."
fi

if [[ $agent_type == beryllium-scope-review ]]; then
    context_tier=$(jq -r \
        'if (.context_tier? | type) == "string" then .context_tier else "" end' \
        <<<"$effective_args")
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
    ' >/dev/null <<<"$effective_args"; then
        deny "beryllium-scope-review must run synchronously."
    fi
fi

((effort_injected == 0)) || rewrite_args "$effective_args"

pass_through
