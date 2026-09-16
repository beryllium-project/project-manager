# Beryllium Project Manager handoff

**Last updated:** 2026-09-15
**Update scope:** twenty-sixth coordination turn; added Project Manager todo
`PMR-073` for a narrowly scoped Git-maintainer specialist invocable only by
the Project Manager and requestable by component agents through durable PM
tasking/returns. Verified clean synchronized security-reviewer owner commit
`f2051a4` and closed `PMR-062` and `PMR-065` independently. No repository
creation, remote change, branch change, symlink change, visibility change,
quarantine transfer, push, or publication action was performed by the
Project Manager.

**Workspace root:** `/home/jmorris/src/beryllium-project`
**Project Manager repository:** `project-manager/`, branch `main`
**Parent coordination repository:** branch `main`, tracking `upstream/main`

## Fast resume

### Overall position

| Area | Current state |
| --- | --- |
| Beryllium runtime | R0-R7 are responsible-human accepted. R8-H0 is a committed candidate and is not accepted. H1-H4 are not authorized. K3 hardware is `NOT RUN`. `PMR-057` and `PMR-061` are complete: clean active/default `beryllium/single-hart-runtime-r0` at owner return `f05ccb3`, synchronized with private `origin`; inactive historical `msft-downstream` and ignored artifacts remain preserved. |
| Helium | Clean detached HEAD at `1ab289c`, also named by synchronized `for-review`; separate refs include travel `52cc71a` and `public/main` plus tag `v0.6.0` at `1c9e526`. The checked-out handoff says release remains blocked, so `PMR-026` asks the owner to reconcile checkout/ref/handoff state. The Project Manager infers no release or approval from ref names or commit subjects. Helium remains a review-and-test PoC, not formally verified or hardware validated. |
| Threat model | `TM-20260911-001-helium-te-poc-astra` is complete, private, backed up, and paused by explicit user request. Owner maintenance commit `c4126b6` follows owner package `5bf6a4b` and Project Manager carry `f4eb272`; clean `main` is synchronized with private `origin/main`. `PMR-028` is closed. The model's risks are conditional analysis, not observed compromise or risk acceptance. |
| XRV | Historical commit `7314e2f` remains unavailable and `REV-20260904-001..009` remain reserved. Replacement records are backed up at `706e708`; owner commit `d618935` adds root `COLLAB.md` and `REV-20260914-010..013`. The responsible human reports the deep-research session complete; no successor XRV commit is observed. `PMR-039` is the private backup decision and `PMR-040` requests review of the new proposed architecture. |
| Analysis-workbook | Owner commit `1ef1ac6` preserves and backs up complete private `AWB-20260915-001-smdbltrp-consideration` and four source rows. Project Manager carry `c7cc0fa` applies the `PMQ-029` rejection; clean `main` is one ahead of `origin/main`. `PMR-059` remains only for the stale repository handoff and structured return. |
| CHERI-RISC-V notes | Owner topic commit `ae09213` preserves the former 21-entry reconciliation and corpus-validator work. Clean `docs/reconcile-project-status` is synchronized with `origin/docs/reconcile-project-status`; `main` remains `6553092`. `PMR-029` and `PMR-020` are closed. `PMR-051` requests a post-push handoff/status refresh; `PMR-009` source triage is now actionable. |
| Formal verification | Clean `main` at `784be93`, two ahead of the reachable `origin/main`. The latest carry adds metadata-only `PMQ-023` and normalizes the routed-pointer section; `PMR-037` remains open only for owner-maintained remote/handoff wording. |
| Other drift | `osr-claude` is clean and synchronized at `e275544`; `PMR-027` is closed and `PMR-044` is actionable. `provenance-review` remains synchronized at `9bfbab3`. |
| Other components | Security-reviewer is clean and synchronized at owner commit `f2051a4`; all four profiles use Opus 5 / `max` / `long_context`, the tasking startup contract is active, `PMR-062` and `PMR-065` are closed independently, and no engagement ran. |
| Queues | 30 source-discovery rows / 30 source ledger rows plus one transfer row are exact. `PMQ-027`, `028`, and corrected `030` are routed to XRV; `PMQ-029` is rejected and its source edit is applied at `c7cc0fa`. `PMQ-008` and `011` remain routed; `HET-001` remains `recorded`/`unaccepted`. |
| Cap-talk closure | `PMR-027` is complete. Successor-first sequencing now requires `PMR-044` and `PMR-045`; then `PMR-052` acquires or bounds the public continuation from the `2016-04-01` start bound, followed by XRV review `PMR-053` and workbook follow-up `PMR-054`. |
| Coordination model | `PMD-20260914-002` adopts pull-based owner returns in component handoffs and PM-owned outbound requests/cards. Every repository write requires a fresh worktree and active-session check; a clean tree alone is not permission. |
| Approved target topology | The organization is `agentic-os-research`. `PMD-20260915-005` supersedes the Beryllium mapping only: private `beryllium-project/beryllium-hypervisor` is the active target, with `beryllium/single-hart-runtime-r0` retained as its active branch. OS-security, XRV, and CHERI notes retain their `agentic-os-research` targets. |
| D0 transition inventory | `PMD-20260914-004` records the bounded local inventory. `PMD-20260915-001` closes `PMR-049`: no additional Microsoft-origin repositories, all successors private initially, and no repository public-approved. `PMD-20260915-005` supersedes only its Beryllium target name; workflow/evidence repositories and formal-verification otherwise stay under `beryllium-project`. "None known" remains an owner statement, not an independently authenticated negative finding. |
| Generated tasking | `PMR-048` is closed citing `PMD-20260914-005`. `scripts/project-tasking.sh` generates ignored per-component views from the committed authoritative request table and resolves either a direct checkout or tracked workspace symlink. It refuses missing, dirty, stale-commit, or wrong-request-blob state rather than showing stale tasking. |
| Tasking startup contract | `PMD-20260915-008` requires every owner context to map `check Project Manager tasking` and obvious variants to the exact resolver. Failure stops; session history, task databases, background agents, prior chat, and remembered PMRs are forbidden fallbacks. Project Manager is updated directly; security-reviewer adoption `PMR-065` is complete, while `PMR-063`, `064`, and `066..072` remain. |
| Planned Git maintenance | `PMR-073` records a Project Manager-owned design/implementation todo for a narrow `git-maintainer` specialist. Only the Project Manager may invoke it; component agents request service through PM tasking/returns. It must preserve existing ownership, operation allowlists, active-session locks, and all human gates. No such specialist exists yet. |
| Human interaction | `PMD-20260915-002` requires one short structured question at a time where appropriate. The Project Manager carries answers forward and prepares matrices and machine-shaped records; the human is not used as a parsing engine. |
| Review/evaluation model | `PMD-20260915-007` supersedes the Project Manager-only preference with a project-wide substitution: active Fable 5.1 review/evaluation profiles use `claude-opus-5`, `max`, and `long_context` unless explicitly overridden. Non-Fable assignments and historical artifacts stay unchanged. Security-reviewer owner `f2051a4` closes `PMR-062`; no active Fable profile remains. |
| Quarantine | Licensed/restricted OS-security resources use private personal repository `os-security-restricted-sources`, clean new history, and manual responsible-human review/copy with license metadata. The Project Manager never opens or copies the restricted subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Apply the tasking startup contract to the ordinary Beryllium owner context
that exposed the lookup gap (`PMR-067`):

