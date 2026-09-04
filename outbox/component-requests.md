# Component requests

Pull-only requests from the Project Manager to component owners. A request is
one owner-actionable sentence with its evidentiary basis. Raising a request
does not modify or notify a component; the responsible human carries it to the
owner, who acts under that component's own rules.

Statuses written by the Project Manager: `open`, `closed` (the owner's action
was observed in component state), `withdrawn`, and `superseded`. Rows are
append-only; never renumber or reuse a `PMR-NNN`.

## Requests

| Request ID | Raised on | Component | Request | Basis | Status | Resolved on | Note |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PMR-001 | 2026-09-04 | formal-verification-research | Confirm that the owner-status table and `HANDOFF.md` describe the second Helium FV integration (merge `eaa497b`), and decide a reachable backup remote. | Parent `HANDOFF.md` at `7677527` recorded the discrepancy; component observed clean on `main` at `8b91ebd` with only the unreachable `jamorris_microsoft` remote | open | Not applicable | The Project Manager does not modify owner-maintained sections. |
| PMR-002 | 2026-09-04 | osr-claude | Remove the stale HTTPS-remote and pending-`mktemp` statements from the handoff infrastructure section. | Parent `HANDOFF.md` at `7677527`; component observed clean at `f2edd17` with an SSH remote and fix commit `bb9ac1f` | open | Not applicable | Agent-owned; ask before any change. |
| PMR-003 | 2026-09-04 | beryllium-repo | Reconcile `planning/HANDOFF.md` so it names the canonical workstation path and describes H0 as committed candidate `102f2b0`, not local-uncommitted, without inferring acceptance. | Parent `HANDOFF.md` at `7677527`; component observed clean at `65f6d89` | open | Not applicable | Committed H0 content is not H0 acceptance. |
| PMR-004 | 2026-09-04 | analysis-workbook | Register `project-manager` in `RESEARCH-SOURCES.md` tier 4 and in the `scripts/readonly-inspect.sh` registered list, and consider citing `../project-manager/HANDOFF.md` and `../project-manager/records/` rather than the parent redirect stubs. | `../analysis-workbook/RESEARCH-SOURCES.md` and `AGENT-INTERFACE.md` at `2261659` cite `../HANDOFF.md` and `../formal-verification/`; the same applies to `../threat-modeler/RESEARCH-SOURCES.md` and `scripts/readonly-inspect.sh` at `0d5bed3` | open | Not applicable | Redirect stubs remain at the parent root until both owners update. |
| PMR-005 | 2026-09-04 | threat-modeler | Decide whether to push the 2 local commits on `main` (`026e6c9`, `0d5bed3`) to private `origin`. | `scripts/inspect-components.sh status` on 2026-09-04 reported `origin/main` behind 0 / ahead 2 | open | Not applicable | Pushing is the owner's decision; the Project Manager never pushes a component. |
| PMR-006 | 2026-09-04 | analysis-workbook | Expect Project Manager status edits for `PMQ-001..PMQ-016` after triage; the human applies them in `outbox/pm-queue.md`. | `queue/LEDGER.md` rows `PML-0001..PML-0016` are `pending` | open | Not applicable | Ledger-only protocol; no edit is due until triage. |
