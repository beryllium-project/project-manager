# Beryllium project manager

This independent component holds the Beryllium Project Manager: the agent,
procedures, records, and tooling that coordinate the component repositories
and their agents from the parent workspace. Invoke the user-facing agent from
this directory with:

```text
/agent project-manager
```

From the parent workspace root, `/add-dir project-manager` loads the same
agent as trusted configuration.

The agent runs a coordination turn: it re-resolves the canonical topology,
inspects every registered component read-only, pulls the component queues,
catches component owner returns from their own handoffs,
carries recorded requests into components only within the standing carry
authority, reconciles the registry and handoff, validates, commits its own
artifacts, and ends with what the user should review and one exact next
action. It manages and orchestrates the other agents by producing exact
invocation, validation, and request instructions; it never runs their
commands and never edits their research, analysis, threat-model, provenance,
session, model, or review content.

## Position in the workspace

The parent workspace root remains the thin coordination shell: `SOT.md`
(canonical topology and workstation-status anchor), `COMPONENTS.md`
(component registry), `README.md`,
`.gitignore`, `.github/copilot-instructions.md`, the compatibility redirect
`HANDOFF.md`, and the tracked component symlink objects. This component owns
the Project Manager handoff, component knowledge cards, the agent roster,
assurance-transfer records, decision records, the queue ledger, and the
component-request outbox.

Before the consolidation recorded in `HANDOFF.md`, these artifacts lived at
the parent root. The compatibility redirect `../HANDOFF.md` remains. The
former `../formal-verification/` redirect files were removed at parent commit
`4a91f7f` and retired by the responsible human in `PMD-20260912-001`;
current assurance records live under `records/assurance/`.

## Bidirectional agent coordination

The coordination model is pull-based (`PMD-20260914-002`):

- component owners return completed, partial, or blocked `PMR`/`PML` work in
  a structured `Project Manager return` section of their component-owned
  handoff document, using `templates/owner-return.md`;
- the Project Manager checks changed component HEADs and open-request owners
  on startup, verifies exact commits and paths, then reconciles its records;
- the Project Manager posts work through `outbox/component-requests.md`,
  `components/<component>.md`, and `outbox/OWNER-RUNBOOK.md`; and
- component agents receive those exact rows and their card before owner work
  begins.

No agent writes another repository merely to deliver a message. Request
closure is the acknowledgement; a distinct follow-up receives a new request
identifier. The existing handoffs and request ledger are sufficient at the
current scale, so there is no second generic returns queue.

`PMD-20260917-002` adds a minimum owner-worker control plane without replacing
that durable model. After a component adopts a validated hidden
`<component>-owner` profile, the Project Manager may select one exact,
already-authorized ready PMR with:

```sh
bash ./scripts/project-tasking.sh dispatch <component> <PMR-NNN>
```

The deterministic packet is bound to the PM commit and request blob; it writes
and launches nothing. The distinct component owner, not the Project Manager,
performs repository work under its own policy. Live
`OWNER_AGENT_RESPONSE_V1` messages accelerate iteration, while the component
handoff remains authoritative. Owner workers return blocking human questions
to the PM instead of calling `ask_user`. At most four repositories run
concurrently and never more than one writer/reservation per repository.

One PM-invocable owner profile exists: hidden `analysis-workbook-owner`, introduced at
`ea72522`, proven read-only under closed `PMR-087`, and used for bounded
write-enabled PMR-086, PMR-038, PMR-004, PMR-050, PMR-055, PMR-059, and
PMR-063 requests through latest return `8b5a301`. Those bounded results
grant no broader owner or Project Manager authority. Historically,
`PMD-20261002-002` staged P2 `PMR-120` as a threat-modeler-only repeated-cost
exception to the deferred rollout. PMR-120 work `ca8fa3c` / return `bbbc534` installs the
hidden `threat-modeler-owner` candidate and the responsible human released
the bootstrap session. `PMD-20261003-001` keeps the request open: the
candidate's `COMPLETE/PARTIAL/BLOCKED` live result omits the established V1
state, checkpoint, question, and push fields. `PMD-20261003-002` selects the
standard-V1 correction; work `71bca3f` / return `e6aed9f` completes it.
`PMD-20261003-003` closes PMR-120 and records the owner adopted but not
native-handshaken or PM-invocable. Both bootstrap bindings are consumed, no
handshake is allocated, and PMR-064/117 are parked P4. Every other component
remains deferred. No Beryllium owner profile exists. V1 adds no
dispatch/return queue, historical
request migration, execution ledger, daemon, lease database, or general Git
automation.

