# Beryllium Project Manager handoff

**Last updated:** 2026-09-14
**Update scope:** fifteenth coordination turn; implemented generated,
fail-closed per-component Project Manager tasking discovery and closed
`PMR-048`. `PMR-049` remains the authenticated D0 human-verification gate.
No component, organization, repository, remote, symlink, visibility,
quarantine, or publication change was executed.

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
| D0 transition inventory | `PMD-20260914-004` records current/target repository, visibility, authorship, licensing, publicability, branch/backup, old-reference, GitHub-service, quarantine, and active-session fields for the parent and all eleven registered repositories. Bounded local inventory `PMR-047` is closed. Authenticated service facts and unresolved human determinations remain `PMR-049`; no external transition is unlocked. |
| Generated tasking | `PMR-048` is closed citing `PMD-20260914-005`. `scripts/project-tasking.sh` generates ignored per-component views from the committed authoritative request table and resolves either a direct checkout or tracked workspace symlink. It refuses missing, dirty, stale-commit, or wrong-request-blob state rather than showing stale tasking. |
| Quarantine | Licensed/restricted resources require a separate private repository visible only to the responsible human. Exact owner, slug, transfer method, and history policy remain `unknown`; the Project Manager never opens or copies the restricted OS-security subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Verify the D0 unknowns before renaming the organization or creating active
successor repositories:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
copilot
# then: /agent project-manager
```

Tell the Project Manager the facts you verified:

```text
Record these PMR-049 answers that I verified from authenticated owner views.
I confirm these additional Microsoft-origin repositories: <names or none>.
The exact
visibility, namespace, authorship, licensing/redistribution, publicability,
Wiki/releases/issues/discussions, Pages/Actions/packages/webhooks/integrations,
and quarantine answers for fields marked unknown are: <answers>. I have not
included credentials, private URLs, serial numbers, or restricted content.
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

- Added `scripts/project-tasking.sh` with `generate`, `check`, and `resolve`
  modes. The authoritative state remains `outbox/component-requests.md`.
- Added ignored local `outbox/tasking/<component>.md` projections recording
  the exact Project Manager commit and committed request-table blob.
- Added fixture coverage for component-name, direct-checkout, and physical
  symlink-entry resolution; cross-named requests; closed and other-owner
  filtering; missing views; dirty request state; stale Project Manager HEAD;
  regeneration; and current-view checks.
- Recorded the contract in `PMD-20260914-005` and closed `PMR-048`.
- Updated the Project Manager agent, skill, instructions, interface, roster,
  README, runbook, parent registry, and parent README. No component or
  external GitHub operation was performed.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P1 | `PMR-028` | Back up the complete private paused threat-model package and reconcile its stale delivery wording through `threat-model-maintainer`. |
| P1 | `PMR-029` | Preserve and complete or intentionally park the dirty CHERI notes topic branch before any PM action there. |
| P1 | `PMR-049` | Verify authenticated GitHub service state, complete Microsoft-origin scope, and the licensing/authorship/publicability/quarantine unknowns in `PMD-20260914-004`; every external transition remains blocked. |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-020` | Verify CHERI notes remote access after the active dirty work is resolved. |
| P2 | `PMR-039` | Review XRV `backup/main..main` and decide whether to push `d618935` to the reachable private backup. |
| P2 | `PMR-040` | XRV owner reviews the three proposed-architecture documents at analysis-workbook `a46dba2`. |
| P2 | `PMR-043` | After `PMR-049` and the organization rename, rehouse Beryllium privately at `agentic-os-research/beryllium`; keep the Microsoft repository reference-only. |
| P2 | `PMR-044` | After `PMR-027`, `PMR-049`, and the organization rename, rehouse OS security and design the separate human-only quarantine repository. |
| P2 | `PMR-045` | After `PMR-049` and the organization rename, rehouse XRV as `agentic-os-research/cheri-hypervisor-research`. |
| P2 | `PMR-046` | After `PMR-029`, `PMR-049`, and the organization rename, rehouse `cheri-riscv-notes`, retain the slug, and prepare the gated SoK publication pilot. |
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
- `PMR-049` must close before any external transition. `PMD-20260914-004`
  does not convert unknown GitHub, authorship, licensing, redistribution,
  publicability, or quarantine facts into approvals.
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
- `../README.md`
- `HANDOFF.md`
- `outbox/OWNER-RUNBOOK.md`
- `outbox/component-requests.md` (`PMR-043..PMR-049`, and superseded
  `PMR-023`)
- `records/decisions/PMD-20260914-005-generated-component-tasking.md`
- `scripts/project-tasking.sh`
- `outbox/tasking/README.md`
- `tests/validate-agent.sh`
- `.github/agents/project-manager.agent.md`
- `.github/skills/beryllium-project-management/SKILL.md`
- `.github/copilot-instructions.md`
- `AGENT-INTERFACE.md`
- `AGENT-ROSTER.md`
- `README.md`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its functional,
stale, and minor findings were corrected in the resolver, tests, tasking
contract, handoff, roster, and registry. No component write was attempted.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 234 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 294 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 27/27 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md` and
  `README.md`.

Post-commit generation and current-view checking follow the Project Manager
commit so each ignored view can name the exact containing HEAD.

This handoff is included in the fifteenth-turn Project Manager commit. Its exact
HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed
  2026-09-14T23:25Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 27/27,
  no edit due.
- User direction: after being told `PMR-049` requires authenticated human
  facts, selected autonomous local tasking pilot `PMR-048`. No human gate or
  external operation was granted.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  its symlink-invocation, cross-component filtering, coverage, check-order,
  missing-view, stale wording, and provenance findings were corrected.
- Previous full Project Manager handoff: Git object
  `9f6b662:HANDOFF.md`.