```sh
cd /home/jmorris/src/beryllium-project/beryllium-repo
pwd
pwd -P
git status --short --branch
copilot
```

Then say:

```text
I approve this exact read-only startup command for this session:
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .

Run it now. Treat its validated output as discovery over
project-manager/outbox/component-requests.md, not as authorization. Do not
search session history, task databases, background agents, prior chat, or
memory. Complete PMR-067; do not combine implementation work.
```

### Minimal restart commands

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh status
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh edits
bash ./scripts/pull-queues.sh check
bash ./scripts/project-tasking.sh check
bash ./scripts/inspect-components.sh registry-check
git status --short --branch
git -C .. status --short --branch
```

## What changed in this turn

- Added `PMR-073`, a Project Manager-owned todo to design and implement a
  Git-maintainer specialist with Project Manager-only invocation and
  component-agent requests through durable PM tasking/returns.
- Recorded the required refusal and evidence boundaries: no free-form Git
  authority, no dirty/active target writes, no destructive/history-rewriting
  defaults, and no remote/push/tag/publication action without existing
  explicit human confirmation.
- Held `PMR-062` and `PMR-065` open while provisional security-reviewer
  commit `ddd02bf` still had a dirty `HANDOFF.md`.
- Verified final owner commit `f2051a4`, clean and synchronized with private
  `origin/main`; closed `PMR-062` and `PMR-065` independently. Owner
  validation reports 319 passed and no security-review engagement ran.
- No repository creation, remote change, branch change, symlink change,
  visibility change, quarantine transfer, push, or publication action was
  performed by the Project Manager.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-067` | Teach the ordinary Beryllium Copilot owner context the exact resolver contract whose absence caused the observed failure. |
