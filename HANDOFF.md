# Beryllium Project Manager handoff

**Last updated:** 2026-09-14
**Update scope:** tenth coordination turn plus a post-turn owner-return note.
The owner return has not yet been reconciled into Project Manager requests,
ledger rows, component cards, or the parent registry.

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
| Collaboration proposal | Analysis-workbook owner commit `4c771c0` adds the three-lane XRV proposal and `CRQ-001`. `PMD-20260914-001` records it as owner-ready, not owner-approved. `PMR-034` routes it to XRV after `PMR-025`; `PMR-036` requests correction of the new queue's status-writer contract. |
| Active owner work | `cheri-riscv-notes-repo` is dirty on no-upstream branch `docs/reconcile-project-status` at `6553092`, with 21 changed entries. The Project Manager did not modify it (`PMR-029`, P1). |
| Restored component | `formal-verification-research/` is again present at its registered direct path. It was observed clean and synchronized at `e5740de`; its `origin` now denotes the reachable `beryllium-project` backup. `PMR-024` is closed. Project Manager carry `c55065c` adds only the `PMQ-021` metadata pointer and is local, one ahead. |
| Relocated XRV repository | The tracked symlink now resolves to clean `ca41490`, 0/0 against an `origin/main` last fetched from the unreachable `jamorris_microsoft` namespace; live backup state is unknown. Previously observed commit `7314e2f` and its nine `REV-20260904-001..009` intake records are absent from the current repository (`PMR-025`, P1). Historical ledger dispositions remain recorded but current owner-index materialization is unavailable. |
| Other drift | `osr-claude` is clean at `f2edd17`, one behind `origin/main` at `e275544` (`PMR-027`, P2). `provenance-review` advanced cleanly to synchronized `9bfbab3`. |
| Other components | `beryllium-repo` remains clean at `65f6d89`; `analysis-workbook` is clean at `8899176`, three ahead of `origin/main`; `security-reviewer` remains at `c13c36e`. |
| Queues | 21 source-discovery rows / 21 ledger rows plus one transfer row. `PMQ-017..020` are routed to XRV as `PML-0018..0021`; `PMQ-021` is accepted as metadata-only and its source status was applied at `8899176`. `PMQ-008` and `PMQ-011` remain routed. `HET-001` remains `recorded` with input state `unaccepted`. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### Post-turn owner return: reconcile first

The responsible human ran the requested XRV and analysis-workbook owner
sessions after this handoff's tenth coordination turn. Treat the following as
an owner report to verify read-only, not as Project Manager closure or a
replacement for the request and ledger protocols:

| Request | Reported owner result | Reported repository state |
| --- | --- | --- |
| `PMR-025` | No local Git repository contained `7314e2f`. Historical IDs `REV-20260904-001..009` remain reserved; the nine pointers were re-recorded as `REV-20260914-001..009`. A reachable private backup `beryllium-project/xrv-research` was created and verified. | XRV commit `706e7082c66fd2a6e88d951e6d998cc8820553cc` is reported on `backup/main`. |
| `PMR-034` | XRV adopted root `COLLAB.md`, kept `review-log.md` plus `review-inbox/` as source intake, aligned owner instructions and handoff, and recorded `PMQ-017..020` as `REV-20260914-010..013`. | XRV commit `d618935` is reported local on `main`, one ahead of `backup/main`; it was intentionally not pushed. |
| `PMR-036` | The analysis-workbook owner assigned CRQ status mirroring to the workbook maintainer, preserved exact Project Manager or owner records as authority, and mirrored `CRQ-001` as `routed` from `PMR-034`. | Analysis-workbook commit `62ee356` is reported local on `main`, four ahead of `origin/main`; it was intentionally not pushed. |

Reported validation:

- XRV review-ID uniqueness, review-log links, changed-path checks, and
  `git diff --check` passed.
- Analysis-workbook's direct transfer-queue validation, workbook check,
  PMR-036 assertions, and `git diff --check` passed.
- The full analysis-workbook contract suite reproduced its documented
  baseline of 182 passes and 8 pre-existing transfer-transition fixture
  failures; do not report the suite as fully green.

On the next Project Manager run:

1. Run the minimal restart commands below and verify all three reported
   commits and remote/ahead states through maintained read-only inspection.
2. Inspect XRV `706e708..d618935` and analysis-workbook
   `8899176..62ee356`; confirm the owner report matches the exact changed
   paths and component contracts.
3. Reconcile `PMR-025`, `PMR-034`, and `PMR-036` without rewriting history.
4. Update `PML-0018..0021` and generate any authorized
   `outbox/pm-queue.md` status edits only after verifying the four XRV review
   records.
