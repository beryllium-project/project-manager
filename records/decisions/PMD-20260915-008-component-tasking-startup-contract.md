# Component tasking startup contract

- **Record ID:** `PMD-20260915-008`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Make the human phrase `check Project Manager tasking` an explicit required
startup contract in every registered component owner context. This extends generated
tasking decision `PMD-20260914-005`: agents must invoke the fail-closed
resolver rather than search conversation/session history, task databases, or
background agents. It touches Project Manager configuration directly and
routes component-owned entry-point changes through `PMR-063..PMR-072`.

## Inputs

- `records/decisions/PMD-20260914-005-generated-component-tasking.md`:
  generated views and the resolver are implemented, exact-commit/blob bound,
  and fail closed, but the record does not require component agent entry
  points to recognize the natural-language phrase.
- `outbox/tasking/README.md` and `scripts/project-tasking.sh` at Project
  Manager `e5e17b1`: the exact logical-workspace-entry command is
  `bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .`.
- Responsible-human observation on 2026-09-15: a Beryllium ordinary Copilot
  session interpreted `check project manager taskings` as a request to search
  persisted session history and background agents; the user cancelled it.
- Responsible-human direction:
  `"these agents should know exactly how to check pm tasking, this one seems
  to not know yet"`.
- Read-only inventory of active component agent entry points: Project Manager
  documents the resolver, but analysis-workbook, threat-modeler,
  security-reviewer, provenance-review, and ordinary owner contexts do not
  map the phrase to it. Several orchestrators prohibit sibling-script
  execution unless explicitly allowed.

## Disposition

1. In every registered component owner context, the phrase
   `check Project Manager tasking` and obvious case/singular/plural variants
   mean: invoke the maintained resolver, validate its output, and present the
   current rows to the human.
2. From a registered logical workspace entry, invoke exactly:

   ```sh
   bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
   ```

   From the workspace root, invoke:

   ```sh
   bash ./project-manager/scripts/project-tasking.sh resolve COMPONENT_NAME
   ```

   Ask the human for the component when it is not explicit.
3. For a physical symlink-target working directory, use the resolver's
   `PM_TASKING_ROOT` and `PM_TASKING_WORKSPACE` environment inputs supplied by
   the human, or stop and request relaunch from the registered logical entry.
   Owners of the three tracked symlink components report `pwd` and `pwd -P`
   during adoption so the chosen invocation is evidenced.
4. A user-invocable orchestrator with an execution allowlist explicitly
   permits only this read-only Project Manager resolver for startup task
   discovery outside any analysis/review package. It is not target execution,
   needs no package `APPROVAL-NNN`, and does not use a component target-command
   runner. The exception grants no other sibling command.
5. If the resolver path is absent, the view is stale, the request table is
   dirty, or resolution fails, stop and tell the human to relaunch from the
   registered workspace entry or repair Project Manager tasking. Never search
   session history, a task/todo database, background agents, or prior chat as
   a fallback; never infer a PMR from memory.
   The Project Manager itself may read its authoritative
   `outbox/component-requests.md` directly while its own request table is
   intentionally dirty during a coordination turn; component owners may not
   use that exception.
6. Treat the resolver output as discovery over
   `outbox/component-requests.md`, not as authorization. Ask the human which
   row to perform when more than one is open, then follow component ownership
   and return rules.
   Generated rows include `Assigned to`, distinguishing directly assigned
   work from cross-named coordination rows.
7. Owner results continue through the component handoff contract in
   `PMD-20260914-002`.
8. Project Manager configuration and tests are updated directly.
   Component-owned agent definitions, instructions, and tests are routed as
   `PMR-063..PMR-072`, one request per registered component.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize a component task, permit arbitrary sibling
execution, make generated views authoritative over
`outbox/component-requests.md`, or allow an agent to select among multiple
open requests without human direction.

## Follow-up

- Complete `PMR-065` with `PMR-062` in the current security-reviewer owner
  maintenance session, then return the exact component commit and validation.

## Provenance

- Written by the `project-manager` agent from the responsible human's
  observed failed interaction and exact direction. The Project Manager did
  not inspect persisted session-history contents.
