# Agent roster

How every Beryllium project agent is invoked, what it consumes and produces,
where it may write, and how it is validated. Until a component adopts a
hidden owner worker, the Project Manager orchestrates by handing the human
these exact invocations and reading each agent's outputs. Under
`PMD-20260917-002`, it may later invoke a distinct adopted component-local
owner for one exact PMR; it still never runs the component command itself.
Its direct writes inside a component remain limited to carried requests in
the three classes of
`records/decisions/PMD-20260904-003-standing-carry-authority.md`.

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

When a task consumes, incorporates, qualifies, or applies sibling research or
analysis, the destination owner first loads `cross-repo-collaboration` and
reads the source repository's root `COLLAB.md` when present
(`PMD-20260917-001`). Complete and validate destination work before recording
use. Write the source only within its explicit guest budget; a missing or
read-only ledger means return completed-use evidence through the source owner
and Project Manager instead. Pointer triage alone does not require this unless
it becomes substantive destination use.

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

Owner-worker pilot: `PMR-084` is closed from analysis-workbook checkpoint
`ea72522`, which adds hidden `analysis-workbook-owner`. The profile is
model-invocable, not user-invocable, has no `ask_user`, and writes only its
own repository. The responsible human released the bootstrap session.
Dedicated `PMR-087` then passed the single-use `PMD-20260918-001` read-only
native discovery/root/task-fingerprint/isolation proof and is closed by
`PMD-20260918-002`: exactly one tool call containing only read-only local Git
identity/status queries before and after, exact unchanged
root/branch/HEAD/tree/status/upstream state, the admitted no-write `progress`
response, and no component change. The synchronous probe's
`active_session: self` ended with no reservation. Exact write-enabled
`PMR-086` was then dispatched from Project Manager `9c81f57` / request blob
`18a5343d` against clean expected HEAD `ea72522`. Verified fixture work
`efbfdb8` and durable return `858a73b` change only
`tests/validate-agent.sh` and `HANDOFF.md`; the full suite passes 357 / 0,
protected queue/analysis paths are unchanged, and the synchronous owner
session ended with no reservation. The commits are local and unpushed;
`PMR-088` is a separate undispatched backup follow-up. Exact PMR-038 then
used the same bounded lane from Project Manager `6da2b8f` / request blob
`4d9661d` against clean `858a73b`. Historical work `2374115` was not
reapplied; return `f7079fb` and boundary checkpoint `5e037b1` change only
`HANDOFF.md`, report 357 / 0, and leave clean `main` twelve ahead. The owner
returned `partial` only because the external fleet todo write was correctly
outside its repository boundary; the Project Manager verified the complete
repository result, performed that bookkeeping, and closed PMR-038. No
Beryllium owner profile exists. Exact PMR-004 then ran from Project Manager
`7a24a00` / request blob `20a6f15d` against clean `5e037b1`: work `5684317`
adds only `project-manager` to `scripts/readonly-inspect.sh`, return
`635719e` changes only `HANDOFF.md`, validation passes 357 / 0, and clean
`main` is fourteen ahead. Exact PMR-050 then ran from Project Manager
`e161e24` / request blob `6b8122a` against clean `635719e`: work `231cca4`
adds only `security-reviewer` after `project-manager`, return `692caeb`
changes only `HANDOFF.md`, validation passes 357 / 0, and clean `main` is
sixteen ahead. Exact PMR-055 then ran from Project Manager `656a792` /
request blob `ac82be0` against clean `692caeb`: work `70bea16` changes only
the CRQ-002 mirror, execution packet, and OPEN-001 question row; return
`6d5d03d` changes only `HANDOFF.md`, validation passes 357 / 0, and clean
`main` is eighteen ahead. Exact PMR-059 then ran from Project Manager
`88cb849` / request blob `5bf6149` against clean `6d5d03d`: work `9d76048`
and return `e6c8aad` change only root `HANDOFF.md`, bind existing synchronized
owner commit `1ef1ac6` and carry `c7cc0fa` without reapplying them, validation
passes 357 / 0, and clean `main` is twenty ahead. PMR-063 remains separate.

Withdrawn: `PMR-073` no longer requests a `git-maintainer` specialist.
`PMD-20260918-003` records that the proven owner-worker path supplies the
bounded need; no component agent may infer a generic Git-service authority.

