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
catches component owner returns from their own handoffs,
carries recorded requests into components only within the standing carry
authority, reconciles the registry and handoff, validates, commits its own
artifacts, and ends with what the user should review and one exact next
action. It manages and orchestrates the other agents by producing exact
invocation, validation, and request instructions; it never runs their
commands and never edits their research, analysis, threat-model, provenance,
session, model, or review content.

## Position in the workspace

The parent workspace root remains the thin coordination shell: `SOT.md`
(canonical topology), `COMPONENTS.md` (component registry), `README.md`,
`.gitignore`, `.github/copilot-instructions.md`, the compatibility redirect
`HANDOFF.md`, and the tracked `*-repo` symlink objects. This component owns
the Project Manager handoff, component knowledge cards, the agent roster,
assurance-transfer records, decision records, the queue ledger, and the
component-request outbox.

Before the consolidation recorded in `HANDOFF.md`, these artifacts lived at
the parent root. The compatibility redirect `../HANDOFF.md` remains. The
former `../formal-verification/` redirect files were removed at parent commit
`4a91f7f` and retired by the responsible human in `PMD-20260912-001`;
current assurance records live under `records/assurance/`.

## Bidirectional agent coordination

The coordination model is pull-based (`PMD-20260914-002`):

- component owners return completed, partial, or blocked `PMR`/`PML` work in
  a structured `Project Manager return` section of their component-owned
  handoff document, using `templates/owner-return.md`;
- the Project Manager checks changed component HEADs and open-request owners
  on startup, verifies exact commits and paths, then reconciles its records;
- the Project Manager posts work through `outbox/component-requests.md`,
  `components/<component>.md`, and `outbox/OWNER-RUNBOOK.md`; and
- component agents receive those exact rows and their card before owner work
  begins.

No agent writes another repository merely to deliver a message. Request
closure is the acknowledgement; a distinct follow-up receives a new request
identifier. The existing handoffs and request ledger are sufficient at the
current scale, so there is no second generic returns queue.

Human intake follows `PMD-20260915-002`: when a decision can be decomposed,
the Project Manager asks one short structured question at a time, carries
prior answers forward, offers a safe recommended default plus exception or
defer choice, and prepares the matrices and durable records itself. If the
human is unavailable, it preserves partial intake and reports the next
unanswered question.

Project-wide model assignment follows the role-to-model matrix of
`PMD-20260916-001` (extending `PMD-20260915-007`): planning, coding,
coordination, and orchestration use `gpt-5.6-sol`; review, evaluation, and
audit use `claude-opus-5`; deep or adversarial security review uses
`gpt-5.3-codex`; every row uses reasoning effort `max` and context tier
`long_context`, unless the responsible human explicitly specifies otherwise.
The `project-manager` orchestrator is `gpt-5.6-sol` and `pm-auditor` is
`claude-opus-5`. Historical artifacts are unchanged; component-owned changes
are routed to their owners (`PMR-074` for `security-reviewer`, closed at
owner commit `2e8d205`).

Every repository write also requires a fresh coordination check. The acting
agent checks worktree state and active-session evidence first; user reports,
handoffs, dirty state, and active session artifacts all block concurrent
writes. A clean tree alone is not a lock grant.

## Safety boundary

The agent writes only:

- inside this repository;
- to the Project Manager-owned parent-root artifacts named in
  `AGENT-INTERFACE.md`, including tracked symlink objects and `.gitignore`;
  and
- inside a carry-eligible component, only to carry a recorded request under
  the standing carry authority
  `records/decisions/PMD-20260904-003-standing-carry-authority.md`, in three
  classes: queue status edits in that component's `outbox/pm-queue.md`,
  metadata-only source-index entries in the owner's designated index, and
  Project Manager-role wording in its Markdown interface, collaboration,
  research-source, and handoff documents. Each carried write needs a clean
  worktree and an open request, and is committed inside that component with
  the request identifier.

It never writes inside another component directory outside those classes,
never writes `helium-te-poc/` or `beryllium-repo` at all, never stages
component contents in the parent, never resets, cleans, or reconciles a
component worktree, and never retargets a tracked symlink without user
direction. Component outbox queues are consumed ledger-first: the three
`outbox/pm-queue.md` source-discovery files can produce class-1 status edits,
while `../analysis-workbook/outbox/helium-transfer-queue.md` is tracked
read-only and never edited by the Project Manager.

Direct Git is permitted against this repository and the parent root, and
inside a component only as `git -C <component>` `status`, `diff`, `log`,
`show`, `add <exact paths>`, and `commit` while carrying. Remote creation,
push, tag, publication, and release, for any repository, happen only after
an explicit same-turn user confirmation.

The agent never grants or infers acceptance, approval, sign-off, licensing,
publication, release, formal verification, hardware validation, or risk
acceptance. Those remain responsible-human gates.

