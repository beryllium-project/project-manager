# Beryllium Project Manager handoff

**Last updated:** 2026-09-05
**Update scope:** second coordination turn (2026-09-05T04:54Z-05:50Z), run
in fleet mode from the handoff's "One recommended next action". The
`/beryllium-project-management` skill **loaded for the first time** (the
follow-up 4 repair worked). Restart snapshot exact: every component clean,
every HEAD matching `../COMPONENTS.md`, `pull-queues.sh check` passing. The
responsible human answered the four queued questions in one `ask_user` form
(quoted in "Provenance"): carry `PMR-015` in both components; register the
Helium transfer queue for read-only tracking; also record the `f0d96b1`
Helium statements and add a read-only ref-listing mode; and push this turn's
coordination commits. **Three carried commits** under `PMD-20260904-003`
class 3, each after a same-turn clean-worktree check and local-instruction
read: `8246147` in `../formal-verification-research/` (`PMR-017`), `226d367`
in `../threat-modeler/` (`PMR-015`), and `ff12f2f` in `../analysis-workbook/`
(`PMR-015`); `PMR-015` and `PMR-017` closed. **`PMD-20260905-001`**: the
transfer queue `../analysis-workbook/outbox/helium-transfer-queue.md` is a
third, read-only source in `scripts/pull-queues.sh` and `queue/README.md`
(`analysis-workbook-transfer`, `HET-NNN`; never an edit target; `accepted`
never used); `PML-0017` records `HET-001` as `routed` (`PMR-016`). New
`scripts/inspect-components.sh refs <component> [<ref>...]` mode (read-only
Git subcommands only); its first run confirmed that the eleven
assurance-relevant refs named in `../helium-te-poc/HANDOFF.md` exist locally,
that `d0cca32` is on no remote-tracking branch and thirteen local branches
have no upstream configured (`PMR-018`), and that both `collab/*` branches in
`../formal-verification-research/` are merged. `records/assurance/helium-te-fv-pathfinder.md`
gained the `f0d96b1` statements and the ref listing. The previous turn
(2026-09-04, follow-ups 1-4) is summarized under "Previous update".
**Workspace root:** `/home/jmorris/src/l1/src/beryllium-project`
**This repository:** `project-manager/`, branch `main`; initial commit
`02335c56b232ecdbd402d537668b15d775291fa4`; `origin` -> private
`beryllium-project/project-manager`; pushed through `c244910` on 2026-09-04
and, under the confirmation quoted in "Provenance", through this turn's
commits on 2026-09-05 (the carry-turn commit `36a162a`, the skill repair
`a1677c1`, this turn's `7adbb48`, and its push record, whose hash is the
`project-manager/` row of `../COMPONENTS.md`)
**Parent coordination repository:** `main`; consolidation commits
`e774b4217ccf5100c66e97b3b23a51a62c5e6365`,
`b2e80b260a8669a649cbf65f21e0291c3cda6a17`, and `839a1b5`; first-coordination-turn
registry commit `393ea6a075ee636db0fe51e47ec237612f001e4a`, its recording
follow-up `15dcdf9`, the standing-carry-authority registry commit
`b34e468b94b2ecbd02d5aa25e9b5e2dfb8fda708`, and its recording follow-up
`9abc320` pushed to `backup/main` on 2026-09-04; the carry-turn registry
commit `e02cff6`, the skill-repair registry commit `1607db5`, this turn's
registry commit `c1e485f`, and its recording follow-up pushed on 2026-09-05
under the confirmation quoted in "Provenance"
**Parent remotes:** `backup` -> private `beryllium-project/beryllium-project`
(pushed through `9abc320` on 2026-09-04 and through this turn's commits on
2026-09-05, both under confirmations quoted in "Provenance"); `origin` ->
unreachable `jamorris_microsoft/beryllium-project` (retained, not retargeted)

## Fast resume: read this first

### Overall position

