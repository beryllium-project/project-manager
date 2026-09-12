# Beryllium Project Manager handoff

**Last updated:** 2026-09-12
**Update scope:** ninth coordination turn; full read-only topology and queue
refresh after workspace relocation, reconciliation of five changed component
states and one absent checkout, retirement of the deleted parent
`formal-verification/` redirects on the responsible human's direction, and
three class-3 coordination carries. No repository was pushed.

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
| Active owner work | `cheri-riscv-notes-repo` is dirty on no-upstream branch `docs/reconcile-project-status` at `6553092`, with 21 changed entries. The Project Manager did not modify it (`PMR-029`, P1). |
| Missing component | Registered direct checkout `formal-verification-research/` is absent; last recorded revision `e5740de`. Do not recreate it. The owner must identify its current canonical location/integration or retire it (`PMR-024`, P2). |
| Relocated XRV repository | The tracked symlink now resolves to clean `ca41490`, 0/0 against an `origin/main` last fetched from the unreachable `jamorris_microsoft` namespace; live backup state is unknown. Previously observed commit `7314e2f` and its nine `REV-20260904-001..009` intake records are absent from the current repository (`PMR-025`, P1). Historical ledger dispositions remain recorded but current owner-index materialization is unavailable. |
| Other drift | `osr-claude` is clean at `f2edd17`, one behind `origin/main` at `e275544` (`PMR-027`, P2). `provenance-review` advanced cleanly to synchronized `9bfbab3`. |
| Other components | `beryllium-repo` remains clean at `65f6d89`; `analysis-workbook` started at `d003dec`; `security-reviewer` started at `9ca5071`; Project Manager carries moved the latter two as listed below. |
| Queues | 17 source rows / 17 ledger rows; no source edit is due. `PMQ-008` and `PMQ-011` remain `new` in analysis-workbook and `routed` in the ledger to the CHERI notes owner. `HET-001` remains `recorded` with input state `unaccepted`. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Protect the complete private threat-model package that currently exists only
in local commit `5bf6a4b`. Review it through the component's maintainer,
reconcile the stale delivery sentence in its handoff, and decide the private
push:

```sh
cd /home/jmorris/src/beryllium-project/threat-modeler
copilot
# then: /agent threat-model-maintainer
```

Tell the maintainer:

```text
Review the complete outgoing main branch, including owner commit 5bf6a4b and
Project Manager carry f4eb272. Keep TM-20260911-001 private and paused, run
the maintained threat-modeler checks, correct only the stale handoff delivery
status, and ask me before pushing main to the existing private origin.
```

Then return the resulting commit/push status to the Project Manager. The
missing XRV intake records and dirty CHERI notes branch remain separate P1
items in `outbox/OWNER-RUNBOOK.md`.

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

### Topology and component drift

- The canonical workspace root is now
  `/home/jmorris/src/beryllium-project`; all three tracked symlinks resolve:
  `beryllium-repo -> ../copilot/msft/beryllium`,
  `cheri-riscv-notes-repo -> ../copilot/gim/cheri-riscv-notes`, and
  `xrv-research-repo -> ../copilot/gim/xrv-research`.
- `formal-verification-research/` is absent. The Project Manager stopped
  using that path and opened `PMR-024`; it did not initialize, clone, copy, or
  recover anything.
- The parent is clean at pre-turn `4a91f7f` and tracks `upstream/main` 0/0.
  `project-manager/` started clean at `aee6b9a`, tracking `origin/main` 0/0.
- `helium-te-poc` changed from the previously recorded travel checkout to
  clean detached `1ab289c`; `PMR-026` records the owner-only reconciliation.
- `provenance-review` advanced to synchronized `9bfbab3`.
- `osr-claude` is locally one behind its tracked remote; `PMR-027` records the
  owner action.
- `threat-modeler` contains the complete paused Astra package at owner commit
  `5bf6a4b`; it was clean and one ahead before the carry.
- `cheri-riscv-notes-repo` is dirty with an active integrity pass; no carry
  was attempted.
- The relocated `xrv-research-repo` is clean at `ca41490` and 0/0 against
  its last-fetched unreachable `origin`; live backup state is unknown.
  `7314e2f` is not an object in that repository. `PMR-013` is superseded by
  combined data/record and backup reconciliation request `PMR-025`.

### Human decision recorded

