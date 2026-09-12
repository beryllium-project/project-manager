# Retire the parent formal-verification redirect files

- **Record ID:** `PMD-20260912-001`
- **Created:** 2026-09-12
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Records the responsible human's disposition of the two parent-root files
removed at parent commit
`4a91f7f88b41698fd896212f6cac7b2fba1c9c81`:
`../formal-verification/README.md` and
`../formal-verification/helium-te-fv-pathfinder.md`. It applies to the
Project Manager contract and to current coordination-source pointers in
`../analysis-workbook/`, `../threat-modeler/`, and
`../security-reviewer/`. Historical evidence locators are not rewritten.

Observed component revisions when recorded:

- `../analysis-workbook/` at
  `d003dece93e2072ce68399127464e23b554bafa3`;
- `../threat-modeler/` at
  `5bf6a4b7524a328d891c3eaeb7feb2d6aa882dd9`;
- `../security-reviewer/` at
  `9ca5071b450eae39f63f7e31f61ad3e7009070e0`.

## Inputs

- Parent commit `4a91f7f88b41698fd896212f6cac7b2fba1c9c81`
  (`misc cleanups`, authored by the responsible human) removed both files.
  The Project Manager does not infer the intended coordination policy from a
  commit subject alone.
- `../SOT.md`, `../README.md`, and
  `../.github/copilot-instructions.md` at parent commit `4a91f7f` still
  described those absent files as maintained Project Manager artifacts.
- `../analysis-workbook/RESEARCH-SOURCES.md` at `d003dec`,
  `../threat-modeler/RESEARCH-SOURCES.md` at `5bf6a4b`, and
  `../security-reviewer/RESEARCH-SOURCES.md` at `9ca5071` still described
  both parent paths as live redirect stubs.
- In the Project Manager session of 2026-09-12, the responsible human chose
  **"Retire the deleted stubs and update current PM/component references
  (recommended)"** when asked whether to retire, restore, or defer.

## Disposition

1. The deleted `../formal-verification/README.md` and
   `../formal-verification/helium-te-fv-pathfinder.md` stay absent. They are
   no longer Project Manager-owned parent-root artifacts.
2. The parent `../HANDOFF.md` remains the sole compatibility redirect to
   `../project-manager/HANDOFF.md`.
3. Current Project Manager contracts and current component source registries
   point directly to `../project-manager/records/assurance/` and no longer
   claim that the retired files exist.
4. Historical package evidence, decision records, and Git history retain
   their original locators. Retirement does not rewrite historical evidence
   or imply that a source was absent when a historical record says it was
   inspected.
5. The current source-registry wording is carried as class 3 of
   `PMD-20260904-003` under `PMR-031`; no research, model, review, session, or
   assurance content is changed.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not retire the independent
`formal-verification-research` component, whose canonical direct checkout is
separately observed absent and routed to its owner under `PMR-024`. It does
not alter Beryllium or Helium assurance state. Beryllium remains accepted
through R7; R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium remains a review-and-test proof
of concept, not formally verified or hardware validated.

## Follow-up

- Carry `PMR-031` into the three clean eligible component source registries,
  update the Project Manager and parent contracts, and validate that no
  current document claims the retired files exist.

## Provenance

- Written by the `project-manager` agent from the inputs above and the
  responsible human's same-turn structured response quoted above.
