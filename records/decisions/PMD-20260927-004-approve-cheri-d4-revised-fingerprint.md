# Approve CHERI D4 revised fingerprint

- **Record ID:** `PMD-20260927-004`
- **Created:** 2026-09-27
- **Status:** recorded
- **Supersedes:** `PMD-20260927-003` (D4-pending disposition only)
- **Superseded by:** None

## Scope

Record the responsible-human D4 `approve_exact` disposition for the revised
CHERI-RISC-V notes thirteen-path proposal at handoff-only base
`b2031812d8644d79d0841a454f2e80a935c595d6` and tracked full-index
binary-diff SHA-256
`8bfec6744d26ba96e3e6c8e6eb3611c9caa1d38f4d6cdabb2bdaccc2a47010ca`.

## Inputs

- `PMD-20260927-003`: PMR-103 is closed as acknowledgement; the exact revised
  proposal remains unstaged and conditional PMR-104 is the integration path.
- `../cheri-riscv-notes/meta/handoff.md` at
  `b2031812d8644d79d0841a454f2e80a935c595d6`: exactly the two authorized
  `meta/status.md` corrections are present; all thirteen content paths remain
  unstaged; maintained validation passed; no remote operation occurred; and
  the prior recovery reservation is released.
- Maintained inspection on 2026-09-27: branch
  `docs/reconcile-project-status` remains at `b203181`, behind zero / ahead
  nine, with the exact thirteen-path status and SHA-256 above.
- Responsible-human response on 2026-09-27: `approve_exact`.

## Disposition

Approve D4 only for the exact revised thirteen-path fingerprint above.
Conditional PMR-104 becomes P1 and may receive a fresh exact-state recovery
specification. The owner may revalidate, stage, and commit exactly those
thirteen currently dirty content paths locally, then append a structured
handoff-only return and release its reservation.

Any HEAD, branch, status, path-set, or fingerprint mismatch stops the
recovery. Approval does not carry forward to a changed proposal.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation beyond the exact D4 citation/corpus-integration gate stated above.
It does not resolve D5 or authorize backup, merge to `main`, push, Pages,
publication, remote change, redistribution, sibling write, or any Beryllium
gate.

## Follow-up

- Commit `outbox/owner-recovery/PMR-104.tsv`, regenerate exact tasking, and
  give the responsible human the single human-run PMR-104 recovery command.

## Provenance

- Written by the `project-manager` agent from the inputs above.