| P2 | `PMR-052` | After `PMR-044` and `PMR-045`, the successor OS-security owner closes or precisely bounds the cap-talk archive gap from the `2016-04-01` start bound. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-039` | Review XRV `backup/main..main` and decide whether to push `d618935` to the reachable private backup. |
| P2 | `PMR-040` | XRV owner reviews the three proposed-architecture documents at analysis-workbook `a46dba2`. |
| P2 | `PMR-044` | Rehouse OS security and create the separate personal quarantine repository under the recorded clean-history/manual-transfer model. |
| P2 | `PMR-045` | Rehouse XRV as `agentic-os-research/cheri-hypervisor-research`. |
| P2 | `PMR-046` | Establish the private `cheri-riscv-notes` successor and retain the slug; publication remains separately gated by license, authorship, public-mirror, and corpus-integrity review. |
| P3 | `PMR-004`, `PMR-050` | Analysis-workbook owner decides the two remaining read-only target-list additions; threat-modeler is complete at `c4126b6`. |
| P3 | `PMR-014` | Triage the five original formal-verification bibliography pointers. |
| P3 | `PMR-037` | Refresh formal-verification remote/handoff wording; bibliography formatting is complete at `784be93`. |
| P3 | `PMR-038` | Finish the still-stale two-surface sentence and handoff commit state, and add the structured return; the completion mirror itself is present at `2374115`. |
| P3 | `PMR-041` | Formal-verification owner triages the later `PMQ-021` and `PMQ-023` pointers. |
| P3 | `PMR-051` | CHERI notes owner refreshes pre-push handoff/status wording and adds the structured return for `ae09213`. |
| P3 | `PMR-009` | CHERI notes owner triages the two remaining source pointers under the current BibTeX-first D4 gate. |
| P3 | `PMR-053` | After `PMR-052`, XRV reviews only materially relevant returned cap-talk threads in the verified successor. |
| P3 | `PMR-054` | After verified OS-security and XRV returns, analysis-workbook appends the revision-bound follow-up inquiry. |
| P3 | `PMR-055` | Analysis-workbook mirrors `CRQ-002` as routed and corrects the packet's stale `OPEN-001` reference to `OPEN-003`. |
| P3 | `PMR-058` | After `PMR-045`, XRV triages the new double-trap specification, QEMU series, and corrected exact OpenSBI pointer. |
| P3 | `PMR-059` | Refresh the workbook repository handoff and add the structured return for synchronized owner commit `1ef1ac6`; `PML-0030` is already applied at `c7cc0fa`. |
| P3 | `PMR-063` | Add the explicit fail-closed tasking startup contract to analysis-workbook. |
| P3 | `PMR-064` | Add the explicit fail-closed tasking startup contract to threat-modeler and its maintainer. |
| P3 | `PMR-066` | Add the explicit fail-closed tasking startup contract to provenance-review. |
| P3 | `PMR-068..PMR-072` | Add the explicit fail-closed tasking startup contract to Helium, formal-verification, OS-security, CHERI notes, and XRV owner contexts. |
| P3 | `PMR-073` | Design and implement the Project Manager-only Git-maintainer specialist with exact request, refusal, evidence, test, and human-gate contracts. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- The organization rename is complete. No repository creation, repository
  transfer, history push, remote change, symlink retarget, visibility change,
  quarantine transfer, or Pages publication was executed in this turn.
- Successor-first sequencing is recorded for `CRQ-002`; it does not itself
  authorize either successor repository, archive access, content copy, or
  redistribution.
- The Beryllium successor and owner-return commits through `f05ccb3` are
  privately backed up; `PMR-061` is closed. None changes acceptance or
  authorization.
- Other component and coordination commits reported ahead of their remotes
  remain unpushed until separately reviewed and confirmed.
- Beryllium H0 acceptance remains open. H1-H4 remain unauthorized. K3
  execution remains `NOT RUN`.
- Helium checkout/ref reconciliation, review, publication, and release remain
  owner gates. The Project Manager records no approval.
- The complete privately backed-up paused threat model has no risk-acceptance
  effect and remains paused.
- The reappeared retained artifacts remain unverified and do not satisfy either
  H0 input-selection gate.
- Licensing, redistribution, publication, and release remain responsible-human
  decisions.

## What to review

- `../COMPONENTS.md`
- `../README.md`
- `HANDOFF.md`
- `outbox/OWNER-RUNBOOK.md`
- `outbox/component-requests.md` (`PMR-062`, `PMR-065`, `PMR-073`)
- `AGENT-INTERFACE.md`
- `AGENT-ROSTER.md`
- `README.md`
- `components/security-reviewer.md`
- `../security-reviewer/HANDOFF.md` at owner commit `f2051a4`

## Validation and commit state

The write-disabled `pm-auditor` found no blocker remaining after the final
security-reviewer return was re-observed. Its initial split-state finding and
all stale/minor findings were corrected in the requests, runbook, interface,
roster, cards, handoff, registry, and READMEs. `PMR-073` remains planned-only
and grants no Git authority.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 322 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 364 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 31/31 exact; no source edit is due;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md` and
  `README.md`.

