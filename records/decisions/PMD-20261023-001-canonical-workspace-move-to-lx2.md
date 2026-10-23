# canonical workspace move to lx2

- **Record ID:** `PMD-20261023-001`
- **Created:** 2026-10-23
- **Status:** recorded
- **Supersedes:** `PMD-20261010-001` (workstation status only)
- **Superseded by:** None

## Scope

Record the responsible human's relocation of the Beryllium workspace to the
Fedora laptop `lx2`, re-resolve the canonical workspace root, and state how
later turns treat the `l1` copy, the unmatched CHERI-RISC-V notes checkout,
and machine-local Copilot state on `lx2`. This touches only Project Manager
artifacts and the Project Manager-owned parent-root `SOT.md`,
`COMPONENTS.md`, and `README.md`; no component is written.

Observed when recorded (maintained read-only `scripts/inspect-components.sh`
`status`, `registry-check`, `quiescence`, and `refs`, 2026-10-23T03:14:58Z
to 03:16Z, root `/home/jmorris/src/beryllium-project`):

- The host reports name `lx2`, a Fedora Linux 44 laptop. The workspace root
  is the same absolute path recorded for `l1`. The earlier `lx2` location
  `~/src/l1/src` is absent.
- The parent is clean on `main` at
  `6639e863acea950df0409a7297e9736b48f39287` and the Project Manager clean
  on `main` at `e3c8e1049e449adc6ea940ac81ede33d1a4048b3`, each 0 behind /
  0 ahead of its remote-tracking ref. Live authenticated `git ls-remote`
  shows only `HEAD` and `refs/heads/main` on each remote, at exactly those
  commits, with no tag. This verifies the 126th-turn push. Neither
  repository has a linked worktree.
- Both tracked symlinks are relative and resolve.
- Helium `f928aac`, formal verification `388690d`, OS-security `86645d4`,
  provenance `9bfbab3`, threat-modeler `aba3350` (0 behind / 6 ahead),
  security-reviewer `c2edac7` (0 / 2), and XRV `7361de4` (0 / 1, dirty only
  with the same two untracked `review-inbox/*.pdf` files) match the
  registry.
- Beryllium and analysis-workbook drifted; their own records explain the
  new commits (`../COMPONENTS.md`).
- CHERI-RISC-V notes does not match. Its symlink target holds only `main`
  at `888f658a9d3c428543d3306ce3eae9de0742562b`, 0 / 0 against its only
  remote-tracking ref `origin/main`. The working-tree files are dated
  2026-10-21, and `meta/handoff.md` reads "As of: 2026-10-20". Maintained
  ref checks find none of the recorded commits: `main` `6553092`, local
  `docs/reconcile-project-status` tip `7f67154`, its remote-tracking tip
  `34a8b50`, `PMR-114` work `8d1bc9d` and return `7fb49f4`, `PMR-104` work
  `41e4125` and return `4deec95`, `ae09213`, `9a4c5ef`, and `cd7dc81`. The
  checkout has no `.github/copilot-instructions.md` or Project Manager
  tasking startup, and its `meta/decisions.md` records D5 licensing (CC BY
  4.0 for prose, MIT for code) as adopted.
- The other checkouts carry local-only branches, inactive-remote tracking
  refs, XRV's untracked files, the parent's ignored `files` link, and the
  repo-local credential helper entries in the parent and Project Manager.
  The Project Manager infers a file-level copy of the `l1` workspace; the
  human did not state the transfer method.
- The parent's ignored `files` link dangles on `lx2`: its session-state
  target is absent.
- Beryllium's seven linked worktrees repaired on `l1` under `PMR-127`
  resolve clean, because the root path is unchanged. The directories of the
  five retained session-state registrations exist on `lx2`, so Git does not
  report them prunable, but `git status` fails in each because its link
  names the former `lx2` root.
- A read-only listing of user-level Copilot assets on `lx2` finds the
  governance hook script and configuration installed on 2026-10-01. The
  configuration binds `BERYLLIUM_PARENT_ROOT` to
  `~/src/l1/src/beryllium-project` and both tracked targets to
  paths under `~/src/l1/src/agentic-os-research/`; all are
  absent. That script denies `task` and `run_dynamic_workflow` inside a
  canonical workspace whose configured root is unusable. The retired
  `beryllium-scope-review` agent and `beryllium-scope-management` skill
  files are present, and `cross-repo-collaboration` is absent. Settings
  were not inspected, and `check` was not run. This turn's `pm-auditor`
  launch, with explicit `claude-opus-5.5` / `max` / `long_context`, was
  refused by that hook with exactly
  `Beryllium governance configuration is broken: BERYLLIUM_PARENT_ROOT is unset or unusable inside canonical workspace /home/jmorris/src/beryllium-project.`

