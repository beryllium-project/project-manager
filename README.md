# Beryllium project manager

This independent component holds the Beryllium Project Manager: the agent,
procedures, records, and tooling that coordinate the component repositories
and their agents from the parent workspace. Invoke the user-facing agent from
this directory with:

```text
/agent project-manager
```

From the parent workspace root, `/add-dir project-manager` loads the same
agent as trusted configuration.

The agent runs a coordination turn: it re-resolves the canonical topology,
inspects every registered component read-only, pulls the component queues,
reconciles the registry and handoff, validates, commits its own artifacts, and
ends with what the user should review and one exact next action. It manages
and orchestrates the other agents by producing exact invocation, validation,
and request instructions; it never acts inside their repositories.

## Position in the workspace

The parent workspace root remains the thin coordination shell: `SOT.md`
(canonical topology), `COMPONENTS.md` (component registry), `README.md`,
`.gitignore`, and the tracked `*-repo` symlink objects. This component owns
the Project Manager handoff, component knowledge cards, the agent roster,
assurance-transfer records, decision records, the queue ledger, and the
component-request outbox.

Before the consolidation recorded in `HANDOFF.md`, these artifacts lived at
the parent root. Redirect stubs remain at `../HANDOFF.md` and
`../formal-verification/helium-te-fv-pathfinder.md` because sibling components
cite those paths as read-only evidence.

## Safety boundary

The agent writes only:

- inside this repository; and
- to the Project Manager-owned parent-root artifacts named in
  `AGENT-INTERFACE.md`, including tracked symlink objects and `.gitignore`.

It never writes inside another component directory, never stages component
contents in the parent, never resets, cleans, or reconciles a component
worktree, and never retargets a tracked symlink without user direction.
Component outbox queues are consumed ledger-only: dispositions live in
`queue/LEDGER.md`, and the exact edits are handed to the user.

Direct Git is permitted only against this repository and the parent root.
Remote creation, push, tag, publication, and release happen only after an
explicit same-turn user confirmation.

The agent never grants or infers acceptance, approval, sign-off, licensing,
publication, release, formal verification, hardware validation, or risk
acceptance. Those remain responsible-human gates.

## Local requirements

The maintained helpers target the Beryllium Linux workstation and require Bash
4 or later, Git, and GNU userland tools including `awk`, `sed`, `grep`,
`sort`, `sha256sum`, and `mktemp`. Missing tools are reported as hard
limitations; the agent never installs them implicitly.

## Layout

```text
.github/agents/project-manager.agent.md      user-facing orchestrator
.github/agents/pm-auditor.agent.md           write-disabled consistency auditor
.github/skills/beryllium-project-management/ the coordination-turn procedure
AGENT-INTERFACE.md                           boundaries, inputs, outputs, gates
AGENT-ROSTER.md                              how every project agent is invoked and validated
HANDOFF.md                                   restartable Project Manager handoff
components/<component>.md                    one knowledge card per registered component
records/assurance/                           assurance-transfer records
records/decisions/PMD-YYYYMMDD-NNN-*.md      decision records
queue/LEDGER.md                              ledger-only dispositions of component queue rows
outbox/component-requests.md                 pull-only requests to component owners
scripts/                                     maintained helpers
templates/                                   record and row templates
tests/validate-agent.sh                      component contract suite
```

## Maintained commands

```sh
bash ./scripts/inspect-components.sh components
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/pull-queues.sh edits
bash ./scripts/new-record.sh decision <slug>
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git diff --check
```

Every mode of `inspect-components.sh` and `pull-queues.sh` is read-only and
runs Git in a sanitized environment without hooks, credentials, or network
access. `new-record.sh` writes only under `records/decisions/`.
