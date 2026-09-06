# Beryllium Project Manager handoff

**Last updated:** 2026-09-06
**Update scope:** seventh coordination turn (2026-09-06T18:13Z-19:30Z), a
recovery session started from the user's "recover from the crash and
continue". **Restart snapshot: a new component exists.** The session that
planned the `security-reviewer` agent (the user's request: "create a new
agent for the project, security-reviewer, initially extracted from the
agent-review artifacts & components in the helium-te-poc repo here") ended in
a Node heap exhaustion at 18:21 local after writing only its plan; no
component had been touched. This turn carried the plan out:
`../security-reviewer/` was created as an independent, agent-owned
repository from the Helium review contract at `../helium-te-poc/` `9b3ff4e`
(read only; unchanged) and committed there as `9ca5071` (126 files:
orchestrator `security-reviewer` on `claude-fable-5.1`, three write-disabled
specialists, skill `beryllium-security-review`, `contracts/` with the
generalized prompt, provenance contract, manifest schema
`urn:beryllium:security-review-manifest:1.0.0`, and template, the ported Node
linter and its 93-check test suite, an approved-per-command runner with
hashed evidence, SR/SRS scaffolders, validator, generated index, `SRQ-NNN`
queue, and a 259-check contract suite; GPL-3.0-only). It is registered in
`../COMPONENTS.md`, the parent `.gitignore` and `README.md`,
`AGENT-ROSTER.md`, `components/security-reviewer.md`,
`scripts/inspect-components.sh`, `scripts/pull-queues.sh` (fourth source
`security-reviewer`, prefix `SRQ`), `queue/README.md`, `tests/validate-agent.sh`,
and the human-run `scripts/owner-actions.sh` (`push_sr`; opt-in `--sr-backup`)
(`records/decisions/PMD-20260906-003-security-reviewer-component-registered.md`).
**It has no remote: its only copy is on this workstation** (`PMR-021`, P2).
`PMR-022` (P3) asks the analysis-workbook and threat-modeler owners to add it
to their `readonly-inspect.sh` target lists. **One question for you**
(`PMD-20260906-003` item 3): does class 1 of the standing carry authority
extend to `../security-reviewer/outbox/pm-queue.md`? Until you say so, its
queue edits are yours. Re-observation at 19:03Z-19:09Z found two owner
commits since the sixth turn, both clean and synchronized as of the last
fetch: `../threat-modeler/` `dae994be` ("docs: add Helium threat-model run
comparison and agent improvement proposals") and `../helium-te-poc/`
`9b3ff4e` ("docs: record directed push of the travel-maintenance branch",
one commit after `f0d96b1`; not reviewed beyond its subject; the frozen gate
refs were not re-checked this turn); every other row unchanged;
`registry-check` exact after the registry update. **No existing component was written; the only Git commands
run against a component were inside the new `security-reviewer/` before it
had an owner agent.** This turn's commits (`security-reviewer/` `9ca5071`,
this repository, the parent) are **local**, as are the sixth turn's two (no
push confirmation was given; the script's default run pushes them). The
sixth turn is summarized under "Previous update: 2026-09-06 sixth
coordination turn (10:30Z-11:05Z)".

**Workspace root:** `/home/jmorris/src/l1/src/beryllium-project`
**This repository:** `project-manager/`, branch `main`; initial commit
`02335c56b232ecdbd402d537668b15d775291fa4`; `origin` -> private
`beryllium-project/project-manager`; pushed through `c244910` on 2026-09-04
and, under the confirmation quoted in "Provenance", through `73cb51b` on
2026-09-05 (the carry-turn commit `36a162a`, the skill repair `a1677c1`, the
second-coordination-turn commit `7adbb48`, and its push record `73cb51b`),
and through `088046c` by the human-run `scripts/owner-actions.sh` at 19:05Z
on 2026-09-05 (the third-coordination-turn commit `208579d` and the follow-up
5 commit `088046c`), and through `94888ea` (the fourth-coordination-turn
commit) at 22:38Z on 2026-09-05 under the confirmation "push when done"
quoted in "Provenance" (`088046c..94888ea`, verified with `git ls-remote`),
and through its recording follow-up `366e0ad` under the same confirmation
(`origin/main` observed at `366e0ad`, 0/0, on 2026-09-06T08:42Z); the
fifth-coordination-turn commit `dbe181a` pushed by the human-run
`scripts/owner-actions.sh` at 10:29Z on 2026-09-06 (`366e0ad..dbe181a`,
verified in its log; `origin/main` observed at `dbe181a` at 10:30Z); the
sixth-coordination-turn commit `d7ba732` and the seventh-coordination-turn
commit, whose hash is the `project-manager/` row of `../COMPONENTS.md`, are
**local**
**Parent coordination repository:** `main`; consolidation commits
`e774b4217ccf5100c66e97b3b23a51a62c5e6365`,
`b2e80b260a8669a649cbf65f21e0291c3cda6a17`, and `839a1b5`; first-coordination-turn
registry commit `393ea6a075ee636db0fe51e47ec237612f001e4a`, its recording
follow-up `15dcdf9`, the standing-carry-authority registry commit
`b34e468b94b2ecbd02d5aa25e9b5e2dfb8fda708`, and its recording follow-up
`9abc320` pushed to `backup/main` on 2026-09-04; the carry-turn registry
commit `e02cff6`, the skill-repair registry commit `1607db5`, the
second-coordination-turn registry commit `c1e485f`, and its recording
follow-up `afb4f03` pushed on 2026-09-05 under the confirmation quoted in
"Provenance"; the third-coordination-turn registry commit `6f8a0a7` and the
follow-up 5 registry commit `6f452b7` pushed to `backup/main` by the
human-run `scripts/owner-actions.sh` at 19:05Z on 2026-09-05; the
fourth-coordination-turn registry commit `60a11a2` pushed to `backup/main` at
22:38Z under the confirmation "push when done" quoted in "Provenance"
(`6f452b7..60a11a2`, verified with `git ls-remote`), and its recording
follow-up `98fc0f5` under the same confirmation (`backup/main` observed at
`98fc0f5`, 0/0, on 2026-09-06T08:42Z); the fifth-coordination-turn registry
commit `1aa13c3` pushed by the human-run `scripts/owner-actions.sh` at 10:29Z
on 2026-09-06 (`98fc0f5..1aa13c3`, verified; `backup/main` observed at
`1aa13c3` at 10:30Z); the sixth-coordination-turn registry commit `36b0579`
and the seventh-coordination-turn registry commit are **local**
**Parent remotes:** `backup` -> private `beryllium-project/beryllium-project`
(pushed through `9abc320` on 2026-09-04 and through `afb4f03` on 2026-09-05,
both under confirmations quoted in "Provenance", through `6f452b7` by the
human-run `scripts/owner-actions.sh` on 2026-09-05, through `60a11a2` and
`98fc0f5` at 22:38Z-22:41Z that day under the confirmation "push when done",
and through `1aa13c3` by the human-run script at 10:29Z on 2026-09-06); `origin` -> unreachable
`jamorris_microsoft/beryllium-project` (retained, not retargeted)

## Fast resume: read this first

### Overall position

| Area | Current state |
| --- | --- |
| Project Manager function | Consolidated into `project-manager/`: agent `project-manager`, auditor `pm-auditor`, skill (loads since `a1677c1`), knowledge cards, roster, records, ledger, requests, scripts, and tests. The parent root is a thin shell with redirect stubs. **Standing carry authority granted 2026-09-04** (`records/decisions/PMD-20260904-003-standing-carry-authority.md`): the agent may itself carry three classes of recorded request inside carry-eligible components (queue status edits; metadata-only source-index entries; Project Manager-role wording), committing there; never `helium-te-poc/` or `beryllium-repo`. Exercised twice: 2026-09-04 (`PMD-20260904-004`: `ccb48f6`, `4a01578`, `83b97a3`) and 2026-09-05, second coordination turn (`8246147` in `../formal-verification-research/` for `PMR-017`; `226d367` in `../threat-modeler/` and `ff12f2f` in `../analysis-workbook/` for `PMR-015`). Six carried commits in total; four (`4a01578`, `226d367`, `83b97a3`, `ff12f2f`) were pushed by their owners at 19:05Z on 2026-09-05 through the human-run `scripts/owner-actions.sh`, and `ccb48f6` and `8246147` reached the new private `backup` remote of formal-verification-research on 2026-09-06 (`PMR-001` closed), so all six are off this workstation. **Not exercised in the third, fourth, fifth, or sixth turn: nothing was due.** Since 2026-09-06 (`PMD-20260906-001`) every open request carries a priority `P1`-`P4`, `outbox/OWNER-RUNBOOK.md` gives exact human steps in that order, and the human-run `scripts/owner-actions.sh --apply-edits` applies the recorded owner-side edits (`outbox/owner-edits/`) as the human's own commits; the agent still never runs it |
| Accepted Beryllium runtime sequence | R0 through exact R7 are responsible-human accepted |
| Current authorized Beryllium work | Non-privileged R8-H0 profile freeze only; H0 remains **BLOCKED / NOT READY / NOT ACCEPTED** with all 81 acceptance rows unresolved |
| Privileged and hardware work | H1-H4 unauthorized; Beryllium K3 execution and hardware evidence remain `NOT RUN` |
| Implementation repository | `beryllium-repo` clean on `beryllium/single-hart-runtime-r0` at `65f6d89`, synchronized with its private origin |
| Helium assurance line | `../helium-te-poc/` clean and synchronized on `helium-te-travel-fedora44`, **now at `9b3ff4e`** (the owner's "docs: record directed push of the travel-maintenance branch", observed 2026-09-06T19:09Z; not reviewed beyond its subject); its parent `f0d96b1` was the HEAD observed 2026-09-05T04:54Z, 05:15Z, 07:13Z, 19:10Z and 2026-09-06T08:42Z and 10:30Z (unchanged since 2026-09-04T22:45Z), and the statements below are as recorded at `f0d96b1`. **Backed up 2026-09-06**: the owner's `scripts/owner-actions.sh --helium-branches` run pushed twelve local branches with upstreams to the private `origin`, including the `d0cca32` lineage; `helium-te-fv-tier8-h7-approved` was already there (`PMR-018` closed; a backup, not publication, not gate review). Its `HANDOFF.md` at that commit **states** that `FV-FIN-001` is resolved, "the responsible human selected Tier 8 as the endpoint for Helium formal-verification experimentation" (decision commit `6d3cd14`), the approved Tier 8 refs are unchanged and must remain frozen, the travel gate remains blocked, and the PoC "is not formally verified and has not been validated on hardware". Refs it names: travel base `3dc3aee`; Tier 8 H6 candidate `ed15451` with H7 gate `85a6e55`; Tier 7 source `7ca97a9` with H7 gate `342e04a`; Tier 6 H7 gate `c594b7f`; Tier 5 H7 gate `111cff2`; earlier H7 lineage `d0cca32`; preserved ref `d87080a`. **These are the component's statements**, now tabulated for `f0d96b1` in `records/assurance/helium-te-fv-pathfinder.md`. The read-only `scripts/inspect-components.sh refs helium-te-poc ...` listing (added in the second turn; re-run at 07:14Z with an identical result) shows every named ref **exists** locally and, as of the last fetch, all but `d0cca32` are reachable from a remote-tracking branch (`PMR-018`). Existence is not gate review: the Project Manager has reviewed no Tier 7/8 gate content or the endpoint decision and infers no approval (`PMD-20260904-002`, `PMD-20260904-004` item 9) |
| Security reviewer (new, 2026-09-06) | `../security-reviewer/` created this turn from the Helium review contract at `../helium-te-poc/` `9b3ff4e` and committed as `9ca5071` (`PMD-20260906-003`): agent `security-reviewer`, specialists `security-evidence`, `security-research`, `security-finding-review`, skill `beryllium-security-review`; private-by-default `reviews/SR-*` packages with a `review-manifest.json` (static-only unless a user-approved command ran through `scripts/run-approved-command.sh` with hashed evidence) and `syntheses/SRS-*` disposition ledgers, written only inside the component; independence rule (a review never reads another review of the same target). Registered everywhere on the Project Manager side; **no remote** (`PMR-021`, P2); sibling target registration requested (`PMR-022`, P3); **no engagement yet**; nothing here is a security review of any component. Class-1 extension to its `outbox/pm-queue.md` is **proposed, not granted** (human question) |
| Component queues | 16 analysis-workbook rows `PMQ-001..016`: **fourteen `accepted`** in the ledger and in the queue file (nine recorded by the xrv-research-repo owner at `7314e2f`; five by the Project Manager as metadata-only pointers at `../formal-verification-research` `ccb48f6`; the class-1 edits applied at `../analysis-workbook` `83b97a3`); two (`PML-0008`, `0011`; `PMR-009`, cheri-riscv-notes-repo) stay `routed`/`new` and request-only. threat-modeler queue empty. **Transfer queue registered 2026-09-05, second turn (`PMD-20260905-001`)**: `../analysis-workbook/outbox/helium-transfer-queue.md` is the third source `analysis-workbook-transfer` in `scripts/pull-queues.sh` and `queue/README.md`, tracked read-only (outside class 1; `edits` prints nothing for it; `accepted` never used; the workbook maintainer mirrors its lifecycle); `PML-0017` records `HET-001` as `routed` to the Beryllium owner (`PMR-016`). **Fourth turn (19:10Z): owner-side triage of `HET-001` recorded** (`records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`): the responsible human, acting as the Beryllium owner, stated "HET-001 is triaged as accepted" and confirmed that this maps to the transfer-lifecycle status `recorded` (planning inputs only; the input state stays `unaccepted`; not acceptance of any Beryllium work); `PMR-016` **closed**. **Mirror observed 2026-09-06**: at `../analysis-workbook` `d003dec` (the maintainer's commit through the human-run `scripts/owner-actions.sh --apply-edits`, `PMR-019`) the transfer queue shows `HET-001` `recorded` with `routed` and `recorded` history rows citing `PMR-016` and `PMD-20260905-002`, `ACTIVITY-002`, input state `unaccepted`; `PML-0017` stays `routed` (terminal) with the observation in its note; `PMR-019` stays open at P3 only for the workbook `HANDOFF.md` prose. `list` now shows only `PMQ-008` and `PMQ-011`; `check` ok (17/17); `edits` none due. `PMR-015` carried in the second turn: both discovery reference sets name `project-manager/queue/LEDGER.md` (`226d367`, `ff12f2f`) |
| Retained PM session artifacts | **Recorded lost from this workstation on 2026-09-06** (`records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`): the human-run `scripts/owner-actions.sh --files-search` found none of the seven names under the home directory and, on the human's `y`, removed the broken parent `files` link; the archive SHA-256 and scaffold tree are kept for later matching; existence elsewhere is `unknown`; regeneration of the two H0-selection inputs is the Beryllium owner's decision. Closed as a Project Manager item |
| Backups | Parent `main` and this repository's `main`: every commit through `1aa13c3` and `dbe181a` is on `backup/main` and `origin/main` (the human's 10:29Z script run pushed the fifth-turn commits, verified); **the sixth-turn (`36b0579`, `d7ba732`) and seventh-turn commits in each repository are local** (the script's default `push_pm` pushes them; the agent pushes only on an explicit confirmation). **security-reviewer is not backed up at all: no remote** (`9ca5071`; `PMR-021`, P2; `--sr-backup`). **analysis-workbook** (`d003dec`), **osr-claude** (`e275544`, personal account), **formal-verification-research** (`e5740de` on the private `backup` remote; `origin` still the stale unreachable namespace), **threat-modeler** (`dae994be`, the owner's commit of 2026-09-06, synchronized as of the last fetch), provenance-review, beryllium-repo, and helium-te-poc (incl. the branches backed up 08:39Z) synchronized at 19:03Z. **xrv-research-repo is 1 commit ahead and not backed up** (`7314e2f`; skipped three times; `PMR-013`, **P1**). cheri-riscv-notes-repo: local `main` synchronized as of its last successful fetch; the script's fetch failed with an authentication error three times (`PMR-020`, P2), so the live state is `unknown` |
| Publication | Nothing public. Push, tag, publication, release, and public migration remain separately controlled human actions |

The repositories are not broken. The runtime project is deliberately stopped
at the H0 input-and-selection gate. Do not start H1, Linux, multicore, device,
DMA, service, policy, or successor implementation to work around that gate.

### What changed in this update

- **Crash recovered.** The previous session (planning the `security-reviewer`
  agent from the user's request quoted above) died of a Node heap exhaustion
  at 18:21 local (`report.20260906.182135.2802183.0.001.json` at the parent
  root, untracked and now ignored; it holds the process environment, so
  review it before keeping it). Its `plan.md` was recovered from the session
  store and carried out; nothing else from that session had reached disk.
- **Component created** (`../security-reviewer/` `9ca5071`, GPL-3.0-only,
  `AUTHORS.md` with the per-file derivation record). Extracted from
  `../helium-te-poc/agent-review/{REVIEW-PROMPT.md,REVIEW-PROVENANCE.md,review-manifest.schema.json,review-manifest.template.json}`,
  `tests/{lint-review-manifest.mjs,test-review-manifest.mjs}`, and the method
  and vocabulary of `docs/review-remediation.md` at `9b3ff4e`; shaped like
  `../threat-modeler/` (read at `226d367`). Extensions over Helium: packages
  live in the component (never in the target); every package needs a
  manifest (no legacy exemption; the five retained Helium packages are
  historical inputs referenced read-only); `source.component`/`source.locator`
  and a required `command_attempt.approval_id` in the schema; an
  approved-per-command execution policy (`APPROVAL-NNN` records quoting the
  user's approval; `scripts/run-approved-command.sh` refuses unrecorded,
  non-approved, unregistered, or wrong-commit targets, runs in a clean
  environment, retains `stdout.log`/`stderr.log`/`exit-result.json`/`run-record.json`,
  and records post-run dirty paths; `scripts/hash-evidence.sh`); a synthesis
  mode (`syntheses/SRS-*`, dispositions `Confirmed | Partially confirmed |
  Recommendation | Already addressed | Rejected-unsupported | Fixed-scope
  non-goal`, canonical actions `REV-P{0..3}-NN`); a write-disabled
  finding-review specialist; a validator with an independence heuristic. Its
  own suite: `259 passed, 0 failed`; linter tests `PASS (93 checks)` (the
  component's observation). Helium is unchanged.
- **Registered.** Parent `.gitignore` (`/security-reviewer/`),
  `../COMPONENTS.md` (backup and component rows; review scope; relationship
  bullets), `../README.md`; here `AGENT-ROSTER.md` (row and
  `### security-reviewer` block), `components/security-reviewer.md`,
  `scripts/inspect-components.sh` (`registered_direct`),
  `scripts/pull-queues.sh` (source `security-reviewer`, prefix `SRQ`, the
  threat-modeler status mapping; `check` 17/17, `summary` shows the empty
  queue), `queue/README.md`, `AGENT-INTERFACE.md`,
  `.github/copilot-instructions.md`, `.github/agents/pm-auditor.agent.md`,
  `tests/validate-agent.sh` (card and roster checks, an empty SRQ fixture
  queue), `README.md` and `scripts/owner-actions.sh` (default `push_sr` once
  remote `origin` exists; opt-in `--sr-backup` creates the private
  `beryllium-project/security-reviewer`, adds `origin`, pushes `-u origin
  main`; `security-reviewer` in `fetch_snapshot`).
- **Recorded**: `PMD-20260906-003` (registration; item 3 proposes, does not
  grant, the class-1 extension); `PMR-021` (P2, backup remote; runbook and
  Quick path updated); `PMR-022` (P3, sibling `readonly-inspect.sh` lists;
  runbook edit next to `PMR-004`).
- **Observed drift, recorded**: `../threat-modeler/` `226d367` -> `dae994be`
  (the owner's own commit and push, 2026-09-06, "docs: add Helium
  threat-model run comparison and agent improvement proposals"; the untracked
  `THREAT-MODEL-RUN-COMPARISON-20260906.md` seen at 18:13Z is now tracked);
  clean, synchronized as of the last fetch; `PMR-022`'s basis cites it.
  `../helium-te-poc/` `f0d96b1` -> `9b3ff4e` (the owner's "docs: record
  directed push of the travel-maintenance branch"; clean; `origin` at the
  same commit as of the last fetch). The Project Manager read neither commit
  beyond its subject; the Helium gate refs and statements tabulated in
  `records/assurance/helium-te-fv-pathfinder.md` for `f0d96b1` were not
  re-checked this turn (a `refs helium-te-poc <eleven refs>` re-run is the
  next turn's routine). Both are observations, not reviews.
- **Not done, deliberately**: no push, no remote, no repository creation; no
  carry (nothing due); the component's own `HANDOFF.md` sentence "Project
  Manager registration pending" is now stale and left to the component (a
  class-3 carry candidate for a later clean-worktree turn); the sibling
  registered lists (`PMR-022`) are owner-only.

### Previous update: 2026-09-06 sixth coordination turn (10:30Z-11:05Z)

**Update scope:** sixth coordination turn (2026-09-06T10:30Z-11:05Z), started
from the user's "done, see log" with the `/beryllium-project-management`
skill loaded. **Restart snapshot: three components moved, all as the human's
10:29Z `scripts/owner-actions.sh --apply-edits --files-search` run recorded
them** (log `scratch/owner-actions/owner-actions-20260906T102908Z.log`,
local, ignored): the maintainer's `d003dec` in `../analysis-workbook/`
("docs: mirror HET-001 to recorded (PMR-019)"; the transfer queue now reads
`HET-001` `recorded`, input state `unaccepted`), the owner's `e275544` in
`../osr-claude/` ("docs: refresh infrastructure facts (PMR-002)"), and the
owner's `e5740de` in `../formal-verification-research/` ("docs: align Project
Manager wording with COLLAB.md (PMR-014)"), each committed by the human after
the diff and pushed and `ls-remote`-verified by the script, together with
this repository's `dbe181a` and the parent's `1aa13c3`; each verified
read-only with `scripts/inspect-components.sh refs`. The `files_search` step
found none of the seven retained PM artifacts under the home directory and,
on the human's `y`, removed the broken parent `files` link; the loss is
recorded as `records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`.
**`PMR-002` closed**; **`PMR-019` and `PMR-014` stay open at P3** for their
remaining halves (the workbook `HANDOFF.md` prose; the five pointers);
`PMR-013` skipped a third time (P1); the cheri-riscv-notes-repo fetch failed
a third time (`PMR-020`). The three applied edit sets were removed from
`outbox/owner-edits/` and the script's table, so `--apply-edits` now reports
nothing pending. `pull-queues.sh check` 17/17; `list` shows only `PMQ-008`
and `PMQ-011`; `PML-0017` stays `routed` with the observed mirror in its
note. **No component was written and no `git -C <component>` command was
run.** This turn's commit here and the parent registry commit are **local**
(no push confirmation was given; the script's default run pushes them). The
fifth turn is summarized under "Previous update: 2026-09-06 fifth
coordination turn (08:42Z-09:58Z)".

- **Owner actions recorded (from the observed state and the 10:29Z log; the
  agent ran nothing).** The human ran `scripts/owner-actions.sh --apply-edits
  --files-search` (execute mode, no `--plan` run this time). `apply_edits`
  showed each diff and, on the human's `y`, committed inside the component:
  `PMR-019` in `../analysis-workbook/` `d003dec` (one file,
  `outbox/helium-transfer-queue.md`, after the component's own
  `validate-helium-transfer-queue.sh --baseline` passed); `PMR-002` in
  `../osr-claude/` `e275544` (`HANDOFF.md`); `PMR-014` wording in
  `../formal-verification-research/` `e5740de` (`.github/copilot-instructions.md`,
  `README.md`). The pushes that followed were fast-forwards verified with
  `ls-remote`: analysis-workbook `ff12f2f..d003dec`, osr-claude
  `f2edd17..e275544`, formal-verification-research `8246147..e5740de`
  (`backup`), this repository `366e0ad..dbe181a`, the parent
  `98fc0f5..1aa13c3`; threat-modeler up to date; xrv-research-repo skipped
  (`origin` unreachable; no `backup` remote yet). `files_search` found none
  of the seven names under the home directory and removed the broken parent
  `files` link on the human's `y`. The cheri-riscv-notes-repo fetch failed a
  third time with an authentication error. Read-only verification this turn:
  `scripts/inspect-components.sh refs <component> <hash>` for each of the
  three commits (each exists on `main` and its remote-tracking branch with
  the expected subject), and the changed files read directly.
- **Requests.** `PMR-002` **closed** (`e275544`). `PMR-019`: the mirror is
  done (`d003dec`); stays open, **P3**, for the three workbook `HANDOFF.md`
  sentences that still say `HET-001` is `new` (the maintainer's words).
  `PMR-014`: the wording half is done (`e5740de`); stays open, P3, for the
  five pointers. `PMR-013` (P1) and `PMR-020` (P2) updated with the third
  skip and third failure. Open set: `PMR-003` P2, `PMR-004` P3, `PMR-009`
  P4, `PMR-013` P1, `PMR-014` P3, `PMR-019` P3, `PMR-020` P2.
- **Ledger.** `PML-0017` stays `routed`; its note records the observed
  mirror (`recorded` at `d003dec`, input state `unaccepted`). `check` 17/17.
- **Retained PM artifacts recorded lost** (`PMD-20260906-002`): from the
  log and the human's "done, see log"; the archive SHA-256 and scaffold tree
  are kept for later matching; regeneration of the two H0-selection inputs
  is the Beryllium owner's decision; no gate moves.
- **Edit sets retired.** The sixteen applied files (eight edit names) in `outbox/owner-edits/`
  (`PMR-019-1..3`, `PMR-002-1..2`, `PMR-014-1..3`) were removed and the
  script's `edits`/`edit_pmrs` tables emptied (empty-safe loops; the step now
  reports "no recorded edit is pending"). `outbox/owner-edits/README.md`
  lists what was applied. `outbox/OWNER-RUNBOOK.md` refreshed: quick path is
  now the plain default run; `PMR-019` moved to P3; closed items kept for one
  turn under "Closed on 2026-09-06".
- **Cards** `components/analysis-workbook.md`, `osr-claude.md`, and
  `formal-verification-research.md` updated. `AGENT-ROSTER.md` unchanged.
- **No carry; no component written; no `git -C <component>` command run.**
  `helium-te-poc/` and `beryllium-repo` untouched.
- This handoff and `../COMPONENTS.md` refreshed. One commit here and one in
  the parent; **neither is pushed** (no confirmation was given; the script's
  default `push_pm` pushes them on your next run).
- `pm-auditor` pass: see "Provenance".

### Previous update: 2026-09-06 fifth coordination turn (08:42Z-09:58Z)

Retained for restartability; superseded where the sections above say so.

Fifth coordination turn (2026-09-06T08:42Z-09:58Z), started
from the user's "I ran the two scripts above, see log" with the
`/beryllium-project-management` skill loaded. **Restart snapshot exact**
(`registry-check` exact; `pull-queues.sh check` 17/17; no new row; no edit
due). Recorded from the observed state and the script's log
(`scratch/owner-actions/owner-actions-20260906T083944Z.log`, local, ignored):
the owner's `--fvr-backup` run created the private
`beryllium-project/formal-verification-research`, added remote `backup`, and
pushed `main` to `8246147` (**`PMR-001` closed**; `main` now tracks
`backup/main` 0/0); the `--helium-branches` run pushed twelve Helium branches
with upstreams, including the `d0cca32` lineage (**`PMR-018` closed**;
`helium-te-fv-tier8-h7-approved` was already on `origin` and alone has no
upstream); xrv-research-repo was skipped again (`PMR-013`, now **P1**); the
cheri-riscv-notes-repo fetch failed again with an authentication error
(**`PMR-020` raised**, P2). The user then asked for clear, specific
instructions for the script's "still yours" items, "more automated", and for
a priority field on every open item; recorded as
`records/decisions/PMD-20260906-001-owner-edits-and-request-priorities.md`:
`outbox/component-requests.md` gains a `Priority` column (`P1`-`P4`, `-` when
closed; validated), `outbox/OWNER-RUNBOOK.md` lists every open item by
priority with exact steps, `outbox/owner-edits/` holds the exact text of the
recorded edits, and the human-run `scripts/owner-actions.sh` gains
`--apply-edits` (`PMR-019`, `PMR-002`, `PMR-014` wording; never
`helium-te-poc/` or `beryllium-repo`), `--files-search`, `push_osr`, default
`push_fvr` once the remote exists, an xrv `backup` target, and a dynamic
priority-sorted "still yours" list (the hard-coded one still named the closed
`PMR-016`). **No component was written and no `git -C <component>` command
was run**; one execution-boundary deviation is disclosed in "Provenance". The
turn's commit here and the parent registry commit are **local** (no push
confirmation was given this turn; the script's default `push_pm` pushes
them). **Adopted from another session** (user choice `include`, quoted in
"Provenance"): at 09:52 local another Copilot session added the parent-root
`formal-verification/README.md` and listed it among the Project Manager-owned
artifacts in `../SOT.md`, `../README.md`, `../.github/copilot-instructions.md`,
and this repository's `.github/copilot-instructions.md`; this turn aligns
`AGENT-INTERFACE.md`, the agent definition, `README.md`, and
`scripts/validate-pm.sh` (parent check) and commits the four parent files
with the registry. The fourth turn is summarized under "Previous update:
2026-09-05 fourth coordination turn (19:10Z-22:40Z)".

- **Owner actions recorded (from the observed state and the 08:39Z log;
  the agent ran nothing).** `--plan` at 08:39:07Z, execute at 08:39:44Z.
  `push_fvr`: `gh repo create beryllium-project/formal-verification-research
  --private`, `remote add backup` (`origin` untouched), `push -u backup main`
  (new branch, 25 commits up to `8246147`, verified); `status` at 08:42Z
  shows `main` tracking `backup/main` 0/0. **`PMR-001` closed.**
  `push_helium`: twelve branches pushed with `-u` and verified
  (`helium-te-fv` and `helium-te-h7-approved` at `d0cca32`,
  `helium-te-fv-h6-candidate`, `helium-te-fv-next`,
  `helium-te-fv-tier5-validated`, `helium-te-fv-tier6-h6-candidate`,
  `helium-te-fv-tier6-pipeline`, `helium-te-fv-tier7-capture-contract`,
  `helium-te-fv-tier7-h6-candidate`, `helium-te-fv-tier8-h6-candidate`,
  `helium-te-fv-tier8-transaction`, `helium-te-release-prep`);
  `helium-te-fv-tier8-h7-approved` skipped as already at `85a6e55` on
  `origin` (no upstream configured; the optional tracking command is the
  owner's). The `refs` listing at 08:42Z confirms nineteen of twenty local
  branches with upstreams and the `d0cca32` lineage on two remote-tracking
  branches. **`PMR-018` closed** (private backup; not publication, not gate
  review). Everything else was up to date; xrv-research-repo skipped
  (`origin` unreachable); the cheri-riscv-notes-repo fetch failed again with
  an authentication error. **`PMR-020` raised** (P2) for that; **`PMR-013`
  is now P1** (`7314e2f` exists only here).
- **Priorities and the owner runbook (`PMD-20260906-001`).** At the user's
  request ("I need this more automated"; "add a priority field to each item
  requiring attention"), `outbox/component-requests.md` gained a `Priority`
  column (`P1` act now, `P2` next, `P3` housekeeping, `P4` waiting; `-` when
  closed; `templates/request-row.md`, the fixture, `scripts/validate-pm.sh`,
  and two `tests/validate-agent.sh` mutations updated), and
  `outbox/OWNER-RUNBOOK.md` now gives exact human steps for every open item
  in priority order: `PMR-013` P1; `PMR-019`, `PMR-003`, `PMR-020`, and the
  retained-artifacts decision P2; `PMR-002`, `PMR-014`, `PMR-004` P3;
  `PMR-009` P4; the Beryllium gates P3/P4. The blockers table below carries
  the same values.
- **`scripts/owner-actions.sh` (human-run; still never executed by the
  agent).** New opt-in `apply_edits` (`--apply-edits`): applies the exact
  recorded edits in `outbox/owner-edits/` for `PMR-019` (workbook
  transfer-queue mirror, validated with the component's own
  `validate-helium-transfer-queue.sh --baseline`), `PMR-002` (osr-claude
  handoff facts, preconditions checked), and the wording half of `PMR-014`
  (formal-verification-research), each shown as a diff, `y/N`, then committed
  by the human inside the component with the request id in the subject;
  refuses dirty worktrees and text that no longer matches; dies if pointed at
  `helium-te-poc/` or `beryllium-repo`. New opt-in `files_search`
  (`--files-search`, `--files-root DIR`): read-only search for the seven lost
  artifact names and a SHA-256 check of any archive, then, only if nothing is
  found, a `y/N` to remove the broken parent `files` link. `push_osr` joins
  the defaults; `push_fvr` runs by default once remote `backup` exists;
  `push_xrv` also targets a `backup` remote once the owner adds one; the
  summary's hard-coded "Still yours" (which still named the closed
  `PMR-016`) is replaced by a priority-sorted list parsed from the request
  table. `bash -n` and the four static guards pass; the block/line replacers
  were exercised on temporary copies only. The user chose this scope in an
  `ask_user` form (quoted in "Provenance"): scripted edits excluding
  `beryllium-repo`; the artifacts search; the five `PMR-014` pointers decided
  later.
- **Boundary documents** (`AGENT-INTERFACE.md`, `README.md`,
  `AGENT-ROSTER.md`, `.github/copilot-instructions.md`,
  `.github/agents/project-manager.agent.md`, the skill) name the new steps
  and the runbook; the skill's Phase 5 now asks for a priority on every new
  request and a runbook refresh each turn.
- **Another session's parent-root change, adopted.** At 09:52 local
  (08:52Z), while this turn was reading logs, a different Copilot session
  wrote the untracked `../formal-verification/README.md` (a short description
  of that directory as a coordination entry point pointing at
  `records/assurance/helium-te-fv-pathfinder.md`, with the same SPDX header
  as the redirect stub) and added it to the Project Manager-owned artifact
  lists in `../SOT.md`, `../README.md`, `../.github/copilot-instructions.md`,
  and this repository's `.github/copilot-instructions.md`. The parent had
  been clean at 08:42Z. Asked how to treat it, the user chose `include`
  ("Include them in this turn's parent commit (recorded as another session's
  change, adopted by you now); the registry and handoff list
  formal-verification/README.md as PM-owned"). This turn therefore lists the
  file in `AGENT-INTERFACE.md`, `.github/agents/project-manager.agent.md`,
  and `README.md`, adds a `scripts/validate-pm.sh` parent check that it points
  at the assurance record, and commits the four parent files together with
  `../COMPONENTS.md`. Nothing was reverted; the other session's wording is
  kept as written.
- **Cards and records.** `components/formal-verification-research.md`,
  `helium-te-poc.md`, `cheri-riscv-notes-repo.md`, and `xrv-research-repo.md`
  updated; `records/assurance/helium-te-fv-pathfinder.md` gained the
  2026-09-06 ref re-observation (existence and reachability only).
- **No carry; no component written; no `git -C <component>` command run.**
  One execution-boundary deviation is disclosed in "Provenance" (the
  analysis-workbook validator run once on a temporary copy).
- This handoff and `../COMPONENTS.md` refreshed. One commit here and one in
  the parent; **neither is pushed** (no confirmation was given this turn; the
  script's default `push_pm` pushes them on your next run).
- `pm-auditor` pass: see "Provenance".

### Previous update: 2026-09-05 fourth coordination turn (19:10Z-22:40Z)

Retained for restartability; superseded where the sections above say so.

Fourth coordination turn (2026-09-05T19:10Z-22:40Z,
spanning the human's answers to two `ask_user` forms), started from the
user's statement "HET-001 is triaged as accepted" with the
`/beryllium-project-management` skill loaded. **Restart snapshot exact**:
every component clean at the revision recorded in `../COMPONENTS.md`;
`registry-check` exact; `pull-queues.sh check` passing (17 source rows, 17
ledger rows); no new `PMQ`/`HET` row; `edits` printed none. Two things were
recorded. (1) **The owner-side triage of `HET-001`** (`PMD-20260905-002`):
the transfer queue's lifecycle has no `accepted` status and
`PMD-20260905-001` never uses `accepted` for a `HET` row, so the agent asked
one `ask_user` form (answers quoted in "Provenance"); the responsible human,
acting as the Beryllium owner, confirmed the mapping to the lifecycle status
`recorded` (all eight lessons recorded as planning inputs; none adopted as a
Beryllium criterion; no authorization change; the input state stays
`unaccepted`), chose the statement to the Project Manager as the owner-side
record (no Beryllium-owned artifact exists), and kept `PML-0017` at
`routed`. `PMR-016` **closed**; `PMR-019` raised to the analysis-workbook
owner to mirror `HET-001` to `recorded` (exact rows in the record; the
Project Manager never edits that file). (2) **The human's owner-actions run
of 19:05Z**, found from the observed remote-tracking state and the script's
own log (`scratch/owner-actions/owner-actions-20260905T190534Z.log`, local,
ignored): analysis-workbook (`efde667..ff12f2f`), threat-modeler
(`affe17b..226d367`; `PMR-005` **closed**), this repository
(`73cb51b..088046c`), and the parent (`afb4f03..6f452b7`) were pushed and
verified by the script; xrv-research-repo was skipped (`PMR-013`: `origin`
is in the unreachable namespace); no opt-in flag was used (`PMR-001`,
`PMR-018` open); the cheri-riscv-notes-repo fetch failed with an
authentication error, so its counts are as of the last successful fetch.
Mid-turn the user asked "what do you recommend for the outstanding human
decisions?"; the answer is retained under "One recommended next action" and
decides nothing. **No component was written and no `git -C <component>`
command was run.** The turn's commit `94888ea` here and the parent registry
commit `60a11a2` were pushed at 22:38Z under the user's confirmation "push
when done" (quoted in "Provenance"): `088046c..94888ea` and
`6f452b7..60a11a2`, both verified with `git ls-remote`; this recording
commit and its parent counterpart are pushed under the same confirmation.
The third turn and follow-up 5 are summarized under "Previous
update: 2026-09-05 third coordination turn (07:13Z-07:30Z) and follow-up 5
(07:46Z-08:05Z)"; the second turn and the 2026-09-04 turns under the sections
after it.

- **`HET-001` owner-side triage recorded
  (`records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`).**
  The user opened with "HET-001 is triaged as accepted". The transfer queue
  (`../analysis-workbook/outbox/helium-transfer-queue.md`, unchanged at
  `ff12f2f`: `new`, `unaccepted`) has no `accepted` lifecycle status,
  `PMR-016` had asked for `recorded`, `deferred`, or `declined`, and
  `PMD-20260905-001` never uses `accepted` for a `HET` row, so the agent asked
  one `ask_user` form. Answers (quoted in "Provenance"): lifecycle
  `recorded`; the statement to the Project Manager is the owner-side record
  (no Beryllium-owned artifact; a read-only text search of
  `../beryllium-repo/` at `65f6d89` found no `HET-001` mention); actor "The
  responsible human, acting as the Beryllium owner, on 2026-09-05"; scope:
  all eight candidate lessons recorded as planning inputs for a possible
  future Beryllium security-significant seam, none adopted as an entry
  criterion, design constraint, evidence requirement, or exit criterion, no
  Beryllium authorization change; ledger handling `keep_routed`. In every
  artifact the word "accepted" is quoted as the human's and mapped to
  `recorded`; it is not the ledger status `accepted` and not acceptance of
  any Beryllium target or work.
- **Requests.** `PMR-016` **closed** 2026-09-05 (the owner's action is the
  statement to the Project Manager, the path the request offered).
  `PMR-019` raised to the analysis-workbook owner: mirror `HET-001` `new` to
  `recorded` in `outbox/helium-transfer-queue.md`; the exact status-history,
  queue-summary, and activity-log rows are in the record's section "Exact
  mirror rows for PMR-019"; request-only (the file is outside class 1).
  `PMR-005` **closed** and `PMR-013` updated from the owner-actions evidence
  below.
- **Ledger.** `PML-0017` stays `routed` (terminal for transfer rows;
  `accepted` not used; "Source status applied" `Not applicable`); its note
  records the owner-side disposition. `pull-queues.sh check` passes (17/17).
- **Owner actions observed.** `scripts/inspect-components.sh status` at
  19:10Z showed analysis-workbook and threat-modeler at 0 ahead (they were 2
  and 4 ahead) and this repository and the parent at 0 ahead on the commits
  the previous handoff called local; `git rev-parse origin/main` here and
  `git -C .. rev-parse backup/main` confirmed `088046c` and `6f452b7`. The
  human-run `scripts/owner-actions.sh` logs in `scratch/owner-actions/`
  (local, ignored) record a `--plan` run at 19:05:11Z and an execute run at
  19:05:34Z with the default steps: pushed and `ls-remote`-verified
  analysis-workbook `efde667..ff12f2f`, threat-modeler `affe17b..226d367`,
  project-manager `73cb51b..088046c`, parent `afb4f03..6f452b7`; skipped
  xrv-research-repo (`origin` in the unreachable namespace); fetched every
  reachable remote, the cheri-riscv-notes-repo fetch failing with an
  authentication error. No opt-in flag was used, so `PMR-001` and `PMR-018`
  stay open; the `refs` listings at 22:00Z for `helium-te-poc` and
  `formal-verification-research` are identical to the 07:14Z records. The
  agent did not run the script; these are the human's actions, recorded from
  the observed remote-tracking state and the script's log.
- **Recommendations, not decisions.** Asked "what do you recommend for the
  outstanding human decisions?", the agent answered before reading the log
  (so it recommended the default script run the human had already made);
  the standing recommendations are under "One recommended next action". The
  human recorded no decision in this turn beyond the `HET-001` triage.
- **No carry; no component written; no `git -C <component>` command run.**
  `helium-te-poc/` and `beryllium-repo` were not touched; the transfer queue
  is not edited by the Project Manager.
- Cards `components/analysis-workbook.md`, `components/beryllium-repo.md`,
  `components/helium-te-poc.md`, and `components/threat-modeler.md` were
  updated (triage; pushes). `AGENT-ROSTER.md` is unchanged. This handoff and
  `../COMPONENTS.md` ("Last reviewed", review scope, the backup table, the
  `project-manager/`, `analysis-workbook/`, `threat-modeler/`, and
  `beryllium-repo` rows, and the closing paragraph) were refreshed. One
  commit here and one in the parent, then a recording commit in each after
  the push; **pushed under the user's confirmation "push when done"**
  (2026-09-05T22:16Z, quoted in "Provenance"), exactly `git push origin
  main` here (`088046c..94888ea`) and `git push backup main` in the parent
  (`6f452b7..60a11a2`) at 22:38Z, verified with `git ls-remote`; no
  component pushed.
- `pm-auditor` pass: see "Provenance".

### Previous update: 2026-09-05 third coordination turn (07:13Z-07:30Z) and follow-up 5 (07:46Z-08:05Z)

Retained for restartability; superseded where the sections above say so.

- **Follow-up 5 (07:46Z-08:05Z): `scripts/owner-actions.sh`, human-run.**
  Steps `preflight`, `review`, `push_awb`, `push_tm`, `push_xrv`, `push_pm`,
  `fetch_snapshot` by default; opt-in `push_fvr` (`--fvr-backup`, `PMR-001`)
  and `push_helium` (`--helium-branches [--helium-only a,b]`, `PMR-018`);
  `--plan`, `--yes`, `--full-diff`, `--only`, `--skip`, `--no-log`. Every
  push is a fast-forward checked against the live remote head
  (`git ls-remote`) and verified afterwards; remotes in the unreachable
  `jamorris_microsoft` namespace are skipped; a dirty worktree is never
  pushed under `--yes`; nothing is forced; no worktree is changed; logs go
  to `scratch/owner-actions/` (ignored). The agent never executes it, in any
  mode: `AGENT-INTERFACE.md`, `README.md` ("Owner actions"),
  `AGENT-ROSTER.md`, `.github/copilot-instructions.md`,
  `.github/agents/project-manager.agent.md`, and the skill say so.
  `scripts/validate-pm.sh` gained four static checks (human-run declaration,
  `bash -n`, no forced/deleting/history-rewriting Git token, guarded
  push/fetch/remote-add lines); `tests/validate-agent.sh` includes it in the
  script-hygiene loop. **The script is untested by the agent** (running it,
  even `--plan`, is outside the execution boundary): dry-run it with
  `--plan` first and read the log.
- **Re-observation only (the turn).** `scripts/inspect-components.sh status`,
  `components`, `symlinks`, and `registry-check` at 07:13Z and `refs
  helium-te-poc` and `refs formal-verification-research` at 07:14Z matched the
  second turn's end state and the 05:15Z ref records exactly (see "Observed
  workspace state"). `pull-queues.sh list` showed only the three
  already-routed rows; `check` passed (17/17); `edits` printed none.
- **No carry, no request change, no ledger change.** Every open request
  (`PMR-001`, `002`, `003`, `004` scripts, `005`, `009`, `013`, `014`,
  `016`, `018`) is request-only or owner-only and none had an observable
  owner action, so `outbox/component-requests.md` and `queue/LEDGER.md` are
  unchanged. No decision record was needed; `AGENT-ROSTER.md` is unchanged;
  the only card change is the observation timestamp in
  `components/helium-te-poc.md` (same state).
- **No component was written; no `git -C <component>` command was run.**
  `helium-te-poc/` and `beryllium-repo` were not touched.
- This handoff (header, position table, this section, next action, blockers,
  observed state, pending coordination, provenance) and `../COMPONENTS.md`
  ("Last reviewed", review scope, backup rows for the parent and
  `project-manager/`, the `project-manager/` and `helium-te-poc/` rows, and
  the closing paragraph) were refreshed. One commit here and one in the
  parent; **neither is pushed** (no confirmation was requested or given).
- `pm-auditor` pass: see "Provenance".

### Previous update: 2026-09-05 second coordination turn (04:54Z-05:50Z, including the 05:44Z push and its recording commits)

Retained for restartability; superseded where the sections above say so.
Run in fleet mode from the previous handoff's "One recommended next action".
The `/beryllium-project-management` skill loaded for the first time (the
follow-up 4 repair worked). Restart snapshot exact: every component clean,
every HEAD matching `../COMPONENTS.md`, `pull-queues.sh check` passing. The
responsible human answered the four queued questions in one `ask_user` form
(quoted in "Provenance"): carry `PMR-015` in both components; register the
Helium transfer queue for read-only tracking; also record the `f0d96b1`
Helium statements and add a read-only ref-listing mode; and push that turn's
coordination commits. Three carried commits under `PMD-20260904-003` class 3,
each after a same-turn clean-worktree check and local-instruction read:
`8246147` in `../formal-verification-research/` (`PMR-017`), `226d367` in
`../threat-modeler/` (`PMR-015`), and `ff12f2f` in `../analysis-workbook/`
(`PMR-015`); `PMR-015` and `PMR-017` closed. `PMD-20260905-001`: the
transfer queue `../analysis-workbook/outbox/helium-transfer-queue.md` is a
third, read-only source in `scripts/pull-queues.sh` and `queue/README.md`
(`analysis-workbook-transfer`, `HET-NNN`; never an edit target; `accepted`
never used); `PML-0017` records `HET-001` as `routed` (`PMR-016`). New
`scripts/inspect-components.sh refs <component> [<ref>...]` mode (read-only
Git subcommands only); its first run confirmed that the eleven
assurance-relevant refs named in `../helium-te-poc/HANDOFF.md` exist locally,
that `d0cca32` is on no remote-tracking branch and thirteen local branches
have no upstream configured (`PMR-018`), and that both `collab/*` branches in
`../formal-verification-research/` are merged.
`records/assurance/helium-te-fv-pathfinder.md` gained the `f0d96b1`
statements and the ref listing. In the bullets below, "this turn" means that
second turn.

- **Skill loaded.** `/beryllium-project-management` was offered and loaded at
  session start for the first time; the follow-up 4 repair is confirmed.
- **Carried, `../formal-verification-research/` commit
  `824614780bd3f900abaa15aa523a3337e4bb3fbe`** (`main`, was `ccb48f6`, now 2
  ahead of the stale ref): `PMR-017` (class 3) tightened one `COLLAB.md`
  "Ledger integration procedure" sentence so the `git switch main` /
  `git branch --no-merged` block is attributed to the research owner alone.
  `state formal-verification-research` was clean immediately before the
  write; `.github/copilot-instructions.md`, `COLLAB.md` (housekeeping budget
  item 3 permits this edit), and `HANDOFF.md` were read; the diff was that
  sentence only. `PMR-017` closed.
- **Carried, `../threat-modeler/` commit
  `226d367bde80c09c85fbadd4600222258d56527a`** (`main`, was `4a01578`, now 4
  ahead) and **`../analysis-workbook/` commit
  `ff12f2faf611c02faeaa75760306808bf5ed7eb9`** (`main`, was `83b97a3`, now 2
  ahead): `PMR-015` (class 3) after the human chose "Carry now in
  threat-modeler and analysis-workbook". Each `RESEARCH-SOURCES.md` discovery
  reference set gained one bullet naming the Project Manager ledger
  (`workspace://project-manager/queue/LEDGER.md`;
  `../project-manager/queue/LEDGER.md`) so a source already routed or
  accepted is not queued again as `new`. Both worktrees clean immediately
  before the write; both components' `.github/copilot-instructions.md`,
  `HANDOFF.md`, and interface documents read; neither owner-only
  `tests/validate-agent.sh` pins anything the bullets change (read only, not
  run). `PMR-015` closed.
- **`records/decisions/PMD-20260905-001-helium-transfer-queue-consumption.md`**:
  the transfer queue is registered as the read-only source
  `analysis-workbook-transfer` (`HET-NNN`; Queue-summary columns Subject and
  Target; awaiting status `new`) in `scripts/pull-queues.sh`; `map_status`
  yields no edit for it; `check` fails a transfer row that uses `accepted` or
  claims an applied status; `queue/README.md` documents the transfer
  semantics ("Source status applied" is `Not applicable`; `routed` is the
  terminal PM disposition; the workbook maintainer mirrors the lifecycle);
  `queue/LEDGER.md` gained `PML-0017` (`HET-001`, `routed`, `PMR-016`).
  `AGENT-INTERFACE.md`, `AGENT-ROSTER.md`, `README.md`,
  `components/analysis-workbook.md`, `.github/copilot-instructions.md`, and
  `.github/agents/pm-auditor.agent.md` name the third source. Fixtures under
  `tests/fixtures/` cover the transfer ledger and a bad transfer row.
- **`scripts/inspect-components.sh refs <component> [<ref>...]`**: lists
  local branches with upstream and ahead/behind, remote-tracking branches
  ("as of the last fetch; not a live remote check"), tags, unmerged
  `collab/*` branches relative to `main`, and per-ref existence, full SHA,
  containing branches, and subject, using only `for-each-ref`, `cat-file -e`,
  `rev-parse`, `branch --contains`, `branch --no-merged`, and `log -1`.
  `scripts/validate-pm.sh` now fails if the script contains a write
  subcommand. First runs: Helium (all eleven named refs exist; `d0cca32` on
  no remote-tracking branch), formal-verification-research (two `collab/*`
  branches, both merged), project-manager.
- **`records/assurance/helium-te-fv-pathfinder.md`**: new section "Observed
  component statements, 2026-09-05 (`f0d96b1`)" above the 2026-09-04 section,
  tabulating the `FV-FIN-001` resolution, the Tier 8 endpoint statement
  (`6d3cd14`), the travel-gate statement, every named ref with its change
  since `e65c6a0`, the `docs/fv-pathfinder-lessons.md` pointer, and the
  handoff's requests to humans, all as the component's statements; plus the
  subsection "Read-only ref listing, 2026-09-05T05:15Z".
  `components/helium-te-poc.md` refreshed to `f0d96b1`.
- `outbox/component-requests.md`: `PMR-015` and `PMR-017` closed with the
  commit hashes; `PMR-001` and `PMR-005` notes updated (2 and 4 ahead);
  **`PMR-018`** raised (helium-te-poc owner: decide whether the thirteen
  local branches without an upstream, including the `d0cca32` lineage, are
  backed up; request-only).
- `components/formal-verification-research.md` and
  `components/threat-modeler.md` record the carries and the `collab/*`
  observation; `../COMPONENTS.md` rows, backup table, review scope, and
  closing paragraph refreshed; `registry-check` exact after the carries.
- `pm-auditor` pass: see "Provenance" for its findings and their reconciliation.
- **Pushed** under the confirmation quoted in "Provenance": this repository's
  `main` to `origin` and the parent's `main` to `backup`. No component was
  pushed.

### Previous update: 2026-09-04 turn and follow-ups 1-4

Retained for restartability; superseded where the sections above say so.

- `../COMPONENTS.md`: `helium-te-poc/` row refreshed to clean `e65c6a0`
  with the component-named refs; `analysis-workbook/` row shows the sixteen
  queue rows as `routed` and names `PMR-011`; `formal-verification-research/`
  row names the observed `PMR-001` resolution and `PMR-010`; the parent and
  `project-manager/` backup rows say this turn's commits are local only;
  review scope and closing paragraph updated.
- `queue/LEDGER.md`: `PML-0001..PML-0016` moved from `pending` to `routed`
  on 2026-09-04, each note naming the owner index searched and its commit.
- `outbox/component-requests.md`: `PMR-007` (xrv-research-repo, 9 pointers),
  `PMR-008` (formal-verification-research, 5 pointers), `PMR-009`
  (cheri-riscv-notes-repo, 2 pointers); `PMR-006` note updated.
- `records/decisions/PMD-20260904-001-first-queue-triage-routing.md` and
  `records/decisions/PMD-20260904-002-helium-observed-state-refresh.md`.
- `records/assurance/helium-te-fv-pathfinder.md`: new section "Observed
  component statements, 2026-09-04"; the 2026-08-18 snapshot is retained
  below it, unchanged apart from a two-sentence pointer at the top of
  "Status".
- `components/helium-te-poc.md`: role text names the component-reported Tier 8
  boundary and points at the assurance record; the request wording is
  tier-agnostic; `./he evidence-check`, `docs-preview`, and
  `publication-check` added to the command list from the component's `./he
  help` at `e65c6a0`.
- `pm-auditor` pass: no blocking item. Its located discrepancies were fixed in
  Project Manager artifacts or turned into requests: `PMR-001` note (both
  halves of the reconciliation are observed satisfied at `8b91ebd`; backup
  decision still open); `PMR-010` (formal-verification-research `COLLAB.md`
  housekeeping budget conflicts with this Project Manager's boundary);
  `PMR-011` (analysis-workbook `AGENT-INTERFACE.md` and queue header disagree
  on the Project Manager-written status set); `components/analysis-workbook.md`
  and `components/formal-verification-research.md` updated accordingly.
- Observed but not acted on: the untracked crash dump named in the previous
  update is no longer present at the parent root (parent clean at `839a1b5`).
- The `/beryllium-project-management` skill is present on disk at
  `.github/skills/beryllium-project-management/SKILL.md` but was not offered
  by the Copilot CLI skill loader in this session; the turn followed the
  on-disk procedure directly. The consolidation itself (2026-09-04, earlier
  the same day) is described under "Provenance".

Follow-up 2, the same evening (governance change and `PMR-007` result):

- `records/decisions/PMD-20260904-003-standing-carry-authority.md`: the
  responsible human's grant, its three classes, the carry-ineligible
  components, preconditions, the commit-inside-the-component rule, the
  `git -C` subcommand allowance, records, audit, and effect on open requests.
- Boundary documents amended to match: `.github/copilot-instructions.md`,
  `.github/agents/project-manager.agent.md` (new coordination-turn step
  "Carry"), `.github/agents/pm-auditor.agent.md` (checks carried commits),
  `.github/skills/beryllium-project-management/SKILL.md` (Phase 4 is
  ledger-first; new Phase 4b "carry"), `AGENT-INTERFACE.md`, `README.md`,
  `AGENT-ROSTER.md`, `queue/README.md`, `queue/LEDGER.md` header, all nine
  `components/*.md` ownership lines, `scripts/pull-queues.sh` usage text,
  and the parent `../SOT.md`, `../README.md`, `../.github/copilot-instructions.md`,
  and `../COMPONENTS.md`.
- `tests/validate-agent.sh`: the `ledger-only` assertion became
  `ledger-first`; new assertions pin `PMD-20260904-003`, the "three classes",
  the two carry-ineligible components, the exact `git -C` subcommand list,
  the clean-worktree precondition, and the auditor's carried-commit check.
- `queue/LEDGER.md`: `PML-0001..0006`, `0009`, `0013`, `0016` moved to
  `accepted` after the xrv-research-repo owner's report (relayed by the user,
  verified read-only): `REV-20260904-001..009` in `review-log.md`, commit
  `7314e2f`, pointer-only `arrived` records. "Source status applied" stays
  `no`; the nine queue edits are due.
- `outbox/component-requests.md`: `PMR-007` closed (`7314e2f`); `PMR-010`
  superseded by `PMR-012` (formal-verification-research wording alignment,
  carry-eligible); `PMR-013` raised (xrv-research-repo push decision);
  `PMR-004`, `PMR-006`, `PMR-008`, `PMR-009`, `PMR-011` notes record
  carry-eligibility.
- `../COMPONENTS.md`: `xrv-research-repo` at `7314e2f`, 1 ahead, backup
  state `unknown`; `analysis-workbook/` row shows the nine acceptances;
  review scope, `project-manager/` role, and closing bullet describe the
  carry authority.
- `pm-auditor` pass on the governance change: one blocking finding, fixed
  before commit: `cheri-riscv-notes-repo/references/` is a generated export
  behind human gate D4 (`meta/handoff.md` at `6553092`), so class 2 has no
  target there and `PMR-009` stays request-only. Stale and minor findings
  fixed in place: the carry exception added to the skill's Phase 2, the
  request header, the closing rule, and the restart procedure; `PMR-012`
  scope split (agent-instruction sentence stays with the owner); `PMR-011`
  extended to the consumer-2 sentence; xrv class 2 not used while its intake
  contract exceeds a metadata entry; the xrv backup state marked `unknown`
  (its handoff names the unreachable namespace); backup rows say this
  update's commits are local until confirmed; cheri-riscv-notes-repo card
  and roster row name `meta/handoff.md`, `CONTRIBUTING.md`, and the
  automation documents.

Follow-up 3, the same evening (the first carry turn, `PMD-20260904-004`):

- Restart snapshot at 2026-09-04T22:18Z: parent clean at `9abc320`, this
  repository clean at `c244910`, `registry-check` exact, `pull-queues.sh
  check` passing. Two drifts against the 16:15Z table: `helium-te-poc/`
  dirty again (25 entries at `e65c6a0`) and `analysis-workbook/` dirty (10
  entries at `2261659`, including `AGENT-INTERFACE.md`, `HANDOFF.md`, agent,
  skill, script, and test files, plus an untracked
  `outbox/helium-transfer-queue.md`). Both had another session active;
  neither was touched. By 22:45Z both sessions had committed and pushed
  (`analysis-workbook/` `efde667`, `helium-te-poc/` `f0d96b1`), and both
  worktrees were clean.
- **Carried, `../formal-verification-research/` commit
  `ccb48f63a4ff477b3faf16a725a68759691e754a`** (`main`, was `8b91ebd`, now 1
  ahead of a stale ref): `PMR-012` (class 3) rewrote the Project Manager
  wording in `COLLAB.md` (intro paragraph, "Parent Project Manager
  housekeeping budget" body, ledger integration procedure) and `HANDOFF.md`
  ("Workspace and agent model", "Possible next steps", "Project Manager
  housekeeping"); `PMR-008` (class 2) added the section "Routed pointers
  awaiting owner triage" to `sources/bibliography.md` with five metadata-only
  entries (`PMQ-007`, `010`, `012`, `014`, `015`), metadata taken from the
  workbook's own `source-discoveries.md` at `2261659`. Guest logs, the owner
  status table, research files, `README.md`, and
  `.github/copilot-instructions.md` untouched. Both requests `closed`;
  `PML-0007`, `0010`, `0012`, `0014`, `0015` `accepted` (applied `no`).
- **Carried, `../threat-modeler/` commit
  `4a015785da41ca7645b9050ac61259ea5885ed48`** (`main`, was `0d5bed3`, now 3
  ahead): the Markdown part of `PMR-004`; `RESEARCH-SOURCES.md` Tier 1 names
  the `project-manager/` handoff, `records/`, `queue/LEDGER.md`, and
  `outbox/component-requests.md` through `workspace://project-manager/...`
  and calls the parent `HANDOFF.md` and
  `formal-verification/helium-te-fv-pathfinder.md` redirect stubs;
  `project-manager` stays outside the owner-only registered target set.
  `PMR-004` stays `open` for the analysis-workbook part and both scripts.
- **Refused at 22:18Z, then carried at 22:45Z, `../analysis-workbook/` commit
  `83b97a32a32c562dc58e775ad37c94a5d6cb16e1`** (`main`, was `2261659` at the
  snapshot, `efde667` after the other session's commit "docs: add Helium
  method transfer queue", now 1 ahead): the first observation was dirty with
  another session active, so nothing was written and no `git -C` command was
  run there (`PMD-20260904-003` item 4). The `pm-auditor` pass located the
  new commit; `state analysis-workbook` confirmed a clean worktree; the local
  instructions were re-read at `efde667`. The commit carries `PMR-011`
  (`AGENT-INTERFACE.md` status set aligned to the queue header, `routed`
  explained as a ledger state, consumers 1-3 naming `project-manager/` and
  its ledger-first protocol), the analysis-workbook Markdown part of `PMR-004`
  (`RESEARCH-SOURCES.md` tier 4 cites `../project-manager/HANDOFF.md`,
  `records/`, `queue/LEDGER.md`, `outbox/component-requests.md` and names the
  parent stubs), and the fourteen class-1 edits (`PMQ-001..007`, `009`,
  `010`, `012..016` to `accepted`, resolved 2026-09-04, notes naming the
  owning component and commit). `PMR-011` and `PMR-006` `closed`; `PMR-004`
  open only for the two owner-only scripts; fourteen ledger rows `yes
  2026-09-04`; `pull-queues.sh edits` reports nothing due. The owner-only
  `tests/validate-agent.sh` (read only) pins nothing the change removed.
- Observed, not touched: `../helium-te-poc/` was dirty (25 entries) at
  `e65c6a0` at 22:18Z and clean at `f0d96b1` (synchronized) at 22:45Z after
  another session committed `6d3cd14` and `f0d96b1`; its handoff's statements
  are recorded in the position table and the Helium note. The committed
  `../analysis-workbook/outbox/helium-transfer-queue.md` (`HET-001`) is
  routed to the Beryllium owner as `PMR-016`; the Project Manager did not
  edit that file.
- Requests raised: `PMR-014` (formal-verification-research owner:
  `.github/copilot-instructions.md` bullet, `README.md` sentence, triage of
  the five pointers, optional "Last updated" refresh; request-only),
  `PMR-015` (threat-modeler and analysis-workbook: consider adding
  `project-manager/queue/LEDGER.md` to the discovery reference sets;
  carry-eligible; not carried, outside the requested set), `PMR-016`
  (beryllium-repo owner: triage `HET-001`; request-only), and `PMR-017`
  (formal-verification-research: tighten one carried `COLLAB.md` sentence the
  auditor located; carry-eligible, next turn).
- `records/decisions/PMD-20260904-004-first-carry-turn.md` records the three
  carries, the refusal and re-observation, and the interpretations later
  turns must honor: a precondition met later in the same turn may be acted
  on only after re-observation and re-reading; the
  formal-verification-research "explicit component-owner or human task"
  clause is satisfied by the grant plus the user's same-turn instruction;
  class-2 pointers go in a labelled "Routed pointers awaiting owner triage"
  section; class-1 edits set status, date, and a resolution note and never
  add an activity-log row; Helium statements are recorded without review.
- `pm-auditor` pass (write-disabled; it had no execute tool and read Git
  metadata as files): no blocking item; it located the two mid-turn
  component moves and eleven stale or minor items (analysis-workbook and
  Helium rows, the `registry-check` sentence, `PMR-005`/`PMR-001` notes, the
  superseded analysis-workbook paragraph, the "Parent remotes" wording, the
  16:15Z paragraph, the untouched formal-verification-research "Last updated"
  line, the `COLLAB.md` colon sentence, the `workspace://` revision-pinning
  limitation, the `PMR-004` basis, and the bibliography preamble's "none is
  yet cited" imprecision left to the owner), all reconciled here, in the
  requests, or as `PMR-017`.
- `../COMPONENTS.md`, `components/formal-verification-research.md`,
  `components/threat-modeler.md`, `components/analysis-workbook.md`, and
  `components/helium-te-poc.md` refreshed accordingly. The
  `/beryllium-project-management` skill was again not offered by the skill
  loader; the on-disk `SKILL.md` procedure was followed directly.

Follow-up 4, the next morning (skill-loader repair, this repository only):

- Root cause of every "skill not offered" note above: the Copilot CLI skill
  loader reported `.github/skills/beryllium-project-management/SKILL.md:
  failed to parse YAML frontmatter: mapping values are not allowed in this
  context at line 2`. The `description:` value began "Run one restartable
  Beryllium coordination turn: re-resolve topology, ..."; the unquoted `: `
  inside the scalar opens a nested mapping, so the whole front matter failed
  and the skill was silently dropped in every earlier session. The two agent
  definitions parse; the sibling skills at
  `../threat-modeler/.github/skills/beryllium-threat-modeling/SKILL.md` and
  `../analysis-workbook/.github/skills/beryllium-analysis/SKILL.md` use the
  same layout without an inner colon (read-only comparison; no state read).
- Fix: the description was reworded as one clause without an inner colon
  (same meaning; the skill body is unchanged). `tests/validate-agent.sh` now
  checks that the front matter of both agent files and the skill opens with
  `---`, is a flat `key: value` mapping, and contains no unquoted value with
  `: `; the suite is 253 passed, 0 failed (`validate-pm.sh` 78/0,
  `git diff --check` clean). The earlier notes stand as history: those turns
  did follow the on-disk `SKILL.md` procedure by hand.
- Effect on records: none to correct. `PMD-20260904-001..004` describe what
  each turn observed; this entry supersedes their "not offered" remark with
  the cause. The next session is the first in which the skill can load; its
  handoff should say whether it did.

### One recommended next action

Back up the new component and push this turn's local commits, in one script
run (it creates the private `beryllium-project/security-reviewer` if absent,
adds remote `origin`, pushes `-u origin main` with a prompt per step, and
then runs the default fast-forward pushes, including `push_pm` for this
repository's and the parent's sixth- and seventh-turn commits):

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
bash ./scripts/owner-actions.sh --plan --sr-backup
bash ./scripts/owner-actions.sh --sr-backup
copilot                                  # then: /agent project-manager
```

Then, in the Project Manager session, answer one question: does class 1 of
the standing carry authority (`PMD-20260904-003`) extend to
`../security-reviewer/outbox/pm-queue.md`? Say "yes" or "no"; a superseding
record quotes your words. Everything else stays as before, in priority order
with exact commands in `outbox/OWNER-RUNBOOK.md`: **P1 `PMR-013`**
(xrv-research-repo `7314e2f` exists only on this workstation); **P2
`PMR-003`** (beryllium-repo handoff), **P2 `PMR-020`** (cheri-riscv-notes-repo
authentication); **P3** `PMR-019`, `PMR-014` pointers, `PMR-004` and
`PMR-022` (the same two owner-only `readonly-inspect.sh` lists; one owner
commit per component covers both); **P4 `PMR-009`**; the Beryllium gates are
unchanged (H0 blocked and not accepted; H1-H4 unauthorized; K3 `NOT RUN`).

When you want the first security review, start it yourself:

```sh
cd /home/jmorris/src/l1/src/beryllium-project/security-reviewer
bash ./tests/validate-agent.sh            # the component's own suite
copilot                                  # then: /agent security-reviewer
```

The coordination turn after your script run records the pushes from your
statement and the log in `scratch/owner-actions/`, closes `PMR-021` when
`state security-reviewer` shows `origin/main` synchronized, and refreshes the
runbook and priorities. No carry is queued.

### Minimal restart commands

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
sed -n '1,120p' HANDOFF.md
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
bash ./scripts/inspect-components.sh refs helium-te-poc
bash ./scripts/pull-queues.sh list
bash ./scripts/pull-queues.sh check
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git status --short --branch
git -C .. status --short --branch
```

Then start Copilot CLI in `project-manager/` and select `/agent project-manager`.

### Blockers and open human gates

| Item | Priority | Owner | State |
| --- | --- | --- | --- |
| Two H0 input selections (normative Fedora 44 H0 static OCI `fcf6c595...1bd1f5`; proposed H1/H2 path inventory `2c5e9396...c6660`) | P3 | Responsible human | Open; not inferred. Would authorize re-checking a still-blocked H0 candidate, not accept H0 |
| H0 acceptance, H1-H4 authorization, K3 execution | P4 | Responsible human | Open; `NOT RUN` |
| Helium Tier 7/8 gate content | - | Component owner and the human who made the gate commits | Not a Project Manager gate. The component's statements at `e65c6a0` and `f0d96b1` are recorded without review (`PMD-20260904-002`; `records/assurance/helium-te-fv-pathfinder.md`); the read-only `refs` listing of 2026-09-05 confirms only that the named refs exist locally, not what any gate contains |
| Index pointers for the routed rows | P4 | `PMR-007` completed by the xrv-research-repo owner (`7314e2f`, `REV-20260904-001..009`); `PMR-008` carried by the Project Manager under `PMD-20260904-003` class 2 at `../formal-verification-research` `ccb48f6` (metadata pointers on the owner's delegated authority, not corpus admission; owner triage `PMR-014`); `PMR-009` stays with the cheri-riscv-notes-repo owner (generated exports behind gate D4) | Fourteen rows `accepted` in the ledger and in the queue file (`83b97a3`); two wait for the owner |
| Wording reconciliations | P3 | `PMR-012` carried at `ccb48f6`; `PMR-011` and the Markdown parts of `PMR-004` carried at `83b97a3` and `4a01578`; `PMR-017` carried at `8246147`; `PMR-015` carried at `226d367` and `ff12f2f`; the formal-verification-research agent-instruction bullet and `README.md` sentences applied by the owner at `e5740de` (`PMR-014` wording half, 2026-09-06); `PMR-002` applied by the owner at `e275544` | Done apart from the two owner-only scripts of `PMR-004` |
| `HET-001` Helium-to-Beryllium method-transfer input (`../analysis-workbook/outbox/helium-transfer-queue.md`) | P3 | Beryllium owner triage done: `PMR-016` closed 2026-09-05 (`PMD-20260905-002`); mirror done by the maintainer at `d003dec` on 2026-09-06 (`PMR-019`, open only for the component's `HANDOFF.md` prose) | Owner-side disposition `recorded` (the human's words "triaged as accepted", mapped at the human's confirmation; planning inputs only; the input state stays `unaccepted`; not acceptance of any Beryllium work); observed `recorded` in the queue at `d003dec`; tracked read-only as `PML-0017` (`routed`, terminal) |
| Standing carry authority | - | Responsible human | Granted 2026-09-04 (`PMD-20260904-003`; user choices quoted in "Provenance"); committed as `d36b015` and pushed; binds sessions started after that commit |
| Decision on the lost retained PM artifacts (see "Retained PM session artifacts") | - | Responsible human | Closed 2026-09-06: the human-run `--files-search` found none of the seven names under the home directory and removed the broken parent `files` link on the human's `y`; recorded as lost from this workstation (`PMD-20260906-002`); existence elsewhere `unknown`; a later find adds a superseding record |
| Push of the first-coordination-turn and standing-carry-authority commits (`project-manager/` and parent) | - | Responsible human confirmation | Closed 2026-09-04 by the two user confirmations quoted in "Provenance"; both `main` branches were synchronized with their private remotes after those pushes |
| Private remote for `project-manager/` | - | Responsible human confirmation | Closed 2026-09-04 by the user confirmation quoted in "Provenance"; `origin` -> private `beryllium-project/project-manager` |
| xrv-research-repo backup of `7314e2f` (exists only on this workstation) | P1 | xrv-research-repo owner | Open; `PMR-013`; `origin` is the unreachable namespace (skipped by the script three times, 2026-09-05 and twice on 2026-09-06); decide a reachable private remote (runbook commands) |
| threat-modeler push of 4 local commits (`026e6c9`, `0d5bed3`, carried `4a01578` and `226d367`) | - | threat-modeler owner | Closed 2026-09-05: pushed by the human-run `scripts/owner-actions.sh` at 19:05Z (`affe17b..226d367`, verified in its log); observed synchronized at 19:10Z; `PMR-005` closed |
| analysis-workbook push of the carried `83b97a3` and `ff12f2f` | - | analysis-workbook owner | Closed 2026-09-05: pushed by the same run (`efde667..ff12f2f`, verified); observed synchronized at 19:10Z |
| formal-verification-research backup, including the carried `ccb48f6` and `8246147` | - | Owner | Closed 2026-09-06: private `beryllium-project/formal-verification-research` created and `main` pushed to `backup` at `8246147` by the human-run script (`--fvr-backup`, verified); `PMR-001` closed |
| helium-te-poc backup of the thirteen local branches without an upstream, including the `d0cca32` lineage | - | helium-te-poc owner | Closed 2026-09-06: twelve pushed with upstreams by the human-run script (`--helium-branches`, verified); `helium-te-fv-tier8-h7-approved` was already on `origin`; `PMR-018` closed; a backup, not publication or gate review |
| Push of the second-coordination-turn commits (`project-manager/` `7adbb48` and its push record `73cb51b`; parent `c1e485f` and its recording follow-up `afb4f03`) | - | Responsible human confirmation | Closed 2026-09-05 by the confirmation quoted in "Provenance"; both pushed and verified with `git ls-remote` |
| Push of the third-coordination-turn commits and the follow-up 5 commits (`project-manager/` `208579d`, `088046c`; parent `6f8a0a7`, `6f452b7`) | - | Responsible human | Closed 2026-09-05: pushed by the human-run `scripts/owner-actions.sh` at 19:05Z (`73cb51b..088046c`, `afb4f03..6f452b7`, verified in its log); `origin/main` and `backup/main` observed at those commits at 19:10Z |
| Push of the fourth-coordination-turn commits (`project-manager/` `94888ea`, `366e0ad`; parent `60a11a2`, `98fc0f5`) | - | Responsible human confirmation | Closed 2026-09-05T22:38Z-22:41Z under the confirmation "push when done" (quoted in "Provenance"), all four verified with `git ls-remote`; `origin/main` at `366e0ad` and `backup/main` at `98fc0f5` re-observed 2026-09-06T08:42Z |
| Push of the fifth-coordination-turn commits (`project-manager/` `dbe181a`; parent `1aa13c3`) | - | Responsible human | Closed 2026-09-06: pushed by the human-run `scripts/owner-actions.sh` at 10:29Z (`366e0ad..dbe181a`, `98fc0f5..1aa13c3`, verified in its log); observed on the remotes at 10:30Z |
| Push of the sixth-coordination-turn commits (`project-manager/`, whose hash is its row in `../COMPONENTS.md`, and the parent registry commit, which is the parent HEAD) | P1 | Responsible human | Open; both local. The script's default `push_pm` pushes them on your next run, or give the agent an explicit push confirmation |
| cheri-riscv-notes-repo `origin` authentication (fetch failed 2026-09-05T19:05Z, 2026-09-06T08:39Z, and 10:29Z) | P2 | Owner | Open; `PMR-020`; live backup state `unknown` until a fetch succeeds or the remote is recorded as unreachable from here |
| security-reviewer backup (`9ca5071` exists only on this workstation; no remote) | P2 | Responsible human as the component's owner | Open; `PMR-021`; `bash ./scripts/owner-actions.sh --sr-backup` creates the private repository, adds `origin`, and pushes with a prompt per step (`PMD-20260906-003`) |
| Class-1 extension of `PMD-20260904-003` to `../security-reviewer/outbox/pm-queue.md` | P3 | Responsible human | Open; proposed by `PMD-20260906-003` item 3, not granted; until then every edit `scripts/pull-queues.sh edits` prints for that file is the human's |
| Push of the seventh-coordination-turn commits (`project-manager/`, whose hash is its row in `../COMPONENTS.md`, and the parent registry commit, which is the parent HEAD) | P1 | Responsible human | Open; both local, like the sixth turn's `d7ba732` and `36b0579`. The script's default `push_pm` pushes all four on your next run, or give the agent an explicit push confirmation |

## Role and authority

This component is the Project Manager layer for coordinating Beryllium
components and their agents. It writes inside this repository, to the Project
Manager-owned parent-root artifacts named in `AGENT-INTERFACE.md`, and, since
the responsible human's grant of 2026-09-04
(`records/decisions/PMD-20260904-003-standing-carry-authority.md`), inside a
carry-eligible component only to carry a recorded request in three classes:
queue status edits in `outbox/pm-queue.md`, metadata-only source-index
entries in the owner's designated index, and Project Manager-role wording in
Markdown interface, collaboration, research-source, and handoff documents.
Each carried write needs a clean worktree and an open request, is committed
inside the component with the request identifier, and is recorded here.
`helium-te-poc/` and `beryllium-repo` are never written. Every component
directory remains agent-owned: reading for coordination is allowed; writing
outside those classes is not. Component instructions, handoffs, and
collaboration protocols remain authoritative within their repositories. The
grant binds sessions started after commit of the amended boundary documents;
the session that recorded it wrote only Project Manager-owned files.

## Observed workspace state

Observed 2026-09-04T16:15Z with `scripts/inspect-components.sh status`, at the
start of the first coordination turn and before that turn's commits; the
2026-09-05 observations follow below. Hashes are in `../COMPONENTS.md`. The earlier observation the same day
(2026-09-04T12:29Z, before the consolidation commits) differed only in the
rows noted.

| Entry | Integration | Worktree | Branch | HEAD | Upstream (behind/ahead) |
| --- | --- | --- | --- | --- | --- |
| Parent | workspace | clean (the crash dump named in the previous update is gone) | `main` | `839a1b5` | `backup/main` (0/0) |
| `project-manager/` | direct | clean | `main` | `ccf8007` | `origin/main` (0/0) |
| `helium-te-poc/` | direct | **clean** (was dirty with 43 entries at `9af92cc` at 12:29Z) | `helium-te-travel-fedora44` | `e65c6a0` | `origin/helium-te-travel-fedora44` (0/0) |
| `formal-verification-research/` | direct | clean | `main` | `8b91ebd` | stale `origin/main` on the unreachable namespace (0/0 against a stale ref) |
| `osr-claude/` | direct | clean | `main` | `f2edd17` | `origin/main` (0/0) |
| `provenance-review/` | direct | clean | `main` | `86d9260` | `origin/main` (0/0) |
| `analysis-workbook/` | direct | clean | `main` | `2261659` | `origin/main` (0/0) |
| `threat-modeler/` | direct | clean | `main` | `0d5bed3` | `origin/main` (0/**2**) |
| `beryllium-repo` | symlink `../copilot/msft/beryllium` | clean | `beryllium/single-hart-runtime-r0` | `65f6d89` | `origin/...` (0/0) |
| `cheri-riscv-notes-repo` | symlink `../copilot/gim/cheri-riscv-notes` | clean | `main` | `6553092` | `origin/main` (0/0) |
| `xrv-research-repo` | symlink `../copilot/gim/xrv-research` | clean | `main` | `ca41490` | `origin/main` (0/0) |

Later the same day (2026-09-04T21:42Z, `scripts/inspect-components.sh state
xrv-research-repo`): `xrv-research-repo` clean on `main` at `7314e2f`, 1
ahead of `origin/main`, after its owner carried `PMR-007`; `../COMPONENTS.md`
records that revision.

Carry-turn observations (2026-09-04, `scripts/inspect-components.sh
status` at 22:18Z before any write and again at 22:45Z after the
`pm-auditor` pass), rows that differ from the 16:15Z table, plus the
revisions moved by this turn's carried commits:

| Entry | 22:18Z | 22:45Z and after this turn's carries | Note |
| --- | --- | --- | --- |
| Parent | clean `main` `9abc320`, `backup/main` (0/0) | unchanged | recording commit for `c244910` |
| `project-manager/` | clean `main` `c244910`, `origin/main` (0/0) | unchanged until this turn's commit | |
| `helium-te-poc/` | **dirty (25)** `helium-te-travel-fedora44` `e65c6a0` (0/0) | clean **`f0d96b1`** (0/0), after the other session's `6d3cd14` and `f0d96b1` | carry-ineligible; not touched; statements recorded |
| `analysis-workbook/` | **dirty (10)** `main` `2261659` (0/0); carry refused | clean **`efde667`** (0/0) after the other session's commit; then **`83b97a3`** (0/**1**) after the carried commit | `PMR-011`, `PMR-004` Markdown, fourteen class-1 edits |
| `formal-verification-research/` | clean `main` `8b91ebd`, stale `origin/main` (0/0) | **`ccb48f6`** (0/**1**) after the carried commit | `PMR-012`, `PMR-008` |
| `threat-modeler/` | clean `main` `0d5bed3`, `origin/main` (0/2) | **`4a01578`** (0/**3**) after the carried commit | `PMR-004` Markdown part |

`registry-check` was exact at 22:18Z, reported the two other-session moves at
22:45Z, and is exact again after `../COMPONENTS.md` was refreshed with all
five moved revisions at the end of this turn.

Second coordination turn, 2026-09-05 (`scripts/inspect-components.sh status`
at 04:54Z before any write; `registry-check` exact; `pull-queues.sh check`
passing). Every row matched the carry-turn end state: parent clean `main`
`1607db5` (`backup/main` 0/2), this repository clean `main` `a1677c1`
(`origin/main` 0/2), `helium-te-poc/` clean `f0d96b1` (0/0),
`formal-verification-research/` clean `ccb48f6` (0/1), `osr-claude/`
`f2edd17`, `provenance-review/` `86d9260`, `analysis-workbook/` clean
`83b97a3` (0/1), `threat-modeler/` clean `4a01578` (0/3), `beryllium-repo`
`65f6d89`, `cheri-riscv-notes-repo` `6553092`, `xrv-research-repo` `7314e2f`
(0/1). Rows moved by this turn's carried commits, each re-observed clean by
`state <component>` immediately before the write:

| Entry | Before | After this turn's carry | Note |
| --- | --- | --- | --- |
| `formal-verification-research/` | clean `main` `ccb48f6` (0/1 against the stale ref) | **`8246147`** (0/**2**) | `PMR-017`, `COLLAB.md` only |
| `threat-modeler/` | clean `main` `4a01578` (0/3) | **`226d367`** (0/**4**) | `PMR-015`, `RESEARCH-SOURCES.md` only |
| `analysis-workbook/` | clean `main` `83b97a3` (0/1) | **`ff12f2f`** (0/**2**) | `PMR-015`, `RESEARCH-SOURCES.md` only |

A `status` run at 05:15Z after the carries and after the first `refs` runs
showed every component still clean at those revisions, and `registry-check`
exact once `../COMPONENTS.md` was refreshed. `helium-te-poc/` was not
written; its ref listing is recorded in
`records/assurance/helium-te-fv-pathfinder.md`.

Third coordination turn, 2026-09-05 (`scripts/inspect-components.sh status`,
`components`, `symlinks`, and `registry-check` at 07:13Z before any write;
`refs helium-te-poc` and `refs formal-verification-research` at 07:14Z):
every row identical to the second turn's end state. Parent clean `main`
`afb4f03` (`backup/main` 0/0); this repository clean `main` `73cb51b`
(`origin/main` 0/0); `helium-te-poc/` clean `helium-te-travel-fedora44`
`f0d96b1` (0/0); `formal-verification-research/` clean `main` `8246147` (0/2
against the stale ref); `osr-claude/` clean `f2edd17` (0/0);
`provenance-review/` clean `86d9260` (0/0); `analysis-workbook/` clean
`ff12f2f` (0/2); `threat-modeler/` clean `226d367` (0/4); `beryllium-repo`
clean `65f6d89` (0/0); `cheri-riscv-notes-repo` clean `6553092` (0/0);
`xrv-research-repo` clean `7314e2f` (0/1). All three tracked symlinks
resolved to the expected repositories. `registry-check` was exact before any
write. The Helium `refs` listing showed the same twenty local branches (the
same thirteen without an upstream), the same eight remote-tracking branches
plus the symbolic `origin/HEAD`,
and no tags as the 05:15Z record; the formal-verification-research listing
showed the same two `collab/*` branches, both merged, and `main` 2 ahead of
the stale `origin/main` at `8b91ebd`. `pull-queues.sh list` showed only
`PMQ-008`, `PMQ-011` (`routed`, `PMR-009`) and `HET-001` (`routed`,
`PMR-016`); `check` passed (17 source rows, 17 ledger rows); `edits` printed
"no source edits are due". No component was written; no `git -C <component>`
command was run.

Fourth coordination turn, 2026-09-05 (`scripts/inspect-components.sh
status` at 19:10Z; `components`, `symlinks`, and `registry-check` at 19:11Z;
all before any write): every HEAD identical to the third turn's end state
plus the two recording commits of the third turn and follow-up 5, and every
worktree clean. Parent clean `main` `6f452b7` (`backup/main` 0/0); this
repository clean `main` `088046c` (`origin/main` 0/0); `helium-te-poc/`
clean `helium-te-travel-fedora44` `f0d96b1` (0/0);
`formal-verification-research/` clean `main` `8246147` (0/2 against the
stale ref); `osr-claude/` clean `f2edd17` (0/0); `provenance-review/` clean
`86d9260` (0/0); `analysis-workbook/` clean `ff12f2f` (**0/0**, was 0/2);
`threat-modeler/` clean `226d367` (**0/0**, was 0/4); `beryllium-repo` clean
`65f6d89` (0/0); `cheri-riscv-notes-repo` clean `6553092` (0/0 as of its
last successful fetch); `xrv-research-repo` clean `7314e2f` (0/1). All three
tracked symlinks resolved to the expected repositories; `registry-check` was
exact before any write. The four changed ahead counts are the human's
19:05Z `scripts/owner-actions.sh` pushes (log in `scratch/owner-actions/`;
`git rev-parse origin/main` here and `git -C .. rev-parse backup/main`
confirmed `088046c` and `6f452b7`). `refs helium-te-poc` and `refs
formal-verification-research` at 22:00Z were identical to the 07:14Z
records (thirteen Helium branches still without an upstream; no
`backup` remote in formal-verification-research). `pull-queues.sh list`
showed only `PMQ-008`, `PMQ-011` (`routed`, `PMR-009`) and `HET-001`
(`routed`, `PMR-016`); `check` passed (17/17); `edits` printed "no source
edits are due". A read-only `grep -rIl` text search of `../beryllium-repo/`
(file reading only, run from `project-manager/`; no Git, build, or script
command in the component) found no `HET-001` mention. No component was
written; no `git -C <component>` command was run.

Fifth coordination turn, 2026-09-06 (`scripts/inspect-components.sh status`
and `registry-check` at 08:42Z before any write; `refs
formal-verification-research` and `refs helium-te-poc` at 08:42Z; `refs
beryllium-repo 102f2b0` later in the turn): every HEAD as recorded and every
worktree clean. Parent clean `main` `98fc0f5` (`backup/main` 0/0); this
repository clean `main` `366e0ad` (`origin/main` 0/0); `helium-te-poc/`
clean `helium-te-travel-fedora44` `f0d96b1` (0/0);
`formal-verification-research/` clean `main` `8246147`, **upstream now
`backup/main` (0/0)** with `origin/main` still the stale `8b91ebd`;
`osr-claude/` `f2edd17` (0/0); `provenance-review/` `86d9260` (0/0);
`analysis-workbook/` `ff12f2f` (0/0); `threat-modeler/` `226d367` (0/0);
`beryllium-repo` `65f6d89` (0/0); `cheri-riscv-notes-repo` `6553092` (0/0 as
of its last successful fetch); `xrv-research-repo` `7314e2f` (0/1). All three
tracked symlinks resolved; `registry-check` exact. The Helium `refs` listing:
the same twenty local branches at the same tips, nineteen with an upstream
(twelve new since the 2026-09-05 listings), twenty remote-tracking branches
plus `origin/HEAD`, no tags; `helium-te-fv-tier8-h7-approved` alone without an
upstream. The formal-verification-research listing: remote-tracking
`backup/main` at `8246147`, the two merged `collab/*` branches unchanged.
`refs beryllium-repo 102f2b0`: exists, on `beryllium/single-hart-runtime-r0`
and its remote-tracking branch, subject "r8: add bounded H0 profile freeze".
`pull-queues.sh list` showed only `PMQ-008`, `PMQ-011`, and `HET-001`
(`routed`); `check` passed (17/17); `edits` printed none. The two
`scratch/owner-actions/` logs of 08:39Z (plan, execute) were read as evidence
of the owner's actions. At 09:20Z the parent worktree was found modified by
another session (`SOT.md`, `README.md`, `.github/copilot-instructions.md`
changed; `formal-verification/README.md` untracked; file times 09:52 local),
adopted by the user's choice quoted in "Provenance". No component was written;
no `git -C <component>` command was run.

Sixth coordination turn, 2026-09-06 (`scripts/inspect-components.sh status`
and `registry-check` at 10:30Z before any write; `refs <component> <hash>` for
the three moved components at 10:30Z): every worktree clean; three HEADs
moved since the fifth turn, all by the human's 10:29Z script run, and
`registry-check` reported exactly those three drifts. Parent clean `main`
`1aa13c3` (`backup/main` 0/0); this repository clean `main` `dbe181a`
(`origin/main` 0/0); `helium-te-poc/` clean `f0d96b1` (0/0);
`formal-verification-research/` clean `main` **`e5740de`** (`backup/main`
0/0; `origin/main` still the stale `8b91ebd`); `osr-claude/` clean `main`
**`e275544`** (`origin/main` 0/0); `provenance-review/` `86d9260` (0/0);
`analysis-workbook/` clean `main` **`d003dec`** (`origin/main` 0/0);
`threat-modeler/` `226d367` (0/0); `beryllium-repo` `65f6d89` (0/0);
`cheri-riscv-notes-repo` `6553092` (0/0 as of its last successful fetch);
`xrv-research-repo` `7314e2f` (0/1). All three tracked symlinks resolved.
`refs analysis-workbook d003dec`: exists, on `main` and `origin/main`,
subject "docs: mirror HET-001 to recorded (PMR-019)"; `refs osr-claude
e275544`: on `main` and `origin/main`, "docs: refresh infrastructure facts
(PMR-002)"; `refs formal-verification-research e5740de`: on `main` and
`backup/main`, "docs: align Project Manager wording with COLLAB.md
(PMR-014)". The transfer queue at `d003dec` shows `HET-001` `recorded`
(history rows `routed` and `recorded` dated 2026-09-06; `ACTIVITY-002`;
input state `unaccepted`); the workbook `HANDOFF.md` still calls it `new` in
three sentences; `../osr-claude/HANDOFF.md` lines 28-29 now state the SSH
remote and the applied `mktemp` fix; the formal-verification-research
agent-instruction bullet and both `README.md` sentences now describe the
standing carry authority; `../beryllium-repo/planning/HANDOFF.md` still holds
the four `local-uncommitted` phrases (`PMR-003` not yet done). The parent
`files` link no longer exists (removed by the human's script run; the path was
ignored, so the parent stays clean). `pull-queues.sh list` shows only
`PMQ-008` and `PMQ-011` (`routed`); `check` 17/17; `edits` none. No component
was written; no `git -C <component>` command was run.

The 16:15Z `registry-check` had reported one drift, `helium-te-poc`
(`9af92cc` recorded, `e65c6a0` live), reconciled in `../COMPONENTS.md` in
that turn. `helium-te-poc/` changed six times on 2026-09-04 (clean
`for-review` at `1ab289c` and the dirty travel branch at `9af92cc`, both as
recorded by the consolidation update without a timestamp for the first; the
clean travel branch at `e65c6a0` at 16:15Z; the same HEAD dirty again with 25
entries at 22:18Z; clean at `f0d96b1` at 22:45Z after two commits by another
session); another agent session works there. Nothing in that worktree was
touched, and its state must not be reset, cleaned, or reconciled by the
Project Manager.

The parent `.gitignore` excludes every direct component checkout, now
including `/project-manager/`. The three `*-repo` entries are tracked symlink
objects; their target contents remain outside parent history.

## Component notes

Each note separates the last Project Manager review (2026-08-29, parent
`HANDOFF.md` at `7677527`) from what was observed on 2026-09-04,
2026-09-05, and 2026-09-06. Conventions,
commands, and boundaries are in `components/<component>.md`.

### Helium Type Enforcement PoC

Observed 2026-09-06T19:09Z (seventh turn): checked-out
`helium-te-travel-fedora44` at `9b3ff4e` ("docs: record directed push of the
travel-maintenance branch", one commit after `f0d96b1`), clean, `origin` at
the same commit as of the last fetch. The Project Manager did not read the
commit beyond its subject and did not re-run the eleven-ref `refs` check this
turn; the statements and refs below stand as recorded at `f0d96b1` until the
next turn re-observes them. `9b3ff4e` is also the commit from which the new
`security-reviewer/` component extracted the `agent-review/` review contract,
read only; Helium is unchanged by that extraction.

Last reviewed: development tip `7780394` on
`helium-te-fv-tier7-capture-contract`; Tier 7 H6 candidate `7ca97a9`
validated but unreviewed; frozen Tier 6 H7 gate `c594b7f`; pre-relocation
preservation `d87080a`. Maintained candidate gate then: 17 harnesses, 142
named claims, 16,233 successful CBMC properties, 16 rejected mutations.

Observed 2026-09-04T12:29Z, as recorded by the consolidation update (its
method for listing refs is not recorded there): all of those refs still
existed, and new branch refs included `helium-te-fv-tier7-h7-approved`
(`342e04a`), `helium-te-fv-tier8-h6-candidate` (`ed15451`),
`helium-te-fv-tier8-h7-approved` (`85a6e55`), `helium-te-fv-tier8-transaction`
(`3dc3aee`), `for-review` (`1ab289c`), and the checked-out
`helium-te-travel-fedora44` (`9af92cc`, dirty with 43 entries).

Reconciled 2026-09-04T16:15Z against `../helium-te-poc/HANDOFF.md` at
`e65c6a0`, worktree clean (`PMD-20260904-002`). The component states that:
the travel branch was created at exact base `3dc3aee` from
`helium-te-fv-tier8-transaction` and lies outside the fixed Tier 8 H6
candidate `ed15451` and frozen Tier 8 H7 gate `85a6e55`; the reviewed Tier 7
source is `7ca97a9` with frozen Tier 7 H7 gate `342e04a`; the frozen Tier 6
H7 gate is `c594b7f` and the Tier 5 H7 gate `111cff2`; the earlier H7 lineage
`helium-te-fv` / `helium-te-h7-approved` is `d0cca32`;
`helium-te-fv-pre-relocation-wip` preserves the pre-transfer snapshot; the
historical `local-history` tip `c8d1032` is absent and must not be recreated;
the exact Tier 8 candidate records 18 successful CBMC checks, 152 named
claims, 19,419 successful properties, and 18 rejected mutations; the Fedora 44
travel checkpoint passed native `./he check` and rootless `./he evaluate` for
maintenance candidate `e83e99c`; and the travel gate remains blocked. The
component further states that Tier 8 "completed responsible-human H6 review
and has a valid frozen H7 gate" and that this "does not approve later
maintenance-branch documentation or constitute publication".

The Project Manager records all of that as the component's own statements. It
has not reviewed the Tier 7 or Tier 8 gate content, had not at that point
verified that the named refs exist or are frozen (the inspect script then
reported only the checked-out branch; the 2026-09-05 `refs` listing later
confirmed existence, not frozenness or content), and infers no approval from
a branch name, a clean
worktree, or a passing evaluator run. The observed statements are tabulated
in `records/assurance/helium-te-fv-pathfinder.md`, above its retained
2026-08-18 snapshot. The component's handoff also names home-directory
travel caches, a bootstrap helper script, and a repository bundle; those are
workstation paths outside the workspace and are deliberately not recorded
here.

Preserve the claim boundary: Helium is a review-and-test PoC, not formally
verified or hardware validated; selected C properties are machine-checked by
CBMC only within their stated source, property, and tool boundary.

Observed 2026-09-04T22:45Z at `f0d96b1` (clean, synchronized; commits
`6d3cd14` "docs: close Helium FV at Tier 8" and `f0d96b1` "docs: record Tier
8 endpoint completion" by another session; subjects are not gate evidence).
`../helium-te-poc/HANDOFF.md` at that commit **states** that `FV-FIN-001` is
resolved: "on 2026-09-04, the responsible human selected Tier 8 as the
endpoint for Helium formal-verification experimentation, and no Tier 9 or
final Helium methods spike will be pursued", decision commit `6d3cd14`; that
the approved Tier 8 H6/H7 refs are unchanged and must remain frozen; that the
travel gate remains blocked; and that "This is a review-and-test PoC. It is
not formally verified and has not been validated on hardware." The same
direction reaches the Project Manager independently as the workbook's
`HET-001`. Recorded as the component's statements only; the Project Manager
has not reviewed the endpoint decision or any gate content and infers no
approval (`PMD-20260904-004` item 9). Recorded on 2026-09-05 in the new
section "Observed component statements, 2026-09-05 (`f0d96b1`)" of
`records/assurance/helium-te-fv-pathfinder.md`, which tabulates every
statement and ref with its change since `e65c6a0`, and in the subsection
"Read-only ref listing, 2026-09-05T05:15Z": `bash
./scripts/inspect-components.sh refs helium-te-poc <refs>` found all eleven
named refs present locally (twenty local branches, no tags); as of the last
fetch all but `d0cca32` are reachable from a remote-tracking branch, and the
local `helium-te-fv-tier8-h6-candidate`, `helium-te-fv-tier8-h7-approved`, and
`helium-te-fv-tier8-transaction` branches have no upstream configured although
`ed15451` and `85a6e55` are reachable from
`origin/helium-te-fv-tier8-h7-approved`. `PMR-018` asked the owner to decide
the backup of the local-only lineage; on 2026-09-06 the owner pushed twelve
branches with upstreams through the human-run `scripts/owner-actions.sh
--helium-branches` (verified in its log; `refs` at 08:42Z shows the `d0cca32`
lineage on `origin/helium-te-fv` and `origin/helium-te-h7-approved`), and
`PMR-018` is closed; `helium-te-fv-tier8-h7-approved` was already on `origin`
and alone has no upstream configured. A private backup: existence is not gate
review and not approval, and nothing was published. The component's handoff at `f0d96b1` asks nothing of the Project
Manager; its stated next actions are the responsible human's (push or
publish the frozen H7 branch manually; decide which work may proceed from the
travel-maintenance baseline).

Incident provenance retained: at 2026-08-11 23:16:30 PDT a subagent ran
`git init` and fetched into the former workspace path under a "Recover
assigned checkout" action. That recovery was incorrect; `SOT.md` rule 3 forbids
it.

### Formal-verification research

Last reviewed: `main` at `eaa497b` with both Helium FV consumption logs
integrated (`26f3a54`, merge `eaa497b`). Observed 2026-09-04: `main` at
`8b91ebd` ("define sub-project collaboration roles"), clean. The only remote
was then the unreachable `jamorris_microsoft` namespace, so the component had
no working off-machine backup (superseded by the "Backed up 2026-09-06"
paragraph below). The coordination discrepancy retained from the last review
(owner-status table and handoff describing only the first integration) is
observed resolved at `8b91ebd`: `COLLAB.md` "Owner status" names latest
integration `eaa497b`, two guest integrations, latest validated destination
`ff4a8a8`, and no unmerged `collab/*` branch on 2026-08-19, and `HANDOFF.md`
names both integrated logs (`6f5f670`, `ff4a8a8`). `PMR-001` stayed open for
the backup decision only (closed 2026-09-06; see "Backed up 2026-09-06"
below).

Component expectations of the Project Manager at `8b91ebd`: `COLLAB.md`
"Parent Project Manager housekeeping budget" would let a designated Project
Manager integrate compliant `collab/*` branches and commit coordination
metadata inside the component, and `HANDOFF.md` asks the "owner or delegated
parent Project Manager" to inspect unmerged `collab/*` branches periodically.
Since `PMD-20260904-003` the Project Manager holds a narrower standing carry
authority: it never integrates `collab/*` branches or edits research, and it
commits in this repository only for carried class-2 (`sources/bibliography.md`
pointers) and class-3 (Project Manager-role wording) requests. `collab/*`
integration stays owner-only; periodic `collab/*` inspection is done
read-only with `scripts/inspect-components.sh refs
formal-verification-research` since 2026-09-05 (see the carry paragraph
below).

Carried 2026-09-04 (22:18Z turn), commit `ccb48f6` on `main`
(`PMD-20260904-004`): `PMR-012` (superseding `PMR-010`) rewrote the
`COLLAB.md` intro paragraph, the body of "Parent Project Manager housekeeping
budget" (heading kept because the owner-only `.github/copilot-instructions.md`
and `README.md` refer to it), and the ledger integration procedure, and the
`HANDOFF.md` sections "Workspace and agent model", "Possible next steps", and
"Project Manager housekeeping", so that both documents now describe the
standing carry authority; `PMR-008` added the `sources/bibliography.md`
section "Routed pointers awaiting owner triage" with five metadata-only
entries. The owner's `.github/copilot-instructions.md` bullet and `README.md`
sentence still describe the old budget and, with the pointer triage, are
`PMR-014`. The component is 1 commit ahead of its stale, unreachable remote
ref; `PMR-001` (backup) is unchanged and now covers the carried commit.

Carried 2026-09-05, commit `8246147` on `main`: `PMR-017` (class 3) made the
"Ledger integration procedure" attribute the `git switch main` / `git branch
--no-merged` block to the research owner alone; the Project Manager runs none
of those commands and only reports what its read-only inspection observes.
The worktree was clean immediately before the write and the diff was that
sentence. The component is now 2 commits ahead of the stale ref (`PMR-001`).
The read-only `refs` listing the same turn showed two local `collab/*`
branches (`collab/helium-te-fv-gpt56sol-20260811-pathfinder` `14f06d5`,
`collab/helium-te-fv-gpt56sol-20260812-trap-effect` `ff67d02`), both merged
into `main`, consistent with the owner-status table; the periodic `collab/*`
inspection the component asked for can now be done without any command
inside the component.

Backed up 2026-09-06: through the human-run `scripts/owner-actions.sh
--fvr-backup` the owner created the private
`beryllium-project/formal-verification-research`, added remote `backup`
(`origin` untouched, still the stale unreachable namespace), and pushed `-u
backup main` (25 commits up to `8246147`, verified with `ls-remote` in the
log); `status` at 08:42Z shows `main` tracking `backup/main` 0/0, so the
carried `ccb48f6` and `8246147` are off this workstation. `PMR-001` closed.
`PMR-014` (P3): the wording half was applied by the owner at 10:29Z on
2026-09-06 through `--apply-edits`, commit `e5740de` ("docs: align Project
Manager wording with COLLAB.md (PMR-014)"; the agent-instruction bullet and
both `README.md` "Workspace relationship" sentences now describe the standing
carry authority), pushed to `backup` (`8246147..e5740de`, verified); observed
clean at `e5740de`, `backup/main` 0/0, at 10:30Z. The five routed pointers
remain the owner's per-pointer call.

### OS security research archive

Observed unchanged at `f2edd17` through 2026-09-06T08:42Z, clean,
synchronized with its personal-account SSH remote. `sources/restricted-microsoft/`
remains quarantined. The retained discrepancy (stale HTTPS-remote and
pending-`mktemp` statements in its handoff, `PMR-002`) was resolved by the
owner on 2026-09-06: through the human-run `scripts/owner-actions.sh
--apply-edits` (its y/N prompt being the component's ask-first convention)
the owner committed `e275544` ("docs: refresh infrastructure facts
(PMR-002)"), replacing the two lines with the SSH remote and the applied
`mktemp` fix, and pushed it (`f2edd17..e275544`, verified). Observed at
10:30Z clean at `e275544`, 0/0. `PMR-002` closed.

### Beryllium implementation repository

Observed unchanged at `65f6d89`, clean, synchronized. Accepted through R7;
commit `102f2b0` holds the authorized non-privileged R8-H0 profile-freeze
candidate; committed content is not acceptance. All 81 H0 acceptance rows
remain unresolved; no normative host/path input has been selected; no K3
execution occurred. Retained discrepancy: `planning/HANDOFF.md` names a former
workstation path and calls H0 uncommitted (`PMR-003`, P2 since 2026-09-06;
the pasted command in `outbox/OWNER-RUNBOOK.md` replaces the six occurrences
and names `102f2b0`, confirmed to exist read-only, without inferring
acceptance; carry-ineligible, so never scripted).

`HET-001` triage, 2026-09-05: the responsible human, acting as the Beryllium
owner, told the Project Manager "HET-001 is triaged as accepted" and
confirmed that this maps to the transfer-lifecycle status `recorded`: all
eight candidate lessons are recorded as planning inputs for a possible future
Beryllium security-significant seam; none is adopted as an entry criterion,
design constraint, evidence requirement, or exit criterion; no Beryllium
authorization changes
(`records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`;
`PMR-016` closed; mirror requested as `PMR-019`). No Beryllium-owned artifact
records it (read-only text search at `65f6d89`); a later one would be cited
by a superseding record. This is not acceptance of any Beryllium target or
work.

The disposable H0 scaffold (prospective tree `44706e5`) and exact derivative
OCI were validated on 2026-08-17 and recorded as uncommitted decision support.
Their artifacts were retained only under the now-lost `files` link; see
"Retained PM session artifacts".

### CHERI-RISC-V knowledge base and CHERI hypervisor research

The knowledge base is observed unchanged at `6553092`, clean, synchronized
as of its last successful fetch; the human-run `scripts/owner-actions.sh`
fetch of its `origin` failed with an authentication error on 2026-09-05 and
2026-09-06, so the live remote state is `unknown` (`PMR-020`, P2, raised
2026-09-06); its content license remains unresolved before any public mirror.
`PMR-009` (P4) waits for the session on the machine that holds the reference
database. The XRV
repository moved from `ca41490` to `7314e2f` (clean, 1 ahead of
`origin/main`) on 2026-09-04 when its owner carried `PMR-007`: the nine
routed pointers are recorded as pointer-only `arrived` records
`REV-20260904-001..009` in `review-log.md` with matching `review-inbox/`
files, own-words summaries and no copied text; the owner reported none as
already present (the Thunderclap CHERI follow-on, HASP 2020, already in the
survey is a different work). Verified read-only by the Project Manager; the
result was relayed by the user. Pushing `7314e2f` is the owner's decision
(`PMR-013`, **P1** since 2026-09-06: the script skipped `origin` as
unreachable on all three runs, so the commit exists only on this workstation; the
runbook gives the commands for a private `backup` remote). The XRV review `REV-20260817-001` (Supervisor Domain Isolation /
SmMTT) stands.

### Provenance review

Last reviewed at `760141d`. Observed now at `86d9260`, clean, synchronized:
adds `reviews/PRV-20260901-001-policy-install-readback/` alongside
`PRV-20260828-001-helium-te-security-architecture/`.

### Analysis workbook

Last reviewed at `ea71bd4` with no session. Observed now at `2261659`, clean,
synchronized: session `AWB-20260829-001-post-g-install-readback-use-case` with
inquiry `Q-001` exists, and `outbox/pm-queue.md` carries 16 `new` rows
(`PMQ-001..016`). All sixteen were triaged on 2026-09-04 and are `routed` in
`queue/LEDGER.md` (`PMD-20260904-001`): nine to `xrv-research-repo`
(`PMR-007`), five to `formal-verification-research` (`PMR-008`), two to
`cheri-riscv-notes-repo` (`PMR-009`). The Project Manager's own read-only
search of each suggested owner's index agreed with the workbook's
`IDX-SET-001` check that every source is absent there. Later on 2026-09-04
the xrv-research-repo owner recorded its nine (`PMR-007`, `7314e2f`), so
`PML-0001..0006`, `0009`, `0013`, `0016` are `accepted`. (Superseded by the
carry-turn paragraphs below: the five `PMR-008` rows were carried by the
Project Manager as class 2, `PMR-009` is request-only with no class-2
target, and the queue edits are applied.) The component's
`AGENT-INTERFACE.md` named a different Project Manager-written status set
(`acknowledged`, `routed`, `integrated`, `declined`); the conflict was raised
as `PMR-011` and carried at `83b97a3`.

At 22:18Z the same day the worktree was **dirty** (10 entries at `2261659`:
`.github/agents/analysis-workbook.agent.md`, `.github/copilot-instructions.md`,
`.github/skills/beryllium-analysis/SKILL.md`, `AGENT-INTERFACE.md`,
`HANDOFF.md`, `README.md`, `WORKBOOK.md`, `scripts/update-workbook.sh`,
`tests/validate-agent.sh` modified; `outbox/helium-transfer-queue.md`
untracked), so the planned carry was refused and nothing was written. At
22:45Z the other session had committed and pushed `efde667` ("docs: add
Helium method transfer queue"; `HANDOFF.md` there records `ACTIVITY-004` and
a "For the Project Manager" section naming both queues) and the worktree was
clean. After re-reading the local instructions at `efde667`, the Project
Manager committed `83b97a3` (`PMD-20260904-004`): `PMR-011` (status set and
consumers 1-3 of the "Source-discovery queue" section), the analysis-workbook
Markdown part of `PMR-004` (`RESEARCH-SOURCES.md` tier 4), and the fourteen
class-1 edits (`PMQ-001..007`, `009`, `010`, `012..016` to `accepted`;
`PMQ-008` and `PMQ-011` stay `new`, `PMR-009`). The component is 1 commit
ahead of its private `origin/main`; pushing is the owner's decision.

The committed `outbox/helium-transfer-queue.md` is a second, separate pull
interface: `HET-NNN` items carry evidence-scoped Helium-to-Beryllium method
inputs with their own lifecycle (`new`, `routed`, `recorded`, `deferred`,
`declined`, `superseded`) and input state (`unaccepted`), outside the
`PMQ-NNN` schema. `HET-001` (target `component://beryllium-repo`, anchored
to Helium Tier 8 candidate `ed15451` and `docs/fv-pathfinder-lessons.md`)
asks the Project Manager or responsible human to route it to the Beryllium
owner; the routing record is `PMR-016`. The workbook maintainer mirrors the
lifecycle only from an exact owner-side record; the Project Manager does not
edit that file (class 1 covers only `outbox/pm-queue.md`). Decided 2026-09-05
(`PMD-20260905-001`, after the human chose read-only registration): the queue
is the third source `analysis-workbook-transfer` in `scripts/pull-queues.sh`
and `queue/README.md`, tracked read-only; `PML-0017` records `HET-001` as
`routed` (`PMR-016`) with "Source status applied" `Not applicable`.

Carried 2026-09-05, commit `ff12f2f` on `main`: `PMR-015` (class 3) added
`../project-manager/queue/LEDGER.md` to the `RESEARCH-SOURCES.md`
"Source-discovery reference set". The worktree was clean immediately before
the write; the diff was one bullet. The component was then 2 commits ahead of
its private `origin/main`; the owner pushed both carried commits at 19:05Z on
2026-09-05 through the human-run `scripts/owner-actions.sh`
(`efde667..ff12f2f`, verified in its log), and the component was observed
synchronized at 19:10Z.

`HET-001` moved on the owner side on 2026-09-05: the responsible human,
acting as the Beryllium owner, triaged it and the Project Manager recorded
the disposition as the lifecycle status `recorded`
(`PMD-20260905-002`; `PMR-016` closed). The transfer queue itself still reads
`new`/`unaccepted` at `ff12f2f`; `PMR-019` hands the maintainer the exact
status-history, queue-summary, and activity-log rows to mirror it, and the
component's `HANDOFF.md` sentences saying `HET-001` is `new` are the
maintainer's to refresh. The Project Manager does not edit either file. Since
2026-09-06 the human applies the three table edits with
`scripts/owner-actions.sh --apply-edits` (exact text
`outbox/owner-edits/PMR-019-*`, validated by the component's own
`validate-helium-transfer-queue.sh --baseline` before the prompt) and commits
them as maintainer; the handoff prose refresh stays a separate maintainer
step (runbook). (Those edit files have since been removed from
`outbox/owner-edits/`, the edit having been applied.) Done 2026-09-06T10:29Z: the maintainer committed `d003dec`
("docs: mirror HET-001 to recorded (PMR-019)") after the component's
validator passed, and pushed it (`ff12f2f..d003dec`, verified); at `d003dec`
the queue shows `HET-001` `recorded` with `routed` and `recorded` history rows
citing `PMR-016` and `PMD-20260905-002`, `ACTIVITY-002`, and the input state
`unaccepted`. `PML-0017` notes the observation and stays `routed`. `PMR-019`
stays open, P3, for the three `HANDOFF.md` sentences that still say `new`.

### Threat modeler

Last reviewed at `affe17b` with no package. Observed 2026-09-04 at
`0d5bed3`, clean, **2 commits ahead** of `origin/main` (superseded below):
packages
`TM-20260901-001-helium-te-poc/` and `TM-20260904-001-helium-te-poc-fable51/`
exist; `outbox/pm-queue.md` is empty. Pushing is the owner's decision
(`PMR-005`).

Carried 2026-09-04 (22:18Z turn), commit `4a01578` on `main`
(`PMD-20260904-004`): the Markdown part of `PMR-004`. `RESEARCH-SOURCES.md`
Tier 1 now names the `project-manager/` component as the Project Manager
function, its `HANDOFF.md`, `records/`, `queue/LEDGER.md`, and
`outbox/component-requests.md` through `workspace://project-manager/...`,
calls the parent `HANDOFF.md` and
`formal-verification/helium-te-fv-pathfinder.md` redirect stubs, and says
`project-manager` is outside this repository's registered target set (that
list is in the owner-only `scripts/readonly-inspect.sh`, still `PMR-004`).
The component is now **3 commits ahead** of `origin/main`; `PMR-005` covers
the carried commit too. Its pull-protocol status set (`acknowledged`,
`routed`, `integrated`, `declined`) is the one `queue/README.md` already maps
to for this queue, so no vocabulary request is needed here. Carried
2026-09-05, commit `226d367` on `main`: `PMR-015` (class 3) added
`workspace://project-manager/queue/LEDGER.md` to the `RESEARCH-SOURCES.md`
"Discovery reference set"; the worktree was clean immediately before the
write and the diff was one bullet. The component was then **4 commits
ahead** of `origin/main`; the owner pushed them at 19:05Z on 2026-09-05
through the human-run `scripts/owner-actions.sh` (`affe17b..226d367`,
verified in its log), the component was observed synchronized at 19:10Z, and
`PMR-005` is closed. Observed 2026-09-06T19:03Z (seventh turn): `main` at
the owner's `dae994be` ("docs: add Helium threat-model run comparison and
agent improvement proposals"), clean, `origin/main` at the same commit as of
the last fetch; the Project Manager has not read that document's content
beyond its subject and records no position on its proposals. `PMR-022` asks
the owner to add `security-reviewer` to the registered target list.

### Security reviewer

Created 2026-09-06 in the seventh (recovery) turn and observed clean on `main`
at `9ca5071`, the initial commit, with **no remote** (`PMR-021`, P2). Role,
boundaries, queue protocol, and commands: `components/security-reviewer.md`
and the `security-reviewer/` row of `../COMPONENTS.md`; creation and
registration record: `records/decisions/PMD-20260906-003-security-reviewer-component-registered.md`.
Derivation: the Helium review contract at `../helium-te-poc/` `9b3ff4e`
(component `AUTHORS.md`; Helium unchanged). No review or synthesis package
exists; `SECURITY-REVIEWS.md` records an empty set; `outbox/pm-queue.md` is
empty (fourth queue source, `SRQ-NNN`). Its `HANDOFF.md` at `9ca5071`
suggests a first static-only engagement against `helium-te-poc` at its exact
clean commit; that is the component's suggestion, and starting it is the
human's decision. Open with the human: whether class 1 of `PMD-20260904-003`
extends to its queue file (until then its queue edits are the human's).

### Cross-project Supervisor Domains disposition

The independently produced OSR survey (`f2edd17`) and XRV review (`ca41490`)
agree: Supervisor Domains / SmMTT is unratified and unavailable on current K3
hardware or a complete mainline stack; it is a centrally administered
physical-resource isolation substrate, not a capability system and not a
replacement for Beryllium's G-stage design; it does not change the accepted R8
plan or unblock H0-H4; re-engagement waits for mainline QEMU or OpenSBI
support, followed by a separately scoped QEMU experiment.

## R8 H0-H4 glossary

`R8` is the bounded K3 hardware-validation stage after accepted R0-R7. The
`H` labels are package names within R8; they are not RISC-V privilege modes,
Hypervisor-extension versions, or assurance levels.

| Package | Plain-language meaning | Gate |
| --- | --- | --- |
| H0 | Freeze the exact board, firmware, tools, memory map, hart plan, procedures, paths, expected observations, and claim limits. Host/documentation work only; no Beryllium K3 execution. | Current package; must be exact-commit accepted before H1 |
| H1 | Run the smallest read-only privileged characterization image. Observe entry mode, harts, H-extension behavior, optional state, PMP/Smepmp, interrupts, cache, IOMMU/IOPMP, and firmware behavior. Do not enter VS mode. | Requires accepted H0 and separate H1 authorization |
| H2 | Run the fixed two-synthetic-domain Beryllium scenario on K3: build roots, enter management/protected subjects, perform positive accesses and real denials, and return safely. | Requires accepted H1 and separate H2 authorization |
| H3 | Repeat GCC/Clang hardware runs, compare canonical K3 and QEMU semantics, and run bounded hardware-safe negative cases. | Requires a complete compatible H2 candidate |
| H4 | Assemble deterministic reports/evidence/evaluator guidance and prepare one exact R8 implementation commit for responsible-human review. | Explicit exact-commit acceptance remains separate |

Current position is **H0 only**.

### The two pending H0 selections

The board does not need to be operational for this decision. The responsible
human can authorize:

1. exact Fedora 44 H0 static OCI archive
   `fcf6c595140a9dd55d6afb633ac7777162492cdae6b77cd27a59e4541c1bd1f5` as the
   normative H0 build/check environment, GNU ELF tools primary and LLVM ELF
   tools as the independent cross-check; and
2. proposed H1/H2 path inventory
   `2c5e93966371697cfb300e7e766cebb6d39bdf3e9678bc69ece9dc9776cb6660`,
   retaining no Beryllium-maintained M-mode runtime, requiring
   firmware-provided DBCN/SRST, reusing accepted R5 guest/QEMU semantics, and
   keeping H1 evidence generated rather than a maintained page.

That instruction would authorize updating and re-checking a still-blocked H0
candidate. It would **not** accept H0, authorize H1, or authorize K3
execution. If no decision is made, wait for the board and complete the
physical checklist; do not infer either selection.

### Board-dependent facts still required later

- exact kit/carrier/SoM/vendor/SKU/revision and project-local non-secret lab ID;
- installed DRAM topology, populated boot medium, and every strap position;
- UART connector/node/voltage/wiring/adapter and bounded capture procedure;
- ordinary power, minimum-off-time, cold-reset, and capture-start procedure;
- exact firmware/DTB bytes, source, configuration, build, and hashes;
- load and entry addresses, full memory ownership/cacheability map;
- participating hart, secondary-hart parking contract/check, and SBI behavior.

Use `unknown` rather than guessing. Never include serial numbers, credentials,
keys, tokens, or private URLs.

## Retained PM session artifacts

The previous handoff exposed decision-support artifacts through an ignored
parent-root `files` symlink into a Copilot session-state directory (session
`a987ff70-9af5-4718-b07f-936f54e21ca8`). On 2026-09-04 that target no longer
exists, and a bounded search of the home directory found none of the named
files. The recorded inventory was:

```text
files/r8-offline-design/K3-H0-PHYSICAL-INSPECTION-CHECKLIST.txt
files/r8-offline-design/fedora44-omni-k3-com260-boot-provenance.md
files/r8-offline-design/r8-h1-h2-proposed-path-inventories-v1-report.md
files/r8-offline-design/K3-MEMORY-CONSTRAINTS.md
files/h0-static-oci/image-identity.txt
files/h0-candidate-scaffold-artifacts/H0-CANDIDATE-SCAFFOLD-REPORT.md
files/k3-h0-return-20260817/source-archive/be-k3-h0-collection.tgz   # mode 0600, 7,675 bytes
```

The inbound archive's recorded SHA-256 is
`277d6168f9b0ae4bbb521eead40dc314f74c855e74f4be4ac3bba3c0af1c5d05`; the
disposable H0 scaffold's recorded prospective tree is
`44706e515d0040ca721b4919af3844032f567d10`.

Per `SOT.md` rule 3 nothing was recreated or recovered. The broken parent link
was left in place as evidence until 2026-09-06, when the human-run
`scripts/owner-actions.sh --files-search` (10:29Z) found none of the seven
names under the home directory (a read-only `find` pruning `.git`,
`node_modules`, and `.cache`, with a SHA-256 check of any archive found) and,
on the human's `y`, removed the link; the human then said "done, see log".
**Recorded as lost from this workstation** in
`records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`,
which keeps the identities above for later matching. Existence on another
machine or medium is `unknown`; `bash ./scripts/owner-actions.sh
--files-search --files-root DIR` repeats the read-only search over any mount.
Whether the two H0-selection inputs among them are regenerated from the
canonical Beryllium repository's checked launchers is the Beryllium owner's
decision under Beryllium's controls; the Project Manager infers nothing and
moves no gate. `project-manager/.gitignore` already ignores a future `files`
link at this repository's root.

## Restart procedure

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
sed -n '1,120p' HANDOFF.md
sed -n '1,80p' ../SOT.md
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh symlinks
bash ./scripts/inspect-components.sh registry-check
bash ./scripts/pull-queues.sh list
bash ./scripts/validate-pm.sh
bash ./tests/validate-agent.sh
git status --short --branch
git -C .. status --short --branch
```

Then:

1. Read `../SOT.md` and `.github/copilot-instructions.md`.
2. Read `../COMPONENTS.md` and confirm every tracked symlink resolves.
3. Check component and agent ownership before assigning or performing writes;
   read the target component's local instructions, `HANDOFF.md`, and
   `COLLAB.md` where present.
4. Keep coordination changes in this repository and the parent root; keep
   component changes in the owning component, requested through
   `outbox/component-requests.md`, except the three carried classes of
   `PMD-20260904-003`, which the Project Manager applies and commits inside
   the eligible component.

## Pending coordination

- **New component to back up and to answer for.** `security-reviewer/`
  (`9ca5071`) has no remote (`PMR-021`); `PMR-022` asks two sibling owners to
  register it as a target; `PMD-20260906-003` item 3 asks the responsible
  human whether class 1 of the standing carry authority extends to its
  `outbox/pm-queue.md`. When `pull-queues.sh list` first shows an `SRQ-NNN`
  row, add a `PML-NNNN` row, route it with a `PMR-NNN`, and, until the
  extension is granted, hand the printed status edit to the human. A later
  class-3 carry candidate: the component's `HANDOFF.md` sentence that
  registration is pending.
- **No carry is queued.** `PMR-015` (`226d367`, `ff12f2f`) and `PMR-017`
  (`8246147`) were carried on 2026-09-05; `PMR-012`, `PMR-008`, `PMR-011`,
  `PMR-006`, and the Markdown parts of `PMR-004` on 2026-09-04. `PMR-009` is
  request-only (cheri-riscv-notes-repo `references/` are generated exports
  behind gate D4). Every open request is request-only or owner-only, carries
  a priority (`P1`-`P4`, `PMD-20260906-001`), and has exact human steps in
  `outbox/OWNER-RUNBOOK.md`; `PMR-019`, `PMR-002`, and the wording half of
  `PMR-014` were applied by the human through `scripts/owner-actions.sh
  --apply-edits` on 2026-09-06 (`d003dec`, `e275544`, `e5740de`), never by
  the agent; no recorded edit is pending in `outbox/owner-edits/`.
- **Transfer queue**: consumed read-only as `analysis-workbook-transfer`
  (`PMD-20260905-001`). If `pull-queues.sh list` shows a new `HET-NNN` row
  in a turn, add a `PML-NNNN` row, route it with a `PMR-NNN`, never edit the
  file, never use `accepted`. The Beryllium owner's triage of `HET-001` is recorded
  (`PMD-20260905-002`; `PMR-016` closed 2026-09-05; disposition `recorded`,
  planning inputs only); the workbook maintainer mirrored it at `d003dec` on
  2026-09-06 (observed: `HET-001` `recorded`, input state `unaccepted`; the
  `PML-0017` note records it and the row stays `routed`); `PMR-019` stays
  open at P3 only for the component's `HANDOFF.md` prose and closes when that
  is observed. A later Beryllium-owned artifact recording the triage is cited
  by a superseding record.
- **Helium**: the `f0d96b1` statements and the read-only ref listing are in
  `records/assurance/helium-te-fv-pathfinder.md`. Each turn, re-run `bash
  ./scripts/inspect-components.sh refs helium-te-poc` and re-read
  `../helium-te-poc/HANDOFF.md`; record changes as statements only
  (`PMD-20260904-002`). `PMR-018` is **closed** 2026-09-06: the owner pushed
  the local-only branches, including the `d0cca32` lineage, to the private
  `origin` (a backup, not publication or gate review).
- **`collab/*` inspection**: `bash ./scripts/inspect-components.sh refs
  formal-verification-research` lists unmerged `collab/*` branches read-only;
  an unmerged branch observed there becomes a request to the owner, never an
  integration.
- **Lost retained artifacts**: recorded lost 2026-09-06 (`PMD-20260906-002`,
  section above); a later find adds a superseding record.
- **Pushes** stay per-turn user-confirmed actions when the agent performs
  them, for this repository, the parent, and every component. The second
  turn's coordination commits were pushed under the confirmation quoted in
  "Provenance" (through `73cb51b` here and `afb4f03` in the parent); the
  third turn's and follow-up 5's commits (`208579d`, `088046c`; `6f8a0a7`,
  `6f452b7`) were pushed by the human-run `scripts/owner-actions.sh` at
  19:05Z on 2026-09-05, as were the carried component commits `4a01578`,
  `226d367`, `83b97a3`, and `ff12f2f` (owners' pushes through the same
  run); the fourth turn's commits in both repositories are pushed under the
  confirmation "push when done" quoted in "Provenance" (verified; `366e0ad`
  and `98fc0f5` re-observed on the remotes 2026-09-06); `ccb48f6` and
  `8246147` reached the new private `backup` remote of
  formal-verification-research on 2026-09-06 (`PMR-001` closed); the fifth
  turn's commits (`dbe181a`, `1aa13c3`) and the owners' `d003dec`,
  `e275544`, and `e5740de` were pushed by the human's 10:29Z run; **the sixth
  turn's commits in both repositories are local**. The human does all of
  these with `bash ./scripts/owner-actions.sh` (never run by the agent); the
  next turn records the result from the human's statement, the script's log
  in `scratch/owner-actions/`, and the observed remote-tracking state.
- `PMR-001` formal-verification-research: **closed** 2026-09-06; the owner
  created the private `beryllium-project/formal-verification-research`, added
  remote `backup` (`origin` untouched), and pushed `main` to `8246147` through
  the human-run script (`--fvr-backup`); `main` tracks `backup/main` 0/0.
- `PMR-012` formal-verification-research (superseded `PMR-010`): **closed**,
  carried at `ccb48f6`. `PMR-014`'s alignment of the agent-instruction bullet
  and `README.md` sentences was applied by the owner at `e5740de` on
  2026-09-06; the request stays open for the five routed pointers.
- `PMR-011` analysis-workbook: **closed**, carried at `83b97a3`
  (`AGENT-INTERFACE.md` aligned to the queue header status set).
- `PMR-002` osr-claude: **closed** 2026-09-06; the owner applied the two-line
  replacement through the human-run `--apply-edits` (`e275544`, pushed).
- `PMR-003` beryllium-repo (P2: a former workstation path in an agent-read
  handoff invites the checkout-recovery incident `../SOT.md` rule 3 forbids):
  reconcile `planning/HANDOFF.md` path and H0 commit wording (request-only:
  carry-ineligible component; pasted command in `outbox/OWNER-RUNBOOK.md`;
  `102f2b0` confirmed to exist read-only on 2026-09-06).
- `PMR-004` analysis-workbook and threat-modeler: both Markdown parts carried
  (`4a01578`, `83b97a3`); open (P3) only for the two owner-only
  `scripts/readonly-inspect.sh` registered lists (exact edits in the runbook).
- `PMR-005` threat-modeler: **closed** 2026-09-05; the owner pushed the 4
  local commits, including the carried `4a01578` and `226d367`, through the
  human-run `scripts/owner-actions.sh` (`affe17b..226d367`, verified).
- `PMR-006` analysis-workbook: **closed**; the fourteen class-1 edits were
  applied at `83b97a3` and the ledger records `yes 2026-09-04`.
- `PMR-007` xrv-research-repo: closed at `7314e2f`; `PMR-013` is the owner's
  push decision for that commit.
- `PMR-008` formal-verification-research: **closed**, carried at `ccb48f6`
  (class 2); the owner may still remove a pointer (`PMR-014`), after which
  the ledger row gets a superseding `rejected` note.
- `PMR-009` cheri-riscv-notes-repo (P4): request-only; the owner records the
  two pointers through the reference database (a SQLite store in a Copilot
  session on another machine) and regeneration (gate D4); metadata in the
  runbook.
- `PMR-013` xrv-research-repo (**P1**): three script runs (2026-09-05T19:05Z,
  2026-09-06T08:39Z and 10:29Z) found `origin` in the unreachable namespace
  and skipped the push, so `7314e2f` exists only on this workstation; the
  runbook gives the commands for a private `backup` remote (an example; the
  remote is the owner's choice), which the script then pushes.
- `PMR-014` formal-verification-research (P3): the wording half was applied
  by the owner at `e5740de` on 2026-09-06 (pushed to `backup`); the five
  routed pointers remain the owner's per-pointer decision (`keep`, `move`,
  `remove`), listed in the runbook.
- `PMR-015` threat-modeler and analysis-workbook: **closed**, carried at
  `226d367` and `ff12f2f` (both discovery reference sets name the ledger).
- `PMR-016` beryllium-repo: **closed** 2026-09-05 (`PMD-20260905-002`): the
  responsible human, acting as the Beryllium owner, triaged `HET-001`
  ("triaged as accepted", mapped at the human's confirmation to the lifecycle
  status `recorded`; planning inputs only, not authorization of any Beryllium
  work); tracked as `PML-0017` (`routed`).
- `PMR-019` analysis-workbook (P3): the mirror was applied by the maintainer
  at `d003dec` on 2026-09-06 (`HET-001` `recorded`, input state
  `unaccepted`; pushed); open only for the three `HANDOFF.md` sentences that
  still say `new`, refreshed in the maintainer's words (runbook prompt);
  closes when observed.
- `PMR-020` cheri-riscv-notes-repo (P2, raised 2026-09-06): decide how this
  workstation authenticates to `origin`, or record that the remote is not
  reachable from here; the script's fetch failed three times with an
  authentication error; live backup state `unknown` until then.
- `PMR-017` formal-verification-research: **closed**, carried at `8246147`.
- `PMR-018` helium-te-poc: **closed** 2026-09-06; the owner pushed twelve of
  the thirteen local branches with upstreams (the thirteenth was already on
  `origin`) through the human-run script (`--helium-branches`); the `d0cca32`
  lineage is on `origin/helium-te-fv` and `origin/helium-te-h7-approved`.
- Obtain the two responsible-human H0 selections, or wait for the exact
  board/firmware packet; do not infer a normative host or path inventory.
- Preserve every Helium approved, candidate, and preserved ref as a distinct
  branch; never create a linked evaluator worktree or move approved branches.
- Remove or replace the stale agent-recreated former-workspace checkout only
  through an explicit human filesystem action.
- Resolve the CHERI-RISC-V knowledge base's content license before any public
  mirror.
- Add future direct checkouts to the parent `.gitignore`; add approved external
  repositories as tracked symlinks; register both in `../COMPONENTS.md`,
  `components/`, `AGENT-ROSTER.md`, and `scripts/inspect-components.sh`.
- Remote reachability facts retained: `gh` holds one account, `xjamesmorris`,
  a member of the `beryllium-project` organization; the `jamorris_microsoft`
  namespace is an Enterprise Managed User tenant that is unreachable from this
  workstation and is not a backup target. Do not retarget `origin` remotes
  without user direction.

## Provenance

- Migrated from the parent `HANDOFF.md` at parent commit
  `767752792026622bbb06c3fcd29d240b0871a3e9` (last updated 2026-08-29) on
  2026-09-04, restructured for restartability and refreshed with observed
  state. The parent path now holds a redirect stub.
- Consolidation commits: this repository's initial commit
  `02335c56b232ecdbd402d537668b15d775291fa4`; parent consolidation commit
  `e774b4217ccf5100c66e97b3b23a51a62c5e6365` (stubs, slimmed instructions,
  registry refresh, `.gitignore`); this repository's provenance commit
  `627d831da278189bd8248ceb2a425d600add87c1`; parent commit
  `b2e80b260a8669a649cbf65f21e0291c3cda6a17` recording that HEAD in the
  `project-manager/` row of `../COMPONENTS.md`.
- Remote creation and first push, 2026-09-04: after running
  `gh auth refresh -h github.com`, the user was shown the exact four steps
  (create the private repository, add `origin` and push this repository's
  `main`, push the parent to `backup/main`, then record and push the recording
  commits) and selected the confirmation "Yes: create private
  `beryllium-project/project-manager`, push its main, and push the parent to
  `backup/main` (steps 1-4)". Executed:
  `gh repo create beryllium-project/project-manager --private`;
  `git remote add origin` with the HTTPS URL of that private repository
  and `git push -u origin main` (`627d831`) in this repository;
  `git push backup main` in the parent (`7677527..b2e80b2`). The remote heads
  were verified against the local HEADs. The recording commits that follow
  this entry are pushed under the same confirmation. No component repository
  was pushed or modified; no tag was created; nothing is public.
- First coordination turn, 2026-09-04 (after `ccf8007` here and `839a1b5` in
  the parent): observed state at 16:15Z, `PML-0001..PML-0016` routed,
  `PMR-007..PMR-009` raised, `PMD-20260904-001` and `PMD-20260904-002`
  recorded, Helium notes and `records/assurance/helium-te-fv-pathfinder.md`
  reconciled against `../helium-te-poc/HANDOFF.md` at `e65c6a0`. One commit
  in each repository (`2439ce5` here, `393ea6a` in the parent); the
  `project-manager/` HEAD is recorded in the `project-manager/` row of
  `../COMPONENTS.md`. No push was performed in that turn. No component
  repository was modified.
- Push of the first-coordination-turn commits, 2026-09-04: the agent's turn
  report ended with "if you want the two local commits backed up, tell me
  explicitly and I'll run `git push origin main` here and `git push backup
  main` in the parent", and the user replied "yep do that". Executed:
  `git push origin main` in this repository (`ccf8007..2439ce5`) and
  `git push backup main` in the parent (`839a1b5..393ea6a`); both remote
  heads were verified against the local HEADs with `git ls-remote`. The
  recording commit that follows this entry, and the parent commit recording
  its HEAD in `../COMPONENTS.md`, are pushed under the same confirmation and
  verified the same way. No component repository was pushed or modified; no
  remote was added or changed; no tag was created; nothing is public.
  Pushed as `947d959` here and `15dcdf9` in the parent.
- Standing carry authority, 2026-09-04 (after `947d959` here and `15dcdf9`
  in the parent): asked how to proceed with `PMR-007..PMR-011`, the user
  asked "would this be a better job for agency? it's a lot of manual work for
  me". Offered the routes "one session at the parent root", "defer", and
  "change governance so the PM carries requests itself", the user selected
  `governance_change`; asked for the write classes and the components that
  stay fully request-only, the user selected
  `classes=queue_status, source_index, pm_role_wording` and
  `hands_off=helium-te-poc, beryllium-repo`, and added "note that the
  xrv-research request is in-progress already". Recorded as
  `records/decisions/PMD-20260904-003-standing-carry-authority.md` with the
  amended boundary documents listed under "What changed in this update". The
  session that recorded it stayed under the previous boundary and wrote only
  Project Manager-owned files; the grant binds sessions started after this
  update's commit. Committed as `d36b015` here and `b34e468` in the parent.
- `PMR-007` result, 2026-09-04: the user relayed the xrv-research-repo
  owner's report that all nine pointers were recorded as pointer-only
  `arrived` records `REV-20260904-001..009` (none already present, declined,
  or deferred; the Thunderclap CHERI follow-on already in the survey is a
  different work) in commit `7314e2f` on `main`, local only, with
  `pm-queue.md` untouched. Verified read-only with
  `scripts/inspect-components.sh state xrv-research-repo` (clean, `7314e2f`,
  ahead 1) and by reading `../xrv-research-repo/review-log.md` and
  `review-inbox/`. Ledger rows `PML-0001..0006`, `0009`, `0013`, `0016` set
  to `accepted`; `PMR-007` closed; `PMR-013` raised for the owner's push
  decision. The nine queue edits are due and not yet applied.
- Push of the standing-carry-authority commits, 2026-09-04: the agent's
  report ended with "If you want `d36b015`/`b34e468` pushed first, say so
  explicitly", and the user replied "push those first". Executed:
  `git push origin main` in this repository (`947d959..d36b015`) and
  `git push backup main` in the parent (`15dcdf9..b34e468`); both remote
  heads were verified against the local HEADs with `git ls-remote`. The
  recording commit that follows this entry, and the parent commit recording
  its HEAD in `../COMPONENTS.md`, are pushed under the same confirmation and
  verified the same way. No component repository was pushed or modified; no
  remote was added or changed; no tag was created; nothing is public.
- First carry turn, 2026-09-04 (after `c244910` here and `9abc320` in the
  parent; `PMD-20260904-004`): in a new session the user asked "carry, per
  HANDOFF.md 'One recommended next action': analysis-workbook (PMR-011,
  PMR-004 Markdown, nine queue edits — one commit),
  formal-verification-research (PMR-012, PMR-008 — one commit),
  threat-modeler (PMR-004 Markdown)". The restart snapshot at 22:18Z found
  `analysis-workbook/` dirty (10 entries, another session active), so that
  carry was first refused under `PMD-20260904-003` item 4 and no `git -C`
  command was run there. In `../formal-verification-research/` (clean at
  `8b91ebd`, local instructions read) the Project Manager edited `COLLAB.md`,
  `HANDOFF.md`, and `sources/bibliography.md`, reviewed `git -C diff` and
  `diff --check`, and committed `ccb48f63a4ff477b3faf16a725a68759691e754a`
  ("Carry PMR-012 and PMR-008 ...", Copilot co-author trailer). In
  `../threat-modeler/` (clean at `0d5bed3`, local instructions read) it edited
  `RESEARCH-SOURCES.md` and committed
  `4a015785da41ca7645b9050ac61259ea5885ed48` ("Carry PMR-004 ..."). The
  `pm-auditor` pass then located that other sessions had committed and
  pushed `analysis-workbook/` (`efde667`) and `helium-te-poc/` (`f0d96b1`);
  `scripts/inspect-components.sh state analysis-workbook` at 22:45Z reported
  a clean worktree, the local instructions were re-read at `efde667`, and the
  Project Manager edited `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`, and
  `outbox/pm-queue.md`, reviewed the diff, and committed
  `83b97a32a32c562dc58e775ad37c94a5d6cb16e1` ("Carry PMR-011, PMR-004, and
  PML-0001..0007/0009/0010/0012..0016 ..."). All three commits are local; no
  component was pushed; no remote was added or changed; no tag was created;
  nothing is public; `helium-te-poc/` was not touched. The
  `/beryllium-project-management` skill was again not offered by the skill
  loader; the on-disk `SKILL.md` was followed. One commit in this repository
  and one in the parent record the turn; neither is pushed without a further
  confirmation.
- Follow-up 4, 2026-09-05T04:49Z: the user reported the Copilot CLI startup
  message "The following skills failed to load:
  .github/skills/beryllium-project-management/SKILL.md: failed to parse YAML
  frontmatter: mapping values are not allowed in this context at line 2" and
  asked for the skill-loading issue to be fixed. The Project Manager changed
  only `.github/skills/beryllium-project-management/SKILL.md` (front-matter
  `description` reworded without an inner `: `; body unchanged) and
  `tests/validate-agent.sh` (front-matter guard) in this repository, then
  refreshed this handoff and the `project-manager/` row of
  `../COMPONENTS.md`. No component was inspected, read for state, or
  written; no `git -C` command was run; nothing was pushed. One commit here
  and one in the parent record the repair; both are local until a further
  confirmation.
- Second coordination turn, 2026-09-05T04:54Z-05:40Z (after `a1677c1` here
  and `1607db5` in the parent): the user opened a new session with "continue
  per handoff" in fleet mode; the `/beryllium-project-management` skill loaded
  at startup. After the restart snapshot the agent asked the four questions
  the previous handoff had queued in one `ask_user` form; the user answered
  `pmr015=carry_both` ("Carry now in threat-modeler and analysis-workbook
  (class 3, one commit each)"), `het_registration=register_readonly`
  ("Register for read-only tracking in pull-queues.sh + queue/README.md + one
  PML row per HET item; never an edit target (recommended)"),
  `optional_items=helium_assurance_refresh, refs_tooling`, and
  `push_confirmation=true` to the field "Back up this turn's coordination
  commits when done? (explicit push confirmation)", whose description read
  "If yes, after committing I will run exactly `git push origin main` in
  project-manager/ and `git push backup main` in the parent, and nothing
  else; no component is pushed." Three write-confined sub-agents worked only
  inside this repository (transfer-queue tooling and `PMD-20260905-001`; the
  `refs` mode; the Helium assurance refresh) while the orchestrator carried
  the requests itself: `../formal-verification-research/` (clean at
  `ccb48f6`; `.github/copilot-instructions.md`, `COLLAB.md`, and `HANDOFF.md`
  read) `COLLAB.md` one sentence, `git -C diff` and `diff --check` reviewed,
  committed `824614780bd3f900abaa15aa523a3337e4bb3fbe` ("collab: PMR-017
  ...", Copilot co-author trailer); `../threat-modeler/` (clean at
  `4a01578`; local instructions read) `RESEARCH-SOURCES.md` one bullet,
  committed `226d367bde80c09c85fbadd4600222258d56527a` ("docs: PMR-015
  ..."); `../analysis-workbook/` (clean at `83b97a3`; local instructions
  read) `RESEARCH-SOURCES.md` one bullet, committed
  `ff12f2faf611c02faeaa75760306808bf5ed7eb9` ("docs: PMR-015 ..."). Only
  `git -C <component> status`, `diff`, `add <path>`, `commit`, `log -1`, and
  `status --short --branch` were run inside components; the `refs` listings
  came from `scripts/inspect-components.sh`. `helium-te-poc/` and
  `beryllium-repo` were not written. `pm-auditor` pass: see the entry that
  follows. One commit in this repository and one in the parent record the
  turn; their hashes and the push are recorded in the entry that follows.
- `pm-auditor` pass, 2026-09-05T05:28Z (write-disabled; it had only a file
  viewer, so it verified the three carried commits by reading Git metadata as
  files and could not count changed files; the orchestrator confirmed one
  file per commit with `git -C <component> show --stat`): no blocking item.
  Ten stale items, all reconciled here before commit: the parent and
  `project-manager/` backup rows and the `project-manager/` registry row
  (pending Phase 8), the pre-push wording of this handoff (this entry and the
  push entry below), the `PMR-016` note ("pending protocol decision"), the
  analysis-workbook card (`PMR-015` still open, 1 ahead), the Helium card
  ("has not verified the named refs exist"), the assurance record's preamble
  (sub-agent process narration and "not independently verified" cells
  contradicted by its own ref-listing subsection), and two superseded Helium
  and formal-verification-research sentences in the component notes.
  Thirteen minor items: "every ref named" and "eleven local-only branches"
  overstated the check (eleven assurance-relevant refs were checked; thirteen
  local branches have no upstream configured, three of whose tips are on
  remote-tracking branches; fixed in the header, `PMR-018`, the Backups row,
  the blockers table, `../COMPONENTS.md`, and the record, which now
  enumerates the thirteen branches); "plumbing" became "read-only Git
  subcommands"; the `HET-001` pin (`83b97a3`, unchanged at `ff12f2f`);
  `PMR-004` listed in both request sets; section intros and "Full hashes";
  the unattributed "accepted travel-maintenance baseline" phrase in the Helium
  card (now quoted as the component's); the skill's Phase 4 (transfer rows
  added); the `pull-queues.sh` header comment; the `PMD-20260905-001` input
  pin (`a1677c1`). Left as is: the `tests/fixtures/valid-pm/queue/README.md`
  fixture wording (fixture only) and the `PMR-015` component column naming
  only `threat-modeler` with `analysis-workbook` in the note (same pattern as
  `PMR-004`).
- Push of the second-coordination-turn commits, 2026-09-05T05:44Z: under the
  `push_confirmation=true` answer quoted above, executed `git push origin
  main` in this repository (`c244910..7adbb48`; the carry-turn commit
  `36a162a`, the skill repair `a1677c1`, and this turn's
  `7adbb48920fefaab8741a47bcb99a385db2d751a`) and `git push backup main` in
  the parent (`9abc320..c1e485f`; the registry commits `e02cff6`, `1607db5`,
  and this turn's `c1e485fc0480d10e845afc6bdf58449c698d37c6`); both remote
  heads were verified against the local HEADs with `git ls-remote`. The
  recording commit that follows this entry, and the parent commit recording
  its HEAD in `../COMPONENTS.md`, are pushed under the same confirmation and
  verified the same way. No component repository was pushed or modified; no
  remote was added or changed; no tag was created; nothing is public.
  Pushed as `73cb51b` here and `afb4f03` in the parent.
- Third coordination turn, 2026-09-05T07:13Z-07:30Z (after `73cb51b` here
  and `afb4f03` in the parent): the user opened a new session with "what's
  next?"; the `/beryllium-project-management` skill loaded. The restart
  snapshot was exact against `../COMPONENTS.md` and this handoff; the queue
  tooling reported no new row and no edit due; the `refs` listings for
  `helium-te-poc` and `formal-verification-research` matched the 05:15Z
  records; no open request had an observable owner action. Nothing was
  carried, routed, or decided. Only this handoff, `../COMPONENTS.md`, and
  the observation timestamp in `components/helium-te-poc.md` were changed.
  No `git -C <component>` command was run; no component was written;
  nothing was pushed; no remote was added or changed; no tag was created;
  nothing is public. One commit in this repository and one in the parent
  record the turn; both are local until a further confirmation.
- `pm-auditor` pass, 2026-09-05T07:21Z (write-disabled; file reading only,
  no command executed): no blocking item. One stale item, reconciled before
  commit: the blockers-table row "Push of this turn's coordination commits"
  would have read, in this handoff, as a push made in the third turn (now
  "Push of the second-coordination-turn commits" with the four hashes; the
  first-coordination-turn row moved to past tense). Six minor items: "nine
  remote-tracking branches" (eight plus the symbolic `origin/HEAD`; fixed);
  the projected end time (set at commit); the dangling "entry that follows"
  pointer (this entry); the second turn's range "05:50Z" versus its
  Provenance entry's "05:40Z" (the range now says it includes the 05:44Z
  push); "this turn" in the retained 2026-09-04 sections and the two
  observed-state tables (left as is: their paragraph headers name the turn);
  and the Helium card's "observed 2026-09-05T04:54Z" (refreshed to 07:13Z,
  same state). One `unknown`: the auditor could not count changed files per
  carried commit without an execute tool; the second turn's `show --stat`
  confirmation stands. Checks A-F (hashes and counts, section split, request
  statuses versus existing component commits, ledger versus queue files,
  sibling interface documents, wording discipline) passed. Committed as
  `208579d` here and `6f8a0a7` in the parent; neither pushed.
- Follow-up 5, 2026-09-05T07:46Z-08:05Z (after `208579d` here and `6f8a0a7`
  in the parent): the user asked "create a script for me to run which
  carries out the needed operations, i want to automate this as much as
  possible". The agent proposed a human-run `scripts/owner-actions.sh` and
  asked one `ask_user` form; the user answered `steps=review, push_awb,
  push_tm, push_xrv, push_pm, fetch_snapshot` (the defaults),
  `fvr_remote=add_backup` ("Opt-in flag --fvr-backup: gh repo create
  beryllium-project/formal-verification-research --private, add remote
  'backup', push main (origin untouched)"), `helium_branches=optin_list`
  ("Opt-in flag --helium-branches: push all thirteen, but --helium-only
  <name,...> restricts to named branches"), and `mode=prompt` ("Execute with
  a y/N prompt per step; --yes skips prompts; --plan prints commands only").
  The agent wrote the script, four static checks in `scripts/validate-pm.sh`,
  the `tests/validate-agent.sh` hygiene-loop entry, and the boundary wording
  in `AGENT-INTERFACE.md`, `README.md`, `AGENT-ROSTER.md`,
  `.github/copilot-instructions.md`, `.github/agents/project-manager.agent.md`,
  and the skill. **The script was not executed by the agent in any mode**;
  it is validated statically only. One execution-boundary deviation is
  disclosed: the agent ran `bash -n scripts/owner-actions.sh` directly once
  (a syntax check of a file in this repository, the same check
  `validate-pm.sh` now performs; no script content ran). No component was
  read for state or written; no `git -C <component>` command was run;
  nothing was pushed; no remote was added or changed; no tag was created;
  nothing is public. One commit here and one in the parent record the
  follow-up; both are local. These answers are the scope of the script, not
  a push confirmation: the pushes happen when the human runs it.
- Fourth coordination turn, 2026-09-05T19:10Z-22:20Z (after `088046c` here
  and `6f452b7` in the parent): the user opened a new session with "HET-001
  is triaged as accepted"; the `/beryllium-project-management` skill loaded.
  The restart snapshot was exact against `../COMPONENTS.md` and this
  handoff. Because the transfer queue's lifecycle has no `accepted` status
  and `PMD-20260905-001` never uses `accepted` for a `HET` row, the agent
  asked one `ask_user` form; the user answered `lifecycle_status=recorded`
  ("recorded (candidate input recorded for Beryllium-side planning; not
  acceptance of work) - recommended"), `owner_record=pm_record` ("This
  statement to the Project Manager is the record (PMR-016 closure + decision
  record); no Beryllium-owned artifact"), `actor_and_date=` "The responsible
  human, acting as the Beryllium owner, on 2026-09-05", `scope=` "All eight
  candidate lessons in HET-001 are recorded as planning inputs for a possible
  future Beryllium security-significant seam. None is adopted yet as an
  owner-side entry criterion, design constraint, evidence requirement, or
  exit criterion. No Beryllium authorization changes: R8-H0 profile freeze
  only; H1-H4 unauthorized; K3 hardware NOT RUN; no implementation
  authorization, target acceptance, review approval, or sign-off is
  implied.", and `ledger_handling=keep_routed` ("Keep PML-0017 at `routed`
  (terminal per PMD-20260905-001) and append the owner disposition to its
  note - recommended"). Recorded as
  `records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`;
  `PMR-016` closed; `PMR-019` raised; `PML-0017` note appended. Mid-turn the
  user asked "what do you recommend for the outstanding human decisions?";
  the agent answered in the conversation and asked a second form; the user
  answered `finish_turn=true` with no decision recorded. Reading the
  ignored `scratch/owner-actions/` logs (written by the human's runs of
  `scripts/owner-actions.sh` at 19:05:11Z with `--plan` and 19:05:34Z in
  execute mode, minutes before this session) and the remote-tracking refs
  then established the pushes recorded in "What changed in this update";
  the agent did not run the script. Only `git` against this repository and
  the parent, `scripts/inspect-components.sh` (`status`, `components`,
  `symlinks`, `registry-check`, `refs`), `scripts/pull-queues.sh`,
  `scripts/new-record.sh`, and a read-only `grep -rIl` text search of
  `../beryllium-repo/` (file reading only) were run; no `git -C <component>`
  command was run;
  no component was written; no remote was added or changed; no tag was
  created; nothing is public. One commit in this repository and one in the
  parent record the turn; they and the recording commits that follow are
  pushed under the confirmation quoted two entries below.
- `pm-auditor` pass, 2026-09-05T22:20Z-22:29Z (write-disabled; file reading
  and searching only; it did not open `scratch/owner-actions/`): no blocking
  item. Five stale items, all reconciled before commit: the position table's
  "six carried commits ... all local" (four are pushed); the
  `project-manager/` registry row's "both local" description (refreshed with
  the new HEAD in Phase 8); the analysis-workbook card's push item (done);
  observation timestamps missing 19:10Z and the 22:00Z `refs` re-run in the
  position table, the Helium registry rows, and the Helium card; and the
  analysis-workbook card and `AGENT-ROSTER.md` omitting
  `scripts/validate-helium-transfer-queue.sh`, which the component's
  `AGENT-INTERFACE.md` at `ff12f2f` requires before a transfer-queue change
  (added, and cited in `PMR-019` and the record's follow-up). Ten minor
  items, all applied: the record now names the tension between the queue's
  `recorded` definition ("in its own artifact") and its triage request's
  "Project Manager-owned artifact" wording and leaves the choice to the
  maintainer; this auditor entry; "the only unbacked-up component"
  (xrv-research-repo also has no reachable remote); "unregenerable" hedged;
  recommendation 6 no longer ties the H0 selections to an operational board;
  the `PMR-013` closure condition; "carries" became "requests" for
  `PMR-019`; the transfer-queue bullet's "Each turn ... shows a new row"
  became conditional; the threat modeler note's superseded 2026-09-04
  observation is date-labeled; the header pointer matches the retitled
  heading. Its `unknown` items: the tool behind the `../beryllium-repo/` text
  search (now named: `grep -rIl`, file reading only, run from
  `project-manager/`); the transfer-queue content being identical between
  `efde667` and `ff12f2f`, the 22:00Z `refs` results, and the owner-actions
  log contents, which it could not verify without execution (the
  orchestrator's own read-only runs stand); and the verbatim fidelity of the
  quoted `ask_user` answers (quoted from the form results). The mirror rows
  in the record were checked against the transfer queue's column shapes,
  locator pattern, and transition table with no discrepancy.
- Push confirmation, 2026-09-05T22:16Z: while the auditor ran, the user
  wrote "push when done". Under that confirmation, after this turn's commit
  here and the parent registry commit, the agent runs exactly `git push
  origin main` in this repository and `git push backup main` in the parent,
  verifies both remote heads against the local HEADs with `git ls-remote`,
  and records the result in a recording commit in each repository, pushed
  under the same confirmation and verified the same way. No component is
  pushed; no remote is added or changed; no tag is created; nothing is
  public. Executed 2026-09-05T22:38Z: `git push origin main` here
  (`088046c..94888ea`) and `git push backup main` in the parent
  (`6f452b7..60a11a2`); both remote heads were verified against the local
  HEADs with `git ls-remote`. The recording commit that follows this entry,
  and the parent commit recording its HEAD in `../COMPONENTS.md`, are pushed
  under the same confirmation and verified the same way.
- Fifth coordination turn, 2026-09-06T08:42Z-09:58Z (after `366e0ad` here and
  `98fc0f5` in the parent): the user opened with "I ran the two scripts
  above, see log"; the `/beryllium-project-management` skill loaded. The
  restart snapshot was exact; the `scratch/owner-actions/` logs of 08:39:07Z
  (`--plan`) and 08:39:44Z (execute, `--fvr-backup --helium-branches`) and
  the `refs` listings established the `PMR-001` and `PMR-018` closures, the
  repeated xrv skip (`PMR-013`), and the repeated cheri-riscv-notes-repo
  authentication failure (`PMR-020`). The user then wrote: "provide clear,
  specific instructions for [the script's "Still yours" list] ... I need this
  more automated" and "also, add a priority field to each item requiring
  attention / todo etc., so we can triage and act on the higest priority
  items quickly, then work on other high priority tasks generally, before
  tackling low-priority issues". One `ask_user` form: the user chose
  `edits_scope=apply_excl_beryllium` ("Add opt-in --apply-edits for PMR-019
  (workbook mirror), PMR-002 (osr-claude), PMR-014 wording (FVR); PMR-003 in
  beryllium-repo stays a pasted command - recommended"), `files_step=true`,
  and `pmr014_pointers=later` ("Decide per pointer later; the runbook lists
  them"). Recorded as
  `records/decisions/PMD-20260906-001-owner-edits-and-request-priorities.md`.
  Read-only reads inside components for the exact text of the recorded edits:
  `../analysis-workbook/outbox/helium-transfer-queue.md`, `HANDOFF.md`,
  `AGENT-INTERFACE.md`, `scripts/readonly-inspect.sh`, and the usage lines of
  `scripts/validate-helium-transfer-queue.sh`; `../osr-claude/HANDOFF.md` and
  `tools/md-to-html.sh`; `../formal-verification-research/.github/copilot-instructions.md`,
  `README.md`, `COLLAB.md`, `sources/bibliography.md`;
  `../beryllium-repo/planning/HANDOFF.md`; `../cheri-riscv-notes-repo/meta/handoff.md`,
  `automation/schema.md`; `../threat-modeler/scripts/readonly-inspect.sh`.
  **One execution-boundary deviation is disclosed:** to check that the
  recorded `PMR-019` edit satisfies the workbook's own rules, the agent ran
  `../analysis-workbook/scripts/validate-helium-transfer-queue.sh --baseline
  <current file> <temporary copy>` once, against a temporary copy in a scratch
  directory; the component was not modified, but running a component script
  is outside the execution boundary and belongs to the human-run step, which
  now performs exactly that validation. The two text-replacement functions
  were otherwise exercised by copying them into a throwaway shell library,
  sourcing it in a scratch directory, and running them against temporary
  copies of the component files; the scratch directory was deleted and
  `scripts/owner-actions.sh` itself was not run in any mode. No `git -C <component>` command was
  run; no component was written; nothing was pushed; no remote was added or
  changed; no tag was created; nothing is public. The two logs contain a
  masked token line from `gh auth status` and several repository URLs
  (`gh` output, the remote addition, the push and fetch lines); none is
  copied into any Project Manager artifact. At 09:20Z the parent worktree
  showed changes this session had not made (`SOT.md`, `README.md`,
  `.github/copilot-instructions.md`, untracked `formal-verification/README.md`,
  all timed 09:52 local; a second Copilot session-state directory was active
  at 09:56 local), plus one hunk in this repository's
  `.github/copilot-instructions.md`. Asked "How should this turn treat them?",
  the user chose `include` ("Include them in this turn's parent commit
  (recorded as another session's change, adopted by you now); the registry
  and handoff list formal-verification/README.md as PM-owned"). One commit in
  this repository and one in the parent record the turn; both are local until
  the human's next script run or an explicit confirmation.
- `pm-auditor` pass, 2026-09-06T09:00Z-09:33Z (write-disabled; file viewer
  only): no blocking item. Seven stale items, all reconciled before commit:
  the position table's "`ccb48f6` and `8246147` stay local" (now backed up);
  the undated formal-verification-research note (now "Observed 2026-09-04",
  superseded below); the component-notes intro and the registry's backup
  table heading and Helium and Beryllium rows lacking the 2026-09-06
  observation; the formal-verification-research card's `refs` bullet (08:42Z
  re-run added); and the analysis-workbook, osr-claude, and beryllium-repo
  cards lacking the priorities and runbook paths. Fifteen minor items, all
  applied: a real defect in `scripts/owner-actions.sh` `apply_one_pmr`, where
  the second loop's `read` overwrote `comp` so prompts and the summary would
  have named the wrong component for `PMR-019` and `PMR-002` (writes used the
  correct directory); row-local variables now; `--only push_fvr` no longer
  demands `--fvr-backup` once the remote exists; the `PMR-014` README edit
  had missed the second "Workspace relationship" sentence (`PMR-014-3`
  added) and its agent-instruction wording was broader than `COLLAB.md`
  class 3 (aligned); the `PMR-019` rows were pre-dated 2026-09-05 and
  described as identical to the record's rows (now dated on application via
  `@DATE@` and described as based on the record, with the differences named);
  "refs frozen" restated as the component's statement; the xrv remote named
  as an example, not the action; the turn window set once at commit; the
  blockers row's dangling "hashes in `../COMPONENTS.md`" for the parent half;
  "one repository URL" (several); how the helper functions were exercised
  (copied into a throwaway library, sourced in a scratch directory; the script
  itself never run); `PMR-014` closes whole, so the next action notes the
  wording half as done; `AGENT-INTERFACE.md` now names the `files_search`
  link removal as the one other file change and lists
  `formal-verification/README.md` in its diagram; the runbook's `PMR-003`
  Python reads and writes UTF-8 explicitly; the auditor's own check list
  gained the priority column and runbook. Its `unknown` items: trailing
  newlines (checked read-only: each of the four target files ends with exactly
  one, so `apply_block` adds no hunk); whether the two components'
  `tests/validate-agent.sh` pin the registered lists (the runbook already
  tells the owner to run them); whether `102f2b0` is the latest H0 commit
  (`PMR-003` names it as the committed candidate the request has always
  named, not as the latest); the validation results (all passing at commit);
  and the parent `.gitignore` (checked: `/files` is ignored, so the link
  removal cannot dirty the parent).
- Sixth coordination turn, 2026-09-06T10:30Z-11:05Z (after `dbe181a` here and
  `1aa13c3` in the parent): the user opened with "done, see log"; the
  `/beryllium-project-management` skill loaded. The restart snapshot showed
  three moved components, matching the human's 10:29Z run of
  `scripts/owner-actions.sh --apply-edits --files-search` (log
  `scratch/owner-actions/owner-actions-20260906T102908Z.log`, local, ignored):
  the maintainer's `d003dec` (analysis-workbook, `PMR-019` mirror), the
  owner's `e275544` (osr-claude, `PMR-002`), and the owner's `e5740de`
  (formal-verification-research, `PMR-014` wording), each committed on the
  human's `y` after the diff and pushed and `ls-remote`-verified by the
  script, with this repository `366e0ad..dbe181a` and the parent
  `98fc0f5..1aa13c3`; xrv-research-repo skipped a third time; the
  cheri-riscv-notes-repo fetch failed a third time; `files_search` found
  none of the seven artifact names under the home directory and removed the
  broken parent `files` link on the human's `y`. The agent verified each
  commit read-only with `scripts/inspect-components.sh refs <component>
  <hash>` and by reading the changed files; it did not run the script and
  ran no `git -C <component>` command. Recorded: `PMR-002` closed; `PMR-019`
  and `PMR-014` updated and kept open at P3 for their remaining halves;
  `PMR-013` and `PMR-020` updated; `PML-0017` note appended (PM status
  `routed` unchanged); `records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`
  written from the log and the human's statement (the `--files-search`
  prompt the human answered `y` said the next turn records the loss); the
  sixteen applied edit files (eight edit names) removed from `outbox/owner-edits/` and the script's
  `edits`/`edit_pmrs` tables emptied with empty-safe loops (`bash -n` and the
  static guards pass; the script was not run); the runbook, cards, this
  handoff, and `../COMPONENTS.md` refreshed. Two read-only commands outside
  the execution list are disclosed: `ls ../files` (a listing at the parent
  root, not inside a component) to confirm the link's absence, and `bash -n
  scripts/owner-actions.sh` run directly once after editing the script (and
  twice in the fifth turn, not disclosed there): a syntax check of a file in
  this repository that executes no script content and that
  `scripts/validate-pm.sh` performs as well. The log contains a masked token
  line from `gh auth status` and several repository URLs; none is copied
  into any Project Manager artifact. No component was written; nothing was
  pushed; no remote was added or changed; no tag was created; nothing is
  public. One commit in this repository and one in the parent record the
  turn; both are local until the human's next script run or an explicit
  confirmation.
- `pm-auditor` pass, 2026-09-06T10:52Z-11:05Z (write-disabled; file reading
  only): no blocking item. Eight stale items, all reconciled before commit:
  the registry's parent and `project-manager/` backup rows still calling the
  fifth-turn commits local (pushed 10:29Z) and its closing paragraph lacking
  the 2026-09-06 observations; the runbook's and the CHERI/XRV note's "two
  runs" (three); the pending-coordination transfer-queue bullet (mirror now
  observed, `PMR-019` open for the prose) and `PMR-012` bullet (`PMR-014`
  wording done); the position table's "third, fourth, or fifth turn"
  (sixth added). Twelve minor items, all applied: "nine applied files"
  (sixteen files, eight edit names); 10:31Z (10:30Z); present-tense mentions
  of the removed edit files (now labelled removed, in the note and the three
  request notes); the 2026-09-04 formal-verification-research sentence
  "`PMR-001` stays open" (labelled closed); the "Parent remotes" line
  (`1aa13c3` added); Helium and Beryllium observation lists (10:30Z added);
  `PMR-014` "request-only" versus the runbook's class-2 carry offer (now
  stated consistently: the dispositions are the owner's, a chosen `remove` is
  carriable as class 2 on that instruction); the P1 push of this turn's
  commits now named in the runbook's quick path; `PMR-019`'s remaining scope
  widened from "three sentences" to the `HANDOFF.md` prose including its
  "Blockers" and "Exact next action"; the script's summary line about
  non-request items and its edit-table comment (a new edit also needs a
  commit-message case and any precondition); the skill's Phase 5 removal rule
  (sets are removed when the owner commit is observed, whether or not the
  request closes); `PMD-20260906-002`'s `ls` citation (now disclosed above).
  Its `unknown` items: the validators' results (all passing at commit); the
  staging of the sixteen removals (staged, `D` in `git status`); how `bash
  -n` was run (disclosed above); the exact `refs` timestamp (10:30Z).
- Seventh coordination turn, 2026-09-06 (recovery session, 18:13Z-19:30Z):
  the `security-reviewer` component was authored with GitHub Copilot CLI from
  the recovered plan of the crashed session and committed inside
  `../security-reviewer/` as `9ca5071` (subject "Create the security-reviewer
  component from the Helium review contract", Copilot co-author trailer);
  registered by `PMD-20260906-003`; `PMR-021` and `PMR-022` raised. No push,
  remote, repository creation, or tag: no confirmation was requested or
  given; the human-run `scripts/owner-actions.sh --sr-backup` is the recorded
  way to do it. `helium-te-poc/`, `threat-modeler/`, and every other existing
  component were read only.
