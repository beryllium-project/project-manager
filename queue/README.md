# Project Manager queue ledger

Component agents publish pull-only queues of discovered sources in their own
repositories:

- `../analysis-workbook/outbox/pm-queue.md` (rows `PMQ-NNN`, statuses written
  by that component: `new`, `unconfirmed`);
- `../threat-modeler/outbox/pm-queue.md` (rows `DISC-NNN`, status written by
  that component: `new`);
- `../security-reviewer/outbox/pm-queue.md` (rows `SRQ-NNN` of kind `source`
  or `owner-action`, status written by that component: `new`; registered
  2026-09-06, `PMD-20260906-003`);
- `../analysis-workbook/outbox/helium-transfer-queue.md` (rows `HET-NNN`,
  lifecycle statuses written by that component, currently `new`, and input
  states kept `unaccepted`).

Those files live inside agent-owned repositories. The Project Manager
therefore operates **ledger-first**: every disposition is recorded in
[`LEDGER.md`](LEDGER.md) in this repository before anything else, and the
exact status-column edit for the source file is then applied by the Project
Manager itself as a class-1 carried write under the standing carry authority
`../records/decisions/PMD-20260904-003-standing-carry-authority.md`,
committed inside the owning component with the `PML` identifiers in the
subject, when that component's worktree is clean and no other session is
active there. Otherwise the edit is handed to the user, who applies it in the
owning component. Class 1 names the analysis-workbook and threat-modeler
queue files; every edit due in `../security-reviewer/outbox/pm-queue.md` is
handed to the user until the responsible human extends class 1 to that file
(`../records/decisions/PMD-20260906-003-security-reviewer-component-registered.md`).
The Project Manager never stages or commits a component
outbox file in the parent. The transfer queue is tracked read-only:
`scripts/pull-queues.sh edits` prints no edit for it, because it is outside
class 1 and the workbook maintainer mirrors lifecycle changes after observing
an exact owner-side record.

## Ledger columns

| Column | Meaning |
| --- | --- |
| Ledger ID | `PML-NNNN`, monotonic, never reused |
| Source component | `analysis-workbook`, `threat-modeler`, `security-reviewer`, or `analysis-workbook-transfer` |
| Source ID | The row identifier in the component queue (`PMQ-NNN`, `DISC-NNN`, `SRQ-NNN`, or `HET-NNN`) |
| Raised on | Date recorded in the source row, or `unknown` |
| Title | Source title as recorded in the source row |
| Suggested owner | Owning component proposed by the source row |
| PM status | `pending`, `routed`, `accepted`, `duplicate`, `rejected`, or `deferred` |
| Source status applied | `no`, or `yes YYYY-MM-DD` once the corresponding status has been applied in a class-1 source file, by the Project Manager as a carried write or by the user; `Not applicable` for `analysis-workbook-transfer` rows because the PM never edits that file |
| Decided on | Date of the latest PM status change, or `Not applicable` |
| Note | Disposition rationale, request ID, or limitation |

## PM status meanings

| PM status | Meaning | Edit for `analysis-workbook` queue | Edit for `threat-modeler` and `security-reviewer` queues | Edit for `analysis-workbook-transfer` queue |
| --- | --- | --- | --- | --- |
| `pending` | Pulled, not yet triaged | none | none | none |
| `routed` | Owning component identified and a `PMR-NNN` request raised in `outbox/component-requests.md` | none | `routed` | none |
| `accepted` | A pointer to the source is recorded in the owning component's designated index under its own rules, by the owner or by the Project Manager as a class-2 carried write on the owner's delegated authority; never corpus admission, review, or endorsement; never used for transfer rows | `accepted` | `integrated` | none |
| `duplicate` | Already recorded by the owning component | `duplicate` | `declined` | none |
| `rejected` | Out of scope or rejected with a reason | `rejected` | `declined` | none |
| `deferred` | Tracked but not acted on now | `deferred` | `acknowledged` | none |

### Transfer inputs (`HET-NNN`)

Transfer rows are read-only tracking entries for Helium-to-Beryllium method
inputs. The PM statuses used for them are `pending`, `routed`, `duplicate`,
`rejected`, and `deferred`. For this source, `routed` means a `PMR-NNN`
request to the target owner has been recorded; it is the terminal PM
disposition, because the remaining lifecycle belongs to the target owner and
the workbook maintainer.

The PM status accepted is never used for transfer rows: the source's own
schema keeps every input `unaccepted`, and no Project Manager disposition may
read as acceptance. "Source status applied" is always `Not applicable` because
the PM never edits `../analysis-workbook/outbox/helium-transfer-queue.md`: the
file is outside class 1 of
`../records/decisions/PMD-20260904-003-standing-carry-authority.md`, and the
workbook maintainer mirrors lifecycle changes after observing an exact
owner-side record, such as the `PMR-NNN` row or an owner artifact. The
source file's observed lifecycle status and commit are recorded in the ledger
Note, and `scripts/pull-queues.sh edits` prints nothing for this source.

`scripts/pull-queues.sh list` shows source rows awaiting a disposition,
`scripts/pull-queues.sh check` fails when a source row has no ledger row or a
ledger row claims an applied status the source file does not show, and
`scripts/pull-queues.sh edits` prints the exact edits due in each component
file, which the Project Manager applies as carried writes or hands to the
user.

A ledger row is a Project Manager disposition of a pointer. It is never a
claim that a source has been read, redistributed, or approved by its owning
component; research owners retain sole authority to admit a source into their
corpus.
