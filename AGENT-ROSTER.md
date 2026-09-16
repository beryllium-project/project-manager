# Agent roster

How every Beryllium project agent is invoked, what it consumes and produces,
where it may write, and how it is validated. The Project Manager orchestrates
by handing the human these exact invocations and by reading each agent's
outputs; it never runs another agent's commands inside that agent's
repository. Its only writes inside a component are carried requests in the
three classes of `records/decisions/PMD-20260904-003-standing-carry-authority.md`.

Each agent component is an independent Git repository. Invoke an agent by
starting Copilot CLI in that directory and selecting the agent, or by loading
the directory with `/add-dir <directory>` from the parent root.

Before owner work begins, provide the agent its current card under
`project-manager/components/` and every open row naming it in
`project-manager/outbox/component-requests.md`. When returning owner work, the agent uses `templates/owner-return.md` to add a
structured `Project Manager return` section to the component-owned handoff
document named by its card, with exact request IDs, commit and paths,
validation, backup state, and requested PM action. The Project Manager pulls
and verifies that return on startup; neither agent writes the other's
repository (`PMD-20260914-002`).

From a registered component's workspace entry, the owner can resolve current
Project Manager tasking without pasted request details:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

The generated view is discovery only and fails closed when its PM commit or
request-table snapshot is stale.

Every component owner entry point must map `check Project Manager tasking`
and obvious case/singular/plural variants to that exact command. Resolver
failure stops; agents never search session history, task/todo databases,
background agents, prior chat, or memory for a PMR fallback
(`PMD-20260915-008`). Component-owner adoption is tracked by
`PMR-063..PMR-072`.

For allow-listed orchestrators, this resolver is startup discovery outside an
analysis, threat-model, provenance, or security-review package. It is not
target execution, needs no package approval record, and does not use a target
command runner. No other sibling command is permitted by this exception.

Before any listed agent writes, it checks the target repository's worktree
and active-session signals. User statements and handoffs can establish an
active session even when Git is clean; concurrent writes wait for an explicit
handoff.

Planned only: `PMR-073` requests a `git-maintainer` specialist invocable
exclusively by `project-manager`. Component agents may request Git service
through PM tasking/returns but may not invoke it. The specialist does not
exist until the request closes and must preserve all current Git and human
gates.

## Agent components

