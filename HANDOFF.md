# Beryllium Project Manager handoff

**Last updated:** 2026-09-15
**Update scope:** seventeenth coordination turn; verified threat-modeler owner
return `c4126b6`, closed `PMR-028`, and recorded completion of the
threat-modeler halves of `PMR-004` and `PMR-022`. No Project Manager
component write or external operation was performed.

**Workspace root:** `/home/jmorris/src/beryllium-project`
**Project Manager repository:** `project-manager/`, branch `main`
**Parent coordination repository:** branch `main`, tracking `upstream/main`

## Fast resume

### Overall position

| Area | Current state |
| --- | --- |
| Beryllium runtime | R0-R7 are responsible-human accepted. R8-H0 is a committed candidate and is not accepted. H1-H4 are not authorized. K3 hardware is `NOT RUN`. |
| Helium | Clean detached HEAD at `1ab289c`, also named by synchronized `for-review`; separate refs include travel `52cc71a` and `public/main` plus tag `v0.6.0` at `1c9e526`. The checked-out handoff says release remains blocked, so `PMR-026` asks the owner to reconcile checkout/ref/handoff state. The Project Manager infers no release or approval from ref names or commit subjects. Helium remains a review-and-test PoC, not formally verified or hardware validated. |
| Threat model | `TM-20260911-001-helium-te-poc-astra` is complete, private, backed up, and paused by explicit user request. Owner maintenance commit `c4126b6` follows owner package `5bf6a4b` and Project Manager carry `f4eb272`; clean `main` is synchronized with private `origin/main`. `PMR-028` is closed. The model's risks are conditional analysis, not observed compromise or risk acceptance. |
| XRV | Historical commit `7314e2f` remains unavailable and `REV-20260904-001..009` remain reserved. Replacement records are backed up at `706e708`; owner commit `d618935` adds root `COLLAB.md` and `REV-20260914-010..013`. The responsible human reports the deep-research session complete; no successor XRV commit is observed. `PMR-039` is the private backup decision and `PMR-040` requests review of the new proposed architecture. |
| Analysis-workbook | Owner commit `a46dba2` completes the CHERI-native hypervisor security-model session with five inquiries and five queue rows. Four rows were duplicates; `PMQ-023` was recorded as a metadata-only routed pointer in formal-verification `sources/bibliography.md` at `784be93`. Project Manager carry `b93722b` applies `PML-0023..0027`; `main` is clean and seven ahead of `origin/main`. `PMR-038` remains for the CRQ completion mirror and stale interface/handoff wording. |
| Active owner work | `cheri-riscv-notes-repo` is dirty on no-upstream branch `docs/reconcile-project-status` at `6553092`, with 21 changed entries. The Project Manager did not modify it (`PMR-029`, P1). |
| Formal verification | Clean `main` at `784be93`, two ahead of the reachable `origin/main`. The latest carry adds metadata-only `PMQ-023` and normalizes the routed-pointer section; `PMR-037` remains open only for owner-maintained remote/handoff wording. |
| Other drift | `osr-claude` is clean at `f2edd17`, one behind `origin/main` at `e275544` (`PMR-027`, P2). `provenance-review` advanced cleanly to synchronized `9bfbab3`. |
| Other components | `beryllium-repo` remains clean at `65f6d89`; `security-reviewer` remains at `c13c36e`. |
| Queues | 26 source-discovery rows / 26 ledger rows plus one transfer row. `PMQ-022`, `024..026` are duplicates; `PMQ-023` is accepted at `784be93`; all five source edits were applied at `b93722b`. Only `PMQ-008` and `PMQ-011` remain `new`/ledger-routed. `HET-001` remains `recorded` with input state `unaccepted`. |
| Coordination model | `PMD-20260914-002` adopts pull-based owner returns in component handoffs and PM-owned outbound requests/cards. Every repository write requires a fresh worktree and active-session check; a clean tree alone is not permission. |
| Approved target topology | `PMD-20260914-003` records the responsible human's approval of `agentic-os-research` as the future active namespace for independent research, Beryllium, and approved successor repositories. Microsoft homes remain inactive references. `PMD-20260915-001` confirms private targets `beryllium`, `cheri-hypervisor-research`, `os-security-research`, and retained `cheri-riscv-notes`. |
| D0 transition inventory | `PMD-20260914-004` records the bounded local inventory. `PMD-20260915-001` records the guided owner inventory and closes `PMR-049`: no additional Microsoft-origin repositories; all successors private initially; four exact active target names confirmed; workflow/evidence repositories and formal-verification stay under `beryllium-project`; no repository is public-approved now. "None known" remains an owner statement, not an independently authenticated negative finding. |
| Generated tasking | `PMR-048` is closed citing `PMD-20260914-005`. `scripts/project-tasking.sh` generates ignored per-component views from the committed authoritative request table and resolves either a direct checkout or tracked workspace symlink. It refuses missing, dirty, stale-commit, or wrong-request-blob state rather than showing stale tasking. |
| Human interaction | `PMD-20260915-002` requires one short structured question at a time where appropriate. The Project Manager carries answers forward and prepares matrices and machine-shaped records; the human is not used as a parsing engine. |
| Quarantine | Licensed/restricted OS-security resources use private personal repository `os-security-restricted-sources`, clean new history, and manual responsible-human review/copy with license metadata. The Project Manager never opens or copies the restricted subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Continue or intentionally park the dirty CHERI-RISC-V notes topic work:

