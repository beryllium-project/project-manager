# Beryllium Project Manager handoff

**Last updated:** 2026-09-04
**Update scope:** first coordination turn after the consolidation. Live
observed-state refresh at 2026-09-04T16:15Z; `helium-te-poc/` row refreshed
from dirty `9af92cc` to clean `e65c6a0`; triage of `PML-0001..PML-0016`
(all `routed` to their suggested owners by `PMR-007..PMR-009`); Helium notes
and `records/assurance/helium-te-fv-pathfinder.md` reconciled against
`../helium-te-poc/HANDOFF.md` at `e65c6a0`, recording Tier 7/8 gate refs as
the component's own statements and never as Project Manager approval;
decision records `PMD-20260904-001` and `PMD-20260904-002`. No component was
modified. Nothing was pushed.
**Workspace root:** `/home/jmorris/src/l1/src/beryllium-project`
**This repository:** `project-manager/`, branch `main`; initial commit
`02335c56b232ecdbd402d537668b15d775291fa4`; `origin` -> private
`beryllium-project/project-manager`, synchronized at
`ccf8007c171d0c9effc00957309fd7f35e607f64` before this turn; this turn's
commit is recorded in the `project-manager/` row of `../COMPONENTS.md`
**Parent coordination repository:** `main` at `839a1b5` before this turn,
synchronized with `backup/main`; consolidation commits
`e774b4217ccf5100c66e97b3b23a51a62c5e6365`,
`b2e80b260a8669a649cbf65f21e0291c3cda6a17`, and `839a1b5` remain the
provenance of the consolidation
**Parent remotes:** `backup` -> private `beryllium-project/beryllium-project`
(pushed through `839a1b5` on 2026-09-04 under the confirmation quoted in
"Provenance"; this turn's parent commit is **not pushed**); `origin` ->
unreachable `jamorris_microsoft/beryllium-project` (retained, not retargeted)

## Fast resume: read this first

### Overall position

| Area | Current state |
| --- | --- |
| Project Manager function | Consolidated into `project-manager/`: agent `project-manager`, auditor `pm-auditor`, skill, knowledge cards, roster, records, ledger, requests, scripts, and tests. The parent root is a thin shell with redirect stubs |
| Accepted Beryllium runtime sequence | R0 through exact R7 are responsible-human accepted |
| Current authorized Beryllium work | Non-privileged R8-H0 profile freeze only; H0 remains **BLOCKED / NOT READY / NOT ACCEPTED** with all 81 acceptance rows unresolved |
| Privileged and hardware work | H1-H4 unauthorized; Beryllium K3 execution and hardware evidence remain `NOT RUN` |
| Implementation repository | `beryllium-repo` clean on `beryllium/single-hart-runtime-r0` at `65f6d89`, synchronized with its private origin |
| Helium assurance line | Reconciled on 2026-09-04 against `../helium-te-poc/HANDOFF.md` at `e65c6a0` (worktree now clean; the 43-entry dirty state seen earlier that day is history). The component states: Tier 8 H6 candidate `ed15451` with frozen H7 gate `85a6e55`; Tier 7 reviewed source `7ca97a9` with frozen H7 gate `342e04a`; frozen Tier 6 H7 gate `c594b7f`; travel maintenance on `helium-te-travel-fedora44` from base `3dc3aee` with its own gate blocked. **These are the component's statements**; the Project Manager has not reviewed any Tier 7/8 gate content, has not verified the refs exist, and infers no approval (`records/decisions/PMD-20260904-002-helium-observed-state-refresh.md`) |
| Component queues | 16 analysis-workbook rows `PMQ-001..016` triaged: all `routed` in `queue/LEDGER.md` to `xrv-research-repo` (9, `PMR-007`), `formal-verification-research` (5, `PMR-008`), `cheri-riscv-notes-repo` (2, `PMR-009`); `routed` maps to no workbook status under the queue file's header, so `scripts/pull-queues.sh edits` prints nothing until an owner reports a result (the workbook's `AGENT-INTERFACE.md` names a different status set; `PMR-011`); threat-modeler queue empty |
| Retained PM session artifacts | **Lost from this workstation**: the ignored parent `files` link no longer resolves and its listed artifacts were not found under the home directory. Human decision required |
| Backups | Parent `backup/main` at `839a1b5` and this repository's `origin/main` at `ccf8007` were synchronized before this turn; **this turn's two commits are local only** until the user confirms a push. analysis-workbook, provenance-review, beryllium-repo, xrv-research-repo, cheri-riscv-notes-repo synchronized with their remotes; threat-modeler is 2 commits ahead of its private origin; formal-verification-research has no reachable remote; osr-claude is on a personal account |
| Publication | Nothing public. Push, tag, publication, release, and public migration remain separately controlled human actions |

