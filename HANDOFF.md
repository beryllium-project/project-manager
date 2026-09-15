# Beryllium Project Manager handoff

**Last updated:** 2026-09-15
**Update scope:** twenty-first coordination turn; verified `PMR-027`
complete, recorded the responsible human's revised private Beryllium target
and active branch, reconciled two active owner-session locks, and ledgered
four new workbook source rows. The responsible human, not the Project
Manager, manually pushed the Beryllium successor. No repository creation,
transfer, remote, branch, symlink, visibility, quarantine transfer, push, or
publication action was performed by the Project Manager.

**Workspace root:** `/home/jmorris/src/beryllium-project`
**Project Manager repository:** `project-manager/`, branch `main`
**Parent coordination repository:** branch `main`, tracking `upstream/main`

## Fast resume

### Overall position

| Area | Current state |
| --- | --- |
| Beryllium runtime | R0-R7 are responsible-human accepted. R8-H0 is a committed candidate and is not accepted. H1-H4 are not authorized. K3 hardware is `NOT RUN`. The canonical checkout is currently dirty on placeholder `main` at `a7809db`; the responsible human selected synchronized `beryllium/single-hart-runtime-r0` at `65f6d89` as the active branch and private `beryllium-project/beryllium-hypervisor` as the revised target. `PMR-057` must restore the active checkout and owner handoff. |
| Helium | Clean detached HEAD at `1ab289c`, also named by synchronized `for-review`; separate refs include travel `52cc71a` and `public/main` plus tag `v0.6.0` at `1c9e526`. The checked-out handoff says release remains blocked, so `PMR-026` asks the owner to reconcile checkout/ref/handoff state. The Project Manager infers no release or approval from ref names or commit subjects. Helium remains a review-and-test PoC, not formally verified or hardware validated. |
| Threat model | `TM-20260911-001-helium-te-poc-astra` is complete, private, backed up, and paused by explicit user request. Owner maintenance commit `c4126b6` follows owner package `5bf6a4b` and Project Manager carry `f4eb272`; clean `main` is synchronized with private `origin/main`. `PMR-028` is closed. The model's risks are conditional analysis, not observed compromise or risk acceptance. |
| XRV | Historical commit `7314e2f` remains unavailable and `REV-20260904-001..009` remain reserved. Replacement records are backed up at `706e708`; owner commit `d618935` adds root `COLLAB.md` and `REV-20260914-010..013`. The responsible human reports the deep-research session complete; no successor XRV commit is observed. `PMR-039` is the private backup decision and `PMR-040` requests review of the new proposed architecture. |
| Analysis-workbook | Dirty owner session based at `2374115` adds complete private `AWB-20260915-001-smdbltrp-consideration`, four source rows, and generated index/log changes. `PML-0028..0031` now cover all rows; `PMR-058` routes three pointers to XRV after its successor, while `PMR-059` asks the active owner to commit/return and apply the one due `PMQ-029` rejection. No concurrent Project Manager write is permitted. |
| CHERI-RISC-V notes | Owner topic commit `ae09213` preserves the former 21-entry reconciliation and corpus-validator work. Clean `docs/reconcile-project-status` is synchronized with `origin/docs/reconcile-project-status`; `main` remains `6553092`. `PMR-029` and `PMR-020` are closed. `PMR-051` requests a post-push handoff/status refresh; `PMR-009` source triage is now actionable. |
| Formal verification | Clean `main` at `784be93`, two ahead of the reachable `origin/main`. The latest carry adds metadata-only `PMQ-023` and normalizes the routed-pointer section; `PMR-037` remains open only for owner-maintained remote/handoff wording. |
| Other drift | `osr-claude` is clean and synchronized at `e275544`; `PMR-027` is closed and `PMR-044` is actionable. `provenance-review` remains synchronized at `9bfbab3`. |
| Other components | Security-reviewer is clean at Project Manager carry `12fd9fb`, three ahead of `origin/main`; `PMR-033` and `PMR-056` are closed, `PMR-060` tracks stable post-refresh wording, and no engagement ran. |
| Queues | 30 source-discovery rows / 30 source ledger rows plus one transfer row are ledger-complete. `PMQ-027`, `028`, and corrected `030` are routed to XRV; `PMQ-029` is rejected as superseded, with its source edit still due because the workbook is dirty. `PMQ-008` and `011` remain routed; `HET-001` remains `recorded`/`unaccepted`. |
| Cap-talk closure | `PMR-027` is complete. Successor-first sequencing now requires `PMR-044` and `PMR-045`; then `PMR-052` acquires or bounds the public continuation from the `2016-04-01` start bound, followed by XRV review `PMR-053` and workbook follow-up `PMR-054`. |
| Coordination model | `PMD-20260914-002` adopts pull-based owner returns in component handoffs and PM-owned outbound requests/cards. Every repository write requires a fresh worktree and active-session check; a clean tree alone is not permission. |
| Approved target topology | The organization is `agentic-os-research`. `PMD-20260915-005` supersedes the Beryllium mapping only: private `beryllium-project/beryllium-hypervisor` is the active target, with `beryllium/single-hart-runtime-r0` retained as its active branch. OS-security, XRV, and CHERI notes retain their `agentic-os-research` targets. |
| D0 transition inventory | `PMD-20260914-004` records the bounded local inventory. `PMD-20260915-001` closes `PMR-049`: no additional Microsoft-origin repositories, all successors private initially, and no repository public-approved. `PMD-20260915-005` supersedes only its Beryllium target name; workflow/evidence repositories and formal-verification otherwise stay under `beryllium-project`. "None known" remains an owner statement, not an independently authenticated negative finding. |
| Generated tasking | `PMR-048` is closed citing `PMD-20260914-005`. `scripts/project-tasking.sh` generates ignored per-component views from the committed authoritative request table and resolves either a direct checkout or tracked workspace symlink. It refuses missing, dirty, stale-commit, or wrong-request-blob state rather than showing stale tasking. |
| Human interaction | `PMD-20260915-002` requires one short structured question at a time where appropriate. The Project Manager carries answers forward and prepares matrices and machine-shaped records; the human is not used as a parsing engine. |
| Review/evaluation model | `PMD-20260915-006` sets future delegated review/evaluation work to `claude-opus-5`, reasoning effort `max`, and context tier `long_context` unless explicitly overridden. It begins after this session; the already-launched audit was not restarted. |
| Quarantine | Licensed/restricted OS-security resources use private personal repository `os-security-restricted-sources`, clean new history, and manual responsible-human review/copy with license metadata. The Project Manager never opens or copies the restricted subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Finish Beryllium successor reconciliation under `PMR-057`:

