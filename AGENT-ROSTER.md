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

PMR-108 extends that startup path with the project-wide topology and
workstation-status anchor. Generated tasking views and dispatch packets bind
`workspace://SOT.md` by SHA-256 and fail closed if it is absent, symlinked, or
changed. Each owner context must also read the current anchor from its
registered logical workspace entry before resolving component paths or
beginning work. The 2026-10-01 inventory, refreshed with owner returns on
2026-10-02, is:

| Component | Registered owner context(s) | SOT startup state |
| --- | --- | --- |
| `project-manager` | `project-manager` | Active in Project Manager and parent-root instructions |
| `analysis-workbook` | `analysis-workbook`; hidden `analysis-workbook-owner` | Active in repository-wide instructions; hidden-owner packets also carry the bound anchor |
| `formal-verification-research` | ordinary research owner | Active; instructions resolve topology through parent `SOT.md` |
| `provenance-review` | orchestrator and write-disabled specialists | Active in repository-wide instructions |
| `beryllium-hypervisor` | ordinary Beryllium owner context | SOT-first startup, fail-closed digest checks, bounded contract validation, and current checkout path adopted by work `2313cbe0` / return `55b568b4` / checkpoint `93819fd9`; PMR-112 closed as acknowledgement; as of the last fetch all three commits are contained in remote-tracking `origin/beryllium/k3-b0-bringup` through `k3-b3-bringup` |
| `helium-te-poc` | ordinary Helium/skill owner context | Gap recorded as parked `PMR-113`, alongside `PMR-068` |
| `cheri-riscv-notes` | ordinary notes owner context | SOT-bound startup and current checkout paths adopted by owner work `8d1bc9d` / return `7fb49f4`; PMR-114 closed as acknowledgement, with both commits local and unpushed |
| `cheri-hypervisor-research` | ordinary XRV owner context | SOT-bound startup and dated checkout facts adopted in owner work/return `7361de4`; PMR-115 closed as acknowledgement, with the commit local and unpushed |
| `osr-claude` | OS-security skill owner context | Ask-first gap recorded as `PMR-116`, alongside `PMR-070` |
| `threat-modeler` | `threat-modeler`; `threat-model-maintainer`; adopted hidden `threat-modeler-owner` (not native-handshaken or PM-invocable) | User-facing startup gap remains parked PMR-117 alongside PMR-064; adopted owner packets bind SOT, but native discovery/isolation remains deferred after PMR-120 closure at `e6aed9f` |
| `security-reviewer` | orchestrator and three write-disabled specialists | Gap recorded as `PMR-118` |

Project-wide model and review practice follows the single-model,
low-overhead SOP `PMD-20261006-001`, recorded from the responsible human's
CRQ-004 instruction. Every orchestrator, agent, sub-agent, and task uses
`claude-opus-5.5` with reasoning effort `max` and context tier
`long_context`; none switches model, lowers effort, changes context tier, or
falls back silently, and an unavailable setting stops work for a report.
Different-model iterative evaluation reviews, separate scope reviews, and
deep security reviews are not standard practice; a security review runs only
on explicit responsible-human request, on the same model. The record
supersedes the model, review, and effort rules of `PMD-20260916-001`,
`PMD-20260930-001`, `PMD-20260930-002`, and `PMD-20260930-005`; the former
scope-review agent and scope-management skill are retired.

The human-installed user-level hook matches `task|run_dynamic_workflow`
inside the Beryllium workspace. It injects `claude-opus-5.5` / `max` /
`long_context` through `modifiedArgs` when `model`, `reasoning_effort`, or
`context_tier` is absent, null, or empty, denies any explicit other value,
and still denies in-scope `run_dynamic_workflow`. Under `PMD-20260930-003`,
new sessions load user-level hook configuration, matcher, and environment; a
registered running session may execute a replaced hook script body at its
next originally matched call but gains no new matcher from replacement
alone. Agent/skill reread behavior is unknown. As of 2026-10-06 the aligned
reinstall is deferred because a `beryllium-hypervisor` human session is
active; the previously installed hook still admits explicit
`claude-opus-5.5` / `max` / `long_context` tasks. Direct custom-agent
sessions, SDK-started workflows, out-of-scope worktrees, disabled hooks,
hook timeout, and non-Copilot tooling remain outside or beyond this
command-hook enforcement.

