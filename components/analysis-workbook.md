# analysis-workbook

- **Workspace entry:** `../analysis-workbook/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 1: status edits in `outbox/pm-queue.md`; class 3:
  Project Manager-role wording in Markdown interface, collaboration,
  research-source, and handoff documents, including `AGENT-INTERFACE.md`,
  `RESEARCH-SOURCES.md`, and `HANDOFF.md`), committing inside this component;
  nothing else
- **Agents:** `analysis-workbook` (user-invocable orchestrator),
  `analysis-workbook-owner` (hidden PM-invocable owner),
  `analysis-evidence` and `analysis-research` (write-disabled specialists);
  skill `beryllium-analysis`. `PMR-084` is closed from local checkpoint
  `ea72522`; the responsible human explicitly released the bootstrap session
  on 2026-09-17. The selected Project Manager runtime registers the profile.
  Dedicated P1 `PMR-087` is the only next invocation and must complete the
  read-only native discovery/root/task-fingerprint/isolation handshake under
  single-use `PMD-20260918-001`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** clean `main` at owner-return checkpoint `ea72522`,
  behind 0 / ahead 8 of last-fetched `origin/main` `1ef1ac6`, local and
  unpushed. The range contains Project Manager carry `c7cc0fa` plus seven
  PMR-084 owner commits. Full component validation remains 349 passed / 8
  failed on pre-existing stale HET-001 fixtures, with zero new PMR-084
  failures; `PMR-086` owns that repair. The durable return's historical
  `active_session: self` is superseded for coordination locking by the
  responsible human's exact release statement. Handshake/write use remains
  blocked pending the exact committed/generated `PMR-087` tasking and
  successful read-only probe. P2 `PMR-086` remains blocked by `PMR-087`;
  `PMR-059`, `PMR-063`, and backup `PMR-085` remain open.
  `PMD-20260915-001` keeps this Be-specific workbench under
  `beryllium-project` for now

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
- After `PMR-063`, the exact read-only Project Manager tasking resolver is a
  single startup-discovery exception outside an analysis package. It is not
  target execution and grants no other sibling command.
- `PMD-20260917-002` creates only the PM control plane. `PMR-084` added the
  hidden owner profile, and the responsible human has released its bootstrap
  session. `PMD-20260918-001` and P1 `PMR-087` define the single-use first
  invocation: read/search plus permitted read-only local Git identity/status
  checks only, exact profile/root/task fingerprint and clean `main`
  `ea72522a7d6448dfa2f3af841c2511522d5bc228`, unchanged pre/post state, no
  specialist, no write-capable operation, and exactly one live
  `OWNER_AGENT_RESPONSE_V1` `progress` document with empty work lists and a
  null handoff checkpoint. PM-side verification may close only `PMR-087`
  without a component handoff write; failure leaves it and `PMR-086` blocked.
  The committed profile and release alone grant no analysis or write
  authority.
- The owner profile's local-Git exception is limited to repository
  status/identity/diff inspection, staging exact PMR paths, and validated
  local work/return commits. It cannot fetch, pull, push, mutate remotes, tag,
  merge, rebase, amend, stash, reset, clean, switch/create branches or
  worktrees, or rewrite history.
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
  `outbox/component-requests.md`. At `eab5f8b` (`PMR-031`) it records the
  parent `HANDOFF.md` as the remaining compatibility redirect and points
  current assurance lookup directly to `../project-manager/records/assurance/`.
  `project-manager` is not in its owner-only
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
  input state still `unaccepted`. Owner commit `62ee356` aligns the handoff;
  `PMR-019` is closed.
  Since `PMD-20260905-001`, the Project Manager
  registers this queue for read-only tracking in `../queue/LEDGER.md` and
  `../scripts/pull-queues.sh`; it never edits that file because class 1
  covers only `outbox/pm-queue.md`.
- Owner commit `4c771c0` adds a third pull interface,
  `outbox/collaboration-requests.md`, and `CRQ-001` for an XRV collaboration
  protocol. Owner commit `62ee356` assigns status mirroring to the maintainer
  and mirrors `CRQ-001` as `routed`; `PMR-036` is closed. XRV owner commit
  `d618935` completes the requested interface, and the maintainer mirrored
  `CRQ-001` as `completed` at `2374115`; `PMR-038` remains open for residual
  interface/handoff wording and the structured return.
- Backup: the owner pushed `main` to private `origin` on 2026-09-05
  (`efde667..ff12f2f`) and 2026-09-06 (`ff12f2f..d003dec`) through the
  human-run `../scripts/owner-actions.sh`, each verified with `ls-remote` in
  its log; observed synchronized (0 behind, 0 ahead) at 2026-09-06T10:30Z.
  Owner commit `1ef1ac6` was observed synchronized on 2026-09-15; Project
  Manager carry `c7cc0fa` plus the seven PMR-084 owner commits now leave
  `main` eight ahead of `origin/main`. `PMR-085` tracks private backup.

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

The collaboration queue is not part of the standing class-1 carry authority.
It is read-only to the Project Manager and its maintainer mirrors exact
coordination outcomes. `PMQ-017..020` were accepted after XRV intake and the
class-1 edits were carried at `0501243`.

Owner commit `a46dba2` completes
`AWB-20260914-002-cheri-hypervisor-security-model` and adds
`PMQ-022..026`. `PML-0023`, `PML-0025..0027` are duplicates;
`PML-0024` is accepted at formal-verification commit `784be93`; all five
source statuses were applied at `b93722b`.

Owner commit `2374115` mirrors `CRQ-001` as `completed`, corrects the
`PMQ-023` triage request, and adds `CRQ-002` plus its successor-first
coordination packet. `PMD-20260915-004` pulls `CRQ-002` and routes the three
owner stages as `PMR-052..PMR-054`; `PMR-055` requests its derived `routed`
mirror and correction of the packet's stale `OPEN-001` reference to current
`OPEN-003`. `PMR-038` remains open because `AGENT-INTERFACE.md` still says
the outbox has two surfaces, `HANDOFF.md` still calls the clean committed
update uncommitted, and no structured Project Manager return names the
partial result.

Owner commit `1ef1ac6` adds `PMQ-027..030`. Ledger rows
`PML-0028`, `PML-0029`, and `PML-0031` route the specification, QEMU series,
and corrected exact OpenSBI pointer to XRV under now-actionable `PMR-058`;
`PMR-045` is closed.
`PML-0030` rejects `PMQ-029` because `PMQ-030` supersedes it; the exact
class-1 source edit is carried at `c7cc0fa`. `PMR-059` remains for the
repository handoff and structured return only.

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
and `security-reviewer` in its `scripts/readonly-inspect.sh` registered list
(`PMR-004`, `PMR-050`; the `RESEARCH-SOURCES.md` Project Manager part was
carried at `83b97a3`; exact edit in `../outbox/OWNER-RUNBOOK.md`);
the remaining stale interface/handoff wording and structured return under
`PMR-038`; the `CRQ-002` routed mirror and stale open-ID correction under
`PMR-055`; the repository handoff and structured return for owner commit
`1ef1ac6` under `PMR-059`; and, only after `PMR-052` and
`PMR-053` return, the bounded cap-talk follow-up inquiry under `PMR-054`.
These are request-only because the collaboration queue and analysis content
are outside class 1. Nothing treats a session as review or acceptance.
`PMR-063` asks the owner to map `check Project Manager tasking` to the exact
fail-closed resolver and prohibit session-history fallback.
`PMR-087` is the dedicated P1 no-write owner capability probe under
`PMD-20260918-001`; `PMR-086` remains open P2 and cannot begin unless that
probe is independently verified and closed.
`PMR-019` and `PMR-036` are closed at `62ee356`. `PMR-015` (the ledger in the source-discovery reference set)
was carried at `ff12f2f` on 2026-09-05. The push of the carried `83b97a3` and
`ff12f2f` was done by the owner at 19:05Z on 2026-09-05 (see "Backup"
above).
