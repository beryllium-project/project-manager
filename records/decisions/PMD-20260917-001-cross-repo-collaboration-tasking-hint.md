# cross repo collaboration tasking hint

- **Record ID:** `PMD-20260917-001`
- **Created:** 2026-09-17
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Require Project Manager tasking to tell a destination owner to load the
`cross-repo-collaboration` skill whenever its task actually consumes sibling
research or analysis. This is a tasking and evidence rule, not a general
requirement for same-repository maintenance, backup, coordination-only
mirrors, or pointer triage that does not use the source in destination work.

Observed state when recorded: Project Manager `097a9a5`; parent `11a477f`;
analysis-workbook `c7cc0fa`; XRV `456c70b`; OS-security `49fbfd6`;
formal-verification `784be93`; CHERI-RISC-V notes `9a4c5ef`; Beryllium
`3ce96fe`. No component was modified by this record.

## Inputs

- Responsible-human direction on 2026-09-16:
  `"i suggest hinting to the other repos to load the
  cross-repo-collaboration skill for these"`.
- User-level `cross-repo-collaboration` skill: establishes the owner/guest
  roles, source-repository `COLLAB.md` boundary, destination-first work,
  completed-use logging, and source-owner integration.
- `../xrv-research-repo/COLLAB.md` at `456c70b`: permits a guest to append one
  completed-use section on a local `collab/*` branch and commit only
  `COLLAB.md`; the XRV owner alone integrates or pushes.
- `../formal-verification-research/COLLAB.md` at `784be93`: grants a similarly
  narrow append-only guest log budget and preserves the Project Manager's
  separate standing carry authority.
- No root `COLLAB.md` was observed in analysis-workbook `c7cc0fa`,
  OS-security `49fbfd6`, or CHERI-RISC-V notes `9a4c5ef`. Absence grants no
  guest write authority.
- `outbox/component-requests.md` at `097a9a5`: current work includes direct
  sibling-analysis consumption (`PMR-040`, `PMR-052..PMR-054`) and
  pointer-triage work that may become consumption only if incorporated
  (`PMR-009`, `PMR-014`, `PMR-041`, `PMR-058`).

## Disposition

1. For every owner task that asks a destination repository to consume,
   incorporate, qualify, or apply sibling research or analysis, the Project
   Manager prompt explicitly says:

   ```text
   Load and follow the `cross-repo-collaboration` skill before using sibling
   research or analysis.
   ```

2. The destination owner reads the source repository's root `COLLAB.md` in
   full when it exists, determines its owner/guest role, and follows the
   smaller of that ledger's budget and all applicable repository rules.
3. A missing `COLLAB.md`, a read-only ledger, a dirty source worktree, an
   active source-owner session, or a ledger without a guest budget grants no
   source write. The destination completes its own work and returns a
   completed-use report through the source owner and Project Manager rather
   than creating a ledger or editing the source.
4. A guest log records completed destination use only after the destination
   work and validation exist. It names exact source and destination revisions,
   concrete destination paths, adopted/rejected guidance, claim limits,
   validation, and feedback. It never logs a plan as completed use.
5. The hint is mandatory now for `PMR-040`, `PMR-052`, `PMR-053`, and
   `PMR-054`. For `PMR-009`, `PMR-014`, `PMR-041`, and `PMR-058`, it becomes
   mandatory only if pointer triage proceeds to substantive destination use;
   recording, declining, or deferring a pointer alone does not require a guest
   log.
6. Backup, remote, tasking-startup, status-mirror, and same-repository
   maintenance requests do not load the skill merely because their PMR text
   mentions another component.
7. Generated tasking remains discovery, not authorization. The hint does not
   widen either repository's write boundary, create a branch, permit a push,
   or grant any human gate.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, hardware validation, source adoption, source-corpus admission,
guest-branch integration, or permission to write a source repository. It does
not require a `COLLAB.md` to be created where none exists.

## Follow-up

- Include the skill-loading hint in every applicable current and future owner
  task; preserve completed-use evidence in the owner return and, only when the
  source ledger permits it, its append-only guest log.

## Provenance

- Written by the `project-manager` agent from the responsible-human direction
  and read-only inspection above. No component repository was written.
