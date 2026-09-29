# pmr105 private backup mechanism

- **Record ID:** `PMD-20260928-001`
- **Created:** 2026-09-28
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Select the bounded human-run mechanism for PMR-105's private backup of the
CHERI notes topic branch without creating an owner-agent launch path,
broadening the generic owner helper, or granting push authority.

Observed when recorded: Project Manager clean at
`520e26cb88b8de46912537359c9e18d4ccbc14c1` with generated request blob
`0902c185d8734474a460dbe2b80177e2ff3e1140`; CHERI notes clean on
`docs/reconcile-project-status` at
`34a8b508eb68f0b61b463bd0f75d55b348c844d1`, behind zero / ahead twelve of
last-fetched `origin/docs/reconcile-project-status`
`9a4c5effef3b87fc7529ec7ff265179ad1130d58`.

## Inputs

- Responsible-human implementation-plan choices:
  `execution_mechanism=dedicated_script`,
  `plan_scope=end_to_end_conditional`, and
  `github_identity_policy=active_verified`.
- `outbox/component-requests.md` at Project Manager `520e26c`: PMR-105 is
  open P2 and permits only a separately confirmed private fast-forward of
  `origin/docs/reconcile-project-status` from `9a4c5ef` to `34a8b50`.
- `records/decisions/PMD-20260927-005-close-pmr104-exact-integration.md`:
  PMR-104 is complete; PMR-105 is a distinct private-backup follow-up and
  receives no push authority from that closure.
- `../cheri-riscv-notes/meta/handoff.md` at `34a8b50`: the worktree is clean,
  PMR-104 must not be rerun, and PMR-105 remains blocked on a new exact
  responsible-human confirmation.
- `AGENT-ROSTER.md` at Project Manager `520e26c`: CHERI notes has no owner
  launch; the Project Manager must obtain the exact confirmation before a
  private fast-forward.
- `scripts/owner-actions.sh` at Project Manager `520e26c`: the generic helper
  has no CHERI target and is intentionally not broadened for this one exact
  push.

## Disposition

Implement one dedicated human-run `outbox/pmr105-push.sh` with two modes:

1. `--plan` performs a read-only, fail-closed inventory and writes a private
   UTC-stamped log under ignored Project Manager scratch.
2. `--execute` is handed to the responsible human only after a fresh
   same-turn exact confirmation. It reruns every check, pushes exactly one
   existing topic ref, verifies every other remote ref is unchanged, refreshes
   only that remote-tracking ref, and requires final clean 0/0 state.

The script uses the currently active GitHub account and never switches
accounts. It requires exact private target identity and `WRITE`, `MAINTAIN`,
or `ADMIN` permission, and the Project Manager binds that observed account
into the confirmation. Any account, permission, branch, tip, cleanliness,
tasking, writer-lock, visibility, or ref mismatch stops without fallback.

The script is an execution aid, not authority. The Project Manager never runs
it. The responsible human runs it and the Project Manager retrieves its log,
independently verifies the resulting state, and closes PMR-105 only on exact
evidence.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize the push, account switching, force or
force-with-lease, tags, mirrors, remote mutation, branch creation or deletion,
merge to `main`, Pages, visibility change, D5 resolution, redistribution,
sibling writes, or a reusable Git-maintainer/owner-agent path.

The exact same-turn responsible-human push confirmation remains open.

## Follow-up

- Validate and commit `outbox/pmr105-push.sh`, then have the responsible human
  run `bash ./outbox/pmr105-push.sh --plan` from `project-manager/`.

## Provenance

- Written by the `project-manager` agent from the inputs above and the
  responsible-human plan choices recorded in this session.