5. Refresh the XRV and analysis-workbook component cards, this handoff,
   `outbox/OWNER-RUNBOOK.md`, `../COMPONENTS.md`, and any queue totals.
6. Preserve both local-only states. Do not push XRV `d618935`,
   analysis-workbook `62ee356`, or any stacked commit without explicit
   responsible-human confirmation in that turn.

### One recommended next action

Reconcile the returned owner work before issuing another XRV or
analysis-workbook request:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh status
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh edits
bash ./scripts/pull-queues.sh check
bash ./scripts/inspect-components.sh registry-check
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

- Reviewed the analysis-workbook proposal committed at `4c771c0`. Its
  three-lane separation is sound, but its CRQ status-writer assignment exceeds
  the current standing carry authority.
- Recorded
  `records/decisions/PMD-20260914-001-collaboration-request-intake-boundary.md`;
  routed `CRQ-001` as `PMR-034`; and opened `PMR-036` for the workbook owner
  to correct and mirror the CRQ lifecycle.
- Added `PML-0018..0022`. `PMQ-017..020` are routed to XRV after
  `PMR-025`; `PMQ-021` was recorded as a metadata-only pointer in
  formal-verification-research at carry commit `c55065c`.
- Observed `formal-verification-research/` restored clean at `e5740de` and
  closed `PMR-024`; the Project Manager did not recreate or recover it.
- After the workbook owner committed the active work at `4c771c0`, applied
  the authorized `PMQ-021` class-1 status edit at carry commit `8899176`.
- No XRV file, research content, analysis content, review record, assurance
  artifact, or human gate was changed.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P1 | `PMR-025` | Locate/reconcile XRV commit `7314e2f` and its nine intake records; they are absent from the current canonical repository. |
| P1 | `PMR-036` | Correct the committed collaboration-queue status-writer contract and mirror `CRQ-001` as routed from `PMR-034`. |
| P1 | `PMR-028` | Back up the complete private paused threat-model package and reconcile its stale delivery wording through `threat-model-maintainer`. |
| P1 | `PMR-029` | Preserve and complete or intentionally park the dirty CHERI notes topic branch before any PM action there. |
| P2 | `PMR-034` | After `PMR-025`, XRV owner decides the collaboration proposal and triages `PMQ-017..020`. |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-020` | Verify CHERI notes remote access after the active dirty work is resolved. |
| P3 | `PMR-004`, `PMR-022` | Owners decide the analysis/threat read-only target-list additions. |
| P3 | `PMR-014` | Triage the five earlier formal-verification bibliography pointers; the topology blocker is closed. |
| P3 | `PMR-019` | Refresh analysis-workbook handoff prose for recorded/unaccepted HET-001. |
| P3 | `PMR-023` | Beryllium owner decides/verifies the implementation backup home. |
| P3 | `PMR-033` | Correct the security-reviewer handoff's self-stale pre-carry synchronization sentence in the next turn or by its owner. |
| P3 | `PMR-037` | Refresh formal-verification remote/handoff wording and normalize the sixth routed bibliography entry after this turn's one-commit limit. |
| P4 | `PMR-009` | CHERI notes owner triages the two remaining source pointers after the active topic work. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- No push was authorized in this turn. New carries `c55065c` and `8899176`,
  the previously pending component commits, and this turn's Project Manager
  and parent commits remain local until the responsible human reviews and
  pushes them.
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
- `outbox/component-requests.md` (`PMR-034..PMR-036`)
- `queue/LEDGER.md` (`PML-0018..0022`)
- `records/decisions/PMD-20260914-001-collaboration-request-intake-boundary.md`
- `AGENT-ROSTER.md` and affected `components/*.md` cards
- component owner commit `../analysis-workbook` `4c771c0`
- carried component commit `../analysis-workbook` `8899176`
- carried component commit `../formal-verification-research` `c55065c`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected; `PMR-033` explicitly defers the one
security-reviewer wording correction that cannot receive a second component
commit in this turn.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 190 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 267 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 22/22 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched, including restored formal-verification-research at `c55065c` and
  analysis-workbook at `8899176`;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md`.

This handoff is included in the tenth-turn Project Manager commit. Its exact
HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed
  2026-09-14T05:34Z-05:38Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 22/22,
  no edit due.
- User direction: review the committed analysis-workbook collaboration
  proposal and perform its stated Project Manager next action.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  stale and minor findings were corrected or recorded as `PMR-037`.
- Previous full Project Manager handoff: Git object
  `b2bbbf1:HANDOFF.md`.
