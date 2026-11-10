# canonical workspace move to lx2 after rsync

- **Record ID:** `PMD-20261110-001`
- **Created:** 2026-11-10
- **Status:** recorded
- **Supersedes:** `PMD-20261025-001` (workstation status and its
  disposition 2 only)
- **Superseded by:** None

## Scope

Record the responsible human's move of the Beryllium workspace from the
`l1` workstation to the Fedora laptop `lx2` by rsync, re-resolve the
canonical workspace root, and state how later turns treat the `l1` copy and
machine-local Copilot and publication-gate state on `lx2`. This touches
only Project Manager artifacts and the Project Manager-owned parent-root
`SOT.md`, `COMPONENTS.md`, and `README.md`; no component is written.

Observed when recorded (maintained read-only `scripts/inspect-components.sh`
`status`, `registry-check`, and `state`, plus read-only listings,
2026-11-10T04:05:11Z to 04:10Z, root `/home/jmorris/src/beryllium-project`):

- `/etc/hostname` reads `lx2`. The workspace root is the same absolute path
  recorded for `l1`.
- The parent is on `main` at `9e6bc7c6301bdf82bfcdfca6439d90449d72fb73` and
  the Project Manager clean on `main` at
  `1b9f296c99b8d6634fad793003bb3397acc61eb3`, each 0 behind / 5 ahead,
  carrying the unpushed 132nd- to 136th-turn commits. The parent's only
  untracked entry is the unregistered `beryllium-cheri/`, as on `l1`.
- Both tracked symlinks are relative and resolve.
- All twelve registry rows match their live HEAD. Every component's branch,
  cleanliness, and ahead/behind counts equal the 136th-turn observation on
  `l1`, including the recorded dirt in formal verification (one untracked
  `inbox.txt`), OS-security (five entries), and XRV (thirteen entries).
  Branches, cleanliness, and ahead/behind counts are therefore unchanged;
  the worktree registrations below did change.
- The private parent `.publication-gate/` arrived; the gate's
  `validate-denylist` reads the denylist as valid.
- The user-level governance hook on `lx2` is the one the human installed on
  2026-10-23: its script's SHA-256 equals the repository source
  `scripts/beryllium-governance-hook.sh`, and its configuration names the
  current root. The Project Manager did not run `check`.
- The publication gate is **not installed** on `lx2`: no
  `~/.config/beryllium/publication-gate`, no `beryllium-publication-gate`
  user skill, and no scoped `core.hooksPath` in this repository. No global
  `core.hooksPath` is set, so the human-run `install` is not refused for
  that reason.
- The parent's ignored `files` link dangles on `lx2`; its session-state
  target is absent here. The five retained Beryllium session-state
  worktree registrations are no longer listed by `git worktree list`
  (their disposition, and whether `66eaa7f7` still exists, are unknown);
  the five repaired `worktrees/be-*` placements, the registered
  `worktrees/beryllium-hypervisor/m10` and `m10-plan` worktrees, and two
  build-directory worktrees are listed.

## Inputs

- Responsible-human statement on 2026-11-10 at about 04:05Z (2026-11-09,
  20:05 at UTC-8), exactly: `"we have rsyncd to lx2, record the move"`.
- Responsible-human structured answer `closed_continue_lx2` (about
  04:40Z): the Beryllium release session that was running on `l1` on
  2026-11-08 is closed, and Beryllium work, including the release,
  continues on `lx2`.
- `PMD-20261025-001` (return to `l1`), `PMD-20261023-001` (earlier move to
  `lx2`), `PMD-20261011-001` (rehydration contract and `REHYDRATE.md`),
  `PMD-20261108-001` (publication gate, per-workstation install), and
  `PMD-20261108-004` (Beryllium release outside the P0 hold, whose public
  pushes still pass the installed gate).
- `../SOT.md` agent rules: former workspace paths become noncanonical after
  relocation and are never recreated, copied, or recovered by an agent.

## Disposition

1. The canonical Beryllium workspace is `~/src/beryllium-project` on the
   Fedora laptop `lx2`, with exact root
   `/home/jmorris/src/beryllium-project` recorded in `../COMPONENTS.md`.
   `../SOT.md` records the status.
2. The `l1` copy is a former workspace location and is noncanonical.
   Later turns never start sessions, resolve tasking, compare, reconcile,
   sync, or recover work from it without a new named decision.
3. The transfer was a human-run rsync, outside the Git-only rehydration
   contract (`PMD-20261011-001`); its scope and options are unstated, and
   no action follows. The dangling `files` link is consistent with
   `~/.copilot` being excluded; the retained artifacts there remain on
   `l1` only, with no GitHub backup (`PMD-20261025-002`).
4. **The publication gate must be installed on `lx2` before any public
   push from `lx2`.** Every public push passes the installed gate
   (`PMD-20261108-001`); the `l1` install does not travel. This applies to
   the Beryllium release's public pushes (`PMD-20261108-004`), the
   threat-modeler fast-forward, and the Project Manager's own push.
   `owner-actions.sh` refuses public pushes until the install, but a direct
   `git push` from `lx2` has no gate hook until then. The install
   is the human-run `scripts/publication-gate-setup.sh install`; the
   Project Manager never runs it against real user configuration.
5. The `lx2` governance hook matches the repository source; until the
   human-run `check` passes on `lx2`, task launches pass
   `claude-opus-5.5` / `max` / `long_context` explicitly.
6. By the human's answer, the Beryllium release session on `l1` is closed
   and the release continues on `lx2`, after the gate install.
7. The 136th turn's unpushed Project Manager and parent commits travelled
   with the rsync; their pushes still need a new same-turn confirmation
   and, for the public Project Manager push, the installed gate.
8. The `l1` backup script `scratch/l1-backup-and-checks.sh` is written for
   `l1`; running it on `lx2` is not recommended until the gate is
   installed here, and it is never run on `l1`; its governance and CHERI
   checks then apply to `lx2`.
9. `SOT.md` changes its SHA-256, so generated tasking is regenerated after
   the Project Manager commit.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not push, change a remote or visibility, delete, archive,
or sync the `l1` copy, clone or recover anything, repair, move, or prune a
worktree, retarget a symlink, install the hook or the publication gate, or
edit user settings. It does not change the P0 hold, `PMR-139`, `PMR-140`, or
`PMD-20261108-004`, decide the CHERI notes history, or register
`beryllium-cheri/`. Every responsible-human gate remains as recorded.

## Follow-up

- The responsible human installs the publication gate on `lx2` with
  `bash /home/jmorris/src/beryllium-project/project-manager/scripts/publication-gate-setup.sh install`,
  then runs the read-only governance check
  `bash /home/jmorris/src/beryllium-project/project-manager/scripts/beryllium-governance.sh check`,
  and tells the Project Manager `done`.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statement and the maintained read-only inspection above.
