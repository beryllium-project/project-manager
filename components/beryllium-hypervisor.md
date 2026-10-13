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
  to the Project Manager. The 2026-10-10 leave-alone hold ended when the
  responsible human reported on 2026-10-11 that the Beryllium session is
  done. Maintained inspection at 2026-10-13T18:27Z, rechecked after the backup push at 21:09Z, observes clean
  `beryllium/k3-b7-bringup` at `PMR-134` owner return
  `f6fc6c7ecd8309b7e361455b8373c287decceca5` ("docs: record the PMR-134
  owner return"), over work `e42c6c6a` ("docs: record the
  development-branch fast-forward (PMR-134)"), `PMR-133` return
  `80ef261e` and work `f0e24f1f`, `PMR-127` return `69bf8f8a` and work
  `da65b80e`, and the owner's record of its 2026-10-10 session on `l1`,
  `563cca143fe4c1362eeb799b07e1b45bcd09ee97` ("docs: record the B7
  re-check on l1"). The six commits after `563cca14` are in
  `origin/beryllium/k3-b7-bringup`, now `f6fc6c7e`, since the responsible
  human's 2026-10-13 backup push (`"push the beryllium backup"`), with no
  upstream configured.
  The owner states that its off-board B7 re-check on `l1` is host-test and
  QEMU emulation only, is not hardware validation, and changes no
  acceptance. Development branch
  `beryllium/single-hart-runtime-r0` was fast-forwarded by closed
  `PMR-134` from `3bc3ef0` to `80ef261e`; after the same backup push it is
  0 behind / 0 ahead of `origin`. `PMR-127` is closed: the owner handoff names the `l1` checkout,
  seven linked-worktree registrations are repaired, and five under a former
  Copilot session-state directory are retained unrepaired and still
  prunable. `PMR-133` is closed: on this branch and, since `PMR-134`, on
  the development branch, `## Project Manager tasking` is again the first
  level-two section, and the owner reports `--tasking-contract` passing;
  the owner reports that the other 21 local branches that contain
  `2e9b5b1a` keep the earlier order. The committed
  instructions record component-side responsible-human acceptance of B0-B7;
  Project Manager gate records are not reconciled to them. On 2026-10-10 the
  Project Manager had run no state inspection, Git command, or write against
  it or its linked worktrees (one inadvertent recursive Markdown text search
  read files there; nothing from it was used). Earlier, maintained inspection at
  2026-10-06T16:03Z observed clean `beryllium/k3-b3-bringup` at
  `afa4336dc584642a7ef862535153116a75b44e5b`, 0 behind / 1 ahead of
  `origin/beryllium/k3-b3-bringup`. The responsible human then reported an
  active human session there, a coordination lock at that time; the Project
  Manager inferred nothing from the branch name. Its committed
  `.github/copilot-instructions.md` adopts an equivalent 2026-10-06 SOP (it
  cites neither CRQ-004 nor `PMD-20261006-001`) and pins `claude-opus-5.5`
  at `max` with `long_context` for all work, sub-agents, and tasks, so no
  Project Manager request is allocated. Residual wording is left to the
  owner, for example the `LLM_POLICY_ALIGNMENT.md` line 63 example
  `Assisted-by` trailer that still names `gpt-5.6-sol` and its line 194
  model-provider recheck trigger. No Project Manager gate changes:
  Beryllium is accepted through R7; R8-H0 is a committed candidate and is
  not accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN` in
  Project Manager records. The component's committed instructions at
  `afa4336` report owner-local B0, B1, and B2 acceptance dated 2026-10-06,
  with markers reproduced on COM260, and B3 not accepted; Project Manager
  records hold no named responsible-human record for them, they are not
  reconciled, and their reconciliation is an open responsible-human
  question. The last recorded (104th-turn) maintained inspection observed
  clean active/default `beryllium/single-hart-runtime-r0` at documentation-only
  PMR-077 return `a8e137ebbbeeff2a5475050b047a8ec6109d22e0`, behind 0 /
  ahead 6 of last-fetched private `origin`
  `4141cf6a83e2395cf9d1b036b2c19d3e3407182b`. Maintained refs inspection at
  2026-10-06T18:16Z shows that local branch at `f213555`, behind 0 / ahead
  22 of `origin/beryllium/single-hart-runtime-r0` `4141cf6`, and `afa4336`
  1 ahead of `origin/beryllium/k3-b3-bringup` `6358ed2` and on no
  remote-tracking branch. As of the last fetch, which is not a live remote
  check, `f213555` and the six return/work/checkpoint commits `a8e137e`,
  `2313cbe0`, `55b568b4`, `93819fd9`, `1f38e699`, and `4c6acbed` are
  contained in remote-tracking `origin/beryllium/k3-b0-bringup`,
  `k3-b1-bringup`, `k3-b2-bringup`, and `k3-b3-bringup`. That containment
  grants no push, publication, or gate.
  PMR-077 return `a8e137e` is the direct child of checkpoint `93819fd9`,
  changes only `planning/HANDOFF.md`, reports the bounded external readiness
  statement and owner validation, and releases the sole observed owner-session
  claim. `PMD-20261004-001` closes PMR-077 as
  acknowledgement only: the statement is human-supplied candidate planning
  input, no external project or artifact was inspected or imported, and no
  H0/H1-H4/K3, KVM0, push, publication, or release gate changes.
  PMR-112 work `2313cbe023a1563289fd3e2aa9743f55465d3746`,
  owner return `55b568b4ed37ca5ae3ac27ee0d4c58b1e764f63a`, and checkpoint
  `93819fd9` adopt SOT-first owner startup, add bounded source-only tasking
  contract validation, correct the directly related active-checkout path, and
  release the owner session. The owner reports four work paths and one
  return/checkpoint handoff path; maintained refs confirm all commits on the
  active branch. As of the last fetch all three commits are contained in
  those remote-tracking k3 branches.
  PMR-112 is closed as acknowledgement only; no component command or
  validator was run by the Project Manager.
  Canonical coordination-only return
  `1f38e6993bd325e639d8c2d6403e89f627ac6614` enumerates the distinct
  thirteen-commit PMR-098 and fourteen-commit PMR-100 ranges, bounded
  validation, exact ref/backup/publication limits, and owner-session release;
  the checkpoint and return change only owner-stated `planning/HANDOFF.md`;
  as of the last fetch both are contained in those remote-tracking k3
  branches. Maintained refs resolve every named commit/subject. PMR-098 and
  PMR-100 are closed as acknowledgements of those returns.
  `PMD-20260926-002` still limits PMR-099
  to exact K0-A plan acceptance/K0-P. The current package remains unaccepted
  and not ready; K0-X and K0-R remain blocked. Any later writer requires
  fresh tasking and one-writer checks. No backup approval, push, publication,
  acceptance, execution, or other gate follows.
  The responsible human also moved six Beryllium linked worktrees into
  workspace-root `worktrees/` and ran `git worktree repair` on `lx2`; the
  root-relative inventory is in `../../COMPONENTS.md`. After the 2026-10-10
  transfer, `PMR-127` repaired five of them at the `l1` root on 2026-10-12;
  the sixth, `be-doc-repro-review-7cf4-20260930`, is absent. Their current flat
  placement is temporary and does not satisfy the preferred namespaced
  convention. The owner also observed six unregistered
  `worktrees/beryllium-hypervisor-*` directories whose Git admin
  directories no longer exist, and an empty `worktrees/beryllium-hypervisor/`.
  Future move/remove work remains Beryllium-owner-only.
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
  The component's last recorded handoff at `93819fd9`, retaining the
  historical `80345e1` reconciliation lineage, records exact H0/R8-C target
  `1999ee7` as accepted, but the responsible human deferred Project Manager
  reconciliation of that claim. Project Manager records therefore keep the
  exact boundary: Beryllium is accepted through R7; R8-H0 is a committed
  candidate and is not accepted; H1-H4 are not authorized; K3 hardware is
  `NOT RUN` in Project Manager records. Older blocked candidate `6e93461`
  remains local.
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
  kernel/BSP remains `UNDECIDED`. The component's instructions, read at
  `69bf8f8a`, record that the responsible human dropped the KVM0 workstream
  and R8 stages H1-H4 on 2026-10-08 (a new accepted plan may recreate
  either). Project Manager records are not reconciled to that drop (open
  responsible-human question), and no gate changes.
- The root Makefile is an inspectable lower-level graph without a `help`
  target.

## Commands

Run these from development branch `beryllium/single-hart-runtime-r0` (on
2026-10-13 the checkout was observed on `beryllium/k3-b7-bringup`; see
**Observed state** above).

```sh
npm ci
./be help
./be status
./be model-check
./be check
./be docs-check
./be evaluate
./tests/r8/run-make.sh r8-check   # R8 history: the component records R8 H1-H4 dropped (2026-10-08)
```

The component's current direction also documents per-milestone bring-up
checks on each milestone branch, for example `make -C bringup/k3-b7 check`
and `make -C bringup/k3-b7 kexec-rehearsal` on `beryllium/k3-b7-bringup`
(owner-documented; the Project Manager runs none of them).

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
decision. The last recorded (104th-turn) read-only inspection observed clean
documentation-only return `a8e137e`, behind 0 / ahead 6 of last-fetched
private `origin` `4141cf6`; the active history through `4141cf6` was
contained, while local `6e93461` and `0d53120` remained without
remote-tracking containment. In that record, returns/checkpoints
`1f38e699`, `4c6acbed`, `2313cbe0`, `55b568b4`, `93819fd9`, and
`a8e137e` were local-only. Maintained refs inspection at
2026-10-06T18:16Z shows those six commits remotely contained, as of the last
fetch, via remote-tracking `origin/beryllium/k3-b0-bringup` through
`k3-b3-bringup`, while candidates `6e93461` and `0d53120` are still on no
remote-tracking branch and remain unbacked. The six commits are outside
PMR-090's fixed scope; PMR-090 stays open, and its candidate, ref, push, and
publication decision is unchanged. The
2026-10-06 observation is under **Observed state** above. The Project
Manager has no same-turn push/publication authorization.
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
blocked gates. H1-H4 are not authorized; K3 hardware is `NOT RUN` in Project
Manager records. The component's instructions now record component-side
B0-B7 acceptance and the responsible human's 2026-10-08 drop of KVM0 and R8
H1-H4; Project Manager records are not reconciled to them (open
responsible-human question).
`PMR-112` is closed from owner work `2313cbe0`, return `55b568b4`, and
checkpoint `93819fd9`. The ordinary owner now reads current
`workspace://SOT.md` before resolving any component, sibling, or Project
Manager tasking; missing/unreadable or SHA-drifted anchors stop. The return
also records the corrected current startup path and bounded source-only
contract validation. It changes no implementation, plan, acceptance record,
ref, worktree, publication state, or closed PMR-098/100 evidence.
`PMR-127` is closed from owner work `da65b80e` and return `69bf8f8a`
(2026-10-12). The handoff's Repository state, Return-to-`l1` note, and
New-session restart launch path name the registered `l1` checkout, with
directly related validator path changes. Seven linked-worktree
registrations are repaired. Five under a former Copilot session-state
directory are retained unrepaired, unpruned, and unlocked; that directory
is absent on `l1`, and whether it still exists on `lx2` is uninspected. The
owner's worktree list puts one of them, `source-first-corrected-validation`,
at `66eaa7f7`, which no branch contains. The owner reports that default
`git gc` may prune them from about 2026-12-28. The responsible human chooses
whether to have the owner lock them or let them go; copying the directory
from `lx2` to `l1` would first need a new named responsible-human decision,
because `PMD-20261011-001` and `PMD-20261010-001` forbid it.
`PMR-133` is closed from owner work `f0e24f1f` and return `80ef261e`
(2026-10-12). On `beryllium/k3-b7-bringup`, `## Project Manager tasking`
is again the first level-two section of `.github/copilot-instructions.md`,
above `## Current direction: 2026-10-08 re-baseline`, so that section's
"supersedes any conflicting guidance below" no longer reaches the
SOT-first startup. The owner moved the tasking section unchanged and
changed `docs/check-links.mjs` to allow exactly one dated
`## Current direction` section between the tasking section and
`## Repository instructions`, never before it; the owner reports
`--tasking-contract` and an 8-case regression passing. Only that branch
carries the fix: the other 22 local branches that contain `2e9b5b1a`,
including development branch `beryllium/single-hart-runtime-r0`, keep the
earlier order (owner-reported), and carrying the fix to them, including any
merge, needs separate responsible-human direction.
On 2026-10-13 the responsible human gave that direction for the
development branch only: `"proceed with these in fleet mode. fast-foward."`
`PMR-134` is closed (2026-10-13) from owner work `e42c6c6a` and return
`f6fc6c7e`. One guarded compare-and-swap ref update, owner-reported,
fast-forwarded `beryllium/single-hart-runtime-r0` from exactly `3bc3ef04`
to exactly `80ef261e`, the `beryllium/k3-b7-bringup` tip that also carries
B6, B7, the 2026-10-08 step-3 roadmap re-baseline (`ecad45d8` /
`915370aa`), and `PMR-127`. It made no checkout, merge, rebase, worktree
change, or push. Maintained refs then showed the branch at `80ef261e`, 0
behind / 65 ahead of last-fetched `origin`; the responsible human's
same-day backup push made it 0/0. The work commit updates only
current-status statements that the move made stale, and no Project Manager
gate record changes; nothing is proposed for the other 21 branches.
`PMR-077` is closed from exact documentation-only owner return `a8e137e`.
The human-supplied external readiness statement is candidate planning input
only. Any COM260-informed H0 successor still requires a separately reviewed
plan, exact base and relation, and explicit responsible-human authorization;
it does not accept H0, authorize H1-H4, or count as Beryllium K3 execution or
hardware validation. `PMR-061` is closed by synchronized private backup. The
ordinary Copilot owner context now implements the exact tasking resolver
mapping whose absence caused the observed session-history fallback.

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