Cross-repository consumption follows `PMD-20260917-001`: destination owners
load `cross-repo-collaboration` before using sibling research or analysis,
read the source `COLLAB.md` when present, and record completed use only within
its explicit guest budget. Missing/read-only ledgers grant no source write;
the use report returns through the source owner and Project Manager. Pointer
triage alone triggers this only if it becomes substantive destination use.

Human intake follows `PMD-20260915-002`: when a decision can be decomposed,
the Project Manager asks one short structured question at a time, carries
prior answers forward, offers a safe recommended default plus exception or
defer choice, and prepares the matrices and durable records itself. If the
human is unavailable, it preserves partial intake and reports the next
unanswered question.

Next-step reporting follows `PMD-20260916-003`: every recommendation includes
a compact current-todo table with priority, request identifiers, **Blocking
status**, and a **Human-focused description** of what each choice unblocks and who
must act. P1/P2 work is shown individually; similar P3/P4 work may be grouped.
The Project Manager explicitly acknowledges priorities outside its view.

The repository-reorganization critical path in `PMD-20260916-002` is
complete: `PMR-044`, `PMR-045`, and `PMR-046` closed at verified owner
returns `49fbfd6`, `456c70b`, and `9a4c5ef`. The active private
OS-security, XRV, and CHERI-RISC-V notes successors are under
`agentic-os-research`; old homes remain inactive references. At that closure
checkpoint the tracked workspace symlinks had not moved; on 2026-09-22 the
responsible human renamed and retargeted the CHERI notes and XRV links to the
verified successors. Publication, licensing, redistribution, release, and
assurance gates remain unchanged.

Project-wide work follows the single-model, low-overhead SOP of
`PMD-20261006-001`, recorded from the responsible human's CRQ-004
instruction. Every orchestrator, agent, sub-agent, and task uses
`claude-opus-5.5` with reasoning effort `max` and context tier
`long_context`. None switches model, lowers effort, changes context tier, or
downgrades because work looks routine, and there is no silent fallback: if
that setting is unavailable, work stops and is reported. Different-model
iterative evaluation reviews, separate scope reviews, and deep security
reviews are not standard practice; a security review runs only on explicit
responsible-human request, on the same model. The `pm-auditor` audit is one
same-model consistency pass with no iteration loop. Work focuses on
completing deliverables efficiently without scope creep or added complexity,
and every human gate is unchanged.

The record supersedes the role-to-model matrix of `PMD-20260916-001` and any
remaining `PMD-20260915-007` preference, the scope-review requirement and
effort overrides of `PMD-20260930-001` (its `max` default stays), the model
and effort rules of `PMD-20260930-002`, and the Codex capability exception
of `PMD-20260930-005`. The `project-manager` orchestrator and `pm-auditor`
pin `claude-opus-5.5`; the former scope-review agent and scope-management
skill are retired. Historical artifacts are unchanged. Analysis-workbook
`4cf44d0` and Beryllium `afa4336` are already aligned; `PMR-121`..`PMR-123`
request threat-modeler, provenance-review, and security-reviewer profile
alignment, and `PMR-124` the analysis-workbook CRQ-004 status mirror.

The human-installed user-level hook matches `task|run_dynamic_workflow`
inside the Beryllium workspace. When `model`, `reasoning_effort`, or
`context_tier` is absent, null, or empty, it injects `claude-opus-5.5` /
`max` / `long_context` through permission-neutral `modifiedArgs`; it denies
any explicit other model, effort, or context tier and still denies in-scope
`run_dynamic_workflow`. The human-run `scripts/beryllium-governance.sh`
manages only the hook script and hook configuration: `install` and
`uninstall` remove exact-match copies of the retired user-level scope
reviewer and skill, and `check` verifies copied-file SHA-256 values, `jq`,
hook-disable settings, the user session and plan defaults, and the absence
of retired scope assets. Direct custom-agent sessions, SDK-started
workflows, out-of-scope worktrees, disabled hooks, hook timeout, and
non-Copilot tooling remain outside or beyond this enforcement; the main
session model comes from the human's launch and settings.