The repositories are not broken. The runtime project is deliberately stopped
at the H0 input-and-selection gate. Do not start H1, Linux, multicore, device,
DMA, service, policy, or successor implementation to work around that gate.

### What changed in this update

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

### One recommended next action

Carry the three owner requests to their owners; the only Project
Manager-owned follow-up is read-only tooling, and it blocks nothing.

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
sed -n '1,120p' HANDOFF.md
grep -E '^\| PMR-00[789] ' outbox/component-requests.md
bash ./scripts/pull-queues.sh list      # 16 rows, all routed
bash ./scripts/pull-queues.sh edits     # empty until an owner reports a result
```

For each owner, open its own agent or session from the paths in
`AGENT-ROSTER.md` and hand over the request text verbatim:
`PMR-007` -> `../xrv-research-repo/` (`review-log.md`, `references.md`);
`PMR-008` -> `../formal-verification-research/` (`sources/bibliography.md`,
`COLLAB.md` protocol); `PMR-009` -> `../cheri-riscv-notes-repo/`
(`references/`). When an owner answers, return here, start
`copilot` then `/agent project-manager`, and say which `PMQ` rows were
recorded, already present, or declined; the agent will update the ledger and
hand you the exact `outbox/pm-queue.md` edits. Separately, decide the lost
retained artifacts (section below) and whether to push this turn's two
commits; the agent does neither without you.

### Minimal restart commands

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
sed -n '1,120p' HANDOFF.md
bash ./scripts/inspect-components.sh status
bash ./scripts/inspect-components.sh registry-check
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
| Helium Tier 7/8 gate content | Component owner and the human who made the gate commits | Not a Project Manager gate. The component's statements at `e65c6a0` are recorded without review (`PMD-20260904-002`); confirming that the named refs exist is a read-only tooling follow-up (see "Pending coordination") |
| Owner admission of the routed pointers (`PMR-007` xrv-research-repo, `PMR-008` formal-verification-research, `PMR-009` cheri-riscv-notes-repo) | Each component owner, carried by the responsible human | Open; source rows stay `new` until an owner answers |
| Owner wording reconciliations (`PMR-010` formal-verification-research `COLLAB.md` housekeeping budget; `PMR-011` analysis-workbook status vocabulary) | Component owners, carried by the responsible human | Open; the Project Manager exercises no in-component budget and writes no status the queue header does not accept |
| Decision on the lost retained PM artifacts (see "Retained PM session artifacts") | Responsible human | Open |
| Push of this turn's `project-manager/` and parent commits | Responsible human confirmation | Open; both commits are local only |
| Private remote for `project-manager/` | Responsible human confirmation | Closed 2026-09-04 by the user confirmation quoted in "Provenance"; `origin` -> private `beryllium-project/project-manager` |
| threat-modeler push of 2 local commits | threat-modeler owner | Open; `PMR-005` |
| formal-verification-research backup | Owner | Open; no reachable remote |

## Role and authority

This component is the Project Manager layer for coordinating Beryllium
components and their agents. It writes only inside this repository and to the
Project Manager-owned parent-root artifacts named in `AGENT-INTERFACE.md`.
Every component directory is agent-owned: reading for coordination is allowed;
writing is not. Component instructions, handoffs, and collaboration protocols
remain authoritative within their repositories.

## Observed workspace state

Observed 2026-09-04T16:15Z with `scripts/inspect-components.sh status`, at the
start of the first coordination turn and before this turn's commits. Full
hashes are in `../COMPONENTS.md`. The earlier observation the same day
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

`registry-check` reported one drift, `helium-te-poc` (`9af92cc` recorded,
`e65c6a0` live), reconciled in `../COMPONENTS.md` this turn. `helium-te-poc/`
changed three times on 2026-09-04 (clean `for-review` at `1ab289c` and the
dirty travel branch at `9af92cc`, both as recorded by the consolidation update
without a timestamp for the first; then the clean travel branch at `e65c6a0`
at 16:15Z); another agent session works there. Nothing in that worktree was
touched, and its state must not be reset, cleaned, or reconciled by the
Project Manager.

The parent `.gitignore` excludes every direct component checkout, now
including `/project-manager/`. The three `*-repo` entries are tracked symlink
objects; their target contents remain outside parent history.

## Component notes

Each note separates the last Project Manager review (2026-08-29, parent
`HANDOFF.md` at `7677527`) from what was observed on 2026-09-04. Conventions,
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
has not reviewed the Tier 7 or Tier 8 gate content, has not verified that the
named refs exist or are frozen (the inspect script reports only the
checked-out branch), and infers no approval from a branch name, a clean
worktree, or a passing evaluator run. The observed statements are tabulated
in `records/assurance/helium-te-fv-pathfinder.md`, above its retained
2026-08-18 snapshot. The component's handoff also names home-directory
travel caches, a bootstrap helper script, and a repository bundle; those are
workstation paths outside the workspace and are deliberately not recorded
here.

Preserve the claim boundary: Helium is a review-and-test PoC, not formally
verified or hardware validated; selected C properties are machine-checked by
CBMC only within their stated source, property, and tool boundary.

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
This Project Manager does not exercise that budget: it writes nothing and runs
no `git` inside any component. Integration stays owner-only; periodic
`collab/*` inspection waits for a read-only ref listing in
`scripts/inspect-components.sh`. The owner is asked to amend the wording
(`PMR-010`).

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

Observed unchanged at `6553092` and `ca41490`, clean, synchronized. The
knowledge base's content license remains unresolved before any public mirror.
The XRV review `REV-20260817-001` (Supervisor Domain Isolation / SmMTT) stands.

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
`IDX-SET-001` check that every source is absent there. The source rows stay
`new` because `routed` has no workbook status under the queue file's own
header; edits follow owner answers. The component's `AGENT-INTERFACE.md`
names a different Project Manager-written status set (`acknowledged`,
`routed`, `integrated`, `declined`); the conflict is raised as `PMR-011`.

### Threat modeler

Last reviewed at `affe17b` with no package. Observed now at `0d5bed3`, clean,
**2 commits ahead** of `origin/main`: packages
`TM-20260901-001-helium-te-poc/` and `TM-20260904-001-helium-te-poc-fable51/`
exist; `outbox/pm-queue.md` is empty. Pushing is the owner's decision
(`PMR-005`).

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
   `outbox/component-requests.md`.

## Pending coordination

- **Carry `PMR-007`, `PMR-008`, `PMR-009`** to the xrv-research-repo,
  formal-verification-research, and cheri-riscv-notes-repo owners. When an
  owner answers, update the matching `PML-` rows in `queue/LEDGER.md`
  (`accepted`, `duplicate`, `rejected`, or `deferred`), then hand the user
  `scripts/pull-queues.sh edits` for `../analysis-workbook/outbox/pm-queue.md`.
  If the formal-verification-research owner declines the integrity-monitoring
  and attestation pointers (PMQ-007, 010, 012, 015), re-route them by a
  superseding ledger note; `osr-claude/` is the candidate alternate.
- **Helium and `collab/*` ref verification tooling:** extend
  `scripts/inspect-components.sh` with a read-only ref listing for a named
  component so the refs named in `../helium-te-poc/HANDOFF.md` and any
  unmerged `collab/*` branch in `../formal-verification-research/` can be
  confirmed without any command inside a component. Until then, re-read those
  handoffs each turn and record their statements only (`PMD-20260904-002`).
- **Decide the lost retained artifacts** (section above).
- **Push decision:** this turn's `project-manager/` and parent commits are
  local only; pushing `origin main` here and `backup main` in the parent needs
  the user's explicit confirmation in the turn that performs it.
- `PMR-001` formal-verification-research: the owner-status table and handoff
  halves are observed satisfied at `8b91ebd`; decide a reachable backup.
- `PMR-010` formal-verification-research: amend the `COLLAB.md` housekeeping
  budget and `HANDOFF.md` wording so the Project Manager's role is read-only
  inspection and reporting; integration and in-component commits stay
  owner-only.
- `PMR-011` analysis-workbook: reconcile the Project Manager-written status
  vocabulary between `AGENT-INTERFACE.md` and the `outbox/pm-queue.md`
  header; the Project Manager follows the queue header until then.
- `PMR-002` osr-claude: remove stale HTTPS-remote and pending-`mktemp` lines.
- `PMR-003` beryllium-repo: reconcile `planning/HANDOFF.md` path and H0 commit
  wording when preparing the exact replacement candidate.
- `PMR-004` analysis-workbook and threat-modeler: register `project-manager/`
  in `RESEARCH-SOURCES.md` and the `scripts/readonly-inspect.sh` registered
  lists; consider citing `project-manager/HANDOFF.md` and
  `project-manager/records/` instead of the parent stubs.
- `PMR-005` threat-modeler: push the 2 local commits (owner's decision).
- `PMR-006` analysis-workbook: `PMQ-001..016` are ledgered and `routed`; no
  status edit is due until an owner reports a result, after which the human
  applies the edits from `scripts/pull-queues.sh edits`.
- `PMR-007..PMR-009`: owner admission decisions for the sixteen routed
  pointers (see the first bullet).
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
  in each repository; the `project-manager/` HEAD is recorded in the
  `project-manager/` row of `../COMPONENTS.md`. **No push was confirmed or
  performed in this turn.** No component repository was modified.
