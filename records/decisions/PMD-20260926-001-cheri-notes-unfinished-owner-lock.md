# cheri notes unfinished owner lock

- **Record ID:** `PMD-20260926-001`
- **Created:** 2026-09-26
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record how the Project Manager treats the dirty CHERI-RISC-V notes checkout
after the responsible human reported that a session was complete "up to
PMR-009" and maintained inspection found later uncommitted work.

The component remains on `docs/reconcile-project-status` at exact PMR-009
return `6cb15e3a6931a9d3f3c6a0f7884246c869151895`, but thirteen tracked
research/status paths are modified. This record resolves only the
coordination lock and owner-session sequencing.

## Inputs

- `../cheri-riscv-notes/meta/handoff.md` at
  `6cb15e3a6931a9d3f3c6a0f7884246c869151895`: the durable PMR-009 owner
  return, released historical reservation, and explicit exclusions for
  PMR-093, push, publication, licensing, merge, and other requests.
- Maintained `scripts/inspect-components.sh state cheri-riscv-notes` output
  at 2026-09-26T00:11:47Z: dirty `docs/reconcile-project-status`, behind 0 /
  ahead 7 of last-fetched `origin/docs/reconcile-project-status`, with
  modified `meta/roadmap.md`, `meta/status.md`, three `references/` files,
  six `sok/` files, and two `wiki/` files.
- Responsible-human structured response on 2026-09-25: classify the current
  thirteen-file state as `unfinished`, rather than completed owner work or
  unrelated local edits.

## Disposition

Treat the existing CHERI-RISC-V notes owner session as active and unfinished.
Preserve its worktree in place and start no new writer or owner launcher.

PMR-009 remains closed at work `e95922f` and return `6cb15e3`; it must not be
rerun or silently expanded to cover the current changes. Open backup-only
PMR-093 and PMR-096 remain blocked until the existing owner validates its
actual scope, commits it or returns a precise blocked result, refreshes
`meta/handoff.md` with a structured return, releases its reservation, and
leaves the worktree clean.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not approve the dirty content, admit a source, resolve
D5, authorize a commit, merge, push, Pages, or publication, close PMR-093 or
PMR-096, or decide whether the current work should ultimately be retained.

## Follow-up

- Resume only the existing CHERI owner session. After it records a durable
  return and exits, verify from `project-manager/` with
  `bash ./scripts/inspect-components.sh state cheri-riscv-notes` before
  reconsidering PMR-093.

## Provenance

- Written by the `project-manager` agent from the inputs above.
