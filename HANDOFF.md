# Beryllium Project Manager handoff

**Last updated:** 2026-09-04
**Update scope:** consolidation of the Project Manager function into this
independent `project-manager/` component; live observed-state refresh of every
registered component; pull of the analysis-workbook queue into the ledger (no
triage yet); record of the broken retained-artifact link. No component was
modified.
**Workspace root:** `/home/jmorris/src/l1/src/beryllium-project`
**This repository:** `project-manager/`, branch `main`; the initial commit is
recorded in the Provenance section once made
**Parent coordination repository:** `main` at `7677527` before this
consolidation; the consolidation commit is recorded in the Provenance section
**Parent remotes:** `backup` -> private `beryllium-project/beryllium-project`
(synchronized at `7677527`); `origin` -> unreachable
`jamorris_microsoft/beryllium-project` (retained, not retargeted)

## Fast resume: read this first

### Overall position

| Area | Current state |
| --- | --- |
| Project Manager function | Consolidated into `project-manager/`: agent `project-manager`, auditor `pm-auditor`, skill, knowledge cards, roster, records, ledger, requests, scripts, and tests. The parent root is a thin shell with redirect stubs |
| Accepted Beryllium runtime sequence | R0 through exact R7 are responsible-human accepted |
| Current authorized Beryllium work | Non-privileged R8-H0 profile freeze only; H0 remains **BLOCKED / NOT READY / NOT ACCEPTED** with all 81 acceptance rows unresolved |
| Privileged and hardware work | H1-H4 unauthorized; Beryllium K3 execution and hardware evidence remain `NOT RUN` |
| Implementation repository | `beryllium-repo` clean on `beryllium/single-hart-runtime-r0` at `65f6d89`, synchronized with its private origin |
| Helium assurance line | Moved since the last coordination review: the component's own handoff names Tier 8 H6 candidate `ed15451` and frozen H7 gate branch `helium-te-fv-tier8-h7-approved` at `85a6e55`; an active travel-maintenance branch `helium-te-travel-fedora44` at `9af92cc` had 43 dirty entries at observation. **The Project Manager has not reviewed the Tier 7/8 gate content**; reconciliation is pending |
| Component queues | 16 analysis-workbook rows `PMQ-001..016` pulled into `queue/LEDGER.md` as `pending`; threat-modeler queue empty |
| Retained PM session artifacts | **Lost from this workstation**: the ignored parent `files` link no longer resolves and its listed artifacts were not found under the home directory. Human decision required |
| Backups | Parent, analysis-workbook, provenance-review, beryllium-repo, xrv-research-repo, cheri-riscv-notes-repo synchronized with their remotes; threat-modeler is 2 commits ahead of its private origin; formal-verification-research has no reachable remote; osr-claude is on a personal account; `project-manager/` has no remote yet |
| Publication | Nothing public. Push, tag, publication, release, and public migration remain separately controlled human actions |

The repositories are not broken. The runtime project is deliberately stopped
at the H0 input-and-selection gate. Do not start H1, Linux, multicore, device,
DMA, service, policy, or successor implementation to work around that gate.

### What changed in this update

- The Project Manager agent, procedures, and records now live in
  `project-manager/` (see `README.md`, `AGENT-INTERFACE.md`,
  `.github/agents/`, `.github/skills/beryllium-project-management/SKILL.md`).
- Component conventions moved from the parent `.github/copilot-instructions.md`
  into `components/<component>.md`; agent invocation and validation moved into
  `AGENT-ROSTER.md`.
- `formal-verification/helium-te-fv-pathfinder.md` moved to
  `records/assurance/helium-te-fv-pathfinder.md`; the parent path is a redirect
  stub because sibling components cite it.
- The parent `HANDOFF.md` became a redirect stub to this file for the same
  reason.
- `queue/LEDGER.md` holds one `pending` row per analysis-workbook queue row.
- `outbox/component-requests.md` records owner requests `PMR-001..PMR-006`.

### One recommended next action