```sh
cd /home/jmorris/src/beryllium-project/cheri-riscv-notes-repo
copilot
```

Then say: `check Project Manager tasking`.

### Minimal restart commands

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh status
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/project-tasking.sh check
bash ./scripts/inspect-components.sh registry-check
git status --short --branch
git -C .. status --short --branch
```

## What changed in this turn

- Verified threat-modeler owner return and exact synchronized commit
  `c4126b6`.
- Closed `PMR-028`: the complete private paused package, Project Manager
  carry, and owner maintenance are backed up; delivery wording is current.
- Recorded that threat-modeler's owner-only `scripts/readonly-inspect.sh`
  registrations for `project-manager` (`PMR-004`) and `security-reviewer`
  (`PMR-022`) are complete. Closed threat-owned `PMR-022` and opened distinct
  analysis-workbook follow-up `PMR-050`.
- No Project Manager component write or external operation was performed.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P1 | `PMR-029` | Preserve and complete or intentionally park the dirty CHERI notes topic branch before any PM action there. |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-020` | Verify CHERI notes remote access after the active dirty work is resolved. |
| P2 | `PMR-039` | Review XRV `backup/main..main` and decide whether to push `d618935` to the reachable private backup. |
| P2 | `PMR-040` | XRV owner reviews the three proposed-architecture documents at analysis-workbook `a46dba2`. |
| P2 | `PMR-043` | After the organization rename, rehouse Beryllium privately at `agentic-os-research/beryllium`; keep the Microsoft repository reference-only. |
| P2 | `PMR-044` | After `PMR-027` and the organization rename, rehouse OS security and create the separate personal quarantine repository under the recorded clean-history/manual-transfer model. |
| P2 | `PMR-045` | After the organization rename, rehouse XRV as `agentic-os-research/cheri-hypervisor-research`. |
| P2 | `PMR-046` | After `PMR-029` and the organization rename, rehouse `cheri-riscv-notes`, retain the slug, and preserve the later gated SoK publication pilot. |
| P3 | `PMR-004`, `PMR-050` | Analysis-workbook owner decides the two remaining read-only target-list additions; threat-modeler is complete at `c4126b6`. |
| P3 | `PMR-014` | Triage the five original formal-verification bibliography pointers. |
| P3 | `PMR-033` | Correct the security-reviewer handoff's self-stale pre-carry synchronization sentence in the next turn or by its owner. |
| P3 | `PMR-037` | Refresh formal-verification remote/handoff wording; bibliography formatting is complete at `784be93`. |
| P3 | `PMR-038` | Mirror `CRQ-001` as `completed` from closed `PMR-034` and XRV commit `d618935`. |
| P3 | `PMR-041` | Formal-verification owner triages the later `PMQ-021` and `PMQ-023` pointers. |
| P4 | `PMR-009` | CHERI notes owner triages the two remaining source pointers after the active topic work. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- No organization rename, repository creation, repository transfer, history
  push, remote change, symlink retarget, visibility change, or Pages
  publication was executed. The human approvals establish target state, not
  completion of external operations.
- `PMR-049` is closed, but no organization rename or repository operation has
  been performed or authorized for agent execution. Each remains a distinct
  responsible-human action.
- Existing local commits remain unpushed until separately reviewed and
  confirmed.
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
- `HANDOFF.md`
- `outbox/OWNER-RUNBOOK.md`
- `outbox/component-requests.md` (`PMR-004`, `PMR-022`, `PMR-028`,
  `PMR-050`)
- `components/threat-modeler.md`
- `../threat-modeler/HANDOFF.md` at `c4126b6`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected in the requests, runbook, threat-modeler card,
handoff, and registry. No component write was attempted.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 256 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 304 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 27/27 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md`.

Post-commit tasking generation and current-view checking follow the Project
Manager commit so each ignored view can name the exact containing HEAD.

This handoff is included in the seventeenth-turn Project Manager commit. Its exact
HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed
  2026-09-15T03:45Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 27/27,
  no edit due.
- User return: "done" after starting `threat-model-maintainer` for `PMR-028`.
  Component-owned `HANDOFF.md` and synchronized commit `c4126b6` provide the
  verified owner return.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  stale and minor findings were corrected in the requests, runbook,
  threat-modeler card, handoff, and registry.
- Previous full Project Manager handoff: Git object
  `8396c95:HANDOFF.md`.
