# canonical workspace return to l1 after rsync

- **Record ID:** `PMD-20261025-001`
- **Created:** 2026-10-25
- **Status:** recorded
- **Supersedes:** `PMD-20261023-001` (workstation status and its
  disposition 2 only)
- **Superseded by:** None

## Scope

Record the responsible human's return of the Beryllium workspace from the
Fedora laptop `lx2` to the `l1` workstation by rsync, re-resolve the
canonical workspace root, and state how later turns treat the `lx2` copy,
the `l1` CHERI-RISC-V notes checkout, and machine-local Copilot state on
`l1`. This touches only Project Manager artifacts and the Project
Manager-owned parent-root `SOT.md`, `COMPONENTS.md`, and `README.md`; no
component is written.

Observed when recorded (maintained read-only `scripts/inspect-components.sh`
`status`, `registry-check`, `refs`, `state`, and `quiescence`,
2026-10-25T22:37:27Z to 22:49:25Z, root `/home/jmorris/src/beryllium-project`):

- `/etc/hostname` reads `l1.local`. The workspace root is the same
  absolute path recorded for `lx2`.
- The parent is clean on `main` at
  `a362829a9d199d7f0a3d8d60c29f943775cab445` and the Project Manager on
  `main` at `e4a4f8ba0720624ed4e7a22993abfcf78bf5b80e`, each 0 behind /
  2 ahead with the unpushed 127th- and 128th-turn commits. The Project
  Manager's only dirt is untracked `.github/copilot/settings.json`
  (`{"model": "claude-opus-5.5"}`) and an empty `settings.json.lock`,
  written by Copilot CLI rather than by the Project Manager; they stay
  untracked.
- Both tracked symlinks resolve.
- Helium `f928aac`, formal verification `388690d`, provenance `9bfbab3`,
  threat-modeler `aba3350` (0 behind / 6 ahead), security-reviewer
  `c2edac7` (0 / 2), CHERI notes `888f658`, and XRV `7361de4` (0 / 1) match
  the registry. Beryllium, OS-security, and analysis-workbook drifted; their
  own records explain the new commits (`../COMPONENTS.md`).
- XRV is dirty with 13 entries: four modified tracked files and nine
  untracked paths (licenses, a MkDocs wiki and its build configuration,
  tests, scripts, and a build-only workflow), with file times from
  2026-10-23T17:40Z to 17:56Z, after the 128th turn observed it on `lx2`.
  Its uncommitted handoff records an owner publication-preparation change
  set, states that no commit, push, remote write, or publication was
  performed, and keeps publication blocked on the owner's disclosure
  decision. The two `review-inbox/*.pdf` files are now ignored by Git.
- The CHERI notes checkout holds only `main` at `888f658`, 0 / 0 against
  `origin/main`. Its `packed-refs` lists only `main` and `origin/main` at
  `888f658`, `ORIG_HEAD` names `6553092`, `FETCH_HEAD` names `34a8b50`
  from the registered remote's `docs/reconcile-project-status`, the reflogs
  are empty, and the objects are one pack. Maintained ref checks find none
  of `6553092`, `7f67154`, `34a8b50`, `8d1bc9d`, `7fb49f4`, `41e4125`,
  `4deec95`, or `cd7dc81`. This matches the `lx2` checkout recorded by
  `PMD-20261023-001`.
- The parent's ignored `files` link resolves on `l1` (1,042 paths).
- The user-level hook configuration names the current root and both tracked
  targets. The installed hook script was modified at 2026-10-19T00:26:23Z,
  after the reported 2026-10-13 `l1` install and consistent with
  Beryllium's record of a hook model edit for one run and its restoration;
  the repository hook source last changed at `337b73b` (2026-10-06). The
  Project Manager did not run `check`.
- Beryllium's five retained session-state worktree registrations are
  prunable on `l1` because their directories are absent here; the five
  repaired `worktrees/be-*` placements and the two build-directory
  worktrees are present and clean.

## Inputs

- Responsible-human statements in this session on 2026-10-25, from about
  22:36Z, exactly: `"ok, we have just rsync'd from lx2 laptop after a few
  days travel, proceed with any actions required"`, then `"btw, I checked
  git status in several projects before the rsync"`, then `"everything
  important should be committed and pushed, gh is a backup"` (the last is
  recorded by `PMD-20261025-002`).
- `PMD-20261023-001` (move to `lx2`), `PMD-20261010-001` (earlier return to
  `l1`), `PMD-20261011-001` (rehydration contract and `REHYDRATE.md`),
  `PMD-20260930-003` (reinstall safety), and `PMD-20261006-001`
  (single-model SOP).