| Component | User-invocable agent | Write-disabled specialists | Skill | Durable output | Outbound queue | Write boundary |
| --- | --- | --- | --- | --- | --- | --- |
| `project-manager/` | `project-manager` (`gpt-5.6-sol`, `max`, `long_context` under project-wide matrix `PMD-20260916-001`) | `pm-auditor` (read, search; `claude-opus-5`, `max`, `long_context` under `PMD-20260916-001`, extending `PMD-20260915-007`) | `beryllium-project-management` | `HANDOFF.md`, `components/`, `records/`, `queue/LEDGER.md`, `outbox/component-requests.md` | `outbox/component-requests.md` (to component owners) | Own repository, Project Manager-owned parent-root artifacts, and carried requests in the three classes of `PMD-20260904-003` inside carry-eligible components (never `helium-te-poc/` or `beryllium-repo`) |
| `analysis-workbook/` | `analysis-workbook`; tasking startup adoption `PMR-063` | `analysis-evidence` (read, search); `analysis-research` (read, search, web) | `beryllium-analysis` | `sessions/AWB-YYYYMMDD-NNN-*/`; generated `WORKBOOK.md` | `outbox/pm-queue.md` (`PMQ-NNN`), read-only-tracked `outbox/helium-transfer-queue.md` (`HET-NNN`), and maintainer-mirrored `outbox/collaboration-requests.md` (`CRQ-NNN`) | Own repository only |
| `threat-modeler/` | `threat-modeler`; `threat-model-maintainer` for repository maintenance and explicitly authorized Git delivery; tasking startup adoption `PMR-064` | `threat-evidence` (read, search); `threat-research` (read, search, web); `threat-model-review` (read, search) | `beryllium-threat-modeling` | `models/TM-YYYYMMDD-NNN-*/`; generated `THREAT-MODELS.md` | `outbox/pm-queue.md` (`DISC-NNN`) | Own repository only |
| `security-reviewer/` | `security-reviewer` (observed `claude-opus-5` at `f2051a4`; `PMR-074` requests `gpt-5.3-codex` under `PMD-20260916-001`; `max`, `long_context`; tasking startup adopted at `f2051a4`) | `security-evidence`, `security-research`, `security-finding-review` (write-disabled; observed Opus 5 at `f2051a4`, `PMR-074` requests `gpt-5.3-codex`; `max` / `long_context`) | `beryllium-security-review` | `reviews/SR-YYYYMMDD-NNN-*/` (each with `review-manifest.json`), `syntheses/SRS-YYYYMMDD-NNN-*/`; generated `SECURITY-REVIEWS.md` | `outbox/pm-queue.md` (`SRQ-NNN`, kinds `source` and `owner-action`) | Own repository only; target execution remains approval-gated, while the PM resolver is separate startup discovery |
| `provenance-review/` | `provenance-review`; tasking startup adoption `PMR-066` | `provenance-code-lineage` (read, search); `provenance-research` (read, search, web) | `provenance-analysis` | `reviews/PRV-YYYYMMDD-NNN-*/` with generated `html/` | none | Own repository only |

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
bash ./scripts/validate-helium-transfer-queue.sh [--baseline <prior-copy>]   # before recording or mirroring a HET change
bash ./scripts/update-workbook.sh --check
git diff --check
```

A session begins in a planning phase and enters analysis only on explicit
confirmation. No component command runs unless the user approves that exact
command by name for the session.

Commit `4c771c0` adds a third `CRQ-NNN` collaboration-request interface;
owner commit `62ee356` makes the maintainer its status writer and mirrors
`CRQ-001` as `routed`. `PMD-20260914-001` keeps it read-only to the Project
Manager; `PMR-038` requests the completion mirror after verified XRV commit
`d618935`. Owner commit `2374115` mirrors `CRQ-001` as `completed`, adds
`CRQ-002`, and partially completes `PMR-038`.
`PMD-20260915-004` records successor-first handling for `CRQ-002`;
`PMR-052..PMR-054` are the three sequenced owner tasks and `PMR-055` is the
workbook's derived routed-status and stale-open-ID correction.
Owner commit `1ef1ac6` adds complete `AWB-20260915-001` and
`PMQ-027..030`; Project Manager carry `c7cc0fa` applies `PML-0030`.

### threat-modeler

```sh
cd threat-modeler
# Copilot CLI: /agent threat-modeler
# For repository maintenance or explicitly authorized commit/push:
# /agent threat-model-maintainer
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

The agent performs discovery and asks the user to choose `Review existing`,
`Review and draft successor`, `Create from evidence`, `Edit scope`, or
`Cancel` before allocating a package. Target execution is prohibited.
After `PMR-064`, the PM resolver is separate read-only startup discovery
outside a threat-model package, not target execution.

### security-reviewer

```sh
cd security-reviewer
# Copilot CLI: /agent security-reviewer
bash ./tests/validate-agent.sh
bash ./scripts/validate-security-review.sh [--draft|--baseline <prior-copy>] reviews/SR-YYYYMMDD-NNN-short-name
bash ./scripts/update-index.sh --check
git diff --check
```

The agent performs discovery and asks the user to choose `Independent
review`, `Synthesis`, `Edit scope`, or `Cancel` before allocating a package.
Target execution is prohibited except for commands the user approves by exact
command text in the session; each runs only through
`scripts/run-approved-command.sh` against an `APPROVAL-NNN` record and the
expected target commit, with evidence retained under the package and hashed
into `review-manifest.json`. A review package never reads another review
package for the same target; synthesis is the only multi-package mode. Its
contract derives from the Helium `agent-review/` artifacts at `9b3ff4e`
(`AUTHORS.md` in the component); Helium is unchanged.

