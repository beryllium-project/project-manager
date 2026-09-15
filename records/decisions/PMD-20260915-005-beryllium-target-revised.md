# Beryllium active target revised

- **Record ID:** `PMD-20260915-005`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** `PMD-20260914-003` disposition 10 and
  `PMD-20260915-001` disposition 9, for the Beryllium active repository
  identity only
- **Superseded by:** None

## Scope

Record the responsible human's revised private active GitHub target and
active branch for Beryllium after a manually completed push, without
mistaking the checked-out placeholder branch for the implementation or
changing any assurance gate. This touches `beryllium-repo` and its
Project Manager target mapping.

## Inputs

- Responsible-human statement: `"i have also pushed the beryllium repo to gh
  as beryllium-hypervisor"`.
- Guided responsible-human answers in this turn:
  `beryllium-project/beryllium-hypervisor`; `replace-target`; visibility
  `private`; active branch `beryllium/single-hart-runtime-r0`.
- `scripts/inspect-components.sh state beryllium-repo`, observed
  2026-09-15T20:40Z: the canonical local repository is dirty on `main` at
  `a7809db`, synchronized with `origin/main`, with untracked `build/` and
  `node_modules/`.
- `scripts/inspect-components.sh refs beryllium-repo a7809db 65f6d89`,
  observed 2026-09-15T20:41Z: local and `origin` refs include synchronized
  `main` at `a7809db` and synchronized
  `beryllium/single-hart-runtime-r0` at `65f6d89`; the preserved reference
  namespace `msft-downstream` contains the same observed branch tips.
- The checked-out `../beryllium-repo/README.md` at `a7809db` contains only
  `Hello`, and its `.github/copilot-instructions.md` describes an
  uninitialized project. The checked-out tree therefore does not expose the
  implementation handoff or maintained Beryllium workflow.

## Disposition

1. The intended private active Beryllium GitHub repository is revised from
   `agentic-os-research/beryllium` to
   `beryllium-project/beryllium-hypervisor`.
2. The intended active development branch remains
   `beryllium/single-hart-runtime-r0`, currently observed at `65f6d89`.
   Checked-out `main` at `a7809db` is a placeholder branch and is not the
   active Beryllium implementation line.
3. The responsible human reports the new private repository was manually
   pushed. Observed local remote-tracking refs corroborate a synchronized copy
   of the active branch and the listed historical branches. Complete
   owner-side history/default-branch verification and an updated component
   handoff remain required.
4. `PMR-043`, whose sentence names the superseded target, is superseded.
   `PMR-057` owns the remaining checkout, default-branch, history, remote,
   and handoff reconciliation.
5. The current workspace symlink and canonical local path do not change.
   The former Microsoft remote remains an inactive reference under the
   observed `msft-downstream` namespace.

## What this record does not decide

This record is coordination evidence. It does not grant implementation
authorization, exact-target acceptance, review approval, risk acceptance,
sign-off, licensing, redistribution, publication, release, formal
verification, or hardware validation. It does not switch branches, remove or
preserve the untracked working files, change a default branch, modify a
remote, retarget the workspace symlink, or authorize another push.

Beryllium remains accepted through R7. R8-H0 remains a committed candidate
and is not accepted; H1-H4 remain unauthorized; K3 hardware is `NOT RUN`.

## Follow-up

- Start the Beryllium owner in `../beryllium-repo`, preserve or disposition
  the current untracked artifacts under owner control, reconcile the checkout
  to `beryllium/single-hart-runtime-r0`, and complete `PMR-057` with an exact
  structured owner return before treating the rehome as complete.

## Provenance

- Written by the `project-manager` agent from the responsible human's exact
  statements and read-only sanitized component inspection. The Project
  Manager did not create, push, rename, transfer, clean, switch, or modify
  the Beryllium repository.