Observed profile alignment on 2026-10-06: analysis-workbook `4cf44d0` pins
`claude-opus-5.5` in `analysis-workbook`, `analysis-workbook-owner`, and
`analysis-evidence`, and `PMR-124` requests its CRQ-004 status mirror.
Beryllium's committed `.github/copilot-instructions.md` at `afa4336` adopts
an equivalent 2026-10-06 SOP (no CRQ-004 / `PMD-20261006-001` citation) and
pins `claude-opus-5.5` / `max` / `long_context`; it receives no request
because it is aligned and its human session is active. Superseded
pins remain in threat-modeler (six profiles at `gpt-5.6-sol`, `PMR-121`),
provenance-review (three profiles at `gpt-5.6-sol`, `PMR-122`), and
security-reviewer (four profiles at `gpt-5.3-codex` with `xhigh` /
`default`, `PMR-123`). Formal-verification, OS-security, the CHERI notes,
XRV, and Helium carry no model pin.

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
passes 357 / 0, and clean `main` is twenty ahead. Exact PMR-063 then ran from
Project Manager `c51a633` / request blob `ca1098b` against clean `e6c8aad`:
work `62bd071` changes only the user-facing agent, instructions, interface,
and agent tests; return `8b5a301` changes only `HANDOFF.md`; the expanded
suite passes 410 / 0; and clean `main` is twenty-two ahead. The operational
analysis housekeeping line is complete.

Threat-modeler rollout is adopted but not native-handshaken. Initial PMR-120
work `ca8fa3c` / return `bbbc534` installed the six-path candidate; correction
work `71bca3f` / return `e6aed9f` aligns standard live/durable V1 contracts
and reports focused 148/0 validation. The profile was adopted at
`gpt-5.6-sol` / `max` / `long_context`, now superseded by
`PMD-20261006-001` and tracked by `PMR-121`; it is model-invocable, not
user-invocable, and has no `ask_user`, delegation, web, or threat-modeling
skill. PMR-120 is closed by
`PMD-20261003-003`; both human bootstrap bindings are consumed. No native
handshake is allocated, so the owner is not PM-invocable and PMR-064/117 are
parked P4. Every other hidden-owner rollout remains deferred.

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
`agentic-os-research`; old homes remain inactive references. At that closure
checkpoint the tracked workspace symlinks had not moved; on 2026-09-22 the
responsible human renamed and retargeted the CHERI notes and XRV links to the
verified successors. Owner results continue through
`templates/owner-return.md`.

## Agent components

| Component | Entry agents | Write-disabled specialists | Skill | Durable output | Outbound queue | Write boundary |
| --- | --- | --- | --- | --- | --- | --- |
| `project-manager/` | `project-manager` (`claude-opus-5.5`, `max`, `long_context` under single-model SOP `PMD-20261006-001`) | `pm-auditor` (read, search; `claude-opus-5.5`, `max`, `long_context`; one same-model pass); the former scope-review specialist is retired | `beryllium-project-management`; the former scope-management skill is retired | `HANDOFF.md`, `components/`, `records/`, `queue/LEDGER.md`, `outbox/component-requests.md` | `outbox/component-requests.md` (to component owners) | Own repository, Project Manager-owned parent-root artifacts, and carried requests in the three classes of `PMD-20260904-003` inside carry-eligible components (never `helium-te-poc/` or `beryllium-hypervisor/`) |
| `analysis-workbook/` | User-invocable `analysis-workbook` (`claude-opus-5.5` at `4cf44d0`); hidden PM-invocable `analysis-workbook-owner` (`claude-opus-5.5`, `max`, `long_context` at `4cf44d0`, no `ask_user`) introduced at `ea72522`; `PMR-124` requests the CRQ-004 status mirror; read-only probe `PMR-087` closed by `PMD-20260918-002`; bounded write-enabled requests PMR-086, PMR-038, PMR-004, PMR-050, PMR-055, PMR-059, and PMR-063 are closed through `8b5a301`; tasking startup is active; Project Manager queue carry `8da398d` is latest | `analysis-evidence` (read, search; `claude-opus-5.5` at `4cf44d0`); `analysis-research` is absent at `4cf44d0` | `beryllium-analysis` with direct-human and PM-mediated owner modes | `sessions/AWB-YYYYMMDD-NNN-*/`; generated `WORKBOOK.md`; owner results in `HANDOFF.md` and `OWNER_AGENT_RESPONSE_V1`; carries `5a646df` / `8da398d` change only `outbox/pm-queue.md` | `outbox/pm-queue.md` (`PMQ-NNN`), read-only-tracked `outbox/helium-transfer-queue.md` (`HET-NNN`), and maintainer-mirrored `outbox/collaboration-requests.md` (`CRQ-NNN`) | Own repository only; ordinary owner local Git remains limited to identity/diff inspection, exact-path staging, and validated local work/return commits. Closure-line commits are contained by synchronized `origin/main` `3c9d2a3`;
PMR-085/088/089/095/097 remain open for review/authorization reconciliation,
not for missing containment; exact earlier backups PMR-085/088/089 and dependent carry backups PMR-095/097 remain separate |
| `threat-modeler/` | `threat-modeler`; `threat-model-maintainer` for repository maintenance and explicitly authorized Git delivery; adopted hidden `threat-modeler-owner` (no `ask_user`) at work `71bca3f` / return `e6aed9f`; all six profiles still pin superseded `gpt-5.6-sol` (`PMR-121`); tasking/SOT startup PMR-064/117 parked P4; owner is not native-handshaken or PM-invocable | `threat-evidence` (read, search); `threat-research` (read, search, web); `threat-model-review` (read, search) | `beryllium-threat-modeling` | `models/TM-YYYYMMDD-NNN-*/`; generated `THREAT-MODELS.md`; owner returns in `HANDOFF.md` | `outbox/pm-queue.md` (`DISC-NNN`) | Own repository only; all four PMR-120 commits are local and unpushed; no handshake or write dispatch is authorized |
| `security-reviewer/` | `security-reviewer` (all four profiles still pin superseded `gpt-5.3-codex` / `xhigh` / `default` from work `2bb4c98` and return `c2edac7`; `PMR-123` requests alignment; direct sessions remain outside the task hook) | `security-evidence`, `security-research`, `security-finding-review` (write-disabled; same superseded pin, `PMR-123`) | `beryllium-security-review` | `reviews/SR-YYYYMMDD-NNN-*/` (each with `review-manifest.json`), `syntheses/SRS-YYYYMMDD-NNN-*/`; generated `SECURITY-REVIEWS.md`; none created yet | `outbox/pm-queue.md` (`SRQ-NNN`, kinds `source` and `owner-action`) | Own repository only; target execution remains approval-gated, the PM resolver is separate startup discovery, and unpushed return tip `c2edac7` is distinct backup-only PMR-111 |
| `provenance-review/` | `provenance-review`; tasking startup adoption `PMR-066`; all three profiles still pin superseded `gpt-5.6-sol` (`PMR-122`) | `provenance-code-lineage` (read, search); `provenance-research` (read, search, web) | `provenance-analysis` | `reviews/PRV-YYYYMMDD-NNN-*/` with generated `html/` | none | Own repository only |

