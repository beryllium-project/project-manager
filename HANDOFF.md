# Beryllium Project Manager handoff

**Last updated:** 2026-09-15
**Update scope:** twentieth coordination turn; pulled analysis-workbook
`CRQ-002`, recorded the responsible human's successor-first sequencing,
routed its three owner stages, and carried the deferred security-reviewer
handoff correction. No repository creation, transfer, remote, symlink,
visibility, quarantine transfer, push, or publication action was performed
by the Project Manager.

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
| Analysis-workbook | Clean owner commit `2374115` is eight ahead of `origin/main`. It adds `CRQ-002`, mirrors `CRQ-001` as completed, and fixes the `PMQ-023` triage reference. `PMR-038` remains partial because one two-surface sentence, the handoff's uncommitted-state wording, and the structured owner return are still missing. |
| CHERI-RISC-V notes | Owner topic commit `ae09213` preserves the former 21-entry reconciliation and corpus-validator work. Clean `docs/reconcile-project-status` is synchronized with `origin/docs/reconcile-project-status`; `main` remains `6553092`. `PMR-029` and `PMR-020` are closed. `PMR-051` requests a post-push handoff/status refresh; `PMR-009` source triage is now actionable. |
| Formal verification | Clean `main` at `784be93`, two ahead of the reachable `origin/main`. The latest carry adds metadata-only `PMQ-023` and normalizes the routed-pointer section; `PMR-037` remains open only for owner-maintained remote/handoff wording. |
| Other drift | `osr-claude` is clean at `f2edd17`, one behind `origin/main` at `e275544` (`PMR-027`, P2). `provenance-review` advanced cleanly to synchronized `9bfbab3`. |
| Other components | `beryllium-repo` remains clean at `65f6d89`. Security-reviewer is clean at Project Manager carry `3a40583`, two ahead of `origin/main`; `PMR-033` is closed, `PMR-056` tracks the post-carry self-reference refresh, and no engagement ran. |
| Queues | 26 source-discovery rows / 26 ledger rows plus one transfer row remain exact; only `PMQ-008` and `PMQ-011` are `new`/ledger-routed, and `HET-001` is `recorded` with input state `unaccepted`. The separate collaboration queue has `CRQ-001` completed and `CRQ-002` new; neither receives a `PML` row. |
| Cap-talk closure | `PMD-20260915-004` records successor-first sequencing for `CRQ-002`: resolve `PMR-027`, complete the private OS-security and XRV successors under `PMR-044`/`PMR-045`, then run OS-security acquisition `PMR-052`, XRV review `PMR-053`, and workbook follow-up `PMR-054`. `PMR-055` requests the derived routed mirror and stale `OPEN-001` correction. |
| Coordination model | `PMD-20260914-002` adopts pull-based owner returns in component handoffs and PM-owned outbound requests/cards. Every repository write requires a fresh worktree and active-session check; a clean tree alone is not permission. |
| Approved target topology | The responsible human confirms the organization is now named `agentic-os-research` (`PMD-20260915-003`). `PMD-20260915-001` confirms private targets `beryllium`, `cheri-hypervisor-research`, `os-security-research`, and retained `cheri-riscv-notes`. Microsoft homes remain future inactive references after verified successors are active. |
| D0 transition inventory | `PMD-20260914-004` records the bounded local inventory. `PMD-20260915-001` records the guided owner inventory and closes `PMR-049`: no additional Microsoft-origin repositories; all successors private initially; four exact active target names confirmed; workflow/evidence repositories and formal-verification stay under `beryllium-project`; no repository is public-approved now. "None known" remains an owner statement, not an independently authenticated negative finding. |
| Generated tasking | `PMR-048` is closed citing `PMD-20260914-005`. `scripts/project-tasking.sh` generates ignored per-component views from the committed authoritative request table and resolves either a direct checkout or tracked workspace symlink. It refuses missing, dirty, stale-commit, or wrong-request-blob state rather than showing stale tasking. |
| Human interaction | `PMD-20260915-002` requires one short structured question at a time where appropriate. The Project Manager carries answers forward and prepares matrices and machine-shaped records; the human is not used as a parsing engine. |
| Quarantine | Licensed/restricted OS-security resources use private personal repository `os-security-restricted-sources`, clean new history, and manual responsible-human review/copy with license metadata. The Project Manager never opens or copies the restricted subtree. |
| Parent coordination | Workspace root and symlinks are current. The responsible human chose to retire the two already-deleted parent `formal-verification/` redirect files (`PMD-20260912-001`); parent `HANDOFF.md` remains the sole compatibility redirect. |
| Retained PM artifacts | The ignored parent `files` path now exposes candidate copies matching all seven formerly lost names. Identity and suitability are unverified (`PMD-20260912-002`, `PMR-032`); no file was opened or copied by the Project Manager. |

### One recommended next action

Reconcile the OS-security checkout for `PMR-027`, the first hard prerequisite
of the successor-first sequence:

```sh
cd /home/jmorris/src/beryllium-project/osr-claude
git status --short --branch
git pull --ff-only origin main
tools/md-to-html.sh --check
```

If local `f2edd17` is intentional, do not pull; return that exact owner
decision instead. Report the resulting HEAD. The Project Manager asks before
any OS-security write and never opens `sources/restricted-microsoft/`.

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

