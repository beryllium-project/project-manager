# authorize cheri status corrections

- **Record ID:** `PMD-20260927-002`
- **Created:** 2026-09-27
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the separate responsible-human authorization to revise only two
locations in the preserved dirty CHERI-RISC-V notes proposal before a new D4
decision.

The component is on `docs/reconcile-project-status` at handoff-only HEAD
`c6606ffdf2a1d4cc7301ec6e901bd2a5129c3251`; thirteen dirty content paths
remain at tracked-diff SHA-256
`6736270acf9ef1f908718679884d3e5b83699526debdafcbac9c33e48677422d`.

## Inputs

- `PMD-20260927-001`: responsible-human D4 deferral for the current exact
  fingerprint.
- Fleet D4 claims review: `meta/status.md` headline
  `Phases 0–9: COMPLETE` contradicts its Phase 9 row and
  `meta/roadmap.md`, which say the Phase 9 scaffold is complete but submission
  readiness is open.
- Final review audit: the same file's missing-documents section retains an
  Intel MPX venue/DOI item already resolved elsewhere in the exact set.
- Responsible-human structured response on 2026-09-26:
  `correction_authorization=authorize_two_corrections`.

## Disposition

Authorize one proposal-revision owner task with exactly two changes, both in
`meta/status.md`:

1. Replace the `Phases 0–9: COMPLETE` headline with wording that states
   Phases 0–8 are complete, the Phase 9 scaffold is complete, and submission
   readiness remains open.
2. Remove the resolved `Intel MPX Explained` venue/DOI item from the
   missing/not-yet-retrieved list; the existing correction ledger remains.

The owner changes no other content path, stages or commits none of the
thirteen content paths, runs maintained validation, and writes only a
handoff-only PMR-103 return with the revised exact fingerprint and final
active-session/reservation state. The revised set then returns to the
responsible human for D4.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not approve D4 for the revised set, authorize integration
of any content path, resolve D5, or authorize backup, merge, push, Pages,
publication, remote change, or sibling write.

## Follow-up

- Commit and generate exact PMR-103 recovery tasking, then give the
  responsible human one preloaded recovery-launch command.

## Provenance

- Written by the `project-manager` agent from the inputs above.
