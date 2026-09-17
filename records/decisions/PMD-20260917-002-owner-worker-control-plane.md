# owner worker control plane

- **Record ID:** `PMD-20260917-002`
- **Created:** 2026-09-17
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether the Project Manager should invoke distinct component-local owner
workers and iterate with them directly, while preserving repository ownership,
durable PM requests/owner returns, guided human gates, and the Project
Manager's prohibition on general component writes. This record establishes
the minimum Project Manager control plane for a later two-component pilot; it
creates no component owner profile and modifies no component.

Observed state at 2026-09-17T18:20Z was exact against the registry: parent
`7be8535`, Project Manager `2773ac6`, Helium `1ab289c`, formal verification
`784be93`, OS-security `49fbfd6`, provenance-review `9bfbab3`,
analysis-workbook `c7cc0fa`, threat-modeler `c4126b6`, security-reviewer
`2e8d205`, Beryllium `7ecf8bd`, CHERI-RISC-V notes `9a4c5ef`, and XRV
`456c70b`.

## Inputs

- `records/decisions/PMD-20260914-002-owner-return-pull-protocol.md` at
  `2773ac6`: PM requests and component-owned handoff returns are already the
  durable bidirectional channel; no second return queue is needed.
- `records/decisions/PMD-20260915-002-guided-human-intake.md` at `2773ac6`:
  the Project Manager presents one short structured human question at a time.
- `records/decisions/PMD-20260915-008-component-tasking-startup-contract.md`
  and `scripts/project-tasking.sh` at `2773ac6`: generated tasking is bound to
  an exact PM commit/request blob and fails closed.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md` at
  `2773ac6`: direct PM component writes remain limited to three classes and
  exclude Helium and Beryllium.
- `records/decisions/PMD-20260916-001-project-wide-role-model-matrix.md` at
  `2773ac6`: owner orchestration uses `gpt-5.6-sol`; review/audit and deep
  security roles retain their recorded model boundaries.
- Responsible-human structured choices on 2026-09-17: dedicated hidden owner
  workers; automatic validated local commits; at most four owner workers with
  one writer per repository; automatic dispatch only for already-authorized
  ready work; one blocking PM-presented human question while other lanes
  continue; analysis-workbook/Beryllium pilot; owner-first execution with
  temporary carry fallback; and exact confirmed private fast-forward pushes
  where component policy permits.
- Responsible-human priority on 2026-09-17: finish repository
  reorganization/project-management work soon and return focus to hardware
  bring-up.

## Disposition

Adopt a minimum owner-worker control plane:

1. A component may later add one hidden profile named `COMPONENT-owner`
   with `disable-model-invocation: false`, `user-invocable: false`, no
   `ask_user`, and write/execute authority limited to that component's own
   repository and maintained policy. Existing direct user-facing
   orchestrators remain unchanged.
2. The Project Manager may invoke only an adopted owner profile for one exact
   directly assigned open PMR after independently verifying recorded
   authority and prerequisites, current tasking, expected component branch and
   HEAD, clean worktree, and no active writer. Priority alone never grants
   authority.
3. `scripts/project-tasking.sh dispatch COMPONENT PMR-NNN` emits one
   deterministic, read-only packet bound to component, request ID, PM commit,
   and request-table blob. It launches nothing, writes nothing, and rejects a
   closed, duplicated, malformed, stale, dirty, cross-named, or
   wrong-component request.
4. Live owner responses use `OWNER_AGENT_RESPONSE_V1` with states `progress`,
   `needs_human`, `completed`, `partial`, `blocked`, or `refused`. The live
   handle accelerates iteration only. Before pausing or returning, the owner
   records durable evidence in the existing component handoff when repository
   state permits.
5. An owner worker never calls `ask_user`. It returns one stable question,
   blocking reason, recommended answer, choices, exact scope, and explicit
   authorization/non-authorization boundaries. The Project Manager validates
   that untrusted response, presents one blocking form, and relays the exact
   answer. Other repositories may continue.
6. At most four owner workers may run concurrently, with no more than one
   writer or reserved PMR per repository. Dirty state, another active session,
   stale identity, authority ambiguity, prohibited operations, malformed
   responses, or repeated failure without new evidence stops that lane.
7. An owner worker may create validated local work and return commits under
   its component rules. A private fast-forward push requires a new exact
   same-turn human confirmation presented by the Project Manager, unchanged
   expected local/remote tips, and explicit component-policy permission.
8. Pilot later with analysis-workbook and Beryllium. First bootstrap and
   validate the analysis owner profile, prove native cross-directory
   discovery and isolation read-only, then bootstrap Beryllium. Failure stops
   for a guided fallback choice.
9. Owner-agent execution becomes the preferred component-write path during
   rollout. The existing three-class standing carry authority remains only a
   temporary fallback until a later responsible-human retain/narrow/supersede
   decision.
10. Keep v1 small: no historical request-table migration, generic dispatch or
    return queue, execution ledger, daemon, lease database, broad parser,
    automatic dependency inference, or general Git automation.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, or hardware validation. It creates
no owner worker, proves no cross-directory discovery or isolation, dispatches
no current PMR, modifies no component, authorizes no push, retires no carry
authority, and grants no implementation or source-admission authority.

Force, destructive history changes, tags, public pushes, remote creation or
mutation, publication, and release remain outside this control plane.
Beryllium remains accepted through R7; R8-C acceptance is plan text only,
candidate `6e93461` remains blocked and unaccepted, H1-H4 remain unauthorized,
and K3 is `NOT RUN`.

## Follow-up

- Raise and carry a dedicated analysis-workbook owner-bootstrap request, then
  prove the hidden owner profile through a read-only native invocation before
  any Beryllium bootstrap.

## Provenance

- Written by the `project-manager` agent from the inputs and responsible-human
  choices above. Two read-only `gpt-5.6-sol` / `max` / `long_context` design
  lanes separately assessed the minimal tasking and governance changes; they
  modified no repository.