## Inputs

- Responsible-human statement at 2026-10-23T03:13Z, exactly: `"we've
  relocated to the laptop again, please rehydrate as appropriate"`.
- Responsible-human answer `unresolved` to the structured question on the
  CHERI notes checkout, selecting "Not sure yet: record as unresolved; I'll
  keep the l1 copy untouched (recommended)".
- `PMD-20261010-001` (return to `l1`), `PMD-20261011-001` (rehydration
  contract and `REHYDRATE.md`), `PMD-20260929-003` (earlier temporary `lx2`
  placement), `PMD-20260930-003` (reinstall safety), and
  `PMD-20261006-001` (single-model SOP).
- `../SOT.md` agent rules: former workspace paths become noncanonical after
  relocation and are never recreated, copied, or recovered.
- Component records read for drift: `component://beryllium-hypervisor/.github/copilot-instructions.md`
  at `882868b952b7921bd528555b7f20c908cb363eea`,
  `component://analysis-workbook/HANDOFF.md` at
  `10c777a6eebed7aca7efcfa622d7aabe645c891d`, and
  `component://cheri-riscv-notes/meta/handoff.md` at
  `888f658a9d3c428543d3306ce3eae9de0742562b`.

## Disposition

1. The canonical Beryllium workspace is `~/src/beryllium-project` on the
   Fedora laptop `lx2`, with exact root
   `/home/jmorris/src/beryllium-project` recorded in `../COMPONENTS.md`.
   The host comes from the observed host name and the human's statement.
   `../SOT.md` records the status.
2. The `l1` copy (`~/src/beryllium-project` and `~/src/agentic-os-research`
   on `l1`) is a former workspace location and is noncanonical. Later turns
   never start sessions, resolve tasking, compare, reconcile, sync, or
   recover work from it. The human keeps it untouched. It is the only known
   location of CHERI notes commits `8d1bc9d`, `7fb49f4`, and `7f67154`
   (the last is a Project Manager carry) and of the retained `../files`
   artifacts. Any later use of it needs a new named decision.
3. The CHERI notes checkout is unresolved. The registry records the `lx2`
   checkout as observed, not as the recorded repository's state. Until a
   named responsible-human decision resolves it, the Project Manager makes
   no carry there and allocates no request that depends on its history,
   and treats its records, including D5, as component-side, never as a
   gate. Starting a CHERI notes owner session on `lx2` before then is not
   recommended.
4. No tracked symlink is retargeted; both resolve.
5. Machine-local Copilot state on `lx2` follows `REHYDRATE.md` section 4,
   run by the human. Until `install && check` passes on `lx2`, the stale
   hook denies task launches inside the workspace. A session started before
   the install keeps its loaded hook configuration and environment
   (`PMD-20260930-003`), so a new session is needed afterwards. The
   Project Manager runs neither mode against real user configuration.
6. The 126th-turn push is verified, and its `"push all"` confirmation is
   consumed.
7. On `lx2`, the five retained Beryllium session-state registrations are
   not prunable while their directories exist. A Beryllium owner could
   reconnect them with `git worktree repair`; whether to do that, lock
   them, or let them go remains the responsible human's choice, and no
   request is allocated.
8. `SOT.md` changes its SHA-256, so generated tasking is regenerated after
   the Project Manager commit.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not push, change a remote, delete or archive the `l1`
copy, clone or recover anything, repair or move a worktree, retarget a
symlink, install the hook, or edit user settings. It does not decide the
CHERI notes repository's canonical history, the fate of its unpushed
commits, or its licensing, redistribution, or publication. It does not
reconcile Beryllium's component-side acceptances and directions (B0-B7,
S1, S2, and S3) or its owner-recorded `claude-fable-5.1` session, decide
the workbook DASICS branch's disposition, or route PMQ-037..048. Every
responsible-human gate remains as recorded.

## Follow-up

- The responsible human completes `REHYDRATE.md` section 4 on `lx2`: the
  model settings, the `cross-repo-collaboration` skill, then `install &&
  check` from `/home/jmorris/src/beryllium-project` with no other Copilot
  session running. Then a new Project Manager session runs the deferred
  `pm-auditor` pass.
- When ready, the responsible human resolves the CHERI notes checkout in a
  named decision; meanwhile the `l1` copy stays untouched.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statements and the maintained read-only inspection above.
