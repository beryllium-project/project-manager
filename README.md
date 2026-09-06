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
`.gitignore`, and the tracked `*-repo` symlink objects. This component owns
the Project Manager handoff, component knowledge cards, the agent roster,
assurance-transfer records, decision records, the queue ledger, and the
component-request outbox.

Before the consolidation recorded in `HANDOFF.md`, these artifacts lived at
the parent root. Redirect stubs remain at `../HANDOFF.md` and
`../formal-verification/helium-te-fv-pathfinder.md` because sibling components
cite those paths as read-only evidence; `../formal-verification/README.md`
(Project Manager-owned since 2026-09-06) describes that directory's
coordination purpose.

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
direction. Component outbox queues are consumed ledger-first: the two
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
outbox/OWNER-RUNBOOK.md                      open items by priority with exact human steps (refreshed each turn)
outbox/owner-edits/                          exact text of the recorded owner-side edits applied by the human-run helper
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
`push_tm` (threat-modeler), `push_xrv` (xrv-research-repo, skipped while its
`origin` is in the unreachable namespace; also `main -> backup` once such a
remote exists), `push_osr` (osr-claude), `push_fvr`
(formal-verification-research `main -> backup`, once that remote exists),
`push_sr` (security-reviewer `main -> origin`, once that remote exists),
`push_pm` (this repository to `origin`, the parent to `backup`),
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
