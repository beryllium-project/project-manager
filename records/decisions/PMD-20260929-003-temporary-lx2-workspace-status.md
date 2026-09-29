# temporary lx2 workspace status

- **Record ID:** `PMD-20260929-003`
- **Created:** 2026-09-29
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's temporary workstation relocation, identify the
existing project-wide status anchor, and defer any child-repository startup
change until the whole project is positively quiescent.

Observed when recorded:

- the parent coordination repository was clean on `main` at
  `30955a6be44f6aa422a155a861975e92358aeecb`, behind zero / ahead nineteen;
- the Project Manager was clean on `main` at
  `7e898c6920fb3c3dcb60c8e8c287feee804402dd`, behind zero / ahead seven;
- the registry matched every registered component HEAD;
- `beryllium-hypervisor` remained at synchronized
  `3467bc6d22360091d2cf89c88ec40d56019ebd24` but had 138 changed entries,
  and the responsible human reported another session running; and
- every other registered component worktree reported clean, while the queue
  ledger remained exact at 34 source rows / 34 ledger rows.

## Inputs

- Responsible-human direction on 2026-09-29: the project is temporarily
  rehomed from the `l1` workstation at Kozy Shack Lab to the Fedora `lx2`
  laptop while the human is in Europe; repositories on `lx2` are under
  `~/src/l1/src` rather than `~/src`; expected return is 2026-10-09; no child
  repository is to be updated while the other session is running; and a P2
  startup-status rollout must wait for full project quiescence.
- `../SOT.md` and `../COMPONENTS.md`: the existing canonical topology contract
  and exact current workstation root. `SOT.md` is suitable as the global
  topology and temporary-workstation status anchor; a second status file is
  not currently necessary.
- `PMD-20260915-008`: existing fail-closed Project Manager tasking startup
  contract, which can carry a future global-status check without relying on
  session history or memory.
- `scripts/inspect-components.sh status` and
  `scripts/inspect-components.sh state beryllium-hypervisor` at
  `2026-09-29T10:11:23Z` / `2026-09-29T10:13:01Z`: current repository state
  and the active dirty Beryllium lock.
- A same-turn maintained refresh at `2026-09-29T10:26:12Z`: the other session
  advanced Beryllium to clean local commit
  `2b404ca31a07e1a0783a44183d0b2de95d053618`, behind zero / ahead one of
  last-fetched `origin`. The responsible human has not released the reported
  session, so the clean tree does not establish quiescence.
- Final same-turn maintained state/ref inspection at
  `2026-09-29T10:37:59Z` / `2026-09-29T10:38:26Z`: local and last-fetched
  `origin/beryllium/single-hart-runtime-r0` both contain exact `2b404ca`,
  behind zero / ahead zero. No responsible-human release or authorization
  evidence for the observed remote-tracking advance was supplied to this
  Project Manager turn.
- `scripts/owner-session.sh`: maintained owner launches hold per-component
  writer reservations, but those reservations do not detect every possible
  direct CLI, desktop, or external agent session.

## Disposition

Record the temporary `lx2` placement now in the Project Manager-owned global
status anchor. The expected 2026-10-09 return is a review date, not an
automatic path, host, symlink, or canonical-workspace switch.

Open P2 `PMR-108` for the Project Manager-owned part of the startup rollout.
It is blocked while any project session remains active and does not authorize
any child-repository write. Its first implementation step must add and
validate a maintained, read-only, fail-closed quiescence check. That check
must require:

1. clean parent and Project Manager worktrees with current registry, queues,
   and generated tasking;
2. every registered component worktree clean and reachable, with no conflict
   or untracked state;
3. no held maintained owner-session, owner-recovery, or future global
   maintenance writer reservation;
4. no user statement, component handoff, owner return, or Project Manager
   runtime state reporting another active session;
5. a same-turn responsible-human confirmation that no non-instrumented CLI,
   desktop, background, or external agent session is active; and
6. an immediate recheck plus a global maintenance reservation before the
   first rollout write.

Automation alone cannot prove item 5. A clean worktree or an unheld maintained
lock is therefore necessary but not sufficient. The same-turn Beryllium
advance from dirty `3467bc6` to clean `2b404ca` demonstrates this boundary:
repository cleanliness changed, but the user-reported active-session lock did
not.

After that gate passes, `PMR-108` may update only Project Manager and allowed
parent-root startup/status tooling, inventory every registered owner context,
and allocate distinct component requests for child-owned startup changes.
Those later requests remain subject to each repository's own ownership,
validation, and one-writer rules.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not modify a child repository, release the current active
session, infer project quiescence, create a new workspace, move a checkout,
retarget a symlink, change a remote, push, tag, or switch canonical hosts on
2026-10-09.

The responsible-human quiescence confirmation remains open. Every component
startup change remains a later owner action or separately authorized carried
coordination write.

## Follow-up

- Leave `PMR-108` blocked while the reported session is active. After the
  responsible human confirms every project session is closed, resolve the
  request from `project-manager/` with:

  ```sh
  bash ./scripts/project-tasking.sh resolve project-manager
  ```

  Then implement the fail-closed quiescence check before allocating any child
  startup request.

## Provenance

- Written by the `project-manager` agent from the responsible-human direction
  and maintained read-only inspection above.
