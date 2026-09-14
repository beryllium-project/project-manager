# Beryllium Project Manager handoff

**Last updated:** 2026-09-14
**Update scope:** thirteenth coordination turn; recorded the responsible
human's approved federated research topology, target
`agentic-os-research` organization, Microsoft-reference retirement model,
Beryllium rehome, private quarantine boundary, and task-discovery direction.
No organization, repository, remote, symlink, visibility, or publication
change was executed.

**Workspace root:** `/home/jmorris/src/beryllium-project`
**Project Manager repository:** `project-manager/`, branch `main`
**Parent coordination repository:** branch `main`, tracking `upstream/main`

## Fast resume

### Overall position

| Area | Current state |
| --- | --- |
| Beryllium runtime | R0-R7 are responsible-human accepted. R8-H0 is a committed candidate and is not accepted. H1-H4 are not authorized. K3 hardware is `NOT RUN`. |
| Helium | Clean detached HEAD at `1ab289c`, also named by synchronized `for-review`; separate refs include travel `52cc71a` and `public/main` plus tag `v0.6.0` at `1c9e526`. The checked-out handoff says release remains blocked, so `PMR-026` asks the owner to reconcile checkout/ref/handoff state. The Project Manager infers no release or approval from ref names or commit subjects. Helium remains a review-and-test PoC, not formally verified or hardware validated. |
| Threat model | `TM-20260911-001-helium-te-poc-astra` is complete, private, and paused by explicit user request. Owner commit `5bf6a4b` is local; Project Manager carry `f4eb272` follows it. `main` is two ahead of `origin/main` (`PMR-028`, P1). The model's risks are conditional analysis, not observed compromise or risk acceptance. |
| XRV | Historical commit `7314e2f` remains unavailable and `REV-20260904-001..009` remain reserved. Replacement records are backed up at `706e708`; owner commit `d618935` adds root `COLLAB.md` and `REV-20260914-010..013`. The responsible human reports the deep-research session complete; no successor XRV commit is observed. `PMR-039` is the private backup decision and `PMR-040` requests review of the new proposed architecture. |
| Analysis-workbook | Owner commit `a46dba2` completes the CHERI-native hypervisor security-model session with five inquiries and five queue rows. Four rows were duplicates; `PMQ-023` was recorded as a metadata-only routed pointer in formal-verification `sources/bibliography.md` at `784be93`. Project Manager carry `b93722b` applies `PML-0023..0027`; `main` is clean and seven ahead of `origin/main`. `PMR-038` remains for the CRQ completion mirror and stale interface/handoff wording. |
| Active owner work | `cheri-riscv-notes-repo` is dirty on no-upstream branch `docs/reconcile-project-status` at `6553092`, with 21 changed entries. The Project Manager did not modify it (`PMR-029`, P1). |
| Formal verification | Clean `main` at `784be93`, two ahead of the reachable `origin/main`. The latest carry adds metadata-only `PMQ-023` and normalizes the routed-pointer section; `PMR-037` remains open only for owner-maintained remote/handoff wording. |
| Other drift | `osr-claude` is clean at `f2edd17`, one behind `origin/main` at `e275544` (`PMR-027`, P2). `provenance-review` advanced cleanly to synchronized `9bfbab3`. |
| Other components | `beryllium-repo` remains clean at `65f6d89`; `security-reviewer` remains at `c13c36e`. |
| Queues | 26 source-discovery rows / 26 ledger rows plus one transfer row. `PMQ-022`, `024..026` are duplicates; `PMQ-023` is accepted at `784be93`; all five source edits were applied at `b93722b`. Only `PMQ-008` and `PMQ-011` remain `new`/ledger-routed. `HET-001` remains `recorded` with input state `unaccepted`. |
| Coordination model | `PMD-20260914-002` adopts pull-based owner returns in component handoffs and PM-owned outbound requests/cards. Every repository write requires a fresh worktree and active-session check; a clean tree alone is not permission. |
| Approved target topology | `PMD-20260914-003` records the responsible human's approval of `agentic-os-research` as the future active namespace for independent research, Beryllium, and approved successor repositories. Microsoft homes remain inactive references. Approved identities include `cheri-hypervisor-research`, `os-security-research`, retained `cheri-riscv-notes`, and a private Beryllium target slug pending final confirmation. |
| Quarantine | Licensed/restricted resources require a separate private repository visible only to the responsible human. Exact owner, slug, transfer method, and history policy remain `unknown`; the Project Manager never opens or copies the restricted OS-security subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Complete the D0 inventory before renaming the organization or creating active
successor repositories:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
copilot
# then: /agent project-manager
```

Tell the Project Manager:

```text
Complete PMR-047 from PMD-20260914-003. Inventory every registered and
human-identified Microsoft-origin repository: current and target active
remote, visibility, authorship context, third-party licensing, publicability,
active branch and backup state, old-name references, Pages/Actions/packages
dependencies, quarantine boundary, and active-session state. Use unknown
rather than guessing and do not inspect restricted content.
```

### Minimal restart commands

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh status
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/inspect-components.sh registry-check
git status --short --branch
git -C .. status --short --branch
```