```sh
cd /home/jmorris/src/beryllium-project/beryllium-repo
git status --short --branch
git switch beryllium/single-hart-runtime-r0
git status --short --branch
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
copilot
```

If the switch refuses because an untracked path conflicts, stop; do not force,
clean, or delete it. Otherwise say: `complete PMR-057`. The owner must
preserve or disposition the untracked `build/` and `node_modules/`, verify
complete successor history, update `planning/HANDOFF.md`, run maintained
validation, and return exact state. The responsible human also selected this
as the GitHub default branch; the exact owner command is in
`outbox/OWNER-RUNBOOK.md`.

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

- Closed `PMR-027` after verifying OS-security clean and synchronized at
  `e275544`; `PMR-044` is now actionable.
- Recorded `PMD-20260915-005` from the responsible human's exact answers:
  private `beryllium-project/beryllium-hypervisor` replaces the prior target,
  and `beryllium/single-hart-runtime-r0` remains active. Superseded
  `PMR-003`/`PMR-043`; `PMR-057` owns remaining reconciliation.
- Observed Beryllium dirty on placeholder `main` at `a7809db` with untracked
  `build/` and `node_modules/`; no Project Manager component write or cleanup
  was attempted.
- Ledgered `PMQ-027..030` as `PML-0028..0031`. Three route through
  `PMR-058`; `PMQ-029` is rejected as superseded by `PMQ-030`. Dirty active
  workbook state blocks the one class-1 edit, handed to its owner in
  `PMR-059`.
- No repository creation, transfer, remote, branch, symlink, visibility,
  quarantine transfer, push, or publication action was performed by the
  Project Manager.
- Carried `PMR-056` as security-reviewer class-3 coordination wording at
  `12fd9fb`. No engagement or gate changed; `PMR-060` records the distinct
  stable-wording follow-up rather than making a prohibited second component
  commit.