| Area | Current state |
| --- | --- |
| Project Manager function | Consolidated into `project-manager/`: agent `project-manager`, auditor `pm-auditor`, skill (loads since `a1677c1`), knowledge cards, roster, records, ledger, requests, scripts, and tests. The parent root is a thin shell with redirect stubs. **Standing carry authority granted 2026-09-04** (`records/decisions/PMD-20260904-003-standing-carry-authority.md`): the agent may itself carry three classes of recorded request inside carry-eligible components (queue status edits; metadata-only source-index entries; Project Manager-role wording), committing there; never `helium-te-poc/` or `beryllium-repo`. Exercised twice: 2026-09-04 (`PMD-20260904-004`: `ccb48f6`, `4a01578`, `83b97a3`) and **2026-09-05 (this turn: `8246147` in `../formal-verification-research/` for `PMR-017`; `226d367` in `../threat-modeler/` and `ff12f2f` in `../analysis-workbook/` for `PMR-015`)**. Six carried commits in total, all local to this workstation until their owners push |
| Accepted Beryllium runtime sequence | R0 through exact R7 are responsible-human accepted |
| Current authorized Beryllium work | Non-privileged R8-H0 profile freeze only; H0 remains **BLOCKED / NOT READY / NOT ACCEPTED** with all 81 acceptance rows unresolved |
| Privileged and hardware work | H1-H4 unauthorized; Beryllium K3 execution and hardware evidence remain `NOT RUN` |
| Implementation repository | `beryllium-repo` clean on `beryllium/single-hart-runtime-r0` at `65f6d89`, synchronized with its private origin |
| Helium assurance line | `../helium-te-poc/` clean and synchronized on `helium-te-travel-fedora44` at `f0d96b1` (observed 2026-09-05T04:54Z, unchanged since 2026-09-04T22:45Z). Its `HANDOFF.md` at that commit **states** that `FV-FIN-001` is resolved, "the responsible human selected Tier 8 as the endpoint for Helium formal-verification experimentation" (decision commit `6d3cd14`), the approved Tier 8 refs are unchanged and must remain frozen, the travel gate remains blocked, and the PoC "is not formally verified and has not been validated on hardware". Refs it names: travel base `3dc3aee`; Tier 8 H6 candidate `ed15451` with H7 gate `85a6e55`; Tier 7 source `7ca97a9` with H7 gate `342e04a`; Tier 6 H7 gate `c594b7f`; Tier 5 H7 gate `111cff2`; earlier H7 lineage `d0cca32`; preserved ref `d87080a`. **These are the component's statements**, now tabulated for `f0d96b1` in `records/assurance/helium-te-fv-pathfinder.md`. New this turn: the read-only `scripts/inspect-components.sh refs helium-te-poc ...` listing shows every named ref **exists** locally and, as of the last fetch, all but `d0cca32` are reachable from a remote-tracking branch (`PMR-018`). Existence is not gate review: the Project Manager has reviewed no Tier 7/8 gate content or the endpoint decision and infers no approval (`PMD-20260904-002`, `PMD-20260904-004` item 9) |
| Component queues | 16 analysis-workbook rows `PMQ-001..016`: **fourteen `accepted`** in the ledger and in the queue file (nine recorded by the xrv-research-repo owner at `7314e2f`; five by the Project Manager as metadata-only pointers at `../formal-verification-research` `ccb48f6`; the class-1 edits applied at `../analysis-workbook` `83b97a3`); two (`PML-0008`, `0011`; `PMR-009`, cheri-riscv-notes-repo) stay `routed`/`new` and request-only. threat-modeler queue empty. **Transfer queue registered this turn (`PMD-20260905-001`)**: `../analysis-workbook/outbox/helium-transfer-queue.md` is the third source `analysis-workbook-transfer` in `scripts/pull-queues.sh` and `queue/README.md`, tracked read-only (outside class 1; `edits` prints nothing for it; `accepted` never used; the workbook maintainer mirrors its lifecycle); `PML-0017` records `HET-001` as `routed` to the Beryllium owner (`PMR-016`, open). `pull-queues.sh check`: 17 source rows, 17 ledger rows, ok; `edits`: none due. **`PMR-015` carried**: both discovery reference sets now name `project-manager/queue/LEDGER.md` (`226d367`, `ff12f2f`) |
| Retained PM session artifacts | **Lost from this workstation**: the ignored parent `files` link no longer resolves and its listed artifacts were not found under the home directory. Human decision required |
| Backups | Parent `main` and this repository's `main` pushed to `backup/main` and `origin/main` on 2026-09-05 (`9abc320..c1e485f`, `c244910..7adbb48`, plus the recording commits) under the confirmation quoted in "Provenance". provenance-review, beryllium-repo, cheri-riscv-notes-repo, helium-te-poc (`f0d96b1`), and osr-claude (personal account) synchronized with their remotes; **analysis-workbook is 2 commits ahead** (carried `83b97a3`, `ff12f2f`); **xrv-research-repo is 1 commit ahead** (`7314e2f`, `PMR-013`; backup state `unknown`); **threat-modeler is 4 commits ahead** (the owner's two plus carried `4a01578`, `226d367`; `PMR-005`); **formal-verification-research has no reachable remote and is 2 commits ahead** of its stale ref (carried `ccb48f6`, `8246147`; `PMR-001`); in Helium, thirteen local branches have no upstream configured and the `d0cca32` lineage is reachable from no remote-tracking branch as of the last fetch (`PMR-018`) |
| Publication | Nothing public. Push, tag, publication, release, and public migration remain separately controlled human actions |

