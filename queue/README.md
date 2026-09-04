# Project Manager queue ledger

Component agents publish pull-only queues of discovered sources in their own
repositories:

- `../analysis-workbook/outbox/pm-queue.md` (rows `PMQ-NNN`, statuses written
  by that component: `new`, `unconfirmed`);
- `../threat-modeler/outbox/pm-queue.md` (rows `DISC-NNN`, status written by
  that component: `new`).

Those files live inside agent-owned repositories. The Project Manager
therefore operates **ledger-only**: every disposition is recorded in
[`LEDGER.md`](LEDGER.md) in this repository, and the exact status-column edit
for the source file is handed to the user, who applies it in the owning
component. The Project Manager never edits, stages, or commits a component
outbox file.

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
| Source status applied | `no`, or `yes YYYY-MM-DD` once the user has applied the corresponding status in the component file |
| Decided on | Date of the latest PM status change, or `Not applicable` |
| Note | Disposition rationale, request ID, or limitation |

## PM status meanings

| PM status | Meaning | Edit for `analysis-workbook` queue | Edit for `threat-modeler` queue |
| --- | --- | --- | --- |
| `pending` | Pulled, not yet triaged | none | none |
| `routed` | Owning component identified and a `PMR-NNN` request raised in `outbox/component-requests.md` | none | `routed` |
| `accepted` | The owning component has recorded the source under its own rules | `accepted` | `integrated` |
| `duplicate` | Already recorded by the owning component | `duplicate` | `declined` |
| `rejected` | Out of scope or rejected with a reason | `rejected` | `declined` |
| `deferred` | Tracked but not acted on now | `deferred` | `acknowledged` |

`scripts/pull-queues.sh list` shows source rows awaiting a disposition,
`scripts/pull-queues.sh check` fails when a source row has no ledger row, and
`scripts/pull-queues.sh edits` prints the exact edits the user should apply in
each component file.

A ledger row is a Project Manager disposition of a pointer. It is never a
claim that a source has been read, redistributed, or approved by its owning
component; research owners retain sole authority to admit a source into their
corpus.
