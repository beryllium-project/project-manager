# pmr105 exact private fast forward authorized

- **Record ID:** `PMD-20260929-001`
- **Created:** 2026-09-29
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's exact single-use authorization for PMR-105's
private CHERI topic fast-forward after successful fail-closed preflight.

Observed when recorded: Project Manager clean at
`b4e551abf50f96dfb79fd04c20920a0db21392cf`; CHERI notes clean on
`docs/reconcile-project-status` at
`34a8b508eb68f0b61b463bd0f75d55b348c844d1`, tracking last-fetched
`origin/docs/reconcile-project-status`
`9a4c5effef3b87fc7529ec7ff265179ad1130d58`, behind zero / ahead twelve.

## Inputs

- Responsible-human statement on 2026-09-29:
  `"authorize PMR-105 exact private fast-forward"`.
- Ignored preflight log
  `scratch/owner-actions/pmr105-push-20260929T013100Z.log`: active account
  `xjamesmorris`, target `agentic-os-research/cheri-riscv-notes`,
  `PRIVATE`, `ADMIN`, branch `docs/reconcile-project-status`, exact
  `9a4c5ef... -> 34a8b50...`, three heads, zero tags, clean worktree, current
  tasking, writer lock held, and `no-remote-write=yes`.
- Maintained independent inspection at `2026-09-29T01:31:47Z`: local clean
  `34a8b50`, upstream tracking ref `9a4c5ef`, behind zero / ahead twelve.
- `PMD-20260928-001`: dedicated human-run mechanism, active-account
  verification, exact one-ref boundary, and all excluded operations.

## Disposition

Authorize exactly one responsible-human invocation of:

```sh
bash ./outbox/pmr105-push.sh --execute
```

from `project-manager/`, bound to all of:

- active GitHub account `xjamesmorris`;
- private repository `agentic-os-research/cheri-riscv-notes`;
- only `refs/heads/docs/reconcile-project-status`;
- remote predecessor
  `9a4c5effef3b87fc7529ec7ff265179ad1130d58`;
- local successor
  `34a8b508eb68f0b61b463bd0f75d55b348c844d1`.

The script must rerun every precondition, including exact account equality.
Any mismatch or nonzero exit stops without fallback or automatic retry. The
authorization is consumed by the one execution attempt.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize another attempt, force or
force-with-lease, tags, mirror, account switching, remote mutation, branch
creation/deletion, `main`, merge, Pages, publication, visibility change, D5,
redistribution, sibling writes, or a Project Manager/parent push.

PMR-105 remains open until the human-run log and independent inspection prove
exact remote containment, other-ref preservation, and final clean 0/0 state.

## Follow-up

- The responsible human runs
  `bash ./outbox/pmr105-push.sh --execute` once from `project-manager/`, then
  reports only that it returned; the Project Manager retrieves the printed
  ignored log and independently verifies closure evidence.

## Provenance

- Written by the `project-manager` agent from the inputs above and the exact
  responsible-human statement quoted above.
