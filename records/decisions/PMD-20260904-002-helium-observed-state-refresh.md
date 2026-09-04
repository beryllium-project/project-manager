# Helium observed-state refresh to e65c6a0 and Tier 7/8 refs recorded as component statements

- **Record ID:** `PMD-20260904-002`
- **Created:** 2026-09-04
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

How the Project Manager records the `helium-te-poc/` component after its
worktree moved from the dirty observation of 2026-09-04T12:29Z (43 entries at
`9af92cc`) to a clean observation at 2026-09-04T16:15Z, and how the Tier 7
and Tier 8 assurance references named in the component's own handoff are
carried in `../COMPONENTS.md`, `HANDOFF.md`, `components/helium-te-poc.md`,
and `records/assurance/helium-te-fv-pathfinder.md`. Observed with
`scripts/inspect-components.sh state helium-te-poc`: integration `direct`,
branch `helium-te-travel-fedora44`, HEAD
`e65c6a09b0164b4fffcbe7dfbede02094406b873`, worktree clean, upstream
`origin/helium-te-travel-fedora44` behind 0 / ahead 0.

## Inputs

- `scripts/inspect-components.sh registry-check` on 2026-09-04: the only
  drift is `helium-te-poc` (recorded `9af92cc`, live `e65c6a0`).
- `../helium-te-poc/HANDOFF.md` at `e65c6a0`, "Repository state": the
  component states that `helium-te-travel-fedora44` was created at exact base
  `3dc3aee` from `helium-te-fv-tier8-transaction` and lies outside the fixed
  Tier 8 H6 candidate `helium-te-fv-tier8-h6-candidate` at `ed15451` and the
  frozen Tier 8 H7 gate `helium-te-fv-tier8-h7-approved` at `85a6e55`; that
  the reviewed Tier 7 source is `helium-te-fv-tier7-h6-candidate` at
  `7ca97a9` with frozen Tier 7 H7 gate `helium-te-fv-tier7-h7-approved` at
  `342e04a`; that the frozen Tier 6 H7 gate `helium-te-fv-tier6-h7-approved`
  is `c594b7f` and the Tier 5 H7 gate `helium-te-fv-tier5-h7-approved` is
  `111cff2`; that `helium-te-fv` and `helium-te-h7-approved` remain at
  `d0cca32`; that `helium-te-fv-pre-relocation-wip` preserves the
  pre-transfer snapshot; and that the historical `local-history` tip
  `c8d1032` is absent and must not be recreated.
- The same file, Tier 8 section: the component reports for the exact combined
  candidate `ed15451` 18 successful CBMC checks, 152 named claims, 19,419
  successful properties, and 18 rejected mutations; it states that
  responsible-human H6 review and the human-created H7 gate-only commit
  (`85a6e55`) "are complete", that the H7 commit changes only
  `publication-gate.conf` with the candidate as sole parent, and that the
  approval "does not approve later maintenance-branch documentation or
  constitute publication". The Fedora 44 travel checkpoint reports native
  `./he check` and rootless `./he evaluate` passing for maintenance candidate
  `e83e99c`, with the travel gate still blocked.
- The same file, formal-verification status: selected fixed-profile C
  properties through the Tier 8 atomic capture-plus-pipeline transaction are
  machine-checked by CBMC; live CSR/frame/sentinel/root reads, policy/PTE
  queries, linker symbols, privileged effects, assembly, compiler, ISA,
  QEMU/hardware behavior, and noninterference remain outside the proof
  boundary; hardware validation is stated as not performed.
- `records/assurance/helium-te-fv-pathfinder.md` in this repository before
  this turn: a 2026-08-18 snapshot naming the development branch
  `helium-te-fv-tier7-capture-contract`, Tier 7 H6 candidate `7ca97a9` as an
  unreviewed candidate, and the frozen Tier 6 H7 gate `c594b7f`.

## Disposition

1. The `helium-te-poc/` row of `../COMPONENTS.md` is refreshed to clean
   `helium-te-travel-fedora44` at `e65c6a0`, synchronized with its upstream.
   The dirty state observed earlier the same day is retained in `HANDOFF.md`
   as history; nothing in the worktree was touched by the Project Manager.
2. The Tier 5, 6, 7, and 8 H6/H7 references, the travel base `3dc3aee`, the
   maintenance candidate `e83e99c`, and the preserved refs listed above are
   recorded in `../COMPONENTS.md`, `HANDOFF.md`, and
   `records/assurance/helium-te-fv-pathfinder.md` as statements made by the
   component in `../helium-te-poc/HANDOFF.md` at `e65c6a0`. The Project
   Manager has not reviewed any Tier 7 or Tier 8 gate content, has not
   verified that those branch refs exist or are frozen in the repository
   (the inspect script reports only the checked-out branch), and infers no
   approval from a branch name, a clean worktree, or a passing evaluator run.
   The frozen Tier 6 H7 gate `c594b7f` keeps the wording it already had in
   the registry from the 2026-08 review.
3. `records/assurance/helium-te-fv-pathfinder.md` gains a dated
   observed-statements section; its migrated 2026-08-18 content is kept
   unchanged, apart from a two-sentence pointer at the top of "Status", as
   the historical snapshot it already declares itself to be.
4. The Project Manager wording for Helium stays: a review-and-test proof of
   concept that is not formally verified and not hardware validated, with
   selected C properties machine-checked by CBMC only inside the component's
   stated source, property, and tool boundary.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not confirm, adopt, or dispute the component's statement
that Tier 7 and Tier 8 completed responsible-human H6 review and carry frozen
H7 gates; that statement belongs to the component and to the human who made
those commits. It does not approve the travel-maintenance lineage, whose gate
the component itself reports as blocked. Whether the named refs exist on the
component's remote remains unverified, and any push is the owner's decision.

## Follow-up

- In a later turn, extend `scripts/inspect-components.sh` with a read-only
  ref listing for a named component so the Project Manager can confirm that
  the refs named in `../helium-te-poc/HANDOFF.md` exist without running any
  command inside the component; until then, re-read
  `../helium-te-poc/HANDOFF.md` at each turn and record its statements.

## Provenance

- Written by the `project-manager` agent from the inputs above during the
  first coordination turn on 2026-09-04, from read-only inspection only; the
  Helium worktree was not modified, reset, cleaned, or reconciled.
