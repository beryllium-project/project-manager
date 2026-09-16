# retained artifacts verified

- **Record ID:** `PMD-20260916-004`
- **Created:** 2026-09-16
- **Status:** recorded
- **Supersedes:** `PMD-20260912-002` for current availability, expected-name
  coverage, and the recorded inbound-archive SHA-256 result only
- **Superseded by:** None

## Scope

Record the bounded result of the responsible human's retained-artifact search
for `PMR-032`. This record establishes current candidate availability,
expected-name coverage, and the one recorded archive-hash comparison. It does
not inspect artifact content or decide either Beryllium H0 input.

Observed state when recorded: Project Manager `fc7377f`; parent `f6065a5`;
Beryllium clean and synchronized at `f05ccb3`. The Project Manager worktree
was dirty only with this active coordination turn's own artifacts and
single-purpose helper correction.

## Inputs

- Responsible-human reports on 2026-09-16: `"done, I think"`,
  `"can't recall if I ran it or got distracted"`, later
  `"I remember I killed it due to gh auth status wait"`, and a request to
  inspect the later run's issues. Ignored earlier log
  `scratch/owner-actions/owner-actions-20260916T211949Z.log` ends at the
  GitHub-authentication heading with no search result.
- Ignored human-run log
  `scratch/owner-actions/owner-actions-20260916T215111Z.log`: all seven
  expected artifact names were found under a Copilot session-state artifact
  area; the inbound archive's SHA-256 matches the value recorded by
  `PMD-20260906-002`; the parent `files` link resolves.
- `records/decisions/PMD-20260906-002-retained-pm-artifacts-recorded-lost.md`:
  expected names, recorded archive hash, and the two responsible-human H0
  input selections.
- `records/decisions/PMD-20260912-002-retained-artifacts-reappeared-unverified.md`:
  candidate copies had reappeared but required the maintained read-only check
  before use.
- `outbox/component-requests.md` at `fc7377f`: `PMR-032` asks to verify
  identity and provenance for the seven candidates, including the recorded
  archive hash, and report whether either H0 selection input is fit for owner
  review.

## Disposition

1. All seven expected artifact names are currently available as candidate
   copies. Their absolute session-state location remains only in the ignored
   human-run log and is not copied into coordination records.
2. The inbound K3 collection archive is byte-identified by a SHA-256 match to
   the value already recorded in `PMD-20260906-002`.
3. Candidate artifacts relevant to the two open H0 input decisions are
   present: the H0 static OCI identity record, physical-inspection checklist,
   and proposed H1/H2 path-inventory report. Their exact mapping and adequacy
   for the normative Fedora 44 H0 static OCI and path-inventory selections
   remain for responsible-human owner review under `PMR-078`.
4. For the six non-archive files, this run establishes expected-name
   presence, not independent byte identity, authenticity, correctness,
   currency, completeness, or suitability for adoption.
   No prior hash or byte baseline for those files is recorded, so the
   maintained check returns bounded `unknown` for their byte identity and
   provenance; no further comparison request is opened without a baseline.
5. `PMR-032` closes on this bounded result. The Project Manager did not open,
   copy, hash, or interpret any retained artifact.
6. The same human-run invocation attempted unrelated push/fetch steps before
   and after `files_search`. Authentication failures changed no recorded
   remote state and do not invalidate the successful local search/hash result.
7. Live instructions now use
   `scripts/owner-actions.sh --only files_search --files-search`; in that
   single-purpose mode the helper skips GitHub authentication and push-target
   preflight.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, risk acceptance, licensing, redistribution, publication, release,
formal verification, or hardware validation. It does not select either H0
input, accept H0, authorize H1-H4, authenticate the six non-archive files by
content, or establish K3 execution. Beryllium remains accepted through R7;
R8-H0 is a committed candidate and is not accepted; H1-H4 are not authorized;
K3 hardware is `NOT RUN`.

## Follow-up

- The responsible human and Beryllium owner decide whether to review and
  select either candidate H0 input under Beryllium's own controls. No
  selection is inferred from this record.

## Provenance

- Written by the `project-manager` agent from the human statement and ignored
  helper log. No retained artifact was opened or copied by the Project
  Manager.
