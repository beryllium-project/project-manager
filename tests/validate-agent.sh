#!/usr/bin/env bash
# Contract suite for the project-manager component: agent definitions, skill,
# instructions, interface documents, maintained scripts, and fixtures.

set -u
export LC_ALL=C

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) || {
    printf 'validate-agent: ERROR: cannot resolve repository root\n' >&2
    exit 2
}
cd -- "$repository_root" || exit 2

fixtures=$repository_root/tests/fixtures
valid_pm=$fixtures/valid-pm
fixture_workspace=$fixtures/workspace
ledgers=$fixtures/ledgers

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

sandbox=$(mktemp -d "${TMPDIR:-/tmp}/project-manager-tests.XXXXXX") || exit 2
cleanup() {
    rm -rf -- "$sandbox"
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM

require_file() {
    if [[ -f $1 ]]; then
        pass "file exists: ${1#"$repository_root/"}"
    else
        fail "file is missing: ${1#"$repository_root/"}"
    fi
}

require_executable() {
    if [[ -x $1 ]]; then
        pass "file is executable: ${1#"$repository_root/"}"
    else
        fail "file is not executable: ${1#"$repository_root/"}"
    fi
}

normalized() {
    # Prose with every whitespace run collapsed, so a statement is found
    # regardless of how its Markdown paragraph is wrapped.
    tr -s '[:space:]' ' ' <"$1"
}

require_text() {
    if [[ -f $1 ]] && normalized "$1" | grep -Fq -- "$2"; then
        pass "${1#"$repository_root/"} states: $2"
    else
        fail "${1#"$repository_root/"} does not state: $2"
    fi
}

require_pattern() {
    # Line-anchored regex; use for front matter and other single-line facts.
    if [[ -f $1 ]] && grep -Eq -- "$2" "$1"; then
        pass "${1#"$repository_root/"} matches: $2"
    else
        fail "${1#"$repository_root/"} does not match: $2"
    fi
}

require_prose() {
    # Regex against wrap-normalized prose; use for multi-word statements.
    if [[ -f $1 ]] && normalized "$1" | grep -Eq -- "$2"; then
        pass "${1#"$repository_root/"} matches: $2"
    else
        fail "${1#"$repository_root/"} does not match: $2"
    fi
}

refute_pattern() {
    if [[ -f $1 ]] && grep -Eq -- "$2" "$1"; then
        fail "${1#"$repository_root/"} must not match: $2"
    else
        pass "${1#"$repository_root/"} does not match: $2"
    fi
}

expect_pass() {
    local description=$1
    shift
    if "$@" >/dev/null 2>&1; then
        pass "$description"
    else
        fail "$description (expected success, command failed)"
    fi
}

expect_fail() {
    local description=$1
    shift
    if "$@" >/dev/null 2>&1; then
        fail "$description (expected failure, command succeeded)"
    else
        pass "$description"
    fi
}

expect_exit() {
    local description=$1 expected=$2 actual
    shift 2
    "$@" >/dev/null 2>&1
    actual=$?
    if ((actual == expected)); then
        pass "$description (exit $actual)"
    else
        fail "$description (expected exit $expected, got $actual)"
    fi
}

expect_output() {
    local description=$1 needle=$2 output
    shift 2
    output=$("$@" 2>/dev/null)
    if printf '%s\n' "$output" | grep -Fq -- "$needle"; then
        pass "$description"
    else
        fail "$description (output lacks: $needle)"
    fi
}

# --- layout ------------------------------------------------------------------

agent=$repository_root/.github/agents/project-manager.agent.md
auditor=$repository_root/.github/agents/pm-auditor.agent.md
skill=$repository_root/.github/skills/beryllium-project-management/SKILL.md
instructions=$repository_root/.github/copilot-instructions.md
interface=$repository_root/AGENT-INTERFACE.md
roster=$repository_root/AGENT-ROSTER.md
readme=$repository_root/README.md
handoff=$repository_root/HANDOFF.md

for f in "$agent" "$auditor" "$skill" "$instructions" "$interface" "$roster" \
    "$readme" "$handoff" "$repository_root/.gitignore" \
    "$repository_root/inbox/README.md" "$repository_root/records/README.md" \
    "$repository_root/records/assurance/helium-te-fv-pathfinder.md" \
    "$repository_root/queue/README.md" "$repository_root/queue/LEDGER.md" \
    "$repository_root/outbox/component-requests.md" \
    "$repository_root/templates/owner-agent-response.md" \
    "$repository_root/templates/owner-return.md" \
    "$repository_root/templates/decision.md" \
    "$repository_root/templates/ledger-row.md" \
    "$repository_root/templates/request-row.md"; do
    require_file "$f"
done

for component in helium-te-poc formal-verification-research osr-claude \
    beryllium-hypervisor cheri-riscv-notes-repo xrv-research-repo provenance-review \
    analysis-workbook threat-modeler security-reviewer; do
    require_file "$repository_root/components/$component.md"
    require_text "$repository_root/components/$component.md" "# $component"
    require_text "$repository_root/components/$component.md" '**Ownership:**'
done

for script in inspect-components.sh pull-queues.sh new-record.sh validate-pm.sh owner-actions.sh; do
    require_executable "$repository_root/scripts/$script"
    require_pattern "$repository_root/scripts/$script" '^set -(euo pipefail|u)$'
    require_text "$repository_root/scripts/$script" 'export LC_ALL=C'
done
require_file "$repository_root/scripts/project-tasking.sh"
require_pattern "$repository_root/scripts/project-tasking.sh" '^set -euo pipefail$'
require_text "$repository_root/scripts/project-tasking.sh" 'export LC_ALL=C'
expect_pass "project-tasking passes bash -n" \
    bash -n "$repository_root/scripts/project-tasking.sh"
refute_pattern "$repository_root/scripts/project-tasking.sh" \
    'git_pm (add|commit|push|fetch|remote|checkout|reset|clean|stash|rebase|tag)'
pmr091_inventory="$repository_root/outbox/pmr091-inventory.sh"
require_file "$pmr091_inventory"
expect_pass "pmr091-inventory passes bash -n" \
    bash -n "$pmr091_inventory"
require_text "$pmr091_inventory" 'export LC_ALL=C'
require_text "$pmr091_inventory" 'ERROR: run this script with bash; do not source it'
require_text "$pmr091_inventory" 'trap restore_account EXIT INT TERM HUP'
require_text "$pmr091_inventory" \
    'gh auth switch --hostname github.com --user xjamesmorris'
refute_pattern "$pmr091_inventory" \
    'git (push|fetch)|gh repo create|git remote (add|set-url|remove)'
pmr091_push="$repository_root/outbox/pmr091-push.sh"
require_file "$pmr091_push"
expect_pass "pmr091-push passes bash -n" \
    bash -n "$pmr091_push"
require_pattern "$pmr091_push" '^set -euo pipefail$'
require_text "$pmr091_push" 'export LC_ALL=C'
require_text "$pmr091_push" 'ERROR: run this script with bash; do not source it'
require_text "$pmr091_push" 'trap restore_account EXIT INT TERM HUP'
require_text "$pmr091_push" \
    'gh auth switch --hostname github.com --user xjamesmorris'
require_text "$pmr091_push" 'git -c push.followTags=false'
require_text "$pmr091_push" "credential.helper='!gh auth git-credential' push"
require_text "$pmr091_push" \
    'origin refs/heads/for-review:refs/heads/for-review'
require_text "$pmr091_push" 'other-refs-preserved=yes'
refute_pattern "$pmr091_push" \
    '--force|--mirror|--follow-tags|push .*--tags|gh repo create|git remote (add|set-url|remove)'
require_executable "$repository_root/tests/validate-agent.sh"
expect_pass "owner-actions passes bash -n" \
    bash -n "$repository_root/scripts/owner-actions.sh"
require_text "$repository_root/scripts/owner-actions.sh" 'files_search_only'
require_text "$repository_root/scripts/owner-actions.sh" 'files_search-only: skipping GitHub authentication and push-target preflight'
require_text "$repository_root/scripts/owner-actions.sh" '--only files_search needs --files-search'
require_text "$repository_root/scripts/owner-actions.sh" '((${#selected[@]} == 1))'
require_text "$repository_root/README.md" '--only files_search --files-search'

for f in "$repository_root/.gitignore"; do
    require_text "$f" '/files'
    require_text "$f" '/inbox/*'
    require_text "$f" '!/inbox/README.md'
    require_text "$f" '/scratch/'
done

# --- agent front matter --------------------------------------------------------

require_pattern "$agent" '^name: project-manager$'
require_pattern "$agent" '^model: gpt-5.6-sol$'
refute_pattern "$agent" '^model: claude-fable-5.1$'
require_pattern "$agent" '^user-invocable: true$'
require_pattern "$agent" '^disable-model-invocation: true$'
require_pattern "$agent" '^tools: \["read", "search", "execute", "edit", "agent", "web", "ask_user"\]$'
require_text "$agent" '/beryllium-project-management'

require_pattern "$auditor" '^name: pm-auditor$'
require_pattern "$auditor" '^model: claude-opus-5$'
require_pattern "$auditor" '^user-invocable: false$'
require_pattern "$auditor" '^tools: \["read", "search"\]$'
refute_pattern "$auditor" '"(execute|edit|web|agent)"'
for f in "$agent" "$skill" "$instructions" "$interface"; do
    require_text "$f" 'gpt-5.6-sol'
    require_text "$f" 'gpt-5.3-codex'
done
for f in "$agent" "$auditor" "$skill" "$instructions" "$interface"; do
    require_text "$f" 'claude-opus-5'
    require_text "$f" 'max'
    require_text "$f" 'long_context'
    require_text "$f" 'PMD-20260915-007'
    require_text "$f" 'PMD-20260916-001'
done
for f in "$agent" "$skill" "$instructions" "$interface" "$readme" \
    "$repository_root/outbox/tasking/README.md"; do
    require_text "$f" 'check Project Manager tasking'
    require_text "$f" 'project-tasking.sh'
    require_text "$f" 'session history'
    require_text "$f" 'background agents'
    require_text "$f" 'PMD-20260915-008'
done
parent_instructions=$repository_root/../.github/copilot-instructions.md
require_file "$parent_instructions"
require_text "$parent_instructions" 'check Project Manager tasking'
require_text "$parent_instructions" \
    'bash ./project-manager/scripts/project-tasking.sh resolve <component>'
require_text "$parent_instructions" 'session history'
require_text "$parent_instructions" 'background agents'
require_text "$parent_instructions" 'PMD-20260915-008'

require_pattern "$skill" '^name: beryllium-project-management$'
require_pattern "$skill" '^user-invocable: false$'

# The skill loader parses the front matter as YAML. An unquoted scalar that
# contains ": " opens a nested mapping ("mapping values are not allowed in
# this context") and the whole file fails to load, silently to every other
# check here. Keep every front-matter value free of an unquoted ": ".
frontmatter_lines() {
    awk 'NR == 1 { if ($0 != "---") exit; next } $0 == "---" { exit } { print }' "$1"
}
for f in "$agent" "$auditor" "$skill"; do
    if [[ $(sed -n '1p' "$f") != '---' ]]; then
        fail "${f#"$repository_root/"} does not open with a YAML front-matter block"
    elif frontmatter_lines "$f" | grep -Eq '^[A-Za-z-]+: [^"'"'"'].*: '; then
        fail "${f#"$repository_root/"} front matter has an unquoted value containing \": \""
    elif frontmatter_lines "$f" | grep -Evq '^[A-Za-z-]+: .+$'; then
        fail "${f#"$repository_root/"} front matter has a line that is not \"key: value\""
    else
        pass "${f#"$repository_root/"} front matter parses as a flat YAML mapping"
    fi
done

# --- boundary statements -------------------------------------------------------

for f in "$agent" "$instructions" "$skill" "$interface"; do
    require_text "$f" 'Never write inside another component directory'
    require_text "$f" 'scripts/inspect-components.sh'
    require_text "$f" 'scripts/pull-queues.sh'
    require_text "$f" 'scripts/project-tasking.sh'
    require_text "$f" 'scripts/new-record.sh'
    require_text "$f" 'scripts/validate-pm.sh'
    require_text "$f" 'tests/validate-agent.sh'
    require_text "$f" 'git -C <component>'
    require_text "$f" 'explicit user confirmation'
    require_text "$f" 'restricted-microsoft'
done

# Standing carry authority (PMD-20260904-003): the only writes permitted inside
# a component are the three recorded classes, never in the two carry-ineligible
# components, with git -C limited to the listed subcommands.
carry_record=$repository_root/records/decisions/PMD-20260904-003-standing-carry-authority.md
require_file "$carry_record"
for f in "$agent" "$instructions" "$skill" "$interface" "$readme" "$roster"; do
    require_text "$f" 'PMD-20260904-003'
done
for f in "$agent" "$instructions" "$skill" "$interface"; do
    require_prose "$f" 'three classes'
    require_prose "$f" '`helium-te-poc/` and `beryllium-hypervisor/` are carry-ineligible'
    require_prose "$f" '`status`, `diff`, `log`, `show`, `add <exact paths>`, and `commit`'
    require_prose "$f" 'clean worktree'
    require_prose "$f" '(A|a) carried commit leaves the component ahead of its remote'
done
for f in "$agent" "$instructions" "$skill" "$interface" "$readme"; do
    refute_pattern "$f" 'ledger-only|ledger only|Ledger-only'
done
require_text "$carry_record" '**Status:** recorded'
require_text "$carry_record" 'Carry-ineligible components'
require_prose "$carry_record" '`helium-te-poc/` and `beryllium-repo` are never written'
require_text "$auditor" 'PMD-20260904-003'

for f in "$agent" "$instructions" "$skill"; do
    require_text "$f" 'accepted through R7'
    require_text "$f" 'NOT RUN'
    require_text "$f" 'review-and-test proof of concept'
    require_text "$f" 'machine-checked by CBMC'
    require_prose "$f" '(never|Never) (create|recreate)[a-z, ]* (a repository|clone)'
done

for f in "$agent" "$instructions" "$skill" "$interface" "$readme"; do
    require_prose "$f" '(never|Never) (grants?|grant or infer|grants or infers|grants or implies)'
    require_prose "$f" 'ledger-first|Ledger-first'
done

for f in "$agent" "$instructions" "$skill" "$interface" "$readme"; do
    require_text "$f" 'PMD-20260915-002'
    require_prose "$f" 'one short .*question at a time'
done

todo_summary_record=$repository_root/records/decisions/PMD-20260916-003-contextual-todo-summary.md
require_file "$todo_summary_record"
require_text "$todo_summary_record" '**Status:** recorded'
for f in "$agent" "$instructions" "$skill" "$interface" "$readme"; do
    require_text "$f" 'PMD-20260916-003'
    require_text "$f" 'Blocking status'
    require_text "$f" 'Human-focused description'
done
require_text "$repository_root/../.github/copilot-instructions.md" 'PMD-20260916-003'
require_text "$repository_root/../.github/copilot-instructions.md" 'blocking status'
require_text "$repository_root/../.github/copilot-instructions.md" 'human-focused'

collaboration_record=$repository_root/records/decisions/PMD-20260917-001-cross-repo-collaboration-tasking-hint.md
require_file "$collaboration_record"
require_text "$collaboration_record" '**Status:** recorded'
for f in "$agent" "$instructions" "$skill" "$interface" "$readme" "$roster"; do
    require_text "$f" 'PMD-20260917-001'
    require_text "$f" 'cross-repo-collaboration'
done
require_text "$repository_root/outbox/tasking/README.md" 'cross-repo-collaboration'
require_text "$repository_root/outbox/tasking/README.md" 'PMD-20260917-001'
require_text "$repository_root/outbox/OWNER-RUNBOOK.md" 'cross-repo-collaboration'
require_text "$repository_root/outbox/OWNER-RUNBOOK.md" 'PMD-20260917-001'
require_text "$repository_root/../.github/copilot-instructions.md" 'PMD-20260917-001'
require_text "$repository_root/../.github/copilot-instructions.md" 'cross-repo-collaboration'

owner_worker_record=$repository_root/records/decisions/PMD-20260917-002-owner-worker-control-plane.md
owner_response=$repository_root/templates/owner-agent-response.md
require_file "$owner_worker_record"
require_text "$owner_worker_record" '**Status:** recorded'
require_text "$owner_worker_record" 'OWNER_AGENT_RESPONSE_V1'
require_text "$owner_worker_record" 'At most four'
for f in "$agent" "$skill" "$instructions" "$interface" "$readme" "$roster"; do
    require_text "$f" 'PMD-20260917-002'
    require_text "$f" '<component>-owner'
done
for f in "$agent" "$skill" "$instructions" "$interface" "$readme" \
    "$repository_root/outbox/tasking/README.md" \
    "$repository_root/outbox/component-requests.md"; do
    require_text "$f" 'project-tasking.sh dispatch <component> <PMR-NNN>'
done
for f in "$agent" "$skill" "$instructions" "$interface" "$readme"; do
    require_text "$f" 'OWNER_AGENT_RESPONSE_V1'
    require_prose "$f" '(four|4) (owner|repositor)'
    require_prose "$f" 'one writer|one writer/reservation|one writer or reserved'
done
require_text "$repository_root/../.github/copilot-instructions.md" 'PMD-20260917-002'
require_text "$repository_root/../.github/copilot-instructions.md" '<component>-owner'
require_text "$owner_response" 'protocol: OWNER_AGENT_RESPONSE_V1'
require_text "$owner_response" 'state: progress | needs_human | completed | partial | blocked | refused'
require_text "$owner_response" 'active_session: self | none | other | unknown'
require_text "$owner_response" 'does_not_authorize:'
require_text "$owner_response" 'never calls `ask_user`'
require_text "$repository_root/templates/owner-return.md" '`needs_human`'
require_text "$repository_root/templates/owner-return.md" '`refused`'
require_text "$repository_root/templates/owner-return.md" '`progress`'
require_text "$repository_root/outbox/component-requests.md" '| PMR-084 |'
require_text "$repository_root/outbox/component-requests.md" '`model: gpt-5.6-sol`'
require_text "$repository_root/outbox/component-requests.md" 'reasoning `max`'
require_text "$repository_root/outbox/component-requests.md" 'context `long_context`'
require_text "$repository_root/scripts/project-tasking.sh" 'dispatch_request()'
require_text "$repository_root/scripts/project-tasking.sh" '# Project Manager dispatch packet v1'
require_text "$repository_root/scripts/project-tasking.sh" 'it writes and launches nothing'

require_text "$auditor" 'You never edit, execute, run Git, use the web'
require_text "$auditor" 'not decisions, dispositions, or'
require_text "$readme" '/agent project-manager'
require_text "$readme" '/add-dir project-manager'
require_text "$interface" '`pm-auditor`'
require_text "$interface" 'outbox/component-requests.md'
require_text "$interface" '../COMPONENTS.md'
require_text "$roster" '`project-manager`'
require_text "$roster" '`analysis-workbook`'
require_text "$roster" '`threat-modeler`'
require_text "$roster" '`security-reviewer`'
require_text "$roster" '`provenance-review`'
require_text "$roster" 'disable-model-invocation: true'
require_text "$handoff" '## Fast resume'
require_text "$handoff" '### One recommended next action'
require_text "$handoff" 'project-manager'
require_text "$repository_root/records/assurance/helium-te-fv-pathfinder.md" '## Provenance'
require_text "$repository_root/records/assurance/helium-te-fv-pathfinder.md" 'SPDX-License-Identifier: GPL-3.0-only'

# --- inspect-components.sh ----------------------------------------------------------

inspect=$repository_root/scripts/inspect-components.sh
expect_exit "inspect-components without a mode exits 2" 2 bash "$inspect"
expect_exit "inspect-components with an unknown mode exits 2" 2 bash "$inspect" bogus
expect_exit "inspect-components state of an unregistered entry exits 1" 1 \
    bash "$inspect" state not-a-component
expect_exit "inspect-components components rejects extra arguments" 2 \
    bash "$inspect" components extra

# Build a synthetic workspace of tiny repositories so registry-check and the
# table modes are tested without depending on live component state. The
# symlink targets live beside the workspace, as the tracked ../copilot/...
# links expect.
synth=$sandbox/workspace
mkdir -p "$synth" "$sandbox/copilot/gim"
init_repo() {
    local dir=$1 name=$2
    mkdir -p "$dir" &&
        git -C "$dir" init -q -b main &&
        git -C "$dir" -c user.name=fixture -c user.email=fixture@example.invalid \
            -c commit.gpgsign=false commit -q --allow-empty -m "fixture $name"
}
init_repo "$synth" workspace
for name in project-manager beryllium-hypervisor helium-te-poc formal-verification-research osr-claude \
    provenance-review analysis-workbook threat-modeler security-reviewer; do
    init_repo "$synth/$name" "$name"
done
init_repo "$sandbox/copilot/gim/cheri-riscv-notes" cheri
init_repo "$sandbox/copilot/gim/xrv-research" xrv
ln -s ../copilot/gim/cheri-riscv-notes "$synth/cheri-riscv-notes-repo"
ln -s ../copilot/gim/xrv-research "$synth/xrv-research-repo"

expect_exit "inspect-components components succeeds on the synthetic workspace" 0 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" components
expect_output "inspect-components components reports the direct Beryllium integration" \
    "beryllium-hypervisor	direct	clean	main" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" components
expect_output "inspect-components symlinks reports resolution" \
    "cheri-riscv-notes-repo	../copilot/gim/cheri-riscv-notes	resolved" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" symlinks
expect_output "inspect-components state reports no upstream" "upstream	none" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" state threat-modeler
expect_output "inspect-components status includes the parent section" \
    "== parent coordination repository ==" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" status

registry=$synth/COMPONENTS.md
{
    printf '# Fixture registry\n\n'
    printf '**Current workstation root:** `%s`\n\n' "$synth"
    printf '| Workspace entry | Integration | Observed state | Role and boundary |\n'
    printf '| --- | --- | --- | --- |\n'
    for name in project-manager beryllium-hypervisor helium-te-poc formal-verification-research osr-claude \
        provenance-review analysis-workbook threat-modeler security-reviewer; do
        printf '| `%s/` | Ignored direct checkout | Clean `main` at `%s` | Fixture |\n' \
            "$name" "$(git -C "$synth/$name" rev-parse --short HEAD)"
    done
    for name in cheri-riscv-notes-repo xrv-research-repo; do
        printf '| `%s` | Tracked symlink | Clean `main` at `%s` | Fixture |\n' \
            "$name" "$(git -C "$synth/$name" rev-parse --short HEAD)"
    done
} >"$registry"
expect_exit "registry-check passes when every recorded revision matches" 0 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"

absent_registry=$synth/COMPONENTS.absent.md
cp "$registry" "$absent_registry"
mv "$synth/provenance-review" "$sandbox/provenance-review-absent"
sed -i '/`provenance-review\/`/c\| `provenance-review/` | Ignored direct checkout | **Absent** at the canonical path | Fixture |' \
    "$absent_registry"
expect_exit "registry-check accepts an explicitly recorded absent component" 0 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$absent_registry"
expect_output "registry-check reports an absent component match" \
    "provenance-review	absent	absent	match" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$absent_registry"
mv "$sandbox/provenance-review-absent" "$synth/provenance-review"

git -C "$synth/osr-claude" -c user.name=fixture -c user.email=fixture@example.invalid \
    -c commit.gpgsign=false commit -q --allow-empty -m "fixture drift"
expect_exit "registry-check fails after a component moves" 1 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"
expect_output "registry-check names the drifted row" "osr-claude" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"

sed -i '/`threat-modeler\/`/d' "$registry"
expect_output "registry-check reports a missing row" "threat-modeler	-	-	missing-row" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"
printf '| `not-registered/` | Ignored direct checkout | Clean `main` at `0123456` | Fixture |\n' >>"$registry"
expect_output "registry-check reports an unregistered row" "not-registered	0123456	-	unregistered-row" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"

rm -rf -- "$synth/provenance-review"
expect_output "inspect-components components reports an absent entry" \
    "provenance-review	direct	absent" \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" components

# --- pull-queues.sh ------------------------------------------------------------------

pull=$repository_root/scripts/pull-queues.sh
expect_exit "pull-queues without a mode exits 2" 2 bash "$pull"
expect_exit "pull-queues with an unknown mode exits 2" 2 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" bogus
expect_exit "pull-queues check passes on the complete fixture ledger" 0 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" check
expect_exit "pull-queues check fails when a source row has no ledger row" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/missing.md" check
expect_exit "pull-queues check fails when a ledger claims an unapplied status" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/false-applied.md" check
expect_exit "pull-queues check fails on an orphan ledger row" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/orphan.md" check
expect_exit "pull-queues check fails on accepted/applied transfer rows" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/transfer-bad.md" check
expect_exit "pull-queues check fails when the ledger is absent" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/absent.md" check
expect_output "pull-queues list shows awaiting rows with their ledger IDs" \
    "analysis-workbook	PMQ-002	unconfirmed	PML-0002	deferred" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" list
expect_output "pull-queues list skips the None placeholder row" \
    "threat-modeler	DISC-001	new	PML-0004	routed" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" list
expect_output "pull-queues list shows transfer rows without code ticks" \
    "analysis-workbook-transfer	HET-001	new	PML-0005	routed" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" list
expect_output "pull-queues edits maps deferred to the analysis-workbook vocabulary" \
    "new value: deferred" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" edits
expect_output "pull-queues edits maps routed to the threat-modeler vocabulary" \
    "new value: routed" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" edits
expect_output "pull-queues edits never instructs an edit from project-manager" \
    "apply them in the owning component, never from project-manager" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" edits
expect_output "pull-queues summary counts awaiting rows" "analysis-workbook	3	2	3	0" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" summary
expect_output "pull-queues summary counts transfer rows once" "analysis-workbook-transfer	1	1	1	0" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" summary
expect_exit "pull-queues check passes on the live ledger" 0 bash "$pull" check

# --- project-tasking.sh -------------------------------------------------------

tasking=$repository_root/scripts/project-tasking.sh
tasking_workspace=$sandbox/tasking-workspace
tasking_pm=$tasking_workspace/project-manager
tasking_target=$sandbox/tasking-symlink-target
mkdir -p "$tasking_pm/components" "$tasking_pm/outbox/tasking" "$tasking_pm/scripts" \
    "$tasking_workspace/direct-component" "$tasking_target"
cp "$tasking" "$tasking_pm/scripts/project-tasking.sh"
ln -s "$tasking_target" "$tasking_workspace/symlink-component"
printf '# direct-component\n' >"$tasking_pm/components/direct-component.md"
printf '# symlink-component\n' >"$tasking_pm/components/symlink-component.md"
printf '# other-component\n' >"$tasking_pm/components/other-component.md"
cat >"$tasking_pm/outbox/component-requests.md" <<'EOF'
# Component requests

| Request ID | Raised on | Component | Request | Basis | Status | Priority | Resolved on | Note |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PMR-001 | 2000-01-01 | direct-component | Do the direct task. | Fixture basis. | open | P2 | Not applicable | Direct note. |
| PMR-002 | 2000-01-01 | symlink-component | Do the symlink task. | Fixture basis. | open | P1 | Not applicable | Symlink note. |
| PMR-003 | 2000-01-01 | direct-component | Ignore the closed task. | Fixture basis. | closed | - | 2000-01-02 | Closed note. |
| PMR-004 | 2000-01-01 | other-component | Coordinate with `direct-component`. | Fixture basis. | open | P1 | Not applicable | Cross-component note. |
| PMR-006 | 2000-01-01 | project-manager | Keep this task self-managed. | Fixture basis. | open | P2 | Not applicable | Self-managed note. |
EOF
git -C "$tasking_pm" init -q
git -C "$tasking_pm" add components outbox/component-requests.md \
    scripts/project-tasking.sh
git -C "$tasking_pm" -c user.name=fixture -c user.email=fixture@example.invalid \
    -c commit.gpgsign=false commit -qm "tasking fixture"

expect_exit "project-tasking without a mode exits 2" 2 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking"
expect_exit "project-tasking rejects an unknown mode" 2 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" bogus
expect_exit "project-tasking generates committed request views" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate
require_file "$tasking_pm/outbox/tasking/direct-component.md"
require_file "$tasking_pm/outbox/tasking/other-component.md"
require_file "$tasking_pm/outbox/tasking/symlink-component.md"
require_text "$tasking_pm/outbox/tasking/direct-component.md" 'PMR-004'
require_text "$tasking_pm/outbox/tasking/direct-component.md" '| Assigned to |'
require_text "$tasking_pm/outbox/tasking/direct-component.md" \
    '| `PMR-004` | P1 | `other-component` |'
refute_pattern "$tasking_pm/outbox/tasking/direct-component.md" 'PMR-00[23]'
expect_output "project-tasking resolves a component name" "PMR-001" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" resolve direct-component
expect_output "project-tasking resolves a direct component path" "PMR-001" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" resolve "$tasking_workspace/direct-component"
expect_output "project-tasking resolves a tracked symlink path" "PMR-002" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" resolve "$tasking_workspace/symlink-component"
expect_output "project-tasking dispatches one directly assigned request" \
    "# Project Manager dispatch packet v1" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_output "project-tasking dispatch packet includes the owner action" \
    "Do the direct task." \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_output "project-tasking dispatch packet includes the request blob" \
    "**Source request blob:**" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_output "project-tasking dispatch packet preserves the no-gate boundary" \
    "does not grant or infer implementation authorization" \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
dispatch_output=$(env PM_TASKING_ROOT="$tasking_pm" \
    PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001 2>/dev/null || true)
if [[ $dispatch_output == *PMR-001* &&
      $dispatch_output != *PMR-002* &&
      $dispatch_output != *PMR-003* &&
      $dispatch_output != *PMR-004* &&
      $dispatch_output != *PMR-006* ]]; then
    pass "project-tasking dispatch packet contains only the selected request"
else
    fail "project-tasking dispatch packet leaked another request"
fi
expect_exit "project-tasking dispatch rejects a closed request" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-003
expect_exit "project-tasking dispatch rejects the wrong component" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-002
expect_exit "project-tasking dispatch rejects a cross-named request" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-004
expect_output "project-tasking dispatch accepts the directly assigned component" \
    "Coordinate with \`direct-component\`." \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch other-component PMR-004
expect_exit "project-tasking dispatch rejects an unknown request" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-999
expect_exit "project-tasking dispatch rejects a malformed request ID" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-1
expect_exit "project-tasking dispatch rejects a path in place of a component" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch "$tasking_workspace/direct-component" PMR-001
expect_exit "project-tasking dispatch rejects missing arguments" 2 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component
expect_exit "project-tasking dispatch rejects extra arguments" 2 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001 extra
expect_exit "project-tasking dispatch rejects project-manager self-dispatch" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch project-manager PMR-006
resolve_from_workspace_entry() {
    local entry=$1
    (
        cd -- "$entry" || exit 2
        env PM_TASKING_ROOT="$tasking_pm" \
            PM_TASKING_WORKSPACE="$tasking_workspace" \
            bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
    )
}
expect_output "documented resolver works from a symlink workspace entry" "PMR-002" \
    resolve_from_workspace_entry "$tasking_workspace/symlink-component"
resolve_from_workspace_root() {
    (
        cd -- "$tasking_workspace" || exit 2
        env PM_TASKING_ROOT="$tasking_pm" \
            PM_TASKING_WORKSPACE="$tasking_workspace" \
            bash ./project-manager/scripts/project-tasking.sh resolve direct-component
    )
}
expect_output "workspace-root resolver form works" "PMR-001" \
    resolve_from_workspace_root
resolve_from_physical_symlink_target() {
    (
        cd -- "$tasking_target" || exit 2
        env PM_TASKING_ROOT="$tasking_pm" \
            PM_TASKING_WORKSPACE="$tasking_workspace" \
            bash "$tasking_pm/scripts/project-tasking.sh" resolve .
    )
}
expect_output "explicit PM tasking roots resolve a physical symlink target" "PMR-002" \
    resolve_from_physical_symlink_target
expect_exit "project-tasking check accepts current generated views" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" check
rm -f -- "$tasking_pm/outbox/tasking/symlink-component.md"
expect_exit "project-tasking dispatch rejects a missing component view" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch symlink-component PMR-002
expect_exit "project-tasking check rejects a missing component view" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" check
expect_exit "project-tasking restores a complete view set" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate
printf '\n' >>"$tasking_pm/outbox/component-requests.md"
expect_exit "project-tasking dispatch rejects a dirty request table" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_exit "project-tasking rejects a dirty request table" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" resolve direct-component
git -C "$tasking_pm" add outbox/component-requests.md
expect_exit "project-tasking dispatch rejects a staged request table" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
git -C "$tasking_pm" reset -q HEAD -- outbox/component-requests.md
git -C "$tasking_pm" checkout -q -- outbox/component-requests.md
git -C "$tasking_pm" -c user.name=fixture -c user.email=fixture@example.invalid \
    -c commit.gpgsign=false commit -q --allow-empty -m "advance fixture"
expect_exit "project-tasking dispatch rejects a stale PM commit" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_exit "project-tasking rejects a stale PM commit" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" check
expect_exit "project-tasking regenerates after a PM commit" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate
expect_exit "project-tasking check accepts regenerated views" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" check

sed -i -E '/Source request blob:/ s/`[0-9a-f]{40}`/`0000000000000000000000000000000000000000`/' \
    "$tasking_pm/outbox/tasking/direct-component.md"
expect_exit "project-tasking dispatch rejects incorrect view metadata" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
expect_exit "project-tasking restores view metadata after regeneration" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate

printf '%s\n' \
    '| PMR-001 | 2000-01-01 | direct-component | Duplicate task. | Duplicate basis. | open | P2 | Not applicable | Duplicate note. |' \
    >>"$tasking_pm/outbox/component-requests.md"
git -C "$tasking_pm" add outbox/component-requests.md
git -C "$tasking_pm" -c user.name=fixture -c user.email=fixture@example.invalid \
    -c commit.gpgsign=false commit -qm "duplicate tasking fixture"
expect_exit "project-tasking regenerates a duplicate request fixture" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate
expect_exit "project-tasking dispatch rejects a duplicate request ID" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-001
sed -i '$d' "$tasking_pm/outbox/component-requests.md"
printf '%s\n' \
    '| PMR-005 | 2000-01-01 | direct-component | Missing basis task. |  | open | P2 | Not applicable | Missing basis note. |' \
    >>"$tasking_pm/outbox/component-requests.md"
git -C "$tasking_pm" add outbox/component-requests.md
git -C "$tasking_pm" -c user.name=fixture -c user.email=fixture@example.invalid \
    -c commit.gpgsign=false commit -qm "malformed tasking fixture"
expect_exit "project-tasking regenerates a malformed request fixture" 0 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" generate
expect_exit "project-tasking dispatch rejects a missing evidence basis" 1 \
    env PM_TASKING_ROOT="$tasking_pm" PM_TASKING_WORKSPACE="$tasking_workspace" \
    bash "$tasking" dispatch direct-component PMR-005

# --- new-record.sh -------------------------------------------------------------------

record_sandbox=$sandbox/records
mkdir -p "$record_sandbox/records/decisions"
cp -R "$repository_root/scripts" "$repository_root/templates" "$record_sandbox/"
today=$(date -u +%Y%m%d)
expect_exit "new-record rejects an unsupported kind" 1 \
    bash "$record_sandbox/scripts/new-record.sh" note some-slug
expect_exit "new-record rejects a malformed slug" 1 \
    bash "$record_sandbox/scripts/new-record.sh" decision Bad_Slug
expect_exit "new-record rejects a long slug" 1 \
    bash "$record_sandbox/scripts/new-record.sh" decision \
    "$(printf 'a%.0s' $(seq 1 49))"
expect_output "new-record creates the first record of the day" \
    "records/decisions/PMD-$today-001-first-slug.md" \
    bash "$record_sandbox/scripts/new-record.sh" decision first-slug
expect_output "new-record allocates the next sequence" \
    "records/decisions/PMD-$today-002-second-slug.md" \
    bash "$record_sandbox/scripts/new-record.sh" decision second-slug --title 'Second & last | title'
if [[ -f $record_sandbox/records/decisions/PMD-$today-002-second-slug.md ]]; then
    require_text "$record_sandbox/records/decisions/PMD-$today-002-second-slug.md" \
        "**Record ID:** \`PMD-$today-002\`"
    require_text "$record_sandbox/records/decisions/PMD-$today-002-second-slug.md" \
        '# Second & last | title'
    refute_pattern "$record_sandbox/records/decisions/PMD-$today-002-second-slug.md" '@@'
fi

# --- validate-pm.sh ------------------------------------------------------------------

validate=$repository_root/scripts/validate-pm.sh
expect_exit "validate-pm passes on the valid fixture" 0 bash "$validate" --no-parent "$valid_pm"
expect_exit "validate-pm passes on this repository without parent checks" 0 \
    bash "$validate" --no-parent
expect_exit "validate-pm rejects an unknown option" 2 bash "$validate" --bogus

mutate() {
    # mutate <name> -> path of a fresh copy of the valid fixture
    local copy=$sandbox/mutant-$1
    rm -rf -- "$copy"
    cp -R "$valid_pm" "$copy"
    printf '%s' "$copy"
}

copy=$(mutate handoff)
sed -i '/^## Pending coordination/d' "$copy/HANDOFF.md"
expect_exit "validate-pm fails when the handoff loses a required section" 1 \
    bash "$validate" --no-parent "$copy"

copy=$(mutate ledger-status)
sed -i 's/| pending | no |/| approved | no |/' "$copy/queue/LEDGER.md"
expect_exit "validate-pm fails on an invalid ledger status" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate ledger-order)
sed -i 's/PML-0002/PML-0001/' "$copy/queue/LEDGER.md"
expect_exit "validate-pm fails when ledger identifiers repeat" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate ledger-applied)
sed -i 's/| yes 2000-01-02 |/| yes |/' "$copy/queue/LEDGER.md"
expect_exit "validate-pm fails on a malformed applied value" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate request-status)
sed -i 's/| closed | - | 2000-01-02 |/| done | - | 2000-01-02 |/' "$copy/outbox/component-requests.md"
expect_exit "validate-pm fails on an invalid request status" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate request-priority)
sed -i 's/| open | P2 |/| open | P9 |/' "$copy/outbox/component-requests.md"
expect_exit "validate-pm fails on an invalid request priority" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate request-priority-closed)
sed -i 's/| closed | - | 2000-01-02 |/| closed | P1 | 2000-01-02 |/' "$copy/outbox/component-requests.md"
expect_exit "validate-pm fails when a closed request keeps a priority" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate decision-placeholder)
sed -i 's/The fixture records a disposition./@@DISPOSITION@@/' \
    "$copy/records/decisions/PMD-20000101-001-fixture-decision.md"
