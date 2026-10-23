# canonical workspace return to l1

- **Record ID:** `PMD-20261010-001`
- **Created:** 2026-10-10
- **Status:** recorded
- **Supersedes:** `PMD-20260929-003` (temporary-workstation status only)
- **Superseded by:** `PMD-20261023-001` (workstation status only)

## Scope

Record the responsible human's return from the temporary `lx2` placement,
re-resolve the canonical workspace root, and state how later turns treat the
former copy, the paused Beryllium inspection, absolute-path locators, and
machine-local user configuration. This touches only Project Manager
artifacts and the Project Manager-owned parent-root `SOT.md`,
`COMPONENTS.md`, `README.md`, and `.github/copilot-instructions.md`.

Observed when recorded (maintained read-only
`scripts/inspect-components.sh state` per entry plus `symlinks`,
2026-10-10T20:18Z, root `/home/jmorris/src/beryllium-project`):

- the parent was clean on `main` at
  `4f9635829d9d8eae64f50eaed7f0de2fa1ac74ee`, behind 0 / ahead 0 of
  `upstream/main`; its remote-tracking reflog records `update by push` to
  `4f96358` at 2026-10-09 15:14:54 -0700, a push the Project Manager did not
  perform;
- the Project Manager was clean on `main` at
  `337b73b07607b8f5d1edeb87f0d385ac1c9322ec`, behind 0 / ahead 19 of
  `origin/main`; neither it nor the parent has a linked worktree;
- both tracked symlinks are relative (`../agentic-os-research/...`) and
  resolve to Git roots at their recorded HEADs: CHERI notes `7f67154` and
  XRV `7361de4`;
- Helium `f928aac`, formal verification `388690d`, OS-security `86645d4`,
  provenance `9bfbab3`, threat-modeler `e6aed9f`, security-reviewer
  `c2edac7`, and CHERI notes match their recorded HEAD, branch, cleanliness,
  and ahead/behind counts; XRV matches and is still dirty only with the same
  two untracked `review-inbox/*.pdf` files;
- analysis-workbook is the only inspected drift: clean local branch
  `analysis/k3-a100-service-design-private` at
  `353c431969d2dcf616c7c3c56e5337f27d9fc141`, with no upstream, while local
  `main` remains at `4cf44d0`;
- generated tasking was current at `337b73b` before `SOT.md` changed; and
- `beryllium-hypervisor/` and its linked worktrees were not inspected (see
  Disposition 4 for one inadvertent text-search read).

## Inputs

- Responsible-human statement on 2026-10-10, exactly: `"we are back from
  travel, and transferred all files from ~/src/l1/src/ there to ~/src/
  here."`
- Responsible-human direction on 2026-10-10, exactly: `"leave
  beryllium-hypervisor repo alone for now"`.
- Responsible-human answer `l1` to the structured question naming this
  host: the usual `l1` workstation at Kozy Shack Lab.
- `PMD-20260929-003`: the temporary `lx2` record. It made the expected
  2026-10-09 return a review date and required explicit human confirmation
  before any host, path, or canonical-workspace switch.
- `../SOT.md` agent rules: former workspace paths become noncanonical after
  relocation and are never recreated, copied, or recovered.
- Project Manager commit `d3dcf8d`: the 2026-09-29 precedent that converted
  absolute old-root locators in durable records to workspace-relative or
  `component://` form.
- `scripts/beryllium-governance.sh`: the installed hook configuration binds
  the absolute `BERYLLIUM_PARENT_ROOT` that was current at install time.

## Disposition

1. The responsible human has confirmed the move. The canonical Beryllium
   workspace is `~/src/beryllium-project` on the usual `l1` workstation,
   with exact root `/home/jmorris/src/beryllium-project` recorded in
   `../COMPONENTS.md`. `../SOT.md` records the status.
2. The `lx2` copy under `~/src/l1/src` is a former workspace location and is
   noncanonical. Later turns never start sessions, resolve tasking, compare,
   reconcile, sync, or recover work from it. Keeping it as an inactive
   offline copy is the responsible human's choice; the Project Manager
   neither deletes nor relies on it.
3. No tracked symlink is retargeted: both are relative and resolve.
4. Beryllium inspection is paused by the responsible human's direction. This
   turn ran no Beryllium state inspection, Git command, request, or write,
   and therefore no `status`, `components`, `registry-check`, or
   `quiescence`, because each reads every registered HEAD. One inadvertent
   recursive Markdown text search over the whole parent tree, made while
   checking Project Manager wording, also read Markdown under
   `beryllium-hypervisor/`, `worktrees/`, and every other component
   checkout. If the ignored path `osr-claude/sources/restricted-microsoft/`
   exists on disk, its Markdown was scanned too; that is unknown, because
   checking would itself access the path. Only unrelated Beryllium glossary
   lines and their file paths appeared in the output, and nothing from those
   paths was used, copied, or recorded. Later parent searches use
   `git -C .. grep`, which covers only tracked parent files.
   Beryllium registry values remain the last
   2026-10-06 `lx2` observation and are unverified after the
   transfer. Git records linked-worktree locations as absolute paths by
   default, so the six `worktrees/be-*` placements repaired on `lx2`, and
   any other Beryllium linked worktree, may need owner-run repair. That is
   unverified.
5. Durable Project Manager records keep relocation-proof locators. The
   absolute old-root commands in `PMD-20261002-001`, `PMD-20261004-001`, and
   `PMD-20261006-001` become workspace-relative wording without changing
   their dispositions. User-facing initial `cd` commands use the new root,
   re-resolved as `PMD-20261002-001` requires.
6. User-level Copilot configuration is machine-local and was not part of the
   stated transfer. Its governance state on `l1` is unknown until the
   responsible human runs the read-only `check` from the new root. An
   install there binds the new root and still waits until governed sessions
   are idle (`PMD-20260930-003`). The Project Manager runs neither mode
   against real user configuration. Project Manager and parent policy
   surfaces state this plan in place of the 2026-10-06 "deferred while the
   Beryllium session is active" wording.
7. `SOT.md` changes its SHA-256, so generated tasking is regenerated after
   the Project Manager commit.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not release or inspect a Beryllium session, change a
Beryllium gate, decide the disposition of the analysis-workbook private
branch or the visibility of that repository's origin, push, change a remote,
delete or archive the `lx2` copy, repair or move a worktree, or retarget a
symlink. Every responsible-human gate remains as recorded.

## Follow-up

- From `/home/jmorris/src/beryllium-project`, the responsible human runs the
  read-only `bash ./project-manager/scripts/beryllium-governance.sh check`;
  `install` follows only while governed sessions are idle.
- When the responsible human lifts the Beryllium hold, the next Project
  Manager turn runs `bash ./scripts/inspect-components.sh status`,
  `registry-check`, and `quiescence` from `project-manager/` before relying
  on any Beryllium state.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statements and the maintained read-only inspection above.
