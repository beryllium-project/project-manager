# Project Manager queue ledger

Component agents publish pull-only queues of discovered sources in their own
repositories:

- `../analysis-workbook/outbox/pm-queue.md` (rows `PMQ-NNN`, statuses written
  by that component: `new`, `unconfirmed`);
- `../threat-modeler/outbox/pm-queue.md` (rows `DISC-NNN`, status written by
  that component: `new`).

Those files live inside agent-owned repositories. The Project Manager
therefore operates **ledger-first**: every disposition is recorded in
[`LEDGER.md`](LEDGER.md) in this repository before anything else, and the
exact status-column edit for the source file is then applied by the Project
Manager itself as a class-1 carried write under the standing carry authority
`../records/decisions/PMD-20260904-003-standing-carry-authority.md`,
committed inside the owning component with the `PML` identifiers in the
subject, when that component's worktree is clean and no other session is
active there. Otherwise the edit is handed to the user, who applies it in the
owning component. The Project Manager never stages or commits a component
outbox file in the parent.

## Ledger columns

| Column | Meaning |
| --- | --- |
| Ledger ID | `PML-NNNN`, monotonic, never reused |
| Source component | `analysis-workbook` or `threat-modeler` |
| Source ID | The row identifier in the component queue (`PMQ-NNN`, `DISC-NNN`) |
| Raised on | Date recorded in the source row, or `unknown` |
| Title | Source title as recorded in the source row |
| Suggested owner | Owning component proposed by the source row |
| PM status | `pending`, `routed`, `accepted`, `duplicate`, `rejected`, or `deferred` |
| Source status applied | `no`, or `yes YYYY-MM-DD` once the corresponding status has been applied in the component file, by the Project Manager as a carried write or by the user |
| Decided on | Date of the latest PM status change, or `Not applicable` |
| Note | Disposition rationale, request ID, or limitation |

## PM status meanings

| PM status | Meaning | Edit for `analysis-workbook` queue | Edit for `threat-modeler` queue |
| --- | --- | --- | --- |
| `pending` | Pulled, not yet triaged | none | none |
| `routed` | Owning component identified and a `PMR-NNN` request raised in `outbox/component-requests.md` | none | `routed` |
| `accepted` | A pointer to the source is recorded in the owning component's designated index under its own rules, by the owner or by the Project Manager as a class-2 carried write on the owner's delegated authority; never corpus admission, review, or endorsement | `accepted` | `integrated` |
| `duplicate` | Already recorded by the owning component | `duplicate` | `declined` |
| `rejected` | Out of scope or rejected with a reason | `rejected` | `declined` |
| `deferred` | Tracked but not acted on now | `deferred` | `acknowledged` |

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
