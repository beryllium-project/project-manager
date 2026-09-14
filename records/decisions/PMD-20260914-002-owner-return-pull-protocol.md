# owner return pull protocol

- **Record ID:** `PMD-20260914-002`
- **Created:** 2026-09-14
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether component agents should write next steps and completion reports
directly into the Project Manager repository, and how the Project Manager and
component owners should exchange durable work state without creating a second
task system or weakening repository ownership. The review follows the
owner-return relay recorded at Project Manager commit `089ce87`, XRV commits
`706e708` and `d618935`, and analysis-workbook commit `62ee356`.

## Inputs

- `HANDOFF.md` at `089ce87`: a responsible-human relay can preserve an owner
  return durably, but it still requires a later Project Manager turn to
  verify evidence and reconcile requests, ledgers, cards, and the registry.
- `../xrv-research-repo/HANDOFF.md`, `COLLAB.md`, and `review-log.md` at
  `d618935`: the component-owned handoff and records contain the durable
  owner result, exact evidence, next work, and backup state.
- `../analysis-workbook/HANDOFF.md`,
  `outbox/collaboration-requests.md`, and `AGENT-INTERFACE.md` at `62ee356`:
  a component can mirror Project Manager coordination while keeping the
  authoritative record and write boundary explicit.
- `outbox/component-requests.md`, `components/*.md`, and
  `outbox/OWNER-RUNBOOK.md` at pre-decision `089ce87`: the Project Manager
  already has durable outbound requests, per-component context, priorities,
  and exact owner steps.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md`: component
  agents and the Project Manager do not receive blanket cross-repository write
  access.

## Disposition

Adopt a **pull-based owner-return protocol** using the existing repositories
and artifacts.

1. **Component to Project Manager.** A component owner records a
   `## Project Manager return` section in that component's own handoff
   document, using the path recorded in its Project Manager component card,
   when completing, partially completing, or blocking a `PMR-NNN` or
   `PML-NNNN` action. Each return names:
   - the related request or ledger identifiers;
   - result state: `completed`, `partial`, `blocked`, or `information`;
   - exact component commit and paths;
   - validation performed and known failures;
   - current branch, upstream, ahead/behind, and push or backup state; and
   - the exact Project Manager action requested.
   The component commit is authoritative evidence. A user-supplied note in
   the Project Manager handoff may relay the result, as `089ce87` did, but is
   not itself request closure.
2. **Project Manager startup.** After topology and status inspection, the
   Project Manager checks every component whose HEAD differs from
   `../COMPONENTS.md` and every component named by an open `PMR-NNN`. It
   reads the component handoff and relevant outbox/interface documents,
   verifies the named commit and current files read-only, then reconciles
   requests, ledgers, cards, the handoff, and the registry. An unverified
   return remains reported, not closed.
3. **Project Manager to component.** The authoritative outbound surfaces
   remain `outbox/component-requests.md`, the matching file under
   `components/`, and
   `outbox/OWNER-RUNBOOK.md`. Before beginning owner work, a component agent
   is given its open request rows and card. The Project Manager does not write
   a component inbox and a component agent does not write the Project Manager
   repository.
4. **Acknowledgement.** Closing the related `PMR-NNN` with exact owner
   evidence is the Project Manager acknowledgement. If closure creates a
   separate downstream mirror or housekeeping action, the Project Manager
   opens a new request rather than extending or silently reusing the closed
   request.
5. **No new generic return queue yet.** Component handoffs plus exact request
   identifiers provide sufficient restartability at the current scale. A
   dedicated `outbox/pm-returns.md` and second ledger would duplicate state
   and add transition logic. Reconsider one only if returns can no longer be
   reliably identified from changed component HEADs and open request IDs.
6. **Repository write coordination lock.** Before writing any repository, the
   acting agent checks its current worktree and active-session signals. For a
   component, the Project Manager runs
   `scripts/inspect-components.sh state COMPONENT_NAME` and reads the current
   handoff; for its own repository and the parent it checks `git status`.
   User statements, owner-return notes, handoffs, dirty worktrees, and active
   session artifacts are all coordination locks. A clean worktree alone does
   not prove that no agent is active. When another session is active, the
   Project Manager waits or sends a request/return through the protocol; it
   does not write concurrently. Writing resumes only after an explicit
   handoff/completion or a fresh check establishes that the repository is
   available.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize component agents to write the Project
Manager repository, authorize the Project Manager to write a component
outside `PMD-20260904-003`, create automatic pushes, or make a component
handoff authoritative for another component. Owner commits, pushes,
integration, research disposition, and every human gate remain with their
existing owners. It also does not treat a clean worktree as a lock grant or
permit concurrent writes with an active owner session.

## Follow-up

- On each component's next owner-maintenance change, use
  `templates/owner-return.md` in the component's own handoff document; before
  starting the owner agent, provide the open rows for that component from
  `outbox/component-requests.md` and its card under `components/`.

## Provenance

- Written by the `project-manager` agent after reviewing the current
  coordination model and the verified `089ce87` owner-return flow. The user
  requested analysis and implementation of a durable bidirectional handoff
  process; when a structured choice could not be answered synchronously, the
  Project Manager selected the boundary-preserving pull protocol.