Post-commit tasking generation and current-view checking follow the Project
Manager commit so each ignored view can name the exact containing HEAD.

This handoff is included in the twenty-sixth-turn Project Manager commit. Its
exact HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed from
  2026-09-16T03:54Z through 2026-09-16T03:59Z.
- Responsible-human direction:
  `"add to project todo: create a git maintainer agent which can be invoked
  by project manager agent, and requested by sub agents"`.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 31/31,
  no edit due after carry `c7cc0fa`.
- Analysis-workbook owner evidence: clean synchronized owner commit
  `1ef1ac6`; session handoff is complete, while repository handoff/structured
  return remain `PMR-059`.
- Analysis-workbook carry: clean-state and instruction checks preceded the
  one-row class-1 change; component commit `c7cc0fa` applies `PML-0030`.
- Security-reviewer history: Project Manager carry `79c664f` closed
  `PMR-060` and was then four ahead; owner commit `f2051a4` now closes
  `PMR-062`/`PMR-065` and is synchronized 0/0 with private `origin/main`.
- Required write-disabled `pm-auditor` pass identified one initial
  tasking-authority blocker; it and all stale/minor findings were corrected
  before final validation.
- Project-wide model direction:
  `"also, project-wide, substitute Opus 5 for Fable 5.1 in review/eval
  roles, to save costs. I will specify Fable 5.1 later as needed."`
- Tasking-startup direction:
  `"these agents should know exactly how to check pm tasking, this one seems
  to not know yet"`; the observed Beryllium owner session searched persisted
  sessions and background agents until the responsible human cancelled it.
- Security-reviewer return: responsible-human exact SHA `f2051a4`; sanitized
  state/refs verify clean synchronized `main` / `origin/main`; component
  handoff returns `PMR-062` and `PMR-065` independently with 319 passing
  tests and no engagement.
- Previous full Project Manager handoff: Git object
  `5d19b74:HANDOFF.md`.