After `PMR-065`, the PM resolver is separate startup discovery outside a
package, is not target execution, and uses neither `APPROVAL-NNN` nor
`scripts/run-approved-command.sh`.

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
| `helium-te-poc/` | skill `helium-documentation`; `.github/copilot-instructions.md`; `HANDOFF.md`; tasking startup adoption `PMR-068` | `./he check`, `./he test`, `./he fv-check`, `./he docs-check`, `./he evaluate` | Human or the Helium line's own agent session |
| `beryllium-repo` | On active/default branch `beryllium/single-hart-runtime-r0`: skills `helium-documentation`, `human-review-summary`, `reviewable-turn-summary`; `.github/copilot-instructions.md`; `planning/HANDOFF.md`; `PMR-057` closed; tasking startup adoption `PMR-067` | `./be status`, `./be model-check`, `./be check`, `./be docs-check`, `./be evaluate` | Human or an ordinary Copilot owner session; no user-invocable custom agent |
| `formal-verification-research/` | `COLLAB.md` guest protocol, `.github/copilot-instructions.md`, `HANDOFF.md`; tasking startup adoption `PMR-069`; restored clean direct checkout observed at `e5740de`, then carried to `c55065c` and `784be93` | none configured | Owner |
| `osr-claude/` | Claude skill `os-security-research`; `CLAUDE.md`; `HANDOFF.md`; tasking startup adoption `PMR-070` | `tools/md-to-html.sh --check` | Owner's Claude agent |
| `cheri-riscv-notes-repo` | `meta/handoff.md`; `CONTRIBUTING.md`; `.github/` policy files; no agent definition observed; tasking startup adoption `PMR-071` | `node automation/validate-corpus.mjs`; `node automation/build-wiki.mjs ../wiki-build <owner>/<repo>` | Human |
| `xrv-research-repo` | `.github/copilot-instructions.md`; `HANDOFF.md`; `COLLAB.md`; `review-log.md`; tasking startup adoption `PMR-072` | none configured | Owner |

## Orchestration rules

- The Project Manager dispatches work by giving the human the exact
  invocation above and, when useful, a `PMR-NNN` request in
  `outbox/component-requests.md`. Under `PMD-20260904-003` it carries three
  classes of request itself (queue status edits, metadata-only source-index
  entries, Project Manager-role wording), committing inside the eligible
  component with the request identifier; every other request is handed to the
  human. It never writes into a component's `inbox/`, and never writes
  `helium-te-poc/` or `beryllium-repo`.
- Owner-side pushes, fetches, remote creation, and the exact recorded
  owner-side edits are the human's. From `project-manager/`,
  `bash ./scripts/owner-actions.sh --plan` shows what is outgoing and
  reachable, and `bash ./scripts/owner-actions.sh` performs the fast-forward
  pushes with a prompt per step; `--apply-edits` adds the recorded edits
  (`outbox/owner-edits/`), diff first, committed by the human inside the
  component (see `README.md` "Owner actions" and `outbox/OWNER-RUNBOOK.md`,
  which lists every open item by priority with exact steps). The parent
  repository currently pushes to `upstream`, not the retired `backup` remote
  name. The Project
  Manager never runs that script; it hands the human this invocation and
  records the result in the next coordination turn.
- Every sibling orchestrator is declared `disable-model-invocation: true`, so
  no agent can invoke another agent's orchestrator; the human starts each
  engagement.
- Agent outputs are evidence for coordination, never approval, acceptance,
  sign-off, publication, or release.
- When a sibling's agents, scripts, or interface documents change, update this
  roster and the matching `components/<component>.md` card in the same
  coordination turn.
