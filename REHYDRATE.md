# Workspace rehydration

**Maintained by:** `project-manager`
**Contract:** `records/decisions/PMD-20261011-001-workspace-rehydration-contract.md`
**Last reviewed:** 2026-10-11 on the usual `l1` workstation (inventory and
commands reviewed; no clone or install was run to test them)

Git is the only transfer mechanism for Beryllium coordination state. Rebuild
a workstation from the repositories below plus the per-workstation steps in
this file. Never copy `~/.copilot` hooks, hook configuration, settings, or
session state between hosts: the governance installer renders host-specific
files from this repository, and copied files fail `check`. The responsible
human runs these commands. The Project Manager never clones or installs,
and pushes only on an explicit same-turn human confirmation. Current
branches, ahead/behind counts, and the exact workspace root are in
`../COMPONENTS.md`.

## 1. Prerequisites

- `git`, an authenticated `gh`, `jq`, `flock`, `sha256sum`, and the Copilot
  CLI. Credentials stay in the workstation's credential stores and are never
  written to any repository.
- Workspace root `/home/jmorris/src/beryllium-project`, as recorded in
  `../COMPONENTS.md`. The two CHERI repositories live beside it, under
  `../agentic-os-research/` relative to that root.

## 2. Coordination repositories

The parent's `main` tracks the canonical repository as remote `upstream`,
which `scripts/owner-actions.sh --only push_pm` expects. The personal fork
`jamorris_microsoft/beryllium-project`, kept as `origin` on `l1`, is not
needed.

```sh
mkdir -p /home/jmorris/src/beryllium-project
cd /home/jmorris/src/beryllium-project
gh repo clone beryllium-project/beryllium-project .
git remote rename origin upstream
gh repo clone beryllium-project/project-manager project-manager
```

## 3. Component repositories

Each component tracks remote `origin`. Inactive former remotes
(`msft-downstream`, `legacy-personal`, `legacy-backup`, `msft-inactive`,
`gim-inactive`) are historical references and are not restored. The
parent's tracked symlinks `cheri-riscv-notes` and
`cheri-hypervisor-research` already point to `../agentic-os-research/`.
Identities come from Project Manager records (component cards and the D0
inventory `PMD-20260914-004`), read-only Git configuration, and the
responsible human (analysis-workbook, 2026-10-11).

| Workspace entry | GitHub repository | Notes |
| --- | --- | --- |
| `beryllium-hypervisor/` | `beryllium-project/beryllium-hypervisor` | Carry-ineligible |
| `helium-te-poc/` | `beryllium-project/helium-te-poc-historical` | Carry-ineligible; identity as named in `outbox/pmr091-push.sh` |
| `formal-verification-research/` | `beryllium-project/formal-verification-research` | |
| `osr-claude/` | `agentic-os-research/os-security-research` | Ask-first owner; restricted sources are never cloned here |
| `provenance-review/` | `beryllium-project/provenance-review` | |
| `analysis-workbook/` | `beryllium-project/analysis-workbook` | Made private on 2026-10-11 (responsible-human report); split pending under `PMR-129`, see below |
| `threat-modeler/` | `beryllium-project/threat-modeler` | |
| `security-reviewer/` | `beryllium-project/security-reviewer` | |
| `../agentic-os-research/cheri-riscv-notes` | `agentic-os-research/cheri-riscv-notes` | Target of tracked symlink `cheri-riscv-notes` |
| `../agentic-os-research/cheri-hypervisor-research` | `agentic-os-research/cheri-hypervisor-research` | Target of tracked symlink `cheri-hypervisor-research` |

```sh
cd /home/jmorris/src/beryllium-project
for spec in \
    beryllium-hypervisor=beryllium-project/beryllium-hypervisor \
    helium-te-poc=beryllium-project/helium-te-poc-historical \
    formal-verification-research=beryllium-project/formal-verification-research \
    osr-claude=agentic-os-research/os-security-research \
    provenance-review=beryllium-project/provenance-review \
    analysis-workbook=beryllium-project/analysis-workbook \
    threat-modeler=beryllium-project/threat-modeler \
    security-reviewer=beryllium-project/security-reviewer \
    ../agentic-os-research/cheri-riscv-notes=agentic-os-research/cheri-riscv-notes \
    ../agentic-os-research/cheri-hypervisor-research=agentic-os-research/cheri-hypervisor-research
do
    gh repo clone "${spec#*=}" "${spec%%=*}"
done
```

