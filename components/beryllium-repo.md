# beryllium-repo

- **Workspace entry:** `../beryllium-repo` (tracked symlink to
  `../copilot/msft/beryllium`, the canonical private implementation
  repository on this workstation)
- **Ownership:** agent-owned implementation repository; ask before modifying;
  the Project Manager writes nothing here and only maintains the parent
  symlink object. Carry-ineligible under `../records/decisions/PMD-20260904-003-standing-carry-authority.md`: every change is a
  `PMR-NNN` request handed to the human
- **Agent:** none user-invocable; maintained skills `helium-documentation`,
  `human-review-summary`, `reviewable-turn-summary`
- **Local instructions to read first:** on the selected active branch,
  `.github/copilot-instructions.md`, `planning/HANDOFF.md`,
  `planning/roadmap.md`, `LLM_POLICY_ALIGNMENT.md`; only generic
  `.github/copilot-instructions.md` exists on the current placeholder `main`
- **Observed state:** see `../../COMPONENTS.md`. Current checkout is a dirty
  placeholder `main` at `a7809db` and exposes only a one-line `README.md`
  plus generic uninitialized-project instructions; the responsible human
  selected synchronized `beryllium/single-hart-runtime-r0` at `65f6d89` as
  the active branch. Do not run maintained Beryllium commands until
  `PMR-057` restores that branch and its owner handoff

## Role

Canonical private Beryllium (`Be` / `be`) implementation: restricted-C
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
- Accepted work is bounded through R7. The branch contains a committed R8-H0
  profile-freeze candidate; committed content is not H0 acceptance. Privileged
  H1-H4 work is not authorized and K3 hardware remains `NOT RUN`.
- Prefer `./be` for maintained workflows. Do not bypass the checked launchers
  or exact accepted-revision controls with ad hoc build inputs. Authorized
  R8-H0 work uses `./tests/r8/run-make.sh r8-check` with the component's
  fresh-worktree validation requirements.
- The repository is private internal history. Public migration, release, Linux
  submission, and human sign-off remain separately controlled. Automation must
  not add a human `Signed-off-by`, approve public release, or edit
  `pathfinder/publication-gate.conf`.
- The root Makefile is an inspectable lower-level graph without a `help`
  target.

## Commands

Run these only after the owner has restored
`beryllium/single-hart-runtime-r0` under `PMR-057`; they are not present on
the currently checked-out placeholder `main`.

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

Reconciliation of the new active repository, active checkout, and component's
own `planning/HANDOFF.md` (including the stale workstation path and H0 commit
wording) under `PMR-057`, which supersedes `PMR-003` and `PMR-043`; the two
responsible-human H0 input selections
recorded in `../records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`
and superseding `PMD-20260912-002` (candidate copies have reappeared but their
identity and suitability remain unverified; `PMR-032`); nothing that infers
acceptance.

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
`beryllium/single-hart-runtime-r0` as the active branch. Sanitized refs show
that branch synchronized at `65f6d89` on `origin`, with the former Microsoft
reference retained under `msft-downstream`; the current checkout is instead
dirty placeholder `main` at `a7809db`. `PMR-057` requires owner verification
of complete history/default branch and restoration of the active checkout
and handoff. No workspace symlink change is directed. Repository creation,
history push, remote and default-branch changes, handoff updates, and any
future local symlink retarget remain owner actions; none changes acceptance
or authorization state.
