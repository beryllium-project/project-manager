# Agent roster

How every Beryllium project agent is invoked, what it consumes and produces,
where it may write, and how it is validated. The Project Manager orchestrates
by handing the human these exact invocations and by reading each agent's
outputs; it never runs another agent's commands inside that agent's
repository.

Each agent component is an independent Git repository. Invoke an agent by
starting Copilot CLI in that directory and selecting the agent, or by loading
the directory with `/add-dir <directory>` from the parent root.

## Agent components

| Component | User-invocable agent | Write-disabled specialists | Skill | Durable output | Outbound queue | Write boundary |
| --- | --- | --- | --- | --- | --- | --- |
| `project-manager/` | `project-manager` | `pm-auditor` (read, search) | `beryllium-project-management` | `HANDOFF.md`, `components/`, `records/`, `queue/LEDGER.md`, `outbox/component-requests.md` | `outbox/component-requests.md` (to component owners) | Own repository plus Project Manager-owned parent-root artifacts |
| `analysis-workbook/` | `analysis-workbook` | `analysis-evidence` (read, search); `analysis-research` (read, search, web) | `beryllium-analysis` | `sessions/AWB-YYYYMMDD-NNN-*/`; generated `WORKBOOK.md` | `outbox/pm-queue.md` (`PMQ-NNN`) | Own repository only |
| `threat-modeler/` | `threat-modeler` | `threat-evidence` (read, search); `threat-research` (read, search, web); `threat-model-review` (read, search) | `beryllium-threat-modeling` | `models/TM-YYYYMMDD-NNN-*/`; generated `THREAT-MODELS.md` | `outbox/pm-queue.md` (`DISC-NNN`) | Own repository only |
| `provenance-review/` | `provenance-review` | `provenance-code-lineage` (read, search); `provenance-research` (read, search, web) | `provenance-analysis` | `reviews/PRV-YYYYMMDD-NNN-*/` with generated `html/` | none | Own repository only |

## Invocation and validation

Run each block from the named component directory.

### project-manager

```sh
cd project-manager
# Copilot CLI: /agent project-manager
bash ./scripts/inspect-components.sh status
bash ./scripts/pull-queues.sh check
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git diff --check
```

### analysis-workbook

```sh
cd analysis-workbook
# Copilot CLI: /agent analysis-workbook
bash ./tests/validate-agent.sh
bash ./scripts/validate-session.sh [--draft|--baseline <prior-copy>] sessions/AWB-YYYYMMDD-NNN-short-name
bash ./scripts/update-workbook.sh --check
git diff --check
```

A session begins in a planning phase and enters analysis only on explicit
confirmation. No component command runs unless the user approves that exact
command by name for the session.

### threat-modeler

```sh
cd threat-modeler
# Copilot CLI: /agent threat-modeler
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

The agent performs discovery and asks the user to choose `Review existing`,
`Review and draft successor`, `Create from evidence`, `Edit scope`, or
`Cancel` before allocating a package. Target execution is prohibited.

### provenance-review

```sh
cd provenance-review
# Copilot CLI: /agent provenance-review
bash ./tests/validate-agent.sh
bash ./scripts/validate-review.sh reviews/PRV-YYYYMMDD-NNN-short-name
python3 ./scripts/render-review.py --check reviews/PRV-YYYYMMDD-NNN-short-name
git diff --check
```

Reviews include a hyperlinked prior-art summary with a clear latest iteration.

## Components without a user-invocable agent

| Component | Local agent material | Maintained check surface | Who runs it |
| --- | --- | --- | --- |
| `helium-te-poc/` | skill `helium-documentation`; `.github/copilot-instructions.md`; `HANDOFF.md` | `./he check`, `./he test`, `./he fv-check`, `./he docs-check`, `./he evaluate` | Human or the Helium line's own agent session |
| `beryllium-repo` | skills `helium-documentation`, `human-review-summary`, `reviewable-turn-summary`; `.github/copilot-instructions.md`; `planning/HANDOFF.md` | `./be status`, `./be model-check`, `./be check`, `./be docs-check`, `./be evaluate` | Human or the Beryllium owner's agent session |
| `formal-verification-research/` | `COLLAB.md` guest protocol; `.github/copilot-instructions.md`; `HANDOFF.md` | none configured | Owner |
| `osr-claude/` | Claude skill `os-security-research`; `CLAUDE.md`; `HANDOFF.md` | `tools/md-to-html.sh --check` | Owner's Claude agent |
| `cheri-riscv-notes-repo` | none observed | `node automation/build-wiki.mjs ../wiki-build <owner>/<repo>` | Human |
| `xrv-research-repo` | `.github/copilot-instructions.md`; `HANDOFF.md`; `review-log.md` | none configured | Owner |

## Orchestration rules

- The Project Manager dispatches work by giving the human the exact
  invocation above and, when useful, a `PMR-NNN` request in
  `outbox/component-requests.md`. It never writes into a component's `inbox/`.
- Every sibling orchestrator is declared `disable-model-invocation: true`, so
  no agent can invoke another agent's orchestrator; the human starts each
  engagement.
- Agent outputs are evidence for coordination, never approval, acceptance,
  sign-off, publication, or release.
- When a sibling's agents, scripts, or interface documents change, update this
  roster and the matching `components/<component>.md` card in the same
  coordination turn.
