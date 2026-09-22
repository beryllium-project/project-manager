# research symlink consolidation

- **Record ID:** `PMD-20260922-002`
- **Created:** 2026-09-22
- **Status:** recorded
- **Supersedes:** Earlier current-state wording that the CHERI notes and XRV
  workspace symlinks remained unchanged; historical owner returns and
  repository-reorganization decisions remain intact
- **Superseded by:** None

## Scope

Record the responsible human's consolidation of the CHERI-RISC-V notes and
XRV research workspace pointers onto their verified
`agentic-os-research` successors. The components remain external repositories
represented by tracked symlink objects; they are not converted to direct
checkouts, submodules, or parent-owned content.

The observed component revisions are CHERI notes
`9a4c5effef3b87fc7529ec7ff265179ad1130d58` and CHERI hypervisor research
`456c70bbc8b5ae75d3d5d47d65d4bb9db445cf08`.

## Inputs

- Responsible-human request on 2026-09-21 to review this further repository
  consolidation, update the project, and push the coordination result.
- Parent staged symlink objects at pre-commit parent
  `587e9cc351b561ea62b3459bae1c9fde596c93bd`:
  `../cheri-riscv-notes ->
  ../agentic-os-research/cheri-riscv-notes` and
  `../cheri-hypervisor-research ->
  ../agentic-os-research/cheri-hypervisor-research`, replacing the two former
  `*-repo` links.
- `../cheri-riscv-notes/meta/handoff.md` at `9a4c5ef`: owner evidence for the
  active successor, topic branch, validation, Wiki archive, issues, and
  remaining publication gates.
- `../cheri-hypervisor-research/HANDOFF.md` at `456c70b`: owner evidence for
  the active successor, reviewed-history boundary, inactive remotes, local
  documentation commits, and completed owner session.
- `scripts/inspect-components.sh status`, `state`, `refs`, and `symlinks` at
  2026-09-22T06:40Z: both replacement links resolve to the expected Git
  roots; CHERI notes is clean and synchronized at `9a4c5ef`; hypervisor
  research is clean at `456c70b`, behind 0 / ahead 2 of `origin/main`.

## Disposition

The active workspace entries are:

- `cheri-riscv-notes`, a tracked symlink to the verified active CHERI notes
  successor; and
- `cheri-hypervisor-research`, a tracked symlink to the verified active XRV
  successor.

The former `cheri-riscv-notes-repo` and `xrv-research-repo` links are retired.
Active Project Manager tasking, cards, requests, runbook steps, registry,
inspection, and helper paths use the current names. Historical decisions,
closed and superseded requests, prior-turn narrative, component owner returns,
and append-only queue-ledger rows retain the names and paths recorded at the
time.

The responsible human's "update project and push" direction is applied
narrowly to the Project Manager and parent coordination repositories after
validation. It does not include either component repository; XRV component
backup remains separate open `PMR-075`.

## What this record does not decide

This record is coordination evidence. It does not authorize a component push
or grant source admission, research acceptance, approval, sign-off, licensing,
publication, release, formal verification, or hardware validation. CHERI
notes licensing/authorship/public-mirror/Pages gates remain open. XRV
documentation backup remains `PMR-075`, and all research-review requests keep
their existing owner and cross-repository-collaboration boundaries.

## Follow-up

- After Project Manager and parent validation and commits, run only the
  maintained human-owned coordination push step:
  `cd /home/jmorris/src/beryllium-project/project-manager && bash
  ./scripts/owner-actions.sh --only push_pm`; then verify both exact tips.

## Provenance

- Written by the `project-manager` agent from the inputs above.