The repositories are not broken. The runtime project is deliberately stopped
at the H0 input-and-selection gate. Do not start H1, Linux, multicore, device,
DMA, service, policy, or successor implementation to work around that gate.

### What changed in this update

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

Five owner actions are yours; the agent does none of them:

1. **formal-verification-research owner:** review
   `git -C ../formal-verification-research show ccb48f6` and `show 8246147`;
   act on `PMR-014` (align `.github/copilot-instructions.md` and `README.md`;
   keep, move, or remove the five routed pointers); decide a reachable backup
   remote (`PMR-001`). Until then both carried commits exist only on this
   workstation.
2. **Beryllium owner:** `PMR-016`: triage `HET-001` in
   `../analysis-workbook/outbox/helium-transfer-queue.md` under Beryllium's
   own planning controls and record the disposition; this is planning input,
   not authorization of any Beryllium work beyond the H0 profile freeze.
3. **threat-modeler and analysis-workbook owners:** review
   `git -C ../threat-modeler show 4a01578 226d367` and
   `git -C ../analysis-workbook show 83b97a3 ff12f2f`; decide the pushes
   (`PMR-005` for threat-modeler's 4 local commits; the workbook is 2 ahead).
4. **helium-te-poc owner:** `PMR-018`: decide whether the thirteen local
   branches without an upstream listed there (including the `d0cca32`
   lineage) should be pushed to the component's private remote (`bash
   ./scripts/inspect-components.sh refs helium-te-poc` from this directory
   shows the current listing read-only).
5. **cheri-riscv-notes-repo owner:** `PMR-009` (two pointers through the
   reference database; gate D4).

Then start a new Project Manager session and ask it to run a plain
coordination turn: re-observe, pull queues (a new `HET-NNN` row now appears in
`pull-queues.sh list`), close any request whose owner action is observed, and
record the lost-artifact decision if you have made one. No carry is queued:
every open request is now request-only (`PMR-001`, `002`, `003`, `005`,
`009`, `013`, `014`, `016`, `018`) or owner-only (`PMR-004` scripts).

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh status
copilot                                  # then: /agent project-manager
```

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

| Item | Owner | State |
| --- | --- | --- |
| Two H0 input selections (normative Fedora 44 H0 static OCI `fcf6c595...1bd1f5`; proposed H1/H2 path inventory `2c5e9396...c6660`) | Responsible human | Open; not inferred. Would authorize re-checking a still-blocked H0 candidate, not accept H0 |
| H0 acceptance, H1-H4 authorization, K3 execution | Responsible human | Open; `NOT RUN` |
| Helium Tier 7/8 gate content | Component owner and the human who made the gate commits | Not a Project Manager gate. The component's statements at `e65c6a0` and `f0d96b1` are recorded without review (`PMD-20260904-002`; `records/assurance/helium-te-fv-pathfinder.md`); the read-only `refs` listing of 2026-09-05 confirms only that the named refs exist locally, not what any gate contains |
| Index pointers for the routed rows | `PMR-007` completed by the xrv-research-repo owner (`7314e2f`, `REV-20260904-001..009`); `PMR-008` carried by the Project Manager under `PMD-20260904-003` class 2 at `../formal-verification-research` `ccb48f6` (metadata pointers on the owner's delegated authority, not corpus admission; owner triage `PMR-014`); `PMR-009` stays with the cheri-riscv-notes-repo owner (generated exports behind gate D4) | Fourteen rows `accepted` in the ledger and in the queue file (`83b97a3`); two wait for the owner |
| Wording reconciliations | `PMR-012` carried at `ccb48f6`; `PMR-011` and the Markdown parts of `PMR-004` carried at `83b97a3` and `4a01578`; `PMR-017` carried at `8246147`; `PMR-015` carried at `226d367` and `ff12f2f`; the formal-verification-research agent-instruction bullet and `README.md` sentence are the owner's (`PMR-014`) | Done apart from `PMR-014` (owner) and the two owner-only scripts of `PMR-004` |
| `HET-001` Helium-to-Beryllium method-transfer input (`../analysis-workbook/outbox/helium-transfer-queue.md`, observed `new`/`unaccepted` at `83b97a3` and unchanged at `ff12f2f`) | Beryllium owner (`PMR-016`); the workbook maintainer mirrors the lifecycle | Open; tracked read-only as `PML-0017` (`PMD-20260905-001`); planning input only, not authorization of any Beryllium work |
| Standing carry authority | Responsible human | Granted 2026-09-04 (`PMD-20260904-003`; user choices quoted in "Provenance"); committed as `d36b015` and pushed; binds sessions started after that commit |
| Decision on the lost retained PM artifacts (see "Retained PM session artifacts") | Responsible human | Open |
| Push of the first-coordination-turn and standing-carry-authority commits (`project-manager/` and parent) | Responsible human confirmation | Closed 2026-09-04 by the two user confirmations quoted in "Provenance"; both `main` branches are synchronized with their private remotes |
| Private remote for `project-manager/` | Responsible human confirmation | Closed 2026-09-04 by the user confirmation quoted in "Provenance"; `origin` -> private `beryllium-project/project-manager` |
| xrv-research-repo push of `7314e2f` | xrv-research-repo owner | Open; `PMR-013` |
| threat-modeler push of 4 local commits (`026e6c9`, `0d5bed3`, carried `4a01578` and `226d367`) | threat-modeler owner | Open; `PMR-005` |
| analysis-workbook push of the carried `83b97a3` and `ff12f2f` | analysis-workbook owner | Open; 2 ahead of private `origin/main` |
| formal-verification-research backup, now including the carried `ccb48f6` and `8246147` | Owner | Open; no reachable remote (`PMR-001`) |
| helium-te-poc backup of the thirteen local branches without an upstream, including the `d0cca32` lineage | helium-te-poc owner | Open; `PMR-018` (read-only observation as of the last fetch; not a gate) |
| Push of this turn's coordination commits (`project-manager/` and parent) | Responsible human confirmation | Closed 2026-09-05 by the confirmation quoted in "Provenance"; both `main` branches pushed |

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
`HANDOFF.md` at `7677527`) from what was observed on 2026-09-04 and
2026-09-05. Conventions,
commands, and boundaries are in `components/<component>.md`.

### Helium Type Enforcement PoC

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
`origin/helium-te-fv-tier8-h7-approved`. `PMR-018` asks the owner to decide
the backup of the local-only lineage. Existence is not gate review and not
approval. The component's handoff at `f0d96b1` asks nothing of the Project
Manager; its stated next actions are the responsible human's (push or
publish the frozen H7 branch manually; decide which work may proceed from the
travel-maintenance baseline).

