# collaboration request intake boundary

- **Record ID:** `PMD-20260914-001`
- **Created:** 2026-09-14
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

How the Project Manager handles the new
`analysis-workbook/outbox/collaboration-requests.md` interface and its first
row, `CRQ-001`, without expanding the standing carry authority. This touches
the analysis-workbook owner commit `4c771c0`, the clean
`xrv-research-repo` at `ca41490`, and the Project Manager coordination
artifacts at pre-turn `b2bbbf1`.

## Inputs

- `../analysis-workbook/outbox/collaboration-requests.md` at `4c771c0`:
  proposes `CRQ-NNN` as a pull-only
  owner-boundary queue and asks the Project Manager to set later statuses.
- `../analysis-workbook/sessions/AWB-20260914-001-object-capability-hypervisor-review/xrv-collaboration-interface.md`
  at `4c771c0`: proposes separate XRV source-intake,
  completed-use, and Project Manager coordination lanes.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md`: class 1
  permits status edits only in the registered `outbox/pm-queue.md` files;
  it does not authorize edits to `outbox/collaboration-requests.md`.
- `../xrv-research-repo/review-log.md` and `HANDOFF.md` at `ca41490`: XRV
  currently has an owner-controlled source-intake workflow and no root
  `COLLAB.md`; the previously observed `7314e2f` and
  `REV-20260904-001..009` records are absent.
- `outbox/component-requests.md`: `PMR-025` already owns the missing-history
  and reachable-backup reconciliation.

## Disposition

The proposed three-lane model is recorded as a sound owner-ready design:
XRV source intake remains in `review-log.md` plus `review-inbox/`; a future
owner-approved root `COLLAB.md` may record completed downstream use; and the
Project Manager routes and observes coordination without owning or integrating
XRV research.

`CRQ-001` is pulled and routed through `PMR-034`, but its source row remains
`new`. The collaboration queue is read-only to the Project Manager unless the
responsible human explicitly extends class 1. Until then, the
analysis-workbook maintainer mirrors an exact Project Manager or owner-side
record, as it does for the transfer queue. `PMR-036` requests that correction
to the proposed queue contract and the routed mirror.

`PMR-025` remains the prerequisite for allocating any new XRV `REV-*` IDs.
`PMR-034` separately asks the XRV owner to decide and, if accepted, implement
the collaboration interface and then triage `PMQ-017..020`. The Project
Manager does not create XRV `COLLAB.md`, change XRV instructions, allocate
review IDs, or write intake notes under this disposition.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not expand `PMD-20260904-003`, approve the proposed XRV
guest branch workflow, recover the missing XRV history, admit any source,
authorize an XRV write or push, or authorize analysis-workbook to write XRV.
XRV owner adoption, review-ID reconciliation, source intake, branch
integration, and every push remain open owner or responsible-human gates.

## Follow-up

- Complete `PMR-025`, then start the XRV owner in
  `/home/jmorris/src/beryllium-project/xrv-research-repo` and hand it
  `PMR-034` from `outbox/component-requests.md`.

## Provenance

- Written by the `project-manager` agent from the inputs above during the
  2026-09-14 coordination turn. No sibling repository was modified by this
  decision.
- The analysis-workbook owner committed the proposal at `4c771c0` while this
  Project Manager record was still uncommitted; the locators above were
  updated before the Project Manager commit.