expect_exit "validate-pm fails on a decision with template placeholders" 1 \
    bash "$validate" --no-parent "$copy"

copy=$(mutate decision-name)
mv "$copy/records/decisions/PMD-20000101-001-fixture-decision.md" \
    "$copy/records/decisions/PMD-2000-001-Fixture.md"
expect_exit "validate-pm fails on a misnamed decision record" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate grant)
printf '\nThe agent approves publication of this fixture.\n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm fails when an artifact grants a human gate" 1 \
    bash "$validate" --no-parent "$copy"

copy=$(mutate negated-grant)
printf '\nThe agent never approves publication; a responsible human does.\n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm accepts a negated gate statement" 0 bash "$validate" --no-parent "$copy"

copy=$(mutate wrapped-negation)
printf '\nHelium is a review-and-test proof of concept and is not formally\nverified or hardware validated.\n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm accepts a negation wrapped across lines" 0 \
    bash "$validate" --no-parent "$copy"

copy=$(mutate verified-claim)
printf '\nThe pathfinder is formally verified.\n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm fails on an unqualified verification claim" 1 \
    bash "$validate" --no-parent "$copy"

copy=$(mutate absolute-path)
printf '\nSee /home/someone/private/notes.md for details.\n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm fails on an absolute workstation path" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate credential)
printf '\ntoken: ghp_%s\n' "$(printf 'A%.0s' $(seq 1 30))" >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm fails on an apparent credential" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate whitespace)
printf 'trailing   \n' >>"$copy/AGENT-ROSTER.md"
expect_exit "validate-pm fails on trailing whitespace" 1 bash "$validate" --no-parent "$copy"

