# contextual todo summary

- **Record ID:** `PMD-20260916-003`
- **Created:** 2026-09-16
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Make every Project Manager next-step recommendation show the responsible
human enough current todo context to choose among project work and priorities
outside the Project Manager's view. This record changes Project Manager
reporting only; it changes no component, request disposition, or human gate.

Observed state when recorded: Project Manager clean and synchronized at
`055deea`; parent clean and synchronized at `9266a93`; registered component
revisions exact; generated tasking current; queue ledger 31/31.

## Inputs

- Responsible-human direction on 2026-09-16:
  `"ok, when suggesting next step in project, please provide a brief summary
  table of current todos, with priority, blocking status, and human-focused
  description. i need to be able to make an informed contextual decision on
  what to do vs other things, which may be outside your view"`.
- `outbox/component-requests.md` at `055deea`: authoritative current request
  identifiers, priorities, dependencies, and owner notes.
- `HANDOFF.md` at `055deea`: restartable overall position, pending
  coordination, blockers, gates, and next action.
- `records/decisions/PMD-20260915-002-guided-human-intake.md` at `055deea`:
  the human is not a parsing engine and receives one short structured
  question at a time where appropriate.

## Disposition

1. Every Project Manager report that recommends a next project action includes
   a compact current-todo table immediately before that recommendation.
2. The table columns are **Priority**, **Request(s)**, **Blocking status**, and
   **Human-focused description**.
3. Blocking status is explicit and actionable: `ready`, `blocked by <request,
   owner response, input, or gate>`, `waiting on owner return`, or
   `deferred/non-blocking`. It names whether the next move belongs to the
   responsible human, a component owner, the Project Manager, or an external
   party.
4. Show every P1 and P2 request individually. P3/P4 requests may be grouped
   only when they share the same owner/context and blocking state; do not hide
   a materially different human choice inside a group.
5. Descriptions explain why a human might choose the work now, what it
   unblocks, and the principal boundary or cost. They avoid internal
   process-only shorthand.
6. The recommendation states why it is the best next action from the observed
   project state while explicitly acknowledging that the human may have
   external priorities the Project Manager cannot see.
7. `HANDOFF.md` carries the same compact table near "One recommended next
   action" so a restart after days away has the decision context.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, hardware validation, task authorization, or priority over work
outside the Project Manager's view. A recommendation remains advice; the
responsible human chooses what to do.

## Follow-up

- Apply this table to `HANDOFF.md` and every future next-step report.

## Provenance

- Written by the `project-manager` agent from the responsible-human direction
  above. No component or external repository was changed.