Then switch each checkout to the branch that `../COMPONENTS.md` records for
it with `git -C <entry> switch <branch>`. On 2026-10-11 these were
`beryllium/k3-b7-bringup` (Beryllium), `for-review` (Helium),
`analysis/k3-a100-service-design-private` (analysis-workbook),
`docs/reconcile-project-status` (CHERI notes), and `main` elsewhere.
`scripts/owner-actions.sh` push steps name specific remotes in its target
table; recreate a remote it expects only on the responsible human's
direction.

Pending analysis-workbook split (`PMD-20261011-002`): until `PMR-129` is
verified, the identity in the table above holds. After it, the workbook's
`origin` is the private `beryllium-project/analysis-workbook-private`,
holding every branch, and remote `public` is
`beryllium-project/analysis-workbook`, holding `main` only, with its push
URL set to `DISABLED-PMR-129-publication-gate`. The Project Manager updates
the table and clone loop when it verifies the split.

## 4. Per-workstation Copilot setup

1. In the Copilot CLI:
   - Run `/config model claude-opus-5.5` to set the user default `model`.
   - Keep the user effort at `max` and the context tier at `long_context`
     (`effortLevel`, `contextTier`). Leave the plan-mode keys unset or equal
     to those values; `/settings unset planModel` removes a different plan
     model.
   - In `/subagents`, set the default and every per-agent model to
     `claude-opus-5.5`, with no other required model. `check` does not
     inspect these values.
2. Restore the user-level skill that `PMD-20260917-001` requires:

   ```sh
   cd /home/jmorris/src/beryllium-project/project-manager
   install -D -m 0644 user-assets/skills/cross-repo-collaboration/SKILL.md "$HOME/.copilot/skills/cross-repo-collaboration/SKILL.md"
   sha256sum "$HOME/.copilot/skills/cross-repo-collaboration/SKILL.md"
   ```

   The expected SHA-256 is
   `da583f99b0685afce6fdd641f26aca79839bf15ee6a94e138b87e8d701dc79f9`.
3. Install the governance hook after section 3, because `install` and
   `check` resolve every tracked parent symlink and stop if a CHERI clone is
   missing, and only while no other governed Copilot session is running
   (`PMD-20260930-003`):

   ```sh
   cd /home/jmorris/src/beryllium-project
   bash ./project-manager/scripts/beryllium-governance.sh install && bash ./project-manager/scripts/beryllium-governance.sh check
   ```

   `install` writes nothing until the session and plan settings it checks
   pass; it does not inspect `/subagents`. Until `check` passes, pass
   `claude-opus-5.5` / `max` / `long_context` explicitly on every task
   launch.

## 5. Project Manager restart

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/project-tasking.sh generate
bash ./scripts/project-tasking.sh check
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
```

Then start Copilot in `project-manager/` and select `/agent project-manager`.

## 6. State Git does not carry

| State | Location | How it is restored |
| --- | --- | --- |
| Unpushed commits and local-only branches | Every repository | A fresh clone lacks them. `../COMPONENTS.md` lists ahead counts and local-only commits. Back them up first: the Project Manager and parent with the human-run `bash ./scripts/owner-actions.sh --only push_pm`, which checks tips but not visibility (`beryllium-project/project-manager` stays public by the responsible human's decision, `PMD-20261012-001`, so that step publishes; default runs include it, and `--skip push_pm` omits it), and components under their owners' rules and a human push decision. |
| Retained Project Manager artifacts | `../files/` (ignored by the parent) | Restore from a backup if the responsible human keeps one (none is recorded in Project Manager records), and locate candidates with the human-run `bash ./scripts/owner-actions.sh --only files_search --files-search --files-root <dir>`. `PMD-20260906-002` and `PMD-20260912-002` hold the inventory; `PMD-20260916-004` records the selection. |
| Linked worktrees | `../worktrees/` and owner-chosen paths | Component-owned; the owner recreates them with `git worktree add`. Beryllium's current registrations are `PMR-127`. |
| Component-ignored data | For example analysis-workbook quarantine copies and XRV `review-inbox/` PDFs | Owner-managed under each component's rules. |
| OS-security restricted sources | Private `os-security-restricted-sources` | Manual responsible-human handling only; agents never access or copy them. |
| User-level Copilot state | `~/.copilot` (settings, hooks, sub-agent defaults, session state) | Section 4; never copied between hosts. |
| Generated and transient Project Manager files | `outbox/tasking/`, `scratch/`, `inbox/` | Tasking is regenerated in section 5; scratch logs and inbox drops are transient. |
| Credentials | `gh` and Git credential stores | Re-authenticate; never stored in a repository. |

## Keep current

Update this file in the same Project Manager commit whenever a repository is
added, removed, renamed, rehomed, or changes identity, a user-level asset is
added or changed, or a machine-local requirement changes
(`PMD-20261011-001`).