`records/decisions/PMD-20260912-001-retire-formal-verification-redirects.md`
records the responsible human's same-turn choice to retire, rather than
restore, the parent files deleted at `4a91f7f`:

- `formal-verification/README.md`;
- `formal-verification/helium-te-fv-pathfinder.md`.

Current coordination points directly to
`project-manager/records/assurance/`. Historical evidence locators are
unchanged. This decision does not retire the separate
`formal-verification-research` component.

`records/decisions/PMD-20260912-002-retained-artifacts-reappeared-unverified.md`
supersedes only the prior current-availability statement in
`PMD-20260906-002`: candidate paths with all seven recorded names are visible
again through the ignored parent `files` path, but identity, provenance, and
suitability remain unknown pending `PMR-032`.

### Carried component commits

Each carry followed a same-turn clean-state check and local-instruction read,
changed only class-3 Project Manager coordination wording, and was committed
inside the component:

| Component | Commit | Request | Change | Push state |
| --- | --- | --- | --- | --- |
| analysis-workbook | `eab5f8b` | `PMR-031` | Replace the retired assurance redirect with the direct Project Manager assurance path | Local, one ahead |
| threat-modeler | `f4eb272` | `PMR-031` | Same pointer update, stacked after owner commit `5bf6a4b` | Local, two ahead |
| security-reviewer | `c13c36e` | `PMR-030`, `PMR-031` | Record completed registration/private backup and update the assurance pointer | Local, one ahead |

No queue edit was due. No component source code, tests, scripts, generated
outputs, research, analysis, model, review, assurance, or gate file was
changed. `helium-te-poc/`, `beryllium-repo`, the dirty CHERI notes worktree,
the absent formal-verification-research path, and the restricted OSR tree were
not written.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P1 | `PMR-025` | Locate/reconcile XRV commit `7314e2f` and its nine intake records; they are absent from the current canonical repository. |
| P1 | `PMR-028` | Back up the complete private paused threat-model package and reconcile its stale delivery wording through `threat-model-maintainer`. |
| P1 | `PMR-029` | Preserve and complete or intentionally park the dirty CHERI notes topic branch before any PM action there. |
| P2 | `PMR-024` | Identify the current formal-verification-research checkout/integration or retire the component. |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-020` | Verify CHERI notes remote access after the active dirty work is resolved. |
| P3 | `PMR-004`, `PMR-022` | Owners decide the analysis/threat read-only target-list additions. |
| P3 | `PMR-014` | Triage five formal-verification bibliography pointers after `PMR-024`. |
| P3 | `PMR-019` | Refresh analysis-workbook handoff prose for recorded/unaccepted HET-001. |
| P3 | `PMR-023` | Beryllium owner decides/verifies the implementation backup home. |
| P3 | `PMR-033` | Correct the security-reviewer handoff's self-stale pre-carry synchronization sentence in the next turn or by its owner. |
| P4 | `PMR-009` | CHERI notes owner triages the two remaining source pointers after the active topic work. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- No push was authorized in this turn. The three carried component commits
  and this turn's Project Manager and parent commits remain local until the
  responsible human reviews and pushes them.
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
- `outbox/component-requests.md` (`PMR-024..PMR-031`)
- `queue/LEDGER.md` (2026-09-12 superseding availability note)
- `records/decisions/PMD-20260912-001-retire-formal-verification-redirects.md`
- `records/decisions/PMD-20260912-002-retained-artifacts-reappeared-unverified.md`
- `AGENT-ROSTER.md` and affected `components/*.md` cards
- `scripts/inspect-components.sh`, `scripts/owner-actions.sh`, and validation
  updates
- component commit `../analysis-workbook` `eab5f8b`
- component commit `../threat-modeler` `f4eb272`
- component commit `../security-reviewer` `c13c36e`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected; `PMR-033` explicitly defers the one
security-reviewer wording correction that cannot receive a second component
commit in this turn.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 179 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 267 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 17/17 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched, including explicit absent/absent for formal-verification-research;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only the four Project Manager-owned root artifacts
  changed in this turn.

This handoff is included in the ninth-turn Project Manager commit. Its exact
HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed
  2026-09-12T04:09Z-04:18Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 17/17,
  no edit due.
- Human decision: the structured answer **"Retire the deleted stubs and
  update current PM/component references (recommended)"** in this turn.
- Previous full Project Manager handoff: Git object
  `aee6b9a:HANDOFF.md`.
