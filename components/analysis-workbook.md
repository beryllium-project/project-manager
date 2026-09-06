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
  `scripts/validate-session.sh`, `scripts/validate-helium-transfer-queue.sh`
  (run with `--baseline <prior copy>` before recording or mirroring a
  transfer-queue change, per its `AGENT-INTERFACE.md` at `ff12f2f`), and
  `tests/validate-agent.sh`. `WORKBOOK.md` is generated; never edit it by
  hand.
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
  `scripts/readonly-inspect.sh` registered list (still `PMR-004`). At
  `ff12f2f` (carried `PMR-015`, 2026-09-05) its "Source-discovery reference
  set" also names `../project-manager/queue/LEDGER.md`.
- At `efde667` (the owner's session, 2026-09-04) the component emits a
  second pull-only queue, `outbox/helium-transfer-queue.md`: `HET-NNN`
  method-transfer inputs with their own lifecycle (`new`, `routed`,
  `recorded`, `deferred`, `declined`, `superseded`) and input state
  (`unaccepted`), outside the `PMQ-NNN` schema; the maintainer mirrors a
  lifecycle change only from an exact owner-side record. `HET-001` (Helium
  Tier 8 endpoint and reusable FV method; target `component://beryllium-repo`)
  was routed as `PMR-016`; on 2026-09-05 the responsible human, acting as the
  Beryllium owner, triaged it, and
  `../records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`
  records the disposition as the lifecycle status `recorded` (planning inputs
  only; the input state stays `unaccepted`; not acceptance of any Beryllium
  work), closes `PMR-016`, and hands the maintainer the exact mirror rows as
  `PMR-019`. At `d003dec` (the maintainer's commit of 2026-09-06 through the
  human-run `../scripts/owner-actions.sh --apply-edits`, after the component's
  own `validate-helium-transfer-queue.sh --baseline` passed) the queue shows
  `HET-001` `recorded`, with `routed` and `recorded` history rows dated
  2026-09-06 citing `PMR-016` and `PMD-20260905-002`, `ACTIVITY-002`, and the
  input state still `unaccepted`; the component's `HANDOFF.md` prose still
  says `new` (the remaining part of `PMR-019`, P3).
  Since `PMD-20260905-001`, the Project Manager
  registers this queue for read-only tracking in `../queue/LEDGER.md` and
  `../scripts/pull-queues.sh`; it never edits that file because class 1
  covers only `outbox/pm-queue.md`.
- Backup: the owner pushed `main` to private `origin` on 2026-09-05
  (`efde667..ff12f2f`) and 2026-09-06 (`ff12f2f..d003dec`) through the
  human-run `../scripts/owner-actions.sh`, each verified with `ls-remote` in
  its log; observed synchronized (0 behind, 0 ahead) at 2026-09-06T10:30Z.

## Outbound queue

`outbox/pm-queue.md` is a source-discovery pull interface. The component
writes rows with status `new` or `unconfirmed`; the Project Manager resolves
them to `accepted`, `duplicate`, `rejected`, or `deferred`. Since `83b97a3`
(carried `PMR-011`) the component's `AGENT-INTERFACE.md`
"Source-discovery queue" uses the same set as the queue header and explains
that `routed` is an intermediate state kept in `../queue/LEDGER.md`. The
Project Manager consumes the queue ledger-first (see `../queue/README.md`)
and applies the status edits itself as class-1 carried writes when this
component is clean (first done at `83b97a3`: fourteen rows). The separate
`outbox/helium-transfer-queue.md` is also consumed ledger-first for `HET-NNN`
tracking, but the PM never edits it; the workbook maintainer mirrors transfer
lifecycle changes from exact owner-side records.

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
part was carried at `83b97a3`; P3, exact edit in `../outbox/OWNER-RUNBOOK.md`);
the `HET-001` lifecycle mirror (`PMR-019`: the table mirror was applied by
the maintainer at `d003dec` on 2026-09-06 through the human-run
`../scripts/owner-actions.sh --apply-edits`, after its own
`scripts/validate-helium-transfer-queue.sh --baseline` passed; the request
stays open, P3, for the `HANDOFF.md` sentences that still call `HET-001`
`new`, which the maintainer refreshes in its own words); nothing that treats a
session as review or acceptance. `PMR-015` (the ledger in the source-discovery reference set)
was carried at `ff12f2f` on 2026-09-05. The push of the carried `83b97a3` and
`ff12f2f` was done by the owner at 19:05Z on 2026-09-05 (see "Backup"
above).
