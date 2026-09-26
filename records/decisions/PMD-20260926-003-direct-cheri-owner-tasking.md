# direct cheri owner tasking

- **Record ID:** `PMD-20260926-003`
- **Created:** 2026-09-26
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record how the Project Manager delivers exact next work directly to the
CHERI-RISC-V notes owner after the responsible human rejected acting as an
instruction relay.

The component is dirty on `docs/reconcile-project-status` at exact HEAD
`6cb15e3a6931a9d3f3c6a0f7884246c869151895`, with thirteen modified
research/status paths and no current structured return for them.

## Inputs

- Responsible-human direction on 2026-09-25:
  `"you should tell the cheri repo what is needed, not have me in the middle"`.
- `PMD-20260926-001`: the responsible human classified the current dirty
  state as `unfinished`; preserve it and treat it as a coordination lock.
- `../cheri-riscv-notes/.github/copilot-instructions.md` at `6cb15e3`: exact
  Project Manager tasking resolution is mandatory; when multiple rows
  resolve, the owner must stop for human selection.
- Maintained inspection at 2026-09-26T03:12:44Z: dirty HEAD `6cb15e3`,
  behind 0 / ahead 7 of last-fetched
  `origin/docs/reconcile-project-status`, with thirteen modified paths across
  `meta/`, `references/`, `sok/`, and `wiki/`.
- `scripts/project-tasking.sh`: generated component views are bound to the
  committed Project Manager HEAD and request-table blob; component dirtiness
  does not prevent read-only resolution.

## Disposition

Post P1 `PMR-101` as the one exact task for the current dirty owner context:
identify and justify the actual scope under the component's own rules,
validate it, commit locally with PMR-101 and the Copilot co-author trailer or
return a precise blocked result, append a structured return using
`templates/owner-return.md`, state active-session/reservation status, and
leave the worktree clean.

Withdraw backup-only `PMR-093` and `PMR-096`. Their old exact ranges remain
historical evidence, but no current owner should act on them while PMR-101 is
open. If backup is still needed after PMR-101 returns, allocate a new request
against the then-current clean branch. This makes PMR-101 the sole open row
for `cheri-riscv-notes`, so the owner does not require a human to choose among
multiple rows.

Delivery is pull-based. After the Project Manager commit and tasking
regeneration, the current CHERI owner context invokes its already-mapped
`check Project Manager tasking` phrase. The human does not copy, translate,
select, or relay a prompt, and no second owner launcher is used.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not establish that a CHERI owner session is currently
live, retroactively authorize the dirty content, grant D4 reference approval,
resolve D5, or authorize PMR-009, backup, push, merge, Pages, publication,
remote changes, or sibling writes. If component authority or provenance is
unclear, PMR-101 returns `blocked`.

## Follow-up

- Commit this Project Manager record and PMR-101, regenerate tasking, and
  verify `bash ./scripts/project-tasking.sh resolve cheri-riscv-notes` shows
  exactly one open row: PMR-101.

## Provenance

- Written by the `project-manager` agent from the inputs above.