`PMD-20260930-003` records the user-level reinstall boundary: new sessions
load hook configuration, matcher, and environment, while a registered
running session can execute an atomically replaced hook script body on its
next originally matched call without gaining new matcher coverage. Agent and
skill reread behavior in running sessions is unknown. Install, reinstall, and
uninstall are recommended only while governed sessions are idle; no process
scanner or acknowledgement flag is used. On 2026-10-01 the responsible human
stated exactly `"there is no other running session"` as point-in-time
evidence only. Recheck immediately before execution; PMR-108 actions still
require fresh same-turn confirmation.
The responsible human later reported the exact governance `install && check`
command completed (`"done above"`). This is human evidence only; the Project
Manager did not inspect real user configuration or establish install-time
session state. As of 2026-10-06, installing the `PMD-20261006-001`-aligned
hook is deferred because a `beryllium-hypervisor` human session is active.
Until then the previously installed hook keeps its older rules for new
sessions but still admits explicit `claude-opus-5.5` / `max` /
`long_context` tasks, so the SOP is followed by passing those values
explicitly.

Every repository write also requires a fresh coordination check. The acting
agent checks worktree state and active-session evidence first; user reports,
handoffs, dirty state, and active session artifacts all block concurrent
writes. A clean tree alone is not a lock grant.

## Safety boundary

The agent writes only:

- inside this repository;
- to the Project Manager-owned parent-root artifacts named in
  `AGENT-INTERFACE.md`, including tracked symlink objects and `.gitignore`;
  and
- inside a carry-eligible component, only to carry a recorded request under
  the standing carry authority
  `records/decisions/PMD-20260904-003-standing-carry-authority.md`, in three
  classes: queue status edits in that component's `outbox/pm-queue.md`,
  metadata-only source-index entries in the owner's designated index, and
  Project Manager-role wording in its Markdown interface, collaboration,
  research-source, and handoff documents. Each carried write needs a clean
  worktree and an open request, and is committed inside that component with
  the request identifier.

It never writes inside another component directory outside those classes,
never writes `helium-te-poc/` or `beryllium-hypervisor/` at all, never stages
component contents in the parent, never resets, cleans, or reconciles a
component worktree, and never retargets a tracked symlink without user
direction. Component outbox queues are consumed ledger-first: the three
`outbox/pm-queue.md` source-discovery files can produce class-1 status edits,
while `../analysis-workbook/outbox/helium-transfer-queue.md` is tracked
read-only and never edited by the Project Manager.

Direct Git is permitted against this repository and the parent root, and
inside a component only as `git -C <component>` `status`, `diff`, `log`,
`show`, `add <exact paths>`, and `commit` while carrying. Remote creation,
push, tag, publication, and release, for any repository, happen only after
an explicit same-turn user confirmation.

The agent never grants or infers acceptance, approval, sign-off, licensing,
publication, release, formal verification, hardware validation, or risk
acceptance. Those remain responsible-human gates.

Invoking a separately adopted component owner does not enlarge this agent's
write or execution boundary. The owner may create validated local work and
return commits under its own component rules. A private fast-forward push
requires a new exact same-turn human confirmation presented by the Project
Manager, unchanged expected tips, and component-policy permission. Force,
tags, public pushes, remote mutation, publication, and release remain outside
the owner-worker control plane.

`PMR-073` is withdrawn by `PMD-20260918-003`; no Git-maintainer specialist or
authority exists. Component agents continue to use durable PM tasking/returns,
and existing repository ownership, operation prohibitions, active-session
locks, and human gates remain binding.

`PMR-076` is the planned OSS project-alignment skill/agent todo. It is not yet
implemented and grants no authority. It requires the responsible human's
`kcopilotd` project to be located and scoped before design begins; all
upstream/peer material remains read-only untrusted evidence, and licensing,
governance, adoption, redistribution, and release remain human decisions.

## Local requirements

The maintained helpers target the Beryllium Linux workstation and require Bash
4 or later, Git, and GNU userland tools including `awk`, `sed`, `grep`,
`sort`, `sha256sum`, and `mktemp`, plus util-linux `flock` and `script`.
Missing tools are reported as hard limitations; the agent never installs them
implicitly.

## Layout

