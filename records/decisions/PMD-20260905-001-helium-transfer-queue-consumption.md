# Helium transfer queue consumption

- **Record ID:** `PMD-20260905-001`
- **Created:** 2026-09-05
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether the Project Manager consumes
`../analysis-workbook/outbox/helium-transfer-queue.md` as part of its
ledger-first pull-queue tooling, and if so whether that source can ever be an
edit target. This record touches the Project Manager queue tooling and
ledger, the analysis-workbook transfer queue, and the request already routed
to `beryllium-repo`. The transfer queue was committed by the workbook owner
at `efde667` and observed at `83b97a3` when this record was written.
`beryllium-repo` remains carry-ineligible under
`PMD-20260904-003`; no Beryllium worktree content is changed by this record.

## Inputs

- `../analysis-workbook/outbox/helium-transfer-queue.md` at `efde667`,
  observed again at `83b97a3`: the file defines `HET-NNN` transfer inputs,
  a queue summary with `Status` and `Input state`, a lifecycle of `new`,
  `routed`, `recorded`, `deferred`, `declined`, and `superseded`, and a rule
  that the analysis-workbook maintainer mirrors lifecycle changes only after
  observing an exact owner-side record. It records `HET-001`, raised
  2026-09-04, target `component://beryllium-repo` iterative development
  process, status `new`, and input state `unaccepted`.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md`: class 1
  allows queue status edits only in
  `../analysis-workbook/outbox/pm-queue.md` and
  `../threat-modeler/outbox/pm-queue.md`; it never makes
  `../analysis-workbook/outbox/helium-transfer-queue.md` a Project Manager
  edit target.
- `outbox/component-requests.md` at this repository's `a1677c1` (the HEAD when
  this record was written):
  `PMR-016` routes `HET-001` to the Beryllium owner, says
  `beryllium-repo` is carry-ineligible, and records that the transfer item is
  a planning input only, not adoption, planning approval, review,
  implementation authorization, acceptance, or assurance.
- The responsible human's choice on 2026-09-05, quoted verbatim:
  "Register for read-only tracking in pull-queues.sh + queue/README.md + one
  PML row per HET item; never an edit target (recommended)" over the
  alternatives "Do not register; track HET items only via PMR rows and
  per-turn re-reading" and "Register with its own ledger file
  (queue/TRANSFER-LEDGER.md) and tooling".

## Disposition

The Project Manager registers the analysis-workbook transfer queue as a third
source named `analysis-workbook-transfer` in `scripts/pull-queues.sh`, with
file `analysis-workbook/outbox/helium-transfer-queue.md`, identifier prefix
`HET`, source title column `Subject`, owner column `Target`, and source
status column `Status`. The source is consumed into the existing
`queue/LEDGER.md`; each item receives one `PML-NNNN` row rather than a
separate transfer ledger.

The transfer queue is read-only for the Project Manager. It is not a class-1
target under `PMD-20260904-003`, and `scripts/pull-queues.sh edits` therefore
prints no edit for any `analysis-workbook-transfer` row. The workbook
maintainer mirrors lifecycle changes in the transfer queue after observing
the exact owner-side record.

For transfer rows, `accepted` is never used as a Project Manager status. The
source schema keeps the input state `unaccepted`, and no Project Manager
ledger disposition may read as acceptance. The Project Manager statuses used
for transfer rows are `pending`, `routed`, `duplicate`, `rejected`, and
`deferred`; `routed` means the Project Manager has recorded a `PMR-NNN`
request to the target owner and is the terminal PM disposition for the row.
The existing `PMR-016` row is the Project Manager's routing record that the
HET file's `routed` lifecycle status may cite if the workbook maintainer
chooses to mirror it.

`PML-0017` records `HET-001` as `routed` on 2026-09-05 with "Source status
applied" set to `Not applicable`, notes the observed transfer status `new`
and input state `unaccepted`, and cites
`../analysis-workbook/outbox/helium-transfer-queue.md` at `83b97a3`.

Alternatives considered:

1. PMR-only re-reading was rejected because it gives no queue-tooling
   visibility and a new `HET-NNN` item could be missed between coordination
   turns.
2. A separate `queue/TRANSFER-LEDGER.md` was rejected because it would
   duplicate the existing ledger structure for one compatible row schema and
   would split Project Manager dispositions across two tools.

## What this record does not decide

This record is coordination evidence. It does not decide the owner-side
disposition of `HET-001`; that belongs to the Beryllium owner through
`PMR-016` or a later Beryllium-owned artifact. It does not authorize any
Beryllium work beyond the current R8-H0 profile freeze; Beryllium is accepted
through R7, R8-H0 is a committed candidate and is not accepted, H1-H4 are not
authorized, and K3 hardware is `NOT RUN`.

This record does not grant acceptance, review, approval, sign-off, risk
acceptance, licensing, redistribution, publication, release, formal
verification, or hardware validation. Helium remains a review-and-test proof
of concept, not formally verified or hardware validated. This record does not
authorize pushing any repository or changing any remote.

## Follow-up

- Later Project Manager turns run `bash ./scripts/pull-queues.sh list`,
  `bash ./scripts/pull-queues.sh summary`, and
  `bash ./scripts/pull-queues.sh check` with
  `analysis-workbook-transfer` included; if a new `HET-NNN` row appears, add
  one `PML-NNNN` row and use `routed` only after a matching `PMR-NNN` request
  or owner-side record exists.
- If the Beryllium owner records, defers, or declines `HET-001`, update
  `PMR-016` or a superseding Project Manager record; the workbook maintainer
  mirrors the transfer lifecycle from that exact record, not from a Project
  Manager edit to the transfer queue.

## Provenance

- Written by the `project-manager` agent from the inputs above on 2026-09-05
  after the responsible human selected read-only registration for the
  transfer queue. No component file was modified.