Parked at P4: `PMR-076` requests a future Project Manager-owned OSS
project-alignment skill/agent, using the responsible human's `kcopilotd`
project as prior implementation input once located. It will compare
revision-bound upstream/peer alignment across LLM policy, workflow,
licensing, governance, automation, release, and contribution practices
without writing peer repositories or deciding human gates. It is not active
under `PMD-20260918-003`; the skill/agent does not exist and grants no
authority.

The `PMD-20260916-002` repository-reorganization critical path is complete:
`PMR-044`, `PMR-045`, and `PMR-046` closed at verified owner returns
`49fbfd6`, `456c70b`, and `9a4c5ef`. The active private successors are under
`agentic-os-research`; old homes remain inactive references and tracked
workspace symlinks did not move. Owner results continue through
`templates/owner-return.md`.

## Agent components

| Component | Entry agents | Write-disabled specialists | Skill | Durable output | Outbound queue | Write boundary |
| --- | --- | --- | --- | --- | --- | --- |
| `project-manager/` | `project-manager` (`gpt-5.6-sol`, `max`, `long_context` under project-wide matrix `PMD-20260916-001`) | `pm-auditor` (read, search; `claude-opus-5`, `max`, `long_context` under `PMD-20260916-001`, extending `PMD-20260915-007`) | `beryllium-project-management` | `HANDOFF.md`, `components/`, `records/`, `queue/LEDGER.md`, `outbox/component-requests.md` | `outbox/component-requests.md` (to component owners) | Own repository, Project Manager-owned parent-root artifacts, and carried requests in the three classes of `PMD-20260904-003` inside carry-eligible components (never `helium-te-poc/` or `beryllium-repo`) |
| `analysis-workbook/` | User-invocable `analysis-workbook`; hidden PM-invocable `analysis-workbook-owner` (`gpt-5.6-sol`, `max`, `long_context`, no `ask_user`) introduced at `ea72522`; read-only probe `PMR-087` closed by `PMD-20260918-002`; write-enabled `PMR-086` closed at `858a73b`; exact housekeeping `PMR-038` closed at `5e037b1`; inspection registrations `PMR-004` and `PMR-050` closed at `635719e` and `692caeb`; derived housekeeping `PMR-055` closed at `6d5d03d`; root-handoff return `PMR-059` closed at `e6c8aad`; tasking startup `PMR-063` remains open | `analysis-evidence` (read, search); `analysis-research` (read, search, web) | `beryllium-analysis` with direct-human and PM-mediated owner modes | `sessions/AWB-YYYYMMDD-NNN-*/`; generated `WORKBOOK.md`; owner results in `HANDOFF.md` and `OWNER_AGENT_RESPONSE_V1`; PMR-059 adds HANDOFF-only work `9d76048` plus checkpoint `e6c8aad`, binding existing `1ef1ac6` / `c7cc0fa` without reapplying them | `outbox/pm-queue.md` (`PMQ-NNN`), read-only-tracked `outbox/helium-transfer-queue.md` (`HET-NNN`), and maintainer-mirrored `outbox/collaboration-requests.md` (`CRQ-NNN`) | Own repository only; ordinary owner local Git remains limited to identity/diff inspection, exact-path staging, and validated local work/return commits. PMR-004/050/055/059/038/086 commits are local and unpushed except existing synchronized `1ef1ac6`; exact earlier backup `PMR-088` and prospective closure-range backup `PMR-089` remain separate |
| `threat-modeler/` | `threat-modeler`; `threat-model-maintainer` for repository maintenance and explicitly authorized Git delivery; tasking startup adoption `PMR-064` | `threat-evidence` (read, search); `threat-research` (read, search, web); `threat-model-review` (read, search) | `beryllium-threat-modeling` | `models/TM-YYYYMMDD-NNN-*/`; generated `THREAT-MODELS.md` | `outbox/pm-queue.md` (`DISC-NNN`) | Own repository only |
| `security-reviewer/` | `security-reviewer` (`gpt-5.3-codex`, `max`, `long_context` at owner `2e8d205` under `PMD-20260916-001`, `PMR-074` closed; tasking startup adopted at `f2051a4`) | `security-evidence`, `security-research`, `security-finding-review` (write-disabled; `gpt-5.3-codex` / `max` / `long_context`) | `beryllium-security-review` | `reviews/SR-YYYYMMDD-NNN-*/` (each with `review-manifest.json`), `syntheses/SRS-YYYYMMDD-NNN-*/`; generated `SECURITY-REVIEWS.md` | `outbox/pm-queue.md` (`SRQ-NNN`, kinds `source` and `owner-action`) | Own repository only; target execution remains approval-gated, while the PM resolver is separate startup discovery |
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
`CRQ-002`, and partially completes `PMR-038`; return `f7079fb` and boundary
checkpoint `5e037b1` finish the distinct root-handoff return, closing the
request without reapplying those historical changes.
`PMD-20260915-004` records successor-first handling for `CRQ-002`;
`PMR-052..PMR-054` are the three sequenced owner tasks; PMR-055's derived
routed-status and stale-open-ID correction is closed at work `70bea16` /
return `6d5d03d`.
Owner commit `1ef1ac6` adds complete `AWB-20260915-001` and
`PMQ-027..030`; Project Manager carry `c7cc0fa` applies `PML-0030`.
PMR-059 HANDOFF-only work `9d76048` and return `e6c8aad` bind those existing
commits without reapplying them and close the request.

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
| `beryllium-repo` | On active/default branch `beryllium/single-hart-runtime-r0`: skills `helium-documentation`, `human-review-summary`, `reviewable-turn-summary`; `.github/copilot-instructions.md`; `planning/HANDOFF.md`; blocked H0 candidate `6e93461`; R8-C plan target `f47ae60` accepted as plan text only; tasking startup and return correction closed at final owner return `416b2e9` (`PMR-067`, `PMR-083`) | `./be status`, `./be model-check`, `./be check`, `./be docs-check`, `./be evaluate`, `./tests/r8/run-make.sh r8-check`; PMR-067 validation also uses `node docs/check-links.mjs --tasking-fence-regression` and explicit `HE_CHROMIUM=$(command -v chromium-headless-shell) ./be docs-check` when Chromium is not auto-discovered | Human or an ordinary Copilot owner session; no user-invocable custom agent |
| `formal-verification-research/` | `COLLAB.md` guest protocol, `.github/copilot-instructions.md`, `HANDOFF.md`; tasking startup adoption `PMR-069`; restored clean direct checkout observed at `e5740de`, then carried to `c55065c` and `784be93` | none configured | Owner |
| `osr-claude/` | Copilot skill `.github/skills/os-security-research/`; `.github/copilot-instructions.md`; `HANDOFF.md`; active private successor at owner return `49fbfd6`; tasking startup adoption `PMR-070` | `tools/md-to-html.sh --check` | Owner |
| `cheri-riscv-notes-repo` | `meta/handoff.md`; `CONTRIBUTING.md`; `.github/` policy files; no agent definition observed; active private successor at owner return `9a4c5ef`; tasking startup adoption `PMR-071` | `node automation/validate-corpus.mjs`; `node automation/build-wiki.mjs ../wiki-build [owner/repo]` (successor identity is the default) | Human |
| `xrv-research-repo` | `.github/copilot-instructions.md`; `HANDOFF.md`; `COLLAB.md`; `review-log.md`; active private successor at owner return `456c70b`; tasking startup adoption `PMR-072` | none configured | Owner |

## Orchestration rules

- The Project Manager dispatches work by giving the human the exact
  invocation above and, when useful, a `PMR-NNN` request in
  `outbox/component-requests.md`. Under `PMD-20260904-003` it carries three
  classes of request itself (queue status edits, metadata-only source-index
  entries, Project Manager-role wording), committing inside the eligible
  component with the request identifier; every other request is handed to the
  human until a validated hidden owner worker is adopted. It never writes
  into a component's `inbox/`, and never writes `helium-te-poc/` or
  `beryllium-repo`.
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
  direct engagement. Hidden `analysis-workbook-owner` is currently the only
  narrow `<component>-owner` exception and remains separately named, tested,
  and `user-invocable: false`.
- Under `PMD-20260917-002`, dispatch is limited to one exact PMR packet,
  four concurrent repositories, and one writer/reservation per repository.
  Owner workers return human questions to the Project Manager and preserve
  durable results in their component handoff. The current standing carry
  authority remains fallback until a later human retain/narrow/supersede
  decision.
- Agent outputs are evidence for coordination, never approval, acceptance,
  sign-off, publication, or release.
- When a sibling's agents, scripts, or interface documents change, update this
  roster and the matching `components/<component>.md` card in the same
  coordination turn.
