# workspace rehydration contract

- **Record ID:** `PMD-20261011-001`
- **Created:** 2026-10-11
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** `PMD-20261011-003` for the follow-up backup step
  (`owner-actions.sh --only push_pm`) only, while
  `beryllium-project/project-manager` is public

## Scope

Make the Beryllium repositories sufficient to check out and rehydrate a
workstation, and fix how machine-local Copilot state is restored. This
touches Project Manager artifacts and the Project Manager-owned parent-root
`SOT.md`, `COMPONENTS.md`, `README.md`, and `.github/copilot-instructions.md`;
no component is written.

Observed when recorded (2026-10-11, on `l1`):

- The responsible human's run of `scripts/beryllium-governance.sh check`
  reported four failures: user `model` not `claude-opus-5.5`, plan model
  default or fallback not `claude-opus-5.5`, and the governance hook and its
  configuration absent. Hook-disable settings, session and plan effort
  `max`, session and plan context `long_context`, and the absence of the
  retired scope assets passed.
- `~/.copilot/skills/` holds only `cross-repo-collaboration` (one
  `SKILL.md`, SHA-256
  `da583f99b0685afce6fdd641f26aca79839bf15ee6a94e138b87e8d701dc79f9`), which
  `PMD-20260917-001` requires and no repository carried; `~/.copilot/agents/`
  and `~/.copilot/hooks/` are empty.
- The installer renders the hook configuration from the current workspace
  root (`BERYLLIUM_PARENT_ROOT`) and the resolved tracked-symlink targets,
  and `check` compares the hook and configuration SHA-256 with freshly
  rendered expectations.
- Project Manager records already named the GitHub identity of every
  repository except the parent, the Project Manager, Helium (named only in
  `outbox/pmr091-push.sh`), and analysis-workbook. Read-only Git
  configuration gives the parent `upstream` `beryllium-project/beryllium-project`
  (its `origin` is the `jamorris_microsoft/beryllium-project` fork) and the
  Project Manager `origin` `beryllium-project/project-manager`.
- The parent `.gitignore` keeps `/files` and `/be-k3-h0-collection.tgz`
  outside Git; `../files` is present and the archive is absent.

## Inputs

- Responsible-human statements on 2026-10-11, exactly: `"I can provide the
  missing copilot files from lx2, give me a script to run there"`, `"also,
  ensure all required information is stored inside the repo so it can be
  checked out and rehydrated"`, and `"fyi, I just made it private as it has
  a private branch, need to resolve that"`.
- The human's pasted `check` output above, and the human's `lx2`
  `git remote show origin` output for analysis-workbook, naming
  `beryllium-project/analysis-workbook` with remote branches `main` and
  `analysis/k3-a100-service-design-private` tracked and up to date.
- `scripts/beryllium-governance.sh` (`render_hook_config`,
  `check_settings`, `check_regular_copy`).
- `PMD-20261006-001`, `PMD-20260930-003`, `PMD-20260917-001`, and
  `PMD-20261010-001`.
- `PMD-20260906-002`, `PMD-20260912-002`, and `PMD-20260916-004` for the
  retained artifacts under `../files`.

## Disposition

1. Git is the only transfer mechanism for Beryllium coordination state. A
   workstation is rebuilt from the repositories and `REHYDRATE.md`;
   machine-local Copilot state is regenerated per workstation and never
   copied between hosts. Copied `lx2` hook files would fail `check`, and
   because their configuration names a root absent on `l1`, the hook would
   refuse every task launch inside the workspace.
2. `REHYDRATE.md` in the Project Manager repository is the maintained
   procedure and inventory: repository identities and remote names, clone
   layout, machine-local Copilot settings, user-level assets, the governance
   install, Project Manager restart, and the state Git does not carry.
   Volatile branch tips stay in `../COMPONENTS.md`.
3. The Project Manager repository carries a byte-identical copy of the
   user-level `cross-repo-collaboration` skill at
   `user-assets/skills/cross-repo-collaboration/SKILL.md`, outside every
   discovered skill path. Restoring it is a documented human step; the
   governance installer's scope stays the hook and its configuration
   (`PMD-20261006-001`).
4. The responsible human sets user settings (`/config model`,
   `/subagents`). The installer never edits them, and `check` verifies the
   session and plan keys but not sub-agent defaults.
5. Only a push makes committed work reachable from a fresh checkout.
   Unpushed commits, the retained `../files` artifacts, component-ignored
   data, OS-security restricted sources, linked worktrees, and credentials
   are listed as state Git does not carry; backups and pushes remain
   responsible-human decisions under existing records.
6. Keep-current rule: update `REHYDRATE.md` in the same Project Manager
   commit whenever a repository is added, removed, renamed, rehomed, or
   changes identity, a user-level asset is added or changed, or a
   machine-local requirement changes.
7. Policy surfaces stop describing the `l1` hook state as a point-in-time
   unknown. They state that user-level hook state is per workstation, that
   `check` reports it and `install` renders it from this repository, and
   that `HANDOFF.md` records the current status.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not push, change a remote or repository visibility, edit
user settings, install the hook, widen the installer's scope, copy any
`~/.copilot` file from `lx2`, restore `../files`, decide where the
analysis-workbook private branch lives or whether its time on a then-public
repository needs follow-up, or change any component. Every
responsible-human gate remains as recorded.

## Follow-up

- The responsible human sets `/config model claude-opus-5.5` and
  `claude-opus-5.5` sub-agent defaults in Copilot, reruns `check`, and runs
  `install && check` from `/home/jmorris/src/beryllium-project` while no
  other governed session is running.
- The responsible human backs up the coordination repositories with the
  human-run `bash ./scripts/owner-actions.sh --only push_pm` from
  `project-manager/`, so that a fresh checkout carries this record.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statements and pasted outputs above and read-only inspection of Project
  Manager tooling, records, and user-level asset names.
