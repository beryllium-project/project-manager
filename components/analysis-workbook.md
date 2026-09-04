# analysis-workbook

- **Workspace entry:** `../analysis-workbook/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 1: status edits in `outbox/pm-queue.md`; class 3:
  Project Manager-role wording in `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`),
  committing inside this component; nothing else
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
- Its `RESEARCH-SOURCES.md` tier 4 cited the parent-root paths
  `../formal-verification/`, `../HANDOFF.md`, `../COMPONENTS.md`, and
  `../SOT.md`; at `83b97a3` (carried `PMR-004`, 2026-09-04) it cites
  `../project-manager/HANDOFF.md`, `records/`, `queue/LEDGER.md`, and
  `outbox/component-requests.md` and names the parent `HANDOFF.md` and
  `formal-verification/helium-te-fv-pathfinder.md` as redirect stubs, which
  the parent keeps. `project-manager` is not in its owner-only
  `scripts/readonly-inspect.sh` registered list (still `PMR-004`).
- At `efde667` (the owner's session, 2026-09-04) the component emits a
  second pull-only queue, `outbox/helium-transfer-queue.md`: `HET-NNN`
  method-transfer inputs with their own lifecycle (`new`, `routed`,
  `recorded`, `deferred`, `declined`, `superseded`) and input state
  (`unaccepted`), outside the `PMQ-NNN` schema; the maintainer mirrors a
  lifecycle change only from an exact owner-side record. `HET-001` (Helium
  Tier 8 endpoint and reusable FV method; target `component://beryllium-repo`)
  is routed as `PMR-016`. The Project Manager never edits that file (class 1
  covers only `outbox/pm-queue.md`); whether `../queue/README.md` and
  `../scripts/pull-queues.sh` register the queue is a pending decision.

## Outbound queue

`outbox/pm-queue.md` is a pull interface. The component writes rows with
status `new` or `unconfirmed`; the Project Manager resolves them to
`accepted`, `duplicate`, `rejected`, or `deferred`. Since `83b97a3` (carried
`PMR-011`) the component's `AGENT-INTERFACE.md` "Source-discovery queue"
uses the same set as the queue header and explains that `routed` is an
intermediate state kept in `../queue/LEDGER.md`. The Project Manager
consumes the queue ledger-first (see `../queue/README.md`) and applies the
status edits itself as class-1 carried writes when this component is clean
(first done at `83b97a3`: fourteen rows).

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
in its `scripts/readonly-inspect.sh` registered list (the `RESEARCH-SOURCES.md`
part was carried at `83b97a3`); whether to add
`project-manager/queue/LEDGER.md` to its source-discovery reference set
(`PMR-015`); a decision on pushing the carried `83b97a3`; nothing that treats
a session as review or acceptance.
