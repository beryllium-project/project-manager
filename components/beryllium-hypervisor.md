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
- **Observed state:** see `../../COMPONENTS.md`. Clean active/default branch
  `beryllium/single-hart-runtime-r0` at final owner return `416b2e9`, behind
  zero and twelve ahead of `origin/beryllium/single-hart-runtime-r0`; local candidate branch
  `beryllium/r8-h0-pmr-080` is `6e93461` with no upstream. `PMR-067` and
  `PMR-083` are closed; the responsible human's `"all ready"`, given in
  direct response to the Project Manager's Beryllium owner-session release
  request, releases the owner-session lock. The responsible human states the
  origin is now in the public project; the local inspector does not
  independently verify remote visibility. Publication follow-up is `PMR-090`

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
- Accepted implementation work is bounded through R7. R8-C plan target
  `f47ae60` is accepted as plan text only; it grants no implementation
  authorization, implementation base/relation, H0 acceptance, or successor
  H0 candidate. The branch contains committed blocked H0 candidate `6e93461`;
  committed content is not H0 acceptance. Privileged H1-H4 work is not
  authorized and K3 hardware remains `NOT RUN`.
- Prefer `./be` for maintained workflows. Do not bypass the checked launchers
  or exact accepted-revision controls with ad hoc build inputs. Authorized
  R8-H0 work uses `./tests/r8/run-make.sh r8-check` with the component's
  fresh-worktree validation requirements.
- The responsible human states the repository has moved to the public project;
  local inspection does not verify this. Public visibility does not itself
  approve release. Public release, Linux submission, and human sign-off remain
  separately controlled. Automation must
  not add a human `Signed-off-by`, approve public release, or edit
  `pathfinder/publication-gate.conf`.
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
decision. H0 remains
unaccepted, H1-H4 unauthorized, and K3 `NOT RUN`.
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
