# Generated component tasking

- **Record ID:** `PMD-20260914-005`
- **Created:** 2026-09-14
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Define the generated Project Manager tasking-discovery contract whose
responsible-human approval is recorded by `PMD-20260914-003` and requested by
`PMR-048`. The contract must let a human
enter either a registered direct checkout or a tracked workspace symlink and
discover that component's open Project Manager requests without pasting
request details, copying mutable task state into a component, or displaying a
stale projection.

The implementation was prepared from Project Manager `9f6b662` and parent
`7d08336`. All registered component revisions matched `../COMPONENTS.md`;
`cheri-riscv-notes-repo` remained dirty and was not modified. No component
repository was written.

## Inputs

- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
  at `9f6b662`: records the responsible human's approval of generated PM-side
  per-component tasking views while
  preserving `outbox/component-requests.md` as authoritative.
- `outbox/component-requests.md` at `9f6b662`: `PMR-048` requires a direct
  checkout and real-symlink pilot, an as-of PM commit, and fail-closed stale
  or unreachable behavior.
- `records/decisions/PMD-20260914-002-owner-return-pull-protocol.md` at
  `9f6b662`: owner returns remain in component-owned handoffs; generated
  tasking is outbound discovery only.
- `scripts/inspect-components.sh status` observed 2026-09-14T23:25Z:
  canonical topology was unchanged; direct and symlink integration forms
  remained available for the pilot.

## Disposition

1. `outbox/component-requests.md` remains the sole authoritative mutable
   request surface.
2. `scripts/project-tasking.sh generate` produces one ignored local
   `outbox/tasking/{component}.md` view per registered component and for the
   Project Manager. Generation reads only the committed request table at the
   current Project Manager HEAD and refuses staged or unstaged request-table
   changes.
3. Every view records the exact full Project Manager commit and Git blob of
   `outbox/component-requests.md`. It contains only open requests assigned to
   that component, plus requests that explicitly cross-name it in the Request
   or Note field, ordered by priority and identifier.
4. From a direct checkout or tracked workspace symlink entry,
   `bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .`
   resolves the
   physical repository to its registered component name. It prints nothing
   unless the view's source commit equals current Project Manager HEAD, the
   request blob matches, and the authoritative table is clean.
5. Missing Project Manager state, an unregistered path, a missing view, a
   missing source commit, a dirty request table, a different request blob, or
   a newer PM commit is an error. The resolver never returns a
   success-shaped stale fallback.
6. Views are ignored and regenerated after each Project Manager commit. They
   are not committed component inputs, owner returns, or task-state mirrors.
7. Fixture validation covers component-name, direct-checkout, and real
   symlink-entry resolution; exact-owner and explicit cross-name inclusion;
   closed and other-owner exclusion; missing-view, dirty-table, and
   stale-commit refusal; regeneration; and current-view checking.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize a component write, execute component
content, notify an owner, close an owner request, or make an external
repository transition. `PMR-049` remains the human-verification gate for D0
unknowns and every external transition.

## Follow-up

- After the Project Manager commit containing this record, generate and check
  the ignored views:

  ```sh
  bash ./scripts/project-tasking.sh generate
  bash ./scripts/project-tasking.sh check
  ```

## Provenance

- Written by the `project-manager` agent from the inputs above and the
  responsible human's 2026-09-14 selection to proceed autonomously with
  `PMR-048` while leaving `PMR-049` open.