copy=$(mutate no-cards)
rm -f "$copy"/components/*.md
expect_exit "validate-pm fails without a component card" 1 bash "$validate" --no-parent "$copy"

# The scaffold prompts that validate-pm.sh rejects must be the ones the
# template actually emits; keep the two in step.
template=$repository_root/templates/decision.md
require_pattern "$template" '^- `\.\./<component>/<path>` at `<commit>`: '
require_pattern "$template" '^State the coordination question'
require_pattern "$template" '^State the Project Manager disposition'
require_pattern "$template" '^- One specific next action, with the exact path or command\.$'

# A record scaffolded by new-record.sh must satisfy validate-pm once filled in.
copy=$(mutate scaffolded)
cp -R "$repository_root/scripts" "$copy/"
scaffolded=$(bash "$copy/scripts/new-record.sh" decision scaffolded-record 2>/dev/null)
if [[ -n $scaffolded && -f $copy/$scaffolded ]]; then
    expect_exit "validate-pm fails on an unfilled scaffold" 1 bash "$validate" --no-parent "$copy"
    sed -i -e 's/^- `..\/<component>\/<path>` at `<commit>`: what it establishes.$/- `..\/fixture-component\/HANDOFF.md` at `0000000`: fixture input./' \
        -e 's/^State the coordination question.*$/Fixture scope./' \
        -e 's/^State the Project Manager disposition in plain language.$/Fixture disposition./' \
        -e 's/^- One specific next action, with the exact path or command.$/- None./' \
        "$copy/$scaffolded"
    expect_exit "validate-pm passes on a filled scaffold" 0 bash "$validate" --no-parent "$copy"
else
    fail "new-record.sh did not scaffold a record in the sandbox"
fi

printf '\n%d passed, %d failed\n' "$pass_count" "$fail_count"
((fail_count == 0))