```text
.github/agents/project-manager.agent.md      user-facing orchestrator
.github/agents/pm-auditor.agent.md           write-disabled consistency auditor
.github/skills/beryllium-project-management/ the coordination-turn procedure
AGENT-INTERFACE.md                           boundaries, inputs, outputs, gates
AGENT-ROSTER.md                              how every project agent is invoked and validated
HANDOFF.md                                   restartable Project Manager handoff
components/<component>.md                    one knowledge card per registered component
records/assurance/                           assurance-transfer records
records/decisions/PMD-YYYYMMDD-NNN-*.md      decision records
queue/LEDGER.md                              ledger-first dispositions of component queue rows
outbox/component-requests.md                 requests to component owners, each with a priority; three classes carried by the agent
outbox/owner-recovery/                       exact tracked dirty-recovery specifications
outbox/tasking/README.md                     contract for ignored generated per-component tasking views
outbox/OWNER-RUNBOOK.md                      open items by priority with exact human steps (refreshed each turn)
outbox/owner-edits/                          exact text of the recorded owner-side edits applied by the human-run helper
outbox/pmr105-push.sh                        HUMAN-RUN exact CHERI PMR-105 preflight/push; never executed by the agent
templates/owner-return.md                    component HANDOFF return shape for PMR/PML owner results
templates/owner-agent-response.md            live PM/owner response and guided-question shape
scripts/                                     maintained helpers (agent-run)
scripts/owner-actions.sh                     HUMAN-RUN owner-side pushes, fetches, recorded edits, artifact search; never executed by the agent
scripts/owner-session.sh                     HUMAN-RUN fail-closed ordinary-owner packet, consumed PMR-120 bootstrap bindings, and interactive copilot --yolo launch
scripts/owner-recovery.sh                    HUMAN-RUN exact dirty-state recovery packet, transcript, and copilot --yolo launch
templates/                                   record and row templates
tests/validate-agent.sh                      component contract suite
```

## Maintained commands

```sh
bash ./scripts/inspect-components.sh components
bash ./scripts/inspect-components.sh fingerprint <component>
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
bash ./scripts/inspect-components.sh quiescence
bash ./scripts/inspect-components.sh refs <component> [<ref>...]
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/pull-queues.sh edits
bash ./scripts/project-tasking.sh generate
bash ./scripts/project-tasking.sh check
bash ./scripts/project-tasking.sh resolve <component-or-workspace-path>
bash ./scripts/project-tasking.sh dispatch <component> <PMR-NNN>
bash ./scripts/owner-session.sh prepare <component> <PMR-NNN>...
bash ./scripts/owner-session.sh launch <component> <PMR-NNN>...
bash ./scripts/owner-recovery.sh prepare <component> <PMR-NNN>
bash ./scripts/owner-recovery.sh launch <component> <PMR-NNN>
bash ./scripts/maintenance-reservation.sh hold -- <command>
bash ./scripts/new-record.sh decision <slug>
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git diff --check
```

Every mode of `inspect-components.sh` and `pull-queues.sh` is read-only and
runs Git in a sanitized environment without hooks, credentials, or network
access. `inspect-components.sh quiescence` reports PMR-108 automated
preconditions only: it enumerates every linked worktree of the parent and
each registered repository, including ignored and outside-workspace paths,
and fails closed on any absent, prunable, or dirty worktree, registry drift,
queue or tasking failure, held owner-session writer lock, or global
maintenance reservation held without this session's marker (a free
reservation is reported, not failed). Its exit 0 never establishes
quiescence: active-session reports, a held reservation, and same-turn human
confirmation remain required. `new-record.sh` writes only under `records/decisions/`. Carried
writes inside components are made by the agent itself, never by these
scripts.

`project-tasking.sh generate` writes only ignored local projections under
`outbox/tasking/`, after confirming the authoritative request table is
committed and the parent `SOT.md` anchor is a readable regular file. Every
view and dispatch packet records `workspace://SOT.md` and its SHA-256.
`check`, `resolve`, and `dispatch` fail closed unless the view records the
current Project Manager commit, exact committed request blob, and current
anchor hash. From either a direct checkout or tracked workspace symlink, run:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

`PMD-20260915-008` makes the natural-language startup contract explicit:
`check Project Manager tasking` means run that exact resolver from the
logical workspace entry. An agent must stop on failure; it must not search
session history, task databases, background agents, prior chat, or memory as
a fallback. Component-owned entry points are tracked by
`PMR-063..PMR-072`. PMR-108's 2026-10-01 inventory found the SOT startup
anchor already active for Project Manager, analysis-workbook,
formal-verification-research, and provenance-review. Distinct owner requests
`PMR-113` and `PMR-116..PMR-118` are the four remaining child-owned gaps.
Beryllium PMR-112 is complete at owner work `2313cbe0`, return `55b568b4`,
and checkpoint `93819fd9`; all three commits remain local and unpushed.
CHERI notes PMR-114 is complete at owner work `8d1bc9d` / return `7fb49f4`,
and XRV PMR-115 is complete at owner work/return `7361de4`; those three
commits also remain local and unpushed.