- Recorded `PMD-20260915-006` and updated Project Manager configuration so
  future delegated review/evaluation work uses Claude Opus 5 with maximum
  reasoning and long context unless explicitly overridden. The current
  already-launched audit was not restarted.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-057` | Restore the selected Beryllium active branch and owner handoff in private `beryllium-project/beryllium-hypervisor`; preserve the dirty artifacts under owner control. |
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
| P3 | `PMR-060` | Replace security-reviewer's post-refresh self-reference with stable historical wording and its closed `PMR-022` item with remaining `PMR-050`; one component commit per turn prevents doing it now. |
| P3 | `PMR-058` | After `PMR-045`, XRV triages the new double-trap specification, QEMU series, and corrected exact OpenSBI pointer. |
| P3 | `PMR-059` | Active workbook owner commits `AWB-20260915-001`, applies the exact `PMQ-029` rejection, and returns validation/backup state. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- The organization rename is complete. No repository creation, repository
  transfer, history push, remote change, symlink retarget, visibility change,
  quarantine transfer, or Pages publication was executed in this turn.
- Successor-first sequencing is recorded for `CRQ-002`; it does not itself
  authorize either successor repository, archive access, content copy, or
  redistribution.
- The responsible human reports the private Beryllium successor push
  complete. Its default/active checkout and handoff remain open owner work,
  and the push changes no acceptance or authorization state.
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
- `outbox/component-requests.md` (`PMR-027`, `PMR-043`,
  `PMR-057..PMR-060`)
- `queue/LEDGER.md` (`PML-0028..PML-0031`)
- `records/decisions/PMD-20260915-005-beryllium-target-revised.md`
- `records/decisions/PMD-20260915-006-review-evaluation-model-preference.md`
- `.github/agents/pm-auditor.agent.md`
- `.github/agents/project-manager.agent.md`
- `.github/copilot-instructions.md`
- `.github/skills/beryllium-project-management/SKILL.md`
- `AGENT-INTERFACE.md`
- `AGENT-ROSTER.md`
- `README.md`
- `tests/validate-agent.sh`
- `components/analysis-workbook.md`
- `components/beryllium-repo.md`
- `components/osr-claude.md`
- `components/xrv-research-repo.md`
- `../security-reviewer/HANDOFF.md` at component commit `12fd9fb`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected in the decision records, requests, ledger,
runbook, cards, handoff, registry, README files, and agent-model contract.
Security-reviewer carry `12fd9fb` closes `PMR-056`; stable follow-up wording
is preserved as distinct `PMR-060` because a second component commit in one
turn is prohibited.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 300 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 324 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 31/31 exact; one source edit remains
  due and is handed to the active workbook owner;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md` and
  `README.md`.

Post-commit tasking generation and current-view checking follow the Project
Manager commit so each ignored view can name the exact containing HEAD.

This handoff is included in the twenty-first-turn Project Manager commit. Its
exact HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed from
  2026-09-15T20:40Z through 2026-09-15T20:48Z.
- OS-security return: responsible-human statement `"ok, completed pmr-027"`;
  sanitized state and refs verify clean synchronized `e275544`.
- Beryllium return and decisions: `"i have also pushed the beryllium repo to
  gh as beryllium-hypervisor"`; exact repository
  `beryllium-project/beryllium-hypervisor`; role `replace-target`; visibility
  `private`; active branch `beryllium/single-hart-runtime-r0`.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 31/31,
  with one `PMQ-029` edit due and handed to the dirty active workbook owner.
- Analysis-workbook owner evidence: dirty local `main` based at `2374115`,
  eight ahead of `origin/main`; live files expose complete uncommitted
  `AWB-20260915-001` and `PMQ-027..030`.
- Security-reviewer carry: clean-state and instruction checks preceded the
  one-file class-3 `HANDOFF.md` change; component commit `12fd9fb` closes
  `PMR-056` and leaves the component three ahead of `origin/main`.
- Future model preference: `"after this session, use Opus 5 max effort max
  context for review/eval purposes in place of fable 5.1 unless otherwise
  specified, to reduce costs."` Recorded in `PMD-20260915-006`; the
  already-launched audit was not restarted.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  stale and minor findings were corrected, with the distinct post-carry
  self-reference recorded as `PMR-056`.
- Previous full Project Manager handoff: Git object
  `5ff7e09:HANDOFF.md`.
