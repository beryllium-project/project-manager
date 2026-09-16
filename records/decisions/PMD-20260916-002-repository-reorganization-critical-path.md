# repository reorganization critical path

- **Record ID:** `PMD-20260916-002`
- **Created:** 2026-09-16
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Define the shortest completion path for the repository reorganization and
defer work that does not block the three remaining private successor
transitions. This record covers `PMR-044` (`osr-claude`), `PMR-045`
(`xrv-research-repo`), and `PMR-046` (`cheri-riscv-notes-repo`). It changes
no component, repository, remote, symlink, visibility, or publication state.

Observed state on 2026-09-16: parent coordination repository clean at
`6d6aaca`; Project Manager clean at `2f8d576`; OS-security clean and
synchronized at `e275544`; XRV clean at `d618935`, one ahead of
`backup/main`; and CHERI-RISC-V notes clean on
`docs/reconcile-project-status` at synchronized `ae09213`, with `main` at
`6553092`. Generated Project Manager tasking was stale at Project Manager
source `659bac0` and must be regenerated from the containing commit before an
owner session begins.

## Inputs

- The responsible human selected the narrow finish line: the reorganization
  is complete when `PMR-044`, `PMR-045`, and `PMR-046` have verified owner
  returns and reconciled coordination state. Other open work may wait.
- The responsible human selected three isolated owner lanes in parallel.
- The responsible human selected a clean active OS-security snapshot that
  excludes `sources/restricted-microsoft/`; the complete old private
  repository remains an inactive historical reference.
- The responsible human selected a common remote policy: each verified new
  successor becomes `origin` and its active upstream, while old homes remain
  under explicit inactive-reference remote names. No workspace symlink moves
  in these lanes.
- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
  at `2f8d576`: approved target identities and independent repository model.
- `records/decisions/PMD-20260915-001-close-d0-owner-inventory.md` at
  `2f8d576`: complete bounded owner inventory, private-by-default successors,
  personal clean-history quarantine, and hosted state to preserve.
- `records/decisions/PMD-20260915-003-organization-rename-completed.md` at
  `2f8d576`: the organization rename is complete and no longer blocks the
  three requests.
- `outbox/component-requests.md` at `2f8d576`: `PMR-044`, `PMR-045`, and
  `PMR-046` are open and owner-actionable.
- `../osr-claude/HANDOFF.md` at `e275544`,
  `../xrv-research-repo/HANDOFF.md` at `d618935`, and
  `../cheri-riscv-notes-repo/meta/handoff.md` at `ae09213`: owner boundaries,
  preserved state, and return surfaces.
- `scripts/inspect-components.sh status`, `components`, `symlinks`, and
  `registry-check` at 2026-09-16T07:48Z: all three target components are
  clean; tracked symlinks resolve unchanged; only the expected Project Manager
  registry revision is stale.

## Disposition

1. **Finish line.** `PMR-044`, `PMR-045`, and `PMR-046` are the only P1
   reorganization requests. Completion requires verified structured owner
   returns, exact registry/handoff reconciliation, and passing Project Manager
   validation. Repository names or conversational reports alone are
   insufficient.
2. **Scope freeze.** Tasking-startup adoption, the planned Git-maintainer,
   source acquisition and triage, research review, general cleanup, symlink
   relocation, publication, Pages, release, and unrelated owner requests are
   deferred unless one becomes a demonstrated hard blocker for a P1 lane.
3. **Parallel ownership.** The three owner lanes may run concurrently because
   they use separate repositories. Each lane still requires a clean worktree,
   no active conflicting session, its own local instructions, and a structured
   return. A blocked lane does not stop the other two.
4. **OS-security history.** The active private
   `agentic-os-research/os-security-research` successor starts from a clean
   snapshot of the reviewed non-restricted tree. Its reachable history must
   contain no `sources/restricted-microsoft/` content. The complete old private
   repository remains an inactive historical reference. The separate personal
   private `os-security-restricted-sources` repository starts with clean new
   history; only the responsible human reviews and copies selected restricted
   files with applicable license metadata.
5. **Remote policy.** After verification, each new private successor becomes
   the component's `origin` and active upstream. Existing homes remain
   explicit inactive-reference remotes. No force push, destructive history
   rewrite, implicit remote replacement, workspace relocation, or tracked
   symlink retarget is part of these lanes.
6. **Preservation.** XRV preserves its owner-controlled history through
   `d618935`, including durable `REV-*` records and `COLLAB.md`.
   CHERI-RISC-V notes preserves `main`, `docs/reconcile-project-status`,
   required refs, the checked-in Wiki source, and hosted issues 2 and 3.
   Publication and corpus-admission gates do not change.
7. **Task discovery.** `PMR-070`, `PMR-071`, and `PMR-072` are not
   prerequisites. Until those owner entry points adopt the natural-language
   mapping, the human explicitly approves and invokes the exact read-only
   resolver from each logical workspace entry. Missing or stale tasking still
   fails closed.
8. **Operation gates.** This record is planning and prioritization, not
   external-operation authorization. Repository creation, remote changes,
   pushes, and the restricted-file transfer require explicit
   repository-specific responsible-human confirmation in the same owner turn.
9. **Convergence.** After all lanes stop writing, the Project Manager verifies
   every returned commit, path, validation result, branch, remote, visibility,
   backup state, hosted-state result, and active-session statement. It closes
   only requests whose evidence matches, then performs one reconciliation and
   validation turn.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, hardware validation, repository creation, remote change, push,
restricted-file transfer, or visibility change. Each external operation
remains a same-turn responsible-human gate. Beryllium remains accepted through
R7; R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium remains a review-and-test proof
of concept and is not formally verified or hardware validated.

## Follow-up

- Commit and regenerate the Project Manager tasking baseline, then use the
  three exact owner-session launch packets in `outbox/OWNER-RUNBOOK.md`.

## Provenance

- Written by the `project-manager` agent from the inputs and structured
  responsible-human choices above. No component was modified, no restricted
  material was accessed, and no external repository operation was performed.
