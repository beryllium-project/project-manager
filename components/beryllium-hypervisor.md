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
- **Observed state:** see `../../COMPONENTS.md`. The responsible human reports
  a separate K0 session running, so Beryllium is coordination-locked and
  read-only to this Project Manager turn. Maintained inspection observes
  active/default `beryllium/single-hart-runtime-r0` dirty at `d3499c3`,
  behind zero / ahead two of last-fetched
  `origin/beryllium/single-hart-runtime-r0` `478d588`. Read-only ref
  inspection also observes multiple local K0 topic branches, including K0-S,
  K0-B, K0-C, and renewed K0-I lines; their worktrees and contents are not
  Project Manager state and are not modified here. The
  component roadmap and `planning/k3-kvm0-k0i-review-summary.md` record exact
  K0-I acceptance at earlier target `abd092a`, but the component still has no
  canonical PMR-098/100 return or explicit session release.
  `PMD-20260926-002` records the exact K0-A plan
  acceptance and closes plan-only PMR-099, satisfying K0-P only. K0-S, K0-X,
  and K0-R remain blocked. The component still has no
  canonical `PMR-098` return for `416b2e9..80345e1` and no canonical
  `PMR-100` return for the later KVM0 series through current `d3499c3`. Do
  not launch another owner session or infer K0-S authority, execution, backup,
  publication, or either reconciliation request complete.
  Last-fetched refs previously contained active/default
  `80345e1` and renamed `origin/historical_he/*` refs; local candidate
  `6e93461` and local R8-C/H0 branch tip `0d53120` had no remote-tracking
  containment. The responsible human selected `defer` for Project Manager
  acceptance reconciliation in `PMD-20260925-001`, so Project Manager state
  remains R0-R7 accepted and R8-H0 committed but unaccepted. `PMR-090`
  remains open for unresolved visibility, publication, and ref scope.

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
  The component at `80345e1` records exact H0/R8-C target `1999ee7` as
  accepted, but the responsible human deferred Project Manager
  reconciliation of that claim; Project Manager records therefore continue
  to treat R8-H0 as a committed candidate that is not accepted. Older blocked
  candidate `6e93461` remains local. Privileged H1-H4 work is not authorized
  and K3 hardware remains `NOT RUN`.
- Prefer `./be` for maintained workflows. Do not bypass the checked launchers
  or exact accepted-revision controls with ad hoc build inputs. Authorized
  R8-H0 work uses `./tests/r8/run-make.sh r8-check` with the component's
  fresh-worktree validation requirements.
- The responsible human previously stated the repository moved to the public
  project, while maintained component records at `80345e1` call the active
  repository and `origin` private. Local inspection does not authenticate
  visibility. `PMR-098` requires the owner to reconcile that conflict.
  Visibility does not itself approve release. Public release, Linux
  submission, and human sign-off remain separately controlled. Automation must
  not add a human `Signed-off-by`, approve public release, or edit
  `pathfinder/publication-gate.conf`.
- `PMD-20260926-002` records responsible-human acceptance of exact KVM0 Plan
  revision K0-A target `5227266`, satisfying K0-P only. K0-I is
  component-recorded accepted at exact target `abd092a` and remains
  unreconciled in Project Manager state pending PMR-098/100. K0-S, K0-X, and
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
decision. Read-only inspection now observes active/default `80345e1`
synchronized with last-fetched `origin`, but local `6e93461` and `0d53120`
remain without remote-tracking containment and the Project Manager has no
same-turn publication-authorization record for the observed active update.
The request therefore remains open.

`PMR-098` requests a canonical owner return for the exact thirteen-commit
range `416b2e9..80345e1`, including validation, active-session, backup/ref,
visibility, and publication state, including an account of the observed
`origin` advance and `helium/* -> historical_he/*` namespace rename.
`PMD-20260925-001` records the responsible human's
choice to defer Project Manager reconciliation of the component-side
`1999ee7` acceptance claim; until a separate decision, Project Manager state
remains R8-H0 committed but unaccepted. `PMR-099` is closed on exact
human-accepted K0-A plan target `5227266` under `PMD-20260926-002`; that
closes plan preparation only and satisfies only K0-P. New `PMR-100` requests
the distinct canonical return for the post-`80345e1` committed KVM0 series
and current active K0 session, whose primary checkout is now clean at
`478d588`. K0-S source preparation and evidence import,
K0-X native execution, K0-R result acceptance, B0,
development-kernel/BSP selection, B1, a retained H0 successor, H1-H4,
publication, and release remain separate blocked gates. H1-H4 are
unauthorized and K3 remains `NOT RUN`.
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