## What changed in this turn

- Recorded the responsible human's approval of consolidation decisions 1, 2,
  3, 5, 6, 7, and 8 from the two-pass Claude Fable 5.1 plan.
- Recorded the approved organization rename
  `Agentic-OS-Development` -> `agentic-os-research`.
- Recorded that all active work moves out of Microsoft repositories; old
  Microsoft homes remain inactive historical references rather than being
  renamed away.
- Recorded the approved active identities:
  `agentic-os-research/cheri-riscv-notes`,
  `agentic-os-research/cheri-hypervisor-research`,
  `agentic-os-research/os-security-research`, and private
  `agentic-os-research/beryllium`.
- Recorded that the canonical OS-security history remains private and that
  quarantined licensed resources require a separate human-only private
  repository. Moving files alone does not make old Git history public-safe.
- Opened `PMR-043..PMR-048` for Beryllium rehome, OS-security
  rehome/quarantine, XRV rehome, SoK rehome/publicability, D0 inventory, and
  the generated Project Manager tasking pilot. `PMR-043` supersedes
  `PMR-023`.
- No external GitHub operation or component write was performed.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P1 | `PMR-028` | Back up the complete private paused threat-model package and reconcile its stale delivery wording through `threat-model-maintainer`. |
| P1 | `PMR-029` | Preserve and complete or intentionally park the dirty CHERI notes topic branch before any PM action there. |
| P1 | `PMR-047` | Complete the D0 remote/licensing/authorship/publicability/quarantine inventory that gates every rename and rehome. |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-020` | Verify CHERI notes remote access after the active dirty work is resolved. |
| P2 | `PMR-039` | Review XRV `backup/main..main` and decide whether to push `d618935` to the reachable private backup. |
| P2 | `PMR-040` | XRV owner reviews the three proposed-architecture documents at analysis-workbook `a46dba2`. |
| P2 | `PMR-043` | Rehouse Beryllium privately at `agentic-os-research/beryllium`; keep the Microsoft repository reference-only. |
| P2 | `PMR-044` | Rehouse/rename OS security and design the separate human-only quarantine repository. |
| P2 | `PMR-045` | Rehouse/rename XRV as `agentic-os-research/cheri-hypervisor-research`. |
| P2 | `PMR-046` | Rehouse `cheri-riscv-notes`, retain the slug, and prepare the gated SoK publication pilot. |
| P2 | `PMR-048` | After D0, pilot generated per-component Project Manager tasking discovery. |
| P3 | `PMR-004`, `PMR-022` | Owners decide the analysis/threat read-only target-list additions. |
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
- Existing local commits remain unpushed until separately reviewed and
  confirmed.
- Beryllium H0 acceptance remains open. H1-H4 remain unauthorized. K3
  execution remains `NOT RUN`.
- Helium checkout/ref reconciliation, review, publication, and release remain
  owner gates. The Project Manager records no approval.
- The complete paused threat model has no risk-acceptance effect.
- The reappeared retained artifacts remain unverified and do not satisfy either
  H0 input-selection gate.
- Licensing, redistribution, publication, and release remain responsible-human
  decisions.

## What to review

- `../COMPONENTS.md`
- `HANDOFF.md`
- `outbox/OWNER-RUNBOOK.md`
- `outbox/component-requests.md` (`PMR-043..PMR-048`, and superseded
  `PMR-023`)
- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
- `components/beryllium-repo.md`
- `components/osr-claude.md`
- `components/xrv-research-repo.md`
- `components/cheri-riscv-notes-repo.md`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected or recorded as open requests. `PMR-033` remains
deliberately deferred; no security-reviewer write was attempted.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 212 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 267 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 27/27 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md` and
  `README.md`.

This handoff is included in the thirteenth-turn Project Manager commit. Its exact
HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed
  2026-09-14T19:41Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 27/27,
  no edit due.
- User direction: approved consolidation decisions 1, 2, 3, 5, 6, 7, and 8;
  selected `Agentic-OS-Development` for rename to `agentic-os-research`;
  directed Beryllium and other Microsoft-origin active work to new GitHub
  homes while old repositories remain inactive references; and required a
  separate human-only private quarantine repository for licensed resources.
  These are target-state decisions, not completed external operations.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  stale and minor findings were corrected in the approval record, requests,
  runbook, cards, registry, and parent README.
- Previous full Project Manager handoff: Git object
  `c7a40b9:HANDOFF.md`.