Incident provenance retained: at 2026-08-11 23:16:30 PDT a subagent ran
`git init` and fetched into the former workspace path under a "Recover
assigned checkout" action. That recovery was incorrect; `SOT.md` rule 3 forbids
it.

### Formal-verification research

Last reviewed: `main` at `eaa497b` with both Helium FV consumption logs
integrated (`26f3a54`, merge `eaa497b`). Observed now: `main` at `8b91ebd`
("define sub-project collaboration roles"), clean. The only remote is the
unreachable `jamorris_microsoft` namespace, so the component has no working
off-machine backup. The coordination discrepancy retained from the last review
(owner-status table and handoff describing only the first integration) is
observed resolved at `8b91ebd`: `COLLAB.md` "Owner status" names latest
integration `eaa497b`, two guest integrations, latest validated destination
`ff4a8a8`, and no unmerged `collab/*` branch on 2026-08-19, and `HANDOFF.md`
names both integrated logs (`6f5f670`, `ff4a8a8`). `PMR-001` stays open for
the backup decision only.

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

### OS security research archive

Observed unchanged at `f2edd17`, clean, synchronized with its personal-account
SSH remote. `sources/restricted-microsoft/` remains quarantined. Retained
discrepancy: stale HTTPS-remote and pending-`mktemp` statements in its handoff
(`PMR-002`).

