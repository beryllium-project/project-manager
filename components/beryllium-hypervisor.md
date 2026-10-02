# beryllium-hypervisor

- **Workspace entry:** `../beryllium-hypervisor/` (ignored canonical direct
  checkout in this workspace)
- **Ownership:** agent-owned implementation repository; ask before modifying;
  the Project Manager writes nothing here; the component is an ignored direct
  checkout and the parent tracks no object for it. Carry-ineligible under
  `../records/decisions/PMD-20260904-003-standing-carry-authority.md`: every change is a
  `PMR-NNN` request handed to the human
- **Agent:** none user-invocable; maintained skills `helium-documentation`,
  `human-review-summary`, `reviewable-turn-summary`. No Beryllium owner profile
  exists. The analysis-workbook read-only proof is closed; any Beryllium owner
  still requires its own adoption and proof, while `PMD-20260918-003` parks
  further rollout. No hidden owner profile was needed for the completed
  ordinary PMR-067/PMR-083 housekeeping session
- **Local instructions to read first:** on the selected active branch,
  `.github/copilot-instructions.md`, `planning/HANDOFF.md`,
  `planning/roadmap.md`, `LLM_POLICY_ALIGNMENT.md`; the placeholder `main`
  branch, which is not checked out, carries only generic instructions
- **Observed state:** see `../../COMPONENTS.md`. Beryllium remains read-only
  to this Project Manager turn. Maintained inspection observes clean
  active/default `beryllium/single-hart-runtime-r0` at local session
  checkpoint `93819fd9550e798bcdc19fb398d48c613ce110f0`, behind 0 / ahead
  5 of last-fetched private `origin` `4141cf6a83e2395cf9d1b036b2c19d3e3407182b`.
  PMR-112 work `2313cbe023a1563289fd3e2aa9743f55465d3746`,
  owner return `55b568b4ed37ca5ae3ac27ee0d4c58b1e764f63a`, and checkpoint
  `93819fd9` adopt SOT-first owner startup, add bounded source-only tasking
  contract validation, correct the directly related active-checkout path, and
  release the owner session. The owner reports four work paths and one
  return/checkpoint handoff path; maintained refs confirm all commits on the
  active branch. All three commits are local-only and not remotely backed up.
  PMR-112 is closed as acknowledgement only; no component command or
  validator was run by the Project Manager.
  Canonical coordination-only return
  `1f38e6993bd325e639d8c2d6403e89f627ac6614` enumerates the distinct
  thirteen-commit PMR-098 and fourteen-commit PMR-100 ranges, bounded
  validation, exact ref/backup/publication limits, and owner-session release;
  the checkpoint and return change only owner-stated `planning/HANDOFF.md`
  and are local-only. Maintained refs resolve every named commit/subject and
  confirm the two-commit local state. PMR-098 and PMR-100 are closed as
  acknowledgements of those returns. `PMD-20260926-002` still limits PMR-099
  to exact K0-A plan acceptance/K0-P. The current package remains unaccepted
  and not ready; K0-X and K0-R remain blocked. Any later writer requires
  fresh tasking and one-writer checks. No backup approval, push, publication,
  acceptance, execution, or other gate follows.
  The responsible human also moved six Beryllium linked worktrees into
  workspace-root `worktrees/` and ran `git worktree repair`; the repaired
  root-relative inventory is in `../../COMPONENTS.md`. Their current flat
  placement is temporary and does not satisfy the preferred namespaced
  convention. Future move/remove work remains Beryllium-owner-only.
  Last-fetched refs contain the PMR-098/100 active ranges through
  `4141cf6`; local candidate `6e93461` and local R8-C/H0 branch tip
  `0d53120` still have no remote-tracking containment. The PMR-098 return
  reports authenticated current GitHub visibility `PRIVATE`, but the Project
  Manager performed no network operation. The responsible human selected
  `defer` for Project Manager acceptance reconciliation in
  `PMD-20260925-001`, so Project Manager state remains accepted through R7
  with R8-H0 committed but unaccepted. `PMR-090` remains open for its fixed
  candidate/ref review and a separate human push/publication decision.

## Role

Canonical Beryllium (`Be` / `be`) implementation: restricted-C
architecture models, the bounded single-hart runtime sequence, Rocq and host
evidence, QEMU packages, documentation, exact responsible-human acceptance
records, and the retained Helium pathfinder under `pathfinder/`. The stable
`./be` wrapper coordinates the maintained workflows.