- `../SOT.md` agent rules: former workspace paths become noncanonical after
  relocation and are never recreated, copied, or recovered by an agent.
- Component records read for drift:
  `component://beryllium-hypervisor/.github/copilot-instructions.md` at
  `977dd4ee883bc3499a37523fb9345a59894f92b8`,
  `component://analysis-workbook/HANDOFF.md` at
  `add426446d343ac7aa895cb83633ca385b1a7ee3`,
  `component://osr-claude/HANDOFF.md` at
  `a6cd0def2a4f63b68ea2a1f3445e3052c93049a9`, and the uncommitted working
  tree of `component://cheri-hypervisor-research/HANDOFF.md` over
  `7361de4138ad733be46e8a72608a779d24ae488a`.

## Disposition

1. The canonical Beryllium workspace is `~/src/beryllium-project` on the
   `l1` workstation again, with exact root
   `/home/jmorris/src/beryllium-project` recorded in `../COMPONENTS.md`.
   The host comes from the observed host name and the human's statements.
   `../SOT.md` records the status.
2. The `lx2` copy is a former workspace location and is noncanonical.
   Later turns never start sessions, resolve tasking, compare, reconcile,
   sync, or recover work from it without a new named decision.
3. The transfer was a human-run rsync from `lx2`, outside the Git-only
   rehydration contract (`PMD-20261011-001`); no action follows. Its scope
   and options are unstated. XRV's change set, dated after the 128th
   turn's `lx2` observation, is consistent with the rsync having included
   `~/src/agentic-os-research`, and the prunable session-state
   registrations are consistent with it not having included `~/.copilot`.
   The human's pre-rsync `git status` check is recorded as stated; it names
   no project.
4. Disposition 2 of `PMD-20261023-001` ends. The `l1` copy is the canonical
   workspace again, and its CHERI notes checkout holds none of `8d1bc9d`,
   `7fb49f4`, or `7f67154`. No local copy of those three never-pushed
   commits is known on any workstation, so they are presumed lost unless
   the human holds another copy. They carried the `PMR-114` startup
   adoption and the `PMR-119` handoff wording, which a later request can
   re-raise once the checkout is resolved. Whether the remote still holds
   `34a8b50` and `cd7dc81` remains unknown; only the human-run read-only
   remote check answers it. The Project Manager infers no cause and never
   fetches, clones, or recovers.
5. The CHERI notes checkout stays unresolved under disposition 3 of
   `PMD-20261023-001`: no carry, no dependent request, and no reliance on
   its history, with its records treated as component-side.
6. The retained `../files` artifacts resolve on `l1`. They are outside Git
   and have no GitHub backup (`PMD-20261025-002`).
7. Machine-local Copilot state on `l1` follows `REHYDRATE.md` section 4.
   The `l1` install was reported done on 2026-10-13, is not independently
   verified, and its script was modified afterwards. Until the human-run
   `check` passes on `l1`, task launches pass `claude-opus-5.5` / `max` /
   `long_context` explicitly. A session started before any reinstall keeps
   its loaded configuration (`PMD-20260930-003`).
8. On `l1` the five retained Beryllium session-state registrations are
   prunable again. Pruning, repairing, locking, or releasing them remains
   the responsible human's choice; no request is allocated.
9. `SOT.md` changes its SHA-256, so generated tasking is regenerated after
   the Project Manager commit.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not delete, archive, or sync the `lx2` copy, clone or
recover anything, repair, move, or prune a worktree, retarget a symlink,
install the hook, or edit user settings. It does not decide the CHERI notes
repository's canonical history, the fate of its lost commits, or its
licensing, redistribution, or publication. It does not decide XRV's
disclosure, history treatment, commit, or publication. It does not
reconcile Beryllium's component-side acceptances and directions (B0-B7, S1,
S2, the S3 MVP plan, the M0 plan, and plan revisions M0-A to M0-C) or its
owner-recorded `claude-fable-5.1` sessions. Every responsible-human gate
remains as recorded.

## Follow-up

- The responsible human runs
  `bash /home/jmorris/src/beryllium-project/project-manager/scratch/l1-backup-and-checks.sh`:
  the read-only governance `check` and CHERI notes remote check, then the
  backup pushes of `PMD-20261025-002`.
- When ready, the responsible human resolves the CHERI notes checkout in a
  named decision.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statements and the maintained read-only inspection above.
