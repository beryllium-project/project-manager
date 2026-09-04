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
    "$repository_root/templates/decision.md" \
    "$repository_root/templates/ledger-row.md" \
    "$repository_root/templates/request-row.md"; do
    require_file "$f"
done

for component in helium-te-poc formal-verification-research osr-claude \
    beryllium-repo cheri-riscv-notes-repo xrv-research-repo provenance-review \
    analysis-workbook threat-modeler; do
    require_file "$repository_root/components/$component.md"
    require_text "$repository_root/components/$component.md" "# $component"
    require_text "$repository_root/components/$component.md" '**Ownership:**'
done

for script in inspect-components.sh pull-queues.sh new-record.sh validate-pm.sh; do
    require_executable "$repository_root/scripts/$script"
    require_pattern "$repository_root/scripts/$script" '^set -(euo pipefail|u)$'
    require_text "$repository_root/scripts/$script" 'export LC_ALL=C'
done
require_executable "$repository_root/tests/validate-agent.sh"

for f in "$repository_root/.gitignore"; do
    require_text "$f" '/files'
    require_text "$f" '/inbox/*'
    require_text "$f" '!/inbox/README.md'
    require_text "$f" '/scratch/'
done

# --- agent front matter --------------------------------------------------------

require_pattern "$agent" '^name: project-manager$'
require_pattern "$agent" '^model: claude-fable-5.1$'
require_pattern "$agent" '^user-invocable: true$'
require_pattern "$agent" '^disable-model-invocation: true$'
require_pattern "$agent" '^tools: \["read", "search", "execute", "edit", "agent", "web", "ask_user"\]$'
require_text "$agent" '/beryllium-project-management'

require_pattern "$auditor" '^name: pm-auditor$'
require_pattern "$auditor" '^model: claude-fable-5.1$'
require_pattern "$auditor" '^user-invocable: false$'
require_pattern "$auditor" '^tools: \["read", "search"\]$'
refute_pattern "$auditor" '"(execute|edit|web|agent)"'

require_pattern "$skill" '^name: beryllium-project-management$'
require_pattern "$skill" '^user-invocable: false$'

# --- boundary statements -------------------------------------------------------

for f in "$agent" "$instructions" "$skill" "$interface"; do
    require_text "$f" 'Never write inside another component directory'
    require_text "$f" 'scripts/inspect-components.sh'
    require_text "$f" 'scripts/pull-queues.sh'
    require_text "$f" 'scripts/new-record.sh'
    require_text "$f" 'scripts/validate-pm.sh'
    require_text "$f" 'tests/validate-agent.sh'
    require_text "$f" 'git -C <component>'
    require_text "$f" 'explicit user confirmation'
    require_text "$f" 'restricted-microsoft'
done

for f in "$agent" "$instructions" "$skill"; do
    require_text "$f" 'accepted through R7'
    require_text "$f" 'NOT RUN'
    require_text "$f" 'review-and-test proof of concept'
    require_text "$f" 'machine-checked by CBMC'
    require_prose "$f" '(never|Never) (create|recreate)[a-z, ]* (a repository|clone)'
done

for f in "$agent" "$instructions" "$skill" "$interface" "$readme"; do
    require_prose "$f" '(never|Never) (grants?|grant or infer|grants or infers|grants or implies)'
    require_prose "$f" 'ledger-only|ledger only|Ledger-only'
done

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
mkdir -p "$synth" "$sandbox/copilot/msft" "$sandbox/copilot/gim"
init_repo() {
    local dir=$1 name=$2
    mkdir -p "$dir" &&
        git -C "$dir" init -q -b main &&
        git -C "$dir" -c user.name=fixture -c user.email=fixture@example.invalid \
            -c commit.gpgsign=false commit -q --allow-empty -m "fixture $name"
}
init_repo "$synth" workspace
for name in project-manager helium-te-poc formal-verification-research osr-claude \
    provenance-review analysis-workbook threat-modeler; do
    init_repo "$synth/$name" "$name"
done
init_repo "$sandbox/copilot/msft/beryllium" beryllium
init_repo "$sandbox/copilot/gim/cheri-riscv-notes" cheri
init_repo "$sandbox/copilot/gim/xrv-research" xrv
ln -s ../copilot/msft/beryllium "$synth/beryllium-repo"
ln -s ../copilot/gim/cheri-riscv-notes "$synth/cheri-riscv-notes-repo"
ln -s ../copilot/gim/xrv-research "$synth/xrv-research-repo"

expect_exit "inspect-components components succeeds on the synthetic workspace" 0 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" components
expect_output "inspect-components components reports the symlink integration" \
    "beryllium-repo	symlink	clean	main" \
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
    for name in project-manager helium-te-poc formal-verification-research osr-claude \
        provenance-review analysis-workbook threat-modeler; do
        printf '| `%s/` | Ignored direct checkout | Clean `main` at `%s` | Fixture |\n' \
            "$name" "$(git -C "$synth/$name" rev-parse --short HEAD)"
    done
    for name in beryllium-repo cheri-riscv-notes-repo xrv-research-repo; do
        printf '| `%s` | Tracked symlink | Clean `main` at `%s` | Fixture |\n' \
            "$name" "$(git -C "$synth/$name" rev-parse --short HEAD)"
    done
} >"$registry"
expect_exit "registry-check passes when every recorded revision matches" 0 \
    env PM_WORKSPACE_ROOT="$synth" bash "$inspect" registry-check "$registry"

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
expect_exit "pull-queues check fails when the ledger is absent" 1 \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/absent.md" check
expect_output "pull-queues list shows awaiting rows with their ledger IDs" \
    "analysis-workbook	PMQ-002	unconfirmed	PML-0002	deferred" \
    bash "$pull" --workspace "$fixture_workspace" --ledger "$ledgers/complete.md" list
expect_output "pull-queues list skips the None placeholder row" \
    "threat-modeler	DISC-001	new	PML-0004	routed" \
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
expect_exit "pull-queues check passes on the live ledger" 0 bash "$pull" check

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
sed -i 's/| closed | 2000-01-02 |/| done | 2000-01-02 |/' "$copy/outbox/component-requests.md"
expect_exit "validate-pm fails on an invalid request status" 1 bash "$validate" --no-parent "$copy"

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