## Invocation and validation

Run each block from the named component directory.

### project-manager

```sh
cd project-manager
# Copilot CLI: /agent project-manager
# Human-only user-level install/check; run only while governed sessions are
# idle (the PMD-20261006-001 reinstall is deferred while Beryllium is active):
# bash ./scripts/beryllium-governance.sh install && bash ./scripts/beryllium-governance.sh check
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
| `helium-te-poc/` | skill `helium-documentation`; `.github/copilot-instructions.md`; `HANDOFF.md`; tasking startup adoption `PMR-068` | `./he check`, `./he test`, `./he docs-check`, `./he evaluate` | Human or the Helium line's own agent session |
| `beryllium-hypervisor/` | Observed 2026-10-06 on clean `beryllium/k3-b3-bringup` at `afa4336`, whose committed `.github/copilot-instructions.md` adopts an equivalent 2026-10-06 SOP (no CRQ-004 / `PMD-20261006-001` citation) pinning `claude-opus-5.5` / `max` / `long_context`; no request is raised while its human session is active. On the recorded active/default branch `beryllium/single-hart-runtime-r0`: skills `helium-documentation`, `human-review-summary`, `reviewable-turn-summary`; `.github/copilot-instructions.md`; `planning/HANDOFF.md`; the last recorded (104th-turn) tip is clean documentation-only PMR-077 return `a8e137e`, behind 0 / ahead 6 of last-fetched private `origin` `4141cf6`; maintained refs inspection at 2026-10-06T18:16Z shows it at `f213555`, behind 0 / ahead 22. Work `2313cbe0`, owner return `55b568b4`, and checkpoint `93819fd9` adopt SOT-first startup and directly related current-path/contract validation. Canonical return `1f38e699` / checkpoint `4c6acbed` keep PMR-098/100 closed. As of the last fetch, which is not a live remote check, those five commits, `a8e137e`, and `f213555` are contained in remote-tracking `origin/beryllium/k3-b0-bringup` through `k3-b3-bringup`, while `afa4336`, `6e93461`, and `0d53120` are on no remote-tracking branch; that containment grants no push, publication, or gate. Maintained refs confirm every named commit and subject. Human-supplied output reports six moved linked worktrees repaired at temporary flat `worktrees/` paths; the exact root-relative inventory is in `../COMPONENTS.md` and future namespacing remains owner-only. K0-I acceptance is recorded at earlier target `abd092a`; the handoff records bounded K0-S preparation/status target acceptance but a mutable, unaccepted, not-ready current package; `PMD-20260925-001` keeps Project Manager R8-H0 state committed but unaccepted | `./be status`, `./be model-check`, `./be check`, `./be docs-check`, `./be evaluate`, `./tests/r8/run-make.sh r8-check`; PMR-112 owner validation additionally reports `node docs/check-links.mjs --tasking-fence-regression`, `node docs/check-links.mjs --tasking-contract`, and `umask 0022 && npm run docs:source-check` passed | The PMR-112 owner session is released; any later writer requires fresh tasking, worktree, and one-writer checks. Project Manager remains read-only |
| `formal-verification-research/` | `COLLAB.md` guest protocol, `.github/copilot-instructions.md`, `HANDOFF.md`; synchronized owner refresh `388690d` contains research `62cc207`, owner controls `9109345`, routed-pointer dispositions, current topology, and exact startup resolver. PMR-014/037/041/069 are closed from that durable evidence | none configured | Owner |
| `osr-claude/` | Copilot skill `.github/skills/os-security-research/`; `.github/copilot-instructions.md`; `HANDOFF.md`; clean private successor synchronized at independent executable-backlog integration `86645d4`; PMR-044 baseline `49fbfd6` remains reachable; PMR-052 is unstarted; tasking startup adoption `PMR-070` | `tools/md-to-html.sh --check` | Owner |
| `cheri-riscv-notes` | `meta/handoff.md`; `CONTRIBUTING.md`; PMR-071/114 `.github/copilot-instructions.md` and maintained tasking validator; clean local `docs/reconcile-project-status` at PMR-119 class-3 carry `7f67154`, 0/3 relative to last-fetched private `origin` tip `34a8b50`. PMR-114 work `8d1bc9d` changes only startup instructions and tasking-validator policy; handoff-only return `7fb49f4` records 35/35 negative mutations and other owner-reported validation; PMR-119 changes only the handoff opening date and next action. No push/fetch occurred, and all three commits are unbacked locally | `node --check automation/*.mjs`; `node automation/validate-project-tasking.mjs`; `node automation/validate-corpus.mjs`; `node automation/build-wiki.mjs ../wiki-build [owner/repo]` | PMR-105 is complete at synchronized topic tip `34a8b50`; PMR-114 and PMR-119 are closed and must not be rerun. Merge, publication, D5, force, tags, and remote mutation remain separate or prohibited |
| `cheri-hypervisor-research` | `.github/copilot-instructions.md`; `HANDOFF.md`; `COLLAB.md`; `review-log.md`; clean local `main` at PMR-115 owner work/return `7361de4`, 0/1 against last-fetched private `origin/main` `5e7387a`. PMR-115 changes only startup instructions and dated handoff path facts; no fetch/push or research/review/source/collaboration change occurred. Existing PMR-075/092/094 predecessor closures remain exact; the Bao-CHERI state remains owner evidence, not a Project Manager disposition | none configured | Owner; PMR-115 is closed as acknowledgement, while the local commit remains unpushed |

## Orchestration rules

- The Project Manager dispatches work by giving the human the exact
  invocation above and, when useful, a `PMR-NNN` request in
  `outbox/component-requests.md`. Under `PMD-20260904-003` it carries three
  classes of request itself (queue status edits, metadata-only source-index
  entries, Project Manager-role wording), committing inside the eligible
  component with the request identifier; every other request is handed to the
  human until a validated hidden owner worker is adopted. It never writes
  into a component's `inbox/`, and never writes `helium-te-poc/` or
  `beryllium-hypervisor/`.
- For a direct ordinary owner session, the Project Manager gives the human one
  exact `bash ./project-manager/scripts/owner-session.sh launch <component>
  <PMR-NNN>...` command instead of prompt text. The human-run helper validates
  PM tasking/component state, writes the complete private packet under ignored
  PM scratch, and launches interactive `copilot --no-auto-update --yolo`.
  The Project Manager never uses it for live owner work; maintained tests use
  only sandbox state and a Copilot stub. The human starts the real command and
  answers genuine gates. Multiple PMRs may share one ordinary session only when the
  responsible human selected them and they retain distinct scope/evidence.
- For a dirty component whose owner-session liveness may be unknown, the
  Project Manager posts one exact PMR, removes competing current rows, and
  regenerates the component's resolver view. The owner context retrieves the
  sole row through `check Project Manager tasking`; the Project Manager does
  not ask the human to copy, translate, select, or relay a prompt and does not
  launch a second writer.
- If the responsible human confirms that dirty component's previous owner
  session is closed, `PMD-20260926-004` permits a separate human-run
  `owner-recovery.sh` launch only from a committed exact-state specification.
  It shares the writer lock, preloads the sole PMR, and retains a transcript
  and before/after state log under ignored PM scratch. The Project Manager
  never executes it, and it grants no retroactive content authority.
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
  direct engagement. The narrow `<component>-owner` exceptions are hidden
  `analysis-workbook-owner` (PM-invocable) and `threat-modeler-owner`
  (adopted at `e6aed9f` with `disable-model-invocation: false` /
  `user-invocable: false`, but not native-handshaken or PM-invocable); each
  remains separately named, tested, and `user-invocable: false`.
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