`PMR-073` is the planned Git-maintainer specialist todo. It is not yet
implemented and grants no authority. The intended design permits invocation
only by the Project Manager; component agents request service through durable
PM tasking/returns. Existing repository ownership, operation prohibitions,
active-session locks, and human gates remain binding.

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
queue/LEDGER.md                              ledger-first dispositions of component queue rows
outbox/component-requests.md                 requests to component owners, each with a priority; three classes carried by the agent
outbox/tasking/README.md                     contract for ignored generated per-component tasking views
outbox/OWNER-RUNBOOK.md                      open items by priority with exact human steps (refreshed each turn)
outbox/owner-edits/                          exact text of the recorded owner-side edits applied by the human-run helper
templates/owner-return.md                    component HANDOFF return shape for PMR/PML owner results
scripts/                                     maintained helpers (agent-run)
scripts/owner-actions.sh                     HUMAN-RUN owner-side pushes, fetches, recorded edits, artifact search; never executed by the agent
templates/                                   record and row templates
tests/validate-agent.sh                      component contract suite
```

## Maintained commands

```sh
bash ./scripts/inspect-components.sh components
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
bash ./scripts/inspect-components.sh refs <component> [<ref>...]
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/pull-queues.sh edits
bash ./scripts/project-tasking.sh generate
bash ./scripts/project-tasking.sh check
bash ./scripts/project-tasking.sh resolve <component-or-workspace-path>
bash ./scripts/new-record.sh decision <slug>
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git diff --check
```

Every mode of `inspect-components.sh` and `pull-queues.sh` is read-only and
runs Git in a sanitized environment without hooks, credentials, or network
access. `new-record.sh` writes only under `records/decisions/`. Carried
writes inside components are made by the agent itself, never by these
scripts.

`project-tasking.sh generate` writes only ignored local projections under
`outbox/tasking/`, after confirming the authoritative request table is
committed. `check` and `resolve` fail closed unless the view records the
current Project Manager commit and exact committed request blob. From either a
direct checkout or tracked workspace symlink, run:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

`PMD-20260915-008` makes the natural-language startup contract explicit:
`check Project Manager tasking` means run that exact resolver from the
logical workspace entry. An agent must stop on failure; it must not search
session history, task databases, background agents, prior chat, or memory as
a fallback. Component-owned entry points are tracked by
`PMR-063..PMR-072`.

From the workspace root, use
`bash ./project-manager/scripts/project-tasking.sh resolve <component>`.
Tracked-symlink owners verify `pwd` versus `pwd -P` and use the documented
`PM_TASKING_ROOT` / `PM_TASKING_WORKSPACE` inputs when the logical entry is
not preserved. Generated rows show `Assigned to` so cross-named requests are
not mistaken for owner assignments.

## Owner actions (human-run)

`scripts/owner-actions.sh` performs, for the responsible human, the owner-side
actions the agent records but never performs. The agent never executes it, in
any mode. Run it from this directory; dry-run first:

```sh
bash ./scripts/owner-actions.sh --plan            # read-only: reachability, outgoing commits, what would run
bash ./scripts/owner-actions.sh                   # review, then y/N per push, then fetch + restart snapshot
bash ./scripts/owner-actions.sh --yes             # same without prompts (a dirty worktree is still skipped)
bash ./scripts/owner-actions.sh --apply-edits     # also: the exact recorded owner-side edits (outbox/owner-edits/), diff, y/N, commit in the component
bash ./scripts/owner-actions.sh --files-search --files-root /mnt/backup   # also: read-only search for the lost retained PM artifacts
bash ./scripts/owner-actions.sh --fvr-backup      # also: create beryllium-project/formal-verification-research (private), add remote backup, push -u backup main
bash ./scripts/owner-actions.sh --sr-backup       # also: create beryllium-project/security-reviewer (private), add remote origin, push -u origin main (PMR-021)
bash ./scripts/owner-actions.sh --helium-branches --helium-only helium-te-fv,helium-te-h7-approved
bash ./scripts/owner-actions.sh --help            # steps, flags, exit status
```

Default steps: `preflight`, `review`, `push_awb` (analysis-workbook),
`push_tm` (threat-modeler), `push_xrv` (xrv-research-repo to its current
tracked `origin`; also `main -> backup` if such a remote exists), `push_osr`
(osr-claude), `push_fvr` (formal-verification-research `main -> backup` when
the component and remote exist),
`push_sr` (security-reviewer `main -> origin`, once that remote exists),
`push_pm` (this repository to `origin`, the parent to `upstream`),
`fetch_snapshot`. Opt-in: `apply_edits` (`--apply-edits`), `push_fvr` remote
creation (`--fvr-backup`), `push_sr` remote creation (`--sr-backup`),
`push_helium` (`--helium-branches`), `files_search`
(`--files-search`). Every push is a fast-forward verified afterwards with
`git ls-remote`; nothing is ever forced; a component file is changed only by
`apply_edits`, only to the exact text recorded in `outbox/owner-edits/`, only
in a clean worktree, after the diff and a `y`, and never in `helium-te-poc/`
or `beryllium-repo` (`records/decisions/PMD-20260906-001-owner-edits-and-request-priorities.md`).
The run ends with the open requests by priority; `outbox/OWNER-RUNBOOK.md` has
the exact steps for each. Logs go to `scratch/owner-actions/` (ignored).
Afterwards, start a Project Manager session and say what the run did.