From the workspace root, use
`bash ./project-manager/scripts/project-tasking.sh resolve <component>`.
Tracked-symlink owners verify `pwd` versus `pwd -P` and use the documented
`PM_TASKING_ROOT` / `PM_TASKING_WORKSPACE` inputs when the logical entry is
not preserved. Generated rows show `Assigned to` so cross-named requests are
not mistaken for owner assignments.

## Ordinary owner sessions (human-run)

Do not copy or reconstruct owner prompts. Run one exact command from the
workspace root:

```sh
bash ./project-manager/scripts/owner-session.sh launch <component> <PMR-NNN>...
```

The launcher requires clean current PM tasking and a clean component, writes a
private revision-bound packet under `project-manager/scratch/owner-sessions/`,
and starts interactive `copilot --no-auto-update --yolo` with a short packet
path/hash/HEAD prompt. `prepare` performs the same checks without launching.
Only `launch` holds the per-component `flock` writer reservation through the
Copilot process; `prepare` reserves no writer. Both `owner-session.sh` and
`owner-recovery.sh` launches also hold a shared lock on the PMR-108 global
maintenance reservation and are refused while it is held.
The Project Manager agent never executes `owner-session.sh` for live owner
work; maintained validation uses only sandbox state and a Copilot stub. The
helper writes no component file before Copilot starts, invokes no hidden owner
worker, grants no gate, and performs no push. The human starts the real
command and answers only genuine unresolved gates.

Every syntactically valid prepare/launch maintains one mode-`0600`,
fixed-field preflight state file under ignored
`project-manager/scratch/owner-sessions/preflight/`. Its exact fields are
schema, UTC timestamp, mode, component, selected agent identifier, selected
request IDs, bootstrap yes/no, current stage, result, and a fixed sanitized
reason. It contains no environment values, command output, URLs, credentials,
component content, user input, or Copilot transcript. An absent log means the
launcher did not reach validated preflight logging, for example because it
stopped during usage/argument parsing or could not create private scratch; a
`launching` result means the launcher reached the Copilot `exec`, not that
Copilot started or that owner work completed.

One narrow bootstrap installed the pre-adoption threat-modeler hidden-owner
candidate, and one exact correction binding aligned standard V1. Both PMR-120
bindings are consumed and remain unusable; request closure and component-HEAD
drift fail closed. Ordinary packets retain mandatory resolver execution, and
the former PMR-064/117 tuple still fails closed. Neither binding granted
direct Project Manager launch, generic fallback, push, gate, or precedent for
another component.

The consumed original bootstrap packet carried scope-review steering
`resume-threat-owner-rollout-20261002-06`. The reviewer saw source request
blob `9c289ab88a4202efb20e5e88ae994f6572c59a75` before PMR-120 existed; the
Project Manager applied its required changes and bound the exact resulting
row through applied request blob
`7508420cd5a91239eb77bdc2198d15c133dbf91f`, SOT SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`,
and threat-modeler HEAD `c4126b6`. The exact envelope adds only
maintenance-only hidden-owner registration in six named component paths.
It does not change either existing user-facing profile beyond registration,
run package scaffolding or threat discovery, use delegation or web, perform
PMR-064/117, or change a model, queue, outbox, remote, risk decision, or gate.
Unavailable scope-review/collaboration mechanisms are not blockers for
unchanged execution; any replan, new direction, envelope exit, or substantive
sibling research/analysis use stops. The task permits validated local
work/return commits and prohibits push. Static profile/tests do not prove
native discovery or isolation. They also did not detect that the delivered
live response format diverges from `templates/owner-agent-response.md`.
`PMD-20261003-001` recorded the gap and `PMD-20261003-002` selected standard
V1. `PMD-20261003-003` closes adoption while deferring the native handshake
and direct dispatch under the return-to-hypervisor priority.

The re-armed correction packet carries review
`threat-owner-standard-v1-correction-20261003-09`, verdict `adjust`,
authority `steering_only_no_approval_or_human_gate`, reviewed source request
blob `0d7e84201e160c94080055fec121ff2dbf5540a8`, applied request blob
`b6160d3130163ede106141c8cb9494222e16186d`, unchanged SOT SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`,
and baseline threat-modeler HEAD
`bbbc5349943c3a7d64ced24f19f90d6e0c50ea06`.