Review this consolidation, then authorize its private backup:

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
sed -n '1,120p' HANDOFF.md
bash ./tests/validate-agent.sh
bash ./scripts/validate-pm.sh
git log --oneline -3
gh auth refresh -h github.com          # the xjamesmorris keyring token was invalid on 2026-09-04
```

Then, in a `project-manager` agent session, state explicitly: "create the
private repository `beryllium-project/project-manager` and push `main`". The
agent will not create a remote or push without that same-turn confirmation.
After that, the first coordination turn triages `PML-0001..PML-0016` and
reconciles the Helium notes against `../helium-te-poc/HANDOFF.md`.

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
| Helium Tier 7/8 gate content review by the Project Manager | Project Manager (read-only) | Pending first coordination turn |
| Decision on the lost retained PM artifacts (see "Retained PM session artifacts") | Responsible human | Open |
| Private remote for `project-manager/` | Responsible human confirmation | Open |
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

Observed 2026-09-04T11:56Z with `scripts/inspect-components.sh status`.
Full hashes are in `../COMPONENTS.md`.

| Entry | Integration | Worktree | Branch | HEAD | Upstream (behind/ahead) |
| --- | --- | --- | --- | --- | --- |
| Parent | workspace | dirty only by untracked `project-manager/` | `main` | `7677527` | `backup/main` (0/0) |
| `project-manager/` | direct | new, uncommitted at observation | `main` | unborn | none |
| `helium-te-poc/` | direct | **dirty, 43 entries** | `helium-te-travel-fedora44` | `9af92cc` | `origin/helium-te-travel-fedora44` (0/0) |
| `formal-verification-research/` | direct | clean | `main` | `8b91ebd` | stale `origin/main` on the unreachable namespace (0/0 against a stale ref) |
| `osr-claude/` | direct | clean | `main` | `f2edd17` | `origin/main` (0/0) |
| `provenance-review/` | direct | clean | `main` | `86d9260` | `origin/main` (0/0) |
| `analysis-workbook/` | direct | clean | `main` | `2261659` | `origin/main` (0/0) |
| `threat-modeler/` | direct | clean | `main` | `0d5bed3` | `origin/main` (0/**2**) |
| `beryllium-repo` | symlink `../copilot/msft/beryllium` | clean | `beryllium/single-hart-runtime-r0` | `65f6d89` | `origin/...` (0/0) |
| `cheri-riscv-notes-repo` | symlink `../copilot/gim/cheri-riscv-notes` | clean | `main` | `6553092` | `origin/main` (0/0) |
| `xrv-research-repo` | symlink `../copilot/gim/xrv-research` | clean | `main` | `ca41490` | `origin/main` (0/0) |

`helium-te-poc/` changed twice during the observation window (clean
`for-review` at `1ab289c`, then the dirty travel branch above). Another agent
session is active there. Nothing in that worktree was touched, and its dirty
state must not be reset, cleaned, or reconciled by the Project Manager.

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

Observed now: all of those refs still exist. New branch refs include
`helium-te-fv-tier7-h7-approved` (`342e04a`), `helium-te-fv-tier8-h6-candidate`
(`ed15451`), `helium-te-fv-tier8-h7-approved` (`85a6e55`),
`helium-te-fv-tier8-transaction` (`3dc3aee`), `for-review` (`1ab289c`), and
the checked-out `helium-te-travel-fedora44` (`9af92cc`). The component's own
`HANDOFF.md` at `9af92cc` describes the travel branch as maintenance outside
the fixed Tier 8 candidate and reports a Fedora 44 checkpoint with 152 named
claims and 19,419 successful properties. The Project Manager records these as
observed component statements; it has not reviewed the Tier 7 or Tier 8 gate
commits and infers no approval from branch names. Reconciling the Helium notes
and `records/assurance/helium-te-fv-pathfinder.md` against the component's
handoff is pending coordination.

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
off-machine backup. Coordination discrepancy retained: the owner-status table
and handoff described only the first integration at last review; whether
`8b91ebd` resolves this is unverified (`PMR-001`).

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
(`PMQ-001..016`), all now ledgered as `pending`.

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

- **Authorize the private remote** `beryllium-project/project-manager` and the
  push of `main`, after `gh auth refresh -h github.com`. Also push the parent
  consolidation commit to `backup/main` on confirmation.
- **Triage `PML-0001..PML-0016`** against each suggested owner's own index
  (xrv-research-repo `review-log.md`, formal-verification-research
  `sources/bibliography.md`, cheri-riscv-notes-repo reference indexes), then
  hand the user `scripts/pull-queues.sh edits`.
- **Reconcile the Helium notes** and `records/assurance/` against
  `../helium-te-poc/HANDOFF.md` at its then-current commit; record Tier 7/8
  gate refs as observed statements, never as Project Manager approval. Do not
  touch the dirty travel worktree.
- **Decide the lost retained artifacts** (section above).
- `PMR-001` formal-verification-research: confirm owner-status table and
  handoff reflect the second integration; decide a reachable backup.
- `PMR-002` osr-claude: remove stale HTTPS-remote and pending-`mktemp` lines.
- `PMR-003` beryllium-repo: reconcile `planning/HANDOFF.md` path and H0 commit
  wording when preparing the exact replacement candidate.
- `PMR-004` analysis-workbook and threat-modeler: register `project-manager/`
  in `RESEARCH-SOURCES.md` and the `scripts/readonly-inspect.sh` registered
  lists; consider citing `project-manager/HANDOFF.md` and
  `project-manager/records/` instead of the parent stubs.
- `PMR-005` threat-modeler: push the 2 local commits (owner's decision).
- `PMR-006` analysis-workbook: `PMQ-001..016` are ledgered; expect status edits
  after triage, applied by the human.
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
- Consolidation commits: recorded here after they are made.
