# analysis-workbook

- **Workspace entry:** `../analysis-workbook/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes nothing here
- **Agents:** `analysis-workbook` (user-invocable orchestrator),
  `analysis-evidence` and `analysis-research` (write-disabled specialists);
  skill `beryllium-analysis`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** see `../../COMPONENTS.md`

## Role

Human-facing analysis workbench. A session runs in two phases: planning names
the aspect and at least one question and waits for explicit confirmation;
analysis freezes the scope, works the local corpus in the order given by
`RESEARCH-SOURCES.md`, goes outward only for recorded gaps, and produces a
report, a standalone summary, and a brief chat reply per numbered `Q-NNN`
inquiry. Durable output lives in `sessions/AWB-YYYYMMDD-NNN-*/`, indexed by
topic and chronology in the generated `WORKBOOK.md`.

## Boundaries and conventions

- Every other component is a read-only, untrusted input. No component may be
  built, tested, or executed without the user approving that exact command by
  name for the session.
- Maintained scripts only: `scripts/new-session.sh`, `scripts/new-inquiry.sh`,
  `scripts/readonly-inspect.sh`, `scripts/update-workbook.sh`,
  `scripts/validate-session.sh`, and `tests/validate-agent.sh`. `WORKBOOK.md`
  is generated; never edit it by hand.
- Session packages default to private; evidence, search, discovery, and
  activity records are append-only, with corrections as superseding records.
- It produces analysis, never review, acceptance, approval, sign-off,
  licensing, publication, or release.
- Its `RESEARCH-SOURCES.md` tier 4 cites the parent-root paths
  `../formal-verification/`, `../HANDOFF.md`, `../COMPONENTS.md`, and
  `../SOT.md`; the parent keeps redirect stubs at those paths.

## Outbound queue

`outbox/pm-queue.md` is a pull interface. The component writes rows with
status `new` or `unconfirmed`; it expects the Project Manager to resolve them
to `accepted`, `duplicate`, `rejected`, or `deferred`. The Project Manager
consumes it ledger-only (see `../queue/README.md`) and hands the user the
exact status edits.

## Commands (run by the human, from `../analysis-workbook/`)

```sh
/agent analysis-workbook                  # in Copilot CLI
bash ./tests/validate-agent.sh
bash ./scripts/validate-session.sh [--draft|--baseline <prior-copy>] sessions/AWB-YYYYMMDD-NNN-short-name
bash ./scripts/update-workbook.sh --check
git diff --check
```

## What the Project Manager may request

A new analysis session on a named aspect; registration of `project-manager/`
in its `RESEARCH-SOURCES.md` and `scripts/readonly-inspect.sh` registered
list; nothing that treats a session as review or acceptance.