### Beryllium implementation repository

Observed unchanged at `65f6d89`, clean, synchronized. Accepted through R7;
commit `102f2b0` holds the authorized non-privileged R8-H0 profile-freeze
candidate; committed content is not acceptance. All 81 H0 acceptance rows
remain unresolved; no normative host/path input has been selected; no K3
execution occurred. Retained discrepancy: `planning/HANDOFF.md` names a former
workstation path and calls H0 uncommitted (`PMR-003`).

The disposable H0 scaffold (prospective tree `44706e5`) and exact derivative
OCI were validated on 2026-08-17 and recorded as uncommitted decision support.
Their artifacts were retained only under the now-lost `files` link; see
"Retained PM session artifacts".

### CHERI-RISC-V knowledge base and CHERI hypervisor research

The knowledge base is observed unchanged at `6553092`, clean, synchronized;
its content license remains unresolved before any public mirror. The XRV
repository moved from `ca41490` to `7314e2f` (clean, 1 ahead of
`origin/main`) on 2026-09-04 when its owner carried `PMR-007`: the nine
routed pointers are recorded as pointer-only `arrived` records
`REV-20260904-001..009` in `review-log.md` with matching `review-inbox/`
files, own-words summaries and no copied text; the owner reported none as
already present (the Thunderclap CHERI follow-on, HASP 2020, already in the
survey is a different work). Verified read-only by the Project Manager; the
result was relayed by the user. Pushing `7314e2f` is the owner's decision
(`PMR-013`). The XRV review `REV-20260817-001` (Supervisor Domain Isolation /
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
the write; the diff was one bullet. The component is now 2 commits ahead of
its private `origin/main`; pushing both carried commits is the owner's
decision.

### Threat modeler

Last reviewed at `affe17b` with no package. Observed now at `0d5bed3`, clean,
**2 commits ahead** of `origin/main`: packages
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
write and the diff was one bullet. The component is now **4 commits ahead**
of `origin/main` (`PMR-005`).

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
was left in place as evidence. The human decides whether a copy exists on
another machine, whether the artifacts can be regenerated from the canonical
Beryllium repository's checked launchers, or whether to record the loss and
remove the link. `project-manager/.gitignore` already ignores a future `files`
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

- **No carry is queued.** `PMR-015` (`226d367`, `ff12f2f`) and `PMR-017`
  (`8246147`) were carried on 2026-09-05; `PMR-012`, `PMR-008`, `PMR-011`,
  `PMR-006`, and the Markdown parts of `PMR-004` on 2026-09-04. `PMR-009` is
  request-only (cheri-riscv-notes-repo `references/` are generated exports
  behind gate D4). Every open request is request-only or owner-only.
- **Transfer queue**: consumed read-only as `analysis-workbook-transfer`
  (`PMD-20260905-001`). Each turn, `pull-queues.sh list` shows a new `HET-NNN`
  row; add a `PML-NNNN` row, route it with a `PMR-NNN`, never edit the file,
  never use `accepted`. When the Beryllium owner records, defers, or declines
  `HET-001`, update `PMR-016` (or supersede it) so the workbook maintainer can
  mirror the lifecycle from that exact record.
- **Helium**: the `f0d96b1` statements and the read-only ref listing are in
  `records/assurance/helium-te-fv-pathfinder.md`. Each turn, re-run `bash
  ./scripts/inspect-components.sh refs helium-te-poc` and re-read
  `../helium-te-poc/HANDOFF.md`; record changes as statements only
  (`PMD-20260904-002`). `PMR-018` (backup of `d0cca32` and the local-only
  branches) is the owner's.
- **`collab/*` inspection**: `bash ./scripts/inspect-components.sh refs
  formal-verification-research` lists unmerged `collab/*` branches read-only;
  an unmerged branch observed there becomes a request to the owner, never an
  integration.
- **Decide the lost retained artifacts** (section above).
- **Pushes** stay per-turn user-confirmed actions, for this repository, the
  parent, and every component. This turn's coordination commits were pushed
  under the confirmation quoted in "Provenance"; the carried component
  commits `ccb48f6`, `8246147`, `4a01578`, `226d367`, `83b97a3`, and
  `ff12f2f` are local until their owners' pushes.
- `PMR-001` formal-verification-research: the owner-status table and handoff
  halves are observed satisfied at `8b91ebd`; decide a reachable backup, which
  now covers the carried `ccb48f6` and `8246147`.
- `PMR-012` formal-verification-research (superseded `PMR-010`): **closed**,
  carried at `ccb48f6`. `PMR-014` asks the owner to align the remaining
  agent-instruction bullet and `README.md` sentence and to triage the five
  routed pointers.
- `PMR-011` analysis-workbook: **closed**, carried at `83b97a3`
  (`AGENT-INTERFACE.md` aligned to the queue header status set).
- `PMR-002` osr-claude: remove stale HTTPS-remote and pending-`mktemp` lines
  (request-only: the `handoff_housekeeping` class was not granted).
- `PMR-003` beryllium-repo: reconcile `planning/HANDOFF.md` path and H0 commit
  wording when preparing the exact replacement candidate (request-only:
  carry-ineligible component).
- `PMR-004` analysis-workbook and threat-modeler: both Markdown parts carried
  (`4a01578`, `83b97a3`); open only for the two owner-only
  `scripts/readonly-inspect.sh` registered lists.
- `PMR-005` threat-modeler: push the 4 local commits, including the carried
  `4a01578` and `226d367` (owner's decision).
- `PMR-006` analysis-workbook: **closed**; the fourteen class-1 edits were
  applied at `83b97a3` and the ledger records `yes 2026-09-04`.
- `PMR-007` xrv-research-repo: closed at `7314e2f`; `PMR-013` is the owner's
  push decision for that commit.
- `PMR-008` formal-verification-research: **closed**, carried at `ccb48f6`
  (class 2); the owner may still remove a pointer (`PMR-014`), after which
  the ledger row gets a superseding `rejected` note.
- `PMR-009` cheri-riscv-notes-repo: request-only; the owner records the two
  pointers through the reference database and regeneration (gate D4).
- `PMR-013` xrv-research-repo: verify the remote (its handoff names the
  unreachable namespace) and decide the push of `7314e2f`.
- `PMR-014` formal-verification-research: owner-only alignment of
  `.github/copilot-instructions.md` and `README.md` with the carried
  `COLLAB.md`, and triage of the five routed pointers.
- `PMR-015` threat-modeler and analysis-workbook: **closed**, carried at
  `226d367` and `ff12f2f` (both discovery reference sets name the ledger).
- `PMR-016` beryllium-repo: triage `HET-001` under Beryllium's own planning
  controls and record the disposition (request-only; planning input, not
  authorization of any Beryllium work); tracked as `PML-0017`.
- `PMR-017` formal-verification-research: **closed**, carried at `8246147`.
- `PMR-018` helium-te-poc: decide the backup of the thirteen local branches
  without an upstream, including the `d0cca32` lineage (request-only;
  carry-ineligible component; not a gate).
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