## Boundaries and conventions

- Preserve Beryllium (`Be` / `be`, `be_` / `BE_`) versus Helium (`He` / `he`,
  `he_` / `HE_`) naming and the restricted GNU C plus explicit
  assembly/platform boundary.
- Plans, implementation authorization, exact-target acceptance, validation
  evidence, push, tag, publication, and release are distinct gates. Never infer
  or record responsible-human acceptance.
- Project Manager acceptance remains bounded through R7 under
  `PMD-20260925-001`. R8-C plan target `f47ae60` is accepted as plan text.
  The component's current handoff at `93819fd9`, retaining the historical
  `80345e1` reconciliation lineage, records exact H0/R8-C target `1999ee7`
  as accepted, but the responsible human deferred Project Manager
  reconciliation of that claim; Project Manager records therefore continue
  to treat R8-H0 as a committed candidate that is not accepted. Older blocked
  candidate `6e93461` remains local. Privileged H1-H4 work is not authorized
  and K3 hardware remains `NOT RUN`.
- Prefer `./be` for maintained workflows. Do not bypass the checked launchers
  or exact accepted-revision controls with ad hoc build inputs. Authorized
  R8-H0 work uses `./tests/r8/run-make.sh r8-check` with the component's
  fresh-worktree validation requirements.
- The responsible human previously stated the repository moved to the public
  project. PMR-098's durable return records owner-authenticated current
  GitHub visibility as `PRIVATE`; the Project Manager did not repeat that
  network check, and the earlier wording is not publication approval.
  Visibility does not itself approve release. Public release, Linux
  submission, and human sign-off remain separately controlled. Automation must
  not add a human `Signed-off-by`, approve public release, or edit
  `pathfinder/publication-gate.conf`.
- `PMD-20260926-002` records responsible-human acceptance of exact KVM0 Plan
  revision K0-A target `5227266`, satisfying K0-P only. PMR-100's canonical
  return records the distinct K0-I exact-target and K0-S
  preparation/status boundaries without expanding their authority. K0-X and
  K0-R remain blocked; KVM0 and K3 remain `NOT RUN`; the development
  kernel/BSP remains `UNDECIDED`.
- The root Makefile is an inspectable lower-level graph without a `help`
  target.

## Commands

Run these from the restored active branch
`beryllium/single-hart-runtime-r0`.

```sh
npm ci
./be help
./be status
./be model-check
./be check
./be docs-check
./be evaluate
./tests/r8/run-make.sh r8-check   # authorized R8-H0 targeted launcher only
```

## What the Project Manager may request

`PMR-032` and `PMD-20260916-004` establish that all seven expected candidate
names are present and the inbound archive hash matches its recorded value;
the six non-archive files had expected-name verification only at that stage.
`PMR-078` is closed at owner decision `db2293b` and return `3ce96fe`: exact
Fedora 44 OCI archive SHA-256
`fcf6c595140a9dd55d6afb633ac7777162492cdae6b77cd27a59e4541c1bd1f5`
and conservative 19-path H1 / 22-path H2 baselines are selected as H0 inputs;
the physical checklist is retained only as a passive collection instrument.
They are incorporated into exact local candidate `6e93461`, which remains
unaccepted and records 80 H0 blockers. Standalone H0 and Chromium
documentation gates pass; full `make check` stops on the existing
source-policy checker treating two non-text binary sequences as retired
namespace text. `PMR-080` is closed on that blocked result. `PMR-081` is
closed at exact R8-C plan target `f47ae60`, packet `0b8fdad`, and acceptance
record `d18b1c9`; the checker remains unchanged and R8-C implementation
authorization is none. `PMR-083` is closed by final return correction
`416b2e9`, following tasking implementation `9b726c1` and bounded remediation
commits. `PMR-067` is also closed: exact resolver startup, fence-aware
contract checks, generated documentation, and explicit-Chromium docs checks
pass; full `make check` stops first on unchanged R3 Node digest drift rather
than a PMR-067 semantic failure. `PMR-090` tracks exact ref review and a separate responsible-human publication
decision. Read-only inspection now observes clean local checkpoint `93819fd9`,
behind 0 / ahead 5 of last-fetched private `origin` `4141cf6`; the active
history through `4141cf6` is contained, while local `6e93461` and `0d53120`
remain without remote-tracking containment. Returns/checkpoints
`1f38e699`, `4c6acbed`, `2313cbe0`, `55b568b4`, and `93819fd9` are
local-only and outside PMR-090's fixed scope. The Project Manager has no
same-turn push/publication authorization.
The component handoff also states that local branch
`beryllium/doc-repro-option-a-20260929` is unpushed and not integrated, that
`archive/generated-docs-2026-09-30` points to `d4c5ff0`, and that K0-S target
`c6570558` is contained by the last-fetched Beryllium refs, while source
target `c1c7e254` is absent from this Beryllium object database and remains
owner-stated sibling evidence. These facts are not Project Manager
acceptance, authority, readiness, publication, or backup approval. They do
not expand PMR-090's fixed scope. The request therefore remains open.