- Observed analysis-workbook advance `b93722b..2374115`; verified the
  `CRQ-001` completion mirror and `PMQ-023` correction, and kept `PMR-038`
  open for the remaining stale wording and owner return.
- Pulled `CRQ-002` without a `PML` row. The responsible human selected
  `successor-first`; `PMD-20260915-004` records that sequencing and
  `PMR-052..PMR-055` preserve the three owner stages plus the derived
  workbook mirror.
- Carried `PMR-033` as security-reviewer class-3 coordination wording at
  `3a40583`. The component is clean and two ahead of `origin/main`; no
  engagement or gate changed. `PMR-056` records the distinct next-turn
  current-HEAD/date/coordination-update refresh.
- No repository creation, transfer, remote, symlink, visibility, quarantine
  transfer, push, or publication action was performed by the Project Manager.

## Pending coordination

| Priority | Request | Blocker or action |
| --- | --- | --- |
| P2 | `PMR-026` | Reconcile Helium's detached checkout, current handoff, and observed refs; no gate is inferred. |
| P2 | `PMR-027` | Fast-forward OSR to existing remote commit `e275544` or state why `f2edd17` is intentional. |
| P2 | `PMR-052` | After `PMR-027`, `PMR-044`, and `PMR-045`, the successor OS-security owner closes or precisely bounds the post-March-2016 cap-talk archive gap. |
| P2 | `PMR-032` | Run the read-only retained-artifact search/hash check and report whether the reappeared candidates match the recorded identities. |
| P2 | `PMR-003` | Reconcile the Beryllium implementation handoff's old path and H0 wording. |
| P2 | `PMR-039` | Review XRV `backup/main..main` and decide whether to push `d618935` to the reachable private backup. |
| P2 | `PMR-040` | XRV owner reviews the three proposed-architecture documents at analysis-workbook `a46dba2`. |
| P2 | `PMR-043` | Rehouse Beryllium privately at `agentic-os-research/beryllium`; keep the Microsoft repository reference-only. |
| P2 | `PMR-044` | After `PMR-027`, rehouse OS security and create the separate personal quarantine repository under the recorded clean-history/manual-transfer model. |
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
| P3 | `PMR-056` | Refresh security-reviewer handoff self-reference to post-carry `3a40583`; one component commit per turn prevents doing it now. |

Exact owner commands and ordering are in `outbox/OWNER-RUNBOOK.md`.

## Open human gates

- The organization rename is complete. No repository creation, repository
  transfer, history push, remote change, symlink retarget, visibility change,
  quarantine transfer, or Pages publication was executed in this turn.
- Successor-first sequencing is recorded for `CRQ-002`; it does not itself
  authorize either successor repository, archive access, content copy, or
  redistribution.
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
- `outbox/component-requests.md` (`PMR-033`, `PMR-038`,
  `PMR-052..PMR-056`)
- `records/decisions/PMD-20260915-004-crq-002-intake-sequencing.md`
- `components/analysis-workbook.md`
- `components/security-reviewer.md`
- `../security-reviewer/HANDOFF.md` at component commit `3a40583`

## Validation and commit state

The write-disabled `pm-auditor` found no blocking discrepancy. Its stale and
minor findings were corrected in the CRQ record, roster, ledger, request
notes, runbook, cards, handoff, and registry. The carry itself satisfied
`PMR-033`; its unavoidable post-commit self-reference refresh is preserved as
distinct `PMR-056` because a second component commit in one turn is
prohibited.

Pre-commit validation passed:

- `bash ./scripts/validate-pm.sh`: 278 passed, 0 failed;
- `bash ./tests/validate-agent.sh`: 304 passed, 0 failed;
- `bash ./scripts/pull-queues.sh check`: 27/27 exact;
- `bash ./scripts/inspect-components.sh registry-check`: every registered row
  matched the pre-commit live state;
- `git diff --check` in this repository and the parent: passed;
- parent status contained only Project Manager-owned `COMPONENTS.md`.

Post-commit tasking generation and current-view checking follow the Project
Manager commit so each ignored view can name the exact containing HEAD.

This handoff is included in the twentieth-turn Project Manager commit. Its
exact HEAD is recorded afterward in the `project-manager/` row of
`../COMPONENTS.md`, followed by the parent commit. Neither commit is pushed
without explicit same-turn confirmation.

## Provenance

- Live state: `scripts/inspect-components.sh status`, `components`,
  `symlinks`, `registry-check`, `state`, and `refs` output observed from
  2026-09-15T14:47Z through 2026-09-15T15:05Z.
- Queue state: `scripts/pull-queues.sh list`, `edits`, and `check`; 27/27,
  no edit due.
- Analysis-workbook owner evidence: clean local `main` at `2374115`, eight
  ahead of `origin/main`; live files establish the partial `PMR-038` result
  and new `CRQ-002`.
- Responsible-human structured selection: `"successor-first"`. This is
  authoritative sequencing input only and authorizes no repository, source,
  redistribution, or publication action.
- Security-reviewer carry: clean-state and instruction checks preceded the
  one-file class-3 `HANDOFF.md` change; component commit `3a40583` closes
  `PMR-033` and leaves the component two ahead of `origin/main`.
- Required write-disabled `pm-auditor` pass found no blocking discrepancy;
  stale and minor findings were corrected, with the distinct post-carry
  self-reference recorded as `PMR-056`.
- Previous full Project Manager handoff: Git object
  `c821694:HANDOFF.md`.