`bash ./scripts/maintenance-reservation.sh hold -- <command>` is human-run
only: it takes that reservation exclusively (refused while any owner launch
runs), exports `PM_MAINTENANCE_RESERVATION=held`, and runs the command, normally
the Project Manager PMR-108 rollout session. It does not block
`owner-actions.sh`, hidden owner workers, or non-instrumented sessions, and
grants no gate or write authority.
The Project Manager agent also never executes
`maintenance-reservation.sh` for live work; maintained validation exercises
it only in sandbox state.

## Closed dirty owner recovery (human-run)

Ordinary owner launch intentionally refuses a dirty component. When the
responsible human confirms the prior owner session closed and the Project
Manager records one exact preserved dirty state under `PMD-20260926-004`, run
the request-specific recovery command from the workspace root:

```sh
bash ./project-manager/scripts/owner-recovery.sh launch <component> <PMR-NNN>
```

The launcher requires a committed `outbox/owner-recovery/<PMR-NNN>.tsv`, one
visible directly assigned request, exact branch/HEAD/porcelain-status
agreement and tracked full-index binary-diff SHA-256, current clean PM
tasking, no merge conflict or untracked path, and the shared per-component
writer lock. It preloads the exact packet into interactive
Copilot and records a terminal transcript plus before/after state under
ignored `scratch/owner-recoveries/`. The Project Manager agent never runs
this helper. It writes no component file before Copilot starts and never
cleans, stashes, resets, stages, commits, pushes, or changes a remote.
Recovery supplies coordination, not retroactive authority for dirty content;
missing component authority returns a blocked owner result. The transcript is
private ignored scratch and may contain sensitive interactive output; never
quote secrets or private locators from it into durable records.

## Owner actions (human-run)

`scripts/owner-actions.sh` performs, for the responsible human, the owner-side
actions the agent records but never performs. The agent never executes it, in
any mode. Run it from this directory; dry-run first:

```sh
bash ./scripts/owner-actions.sh --plan            # read-only: reachability, outgoing commits, what would run
bash ./scripts/owner-actions.sh                   # review, then y/N per push, then fetch + restart snapshot
bash ./scripts/owner-actions.sh --yes             # same without prompts (a dirty worktree is still skipped)
bash ./scripts/owner-actions.sh --apply-edits     # also: the exact recorded owner-side edits (outbox/owner-edits/), diff, y/N, commit in the component
bash ./scripts/owner-actions.sh --only files_search --files-search --files-root /mnt/backup   # only: read-only retained-artifact search; skips GitHub/push preflight
bash ./scripts/owner-actions.sh --fvr-backup      # also: create beryllium-project/formal-verification-research (private), add remote backup, push -u backup main
bash ./scripts/owner-actions.sh --sr-backup       # also: create beryllium-project/security-reviewer (private), add remote origin, push -u origin main (PMR-021)
bash ./scripts/owner-actions.sh --helium-branches --helium-only helium-te-fv,helium-te-h7-approved
bash ./scripts/owner-actions.sh --help            # steps, flags, exit status
```

Default steps: `preflight`, `review`, `push_awb` (analysis-workbook),
`push_tm` (threat-modeler), `push_xrv` (cheri-hypervisor-research to its current
tracked active `origin`), `push_osr`
(osr-claude), `push_fvr` (formal-verification-research `main -> backup` when
the component and remote exist),
`push_sr` (security-reviewer `main -> origin`, once that remote exists),
`push_pm` (this repository to `origin`, the parent to `upstream`),
`fetch_snapshot`. Opt-in: `apply_edits` (`--apply-edits`), `push_fvr` remote
creation (`--fvr-backup`), `push_sr` remote creation (`--sr-backup`),
`push_helium` (`--helium-branches`), `files_search`
(`--files-search`). Every push is a fast-forward verified afterwards with
`git ls-remote`; nothing is ever forced; a component file is changed only by
`apply_edits`, only to the exact text recorded in `outbox/owner-edits/`, only
in a clean worktree, after the diff and a `y`, and never in `helium-te-poc/`
or `beryllium-hypervisor/` (`records/decisions/PMD-20260906-001-owner-edits-and-request-priorities.md`).
The run ends with the open requests by priority; `outbox/OWNER-RUNBOOK.md` has
the exact steps for each. Logs go to `scratch/owner-actions/` (ignored).
Afterwards, start a Project Manager session and say what the run did.

PMR-105 used a separate one-request script rather than the generic helper.
The exact private topic fast-forward completed on 2026-09-29 and is closed by
`PMD-20260929-002`; do not rerun `outbox/pmr105-push.sh`. Its retained private
logs under `scratch/owner-actions/` show exact account/ref/tip checks,
other-ref preservation, and final clean 0/0 state.