`PMR-098` and `PMR-100` are closed from canonical return `1f38e699` and
session checkpoint `4c6acbed`. PMR-098 covers only the exact thirteen-commit
`416b2e9..80345e1` range; PMR-100 covers only the exact fourteen-commit
`80345e1..2b404ca` KVM0 range. Later source-first work
`6bb3349..4141cf6` remains observation-only for PMR-100.
`PMD-20260925-001` still defers Project Manager reconciliation of the
component-side `1999ee7` acceptance claim, so Project Manager state remains
R8-H0 committed but unaccepted. PMR-099 remains closed on exact
human-accepted K0-A target `5227266` under `PMD-20260926-002`, satisfying
only K0-P. The PMR-100 return records bounded K0-I and K0-S history; the
current package remains mutable, unaccepted, and not ready. K0-X native
execution, K0-R result acceptance, B0, development-kernel/BSP selection, B1,
a retained H0 successor, H1-H4, publication, and release remain separate
blocked gates. H1-H4 are unauthorized and K3 remains `NOT RUN`.
`PMR-112` is closed from owner work `2313cbe0`, return `55b568b4`, and
checkpoint `93819fd9`. The ordinary owner now reads current
`workspace://SOT.md` before resolving any component, sibling, or Project
Manager tasking; missing/unreadable or SHA-drifted anchors stop. The return
also records the corrected current startup path and bounded source-only
contract validation. It changes no implementation, plan, acceptance record,
ref, worktree, publication state, or closed PMR-098/100 evidence.
External K3 COM260 bring-up is in progress in a separate
environment/project under `PMR-077`; Beryllium hardware bring-up waits for a
responsible-human readiness return, which does not accept H0, authorize
H1-H4, or count as Beryllium hardware validation. `PMR-061` is closed by
synchronized private backup. The ordinary Copilot owner context now
implements the exact tasking resolver mapping whose absence caused the
observed session-history fallback.

## Helium-to-Beryllium transfer input

`HET-001` (`../../analysis-workbook/outbox/helium-transfer-queue.md`) was
routed to the Beryllium owner as `PMR-016` on 2026-09-04. On 2026-09-05 the
responsible human, acting as the Beryllium owner, triaged it and told the
Project Manager "HET-001 is triaged as accepted", confirming that this maps
to the transfer-lifecycle status `recorded`: all eight candidate lessons are
recorded as planning inputs for a possible future Beryllium
security-significant seam, none is adopted as an entry criterion, design
constraint, evidence requirement, or exit criterion, and no Beryllium
authorization changes
(`../records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`;
`PMR-016` and mirror request `PMR-019` are closed). No Beryllium-owned artifact
records the triage (read-only text search at `65f6d89`); if the owner later
writes one, a superseding Project Manager record cites it. This is not
acceptance of any Beryllium target or work.

The responsible human revised the private active GitHub home to
`beryllium-project/beryllium-hypervisor` and reported the manual push
complete (`PMD-20260915-005`). The same record selects
`beryllium/single-hart-runtime-r0` as the active branch. Owner reconciliation
commits `3221231` and `f05ccb3` restore the active checkout, default-branch
record, inactive `msft-downstream`, maintained workflow, and structured
return; `PMR-057` is closed. The active branch and both return commits through
`f05ccb3` are synchronized with private `origin`; `PMR-061` is closed.
At that historical checkpoint no workspace symlink change was directed.
The responsible human moved the canonical checkout to
`../beryllium-hypervisor/` on 2026-09-21; the former `beryllium-repo` symlink
is retired. Repository creation, history push, remote and default-branch
changes, and handoff updates remain owner actions; none changes acceptance or
authorization state.
