# P0 hold lifted after the Beryllium release

- **Record ID:** `PMD-20261110-003`
- **Created:** 2026-11-10
- **Status:** recorded
- **Supersedes:** `PMD-20261108-001` (only its hold, which ends here);
  `PMD-20261108-004` (fulfilled)
- **Superseded by:** None

## Scope

Close P0 `PMR-139` and `PMR-140`, lift the P0 publication-safety hold, and
route the remaining clean-up of the private internal Beryllium copies as a
P2 follow-up, after the Beryllium release and the deletion of the public
review snapshot. Touches only Project Manager artifacts, the parent
`COMPONENTS.md`, and the private parent note; no component is written.

Observed (2026-11-10T22:59Z to 23:10Z, on `lx2`; maintained `state` and
`refs`, the gate's read-only `classify` and `audit`):

- `../beryllium-hypervisor` clean on local `beryllium/mvp-s3d-plan` at
  `d56fa1a334ebf016467e3c901fc5f8ee12833ac3` (equal to
  `beryllium/mvp-release-step-6`); internal `main` unchanged at `c7be2498`,
  0/0 with private `origin`. Its `planning/HANDOFF.md` at `d56fa1a`
  records MVP 1.0 published at tag `mvp-1.0` (tag object `423014a7`; the
  responsible human's own action, not a Project Manager approval), the
  review snapshot deleted from the public repository (the human's reply
  `snapshot deletion done`), and public refs `main` (`a0d0b78b`),
  `cheri-platform` (`3265fcf8`), and `mvp-1.0` only.
- The gate classifies `beryllium-project/beryllium-hypervisor` public and
  `beryllium-project/beryllium-hypervisor-internal` private.
- `audit --remote origin` of the live public view: PASS (5 live refs,
  5,755 items).
- `audit --all-refs`: PASS for publication clones
  `../beryllium-hypervisor-public` (13 refs, 6,148 items) and
  `../beryllium-hypervisor-rc3` (6 refs, 3,717 items), both of which hold
  the deleted snapshot commit `5391bc30` and tag object `8d120ce3` that
  GitHub still serves by ID; BLOCKED for the private canonical checkout
  (499 findings, 195 refs) and the push-disabled
  `../beryllium-hypervisor-release` (463 findings, 110 refs).

## Inputs

- Responsible-human statement, exactly: `"beryllium-hypervisor session
  says done"` (2026-11-10T22:59Z, 23:59 at UTC+1), and structured answer
  `close_and_followup` (about 23:10Z).
- `PMD-20261108-001` (gate, P0, hold), `PMD-20261108-004` (release
  outside the hold), `PMD-20261110-001` (gate installed on `lx2`).

## Disposition

1. `PMR-139` closes: the public review-snapshot path no longer exists,
   and the live public repository and every local copy of the deleted
   snapshot pass the gate.
2. `PMR-140` closes with it: the gate is installed on `l1` and `lx2`, and
   `PMR-138` and `PMR-139` are closed.
3. The P0 hold ends: security-reviewer pushes, a Beryllium merge of an
   internal branch into `main`, and any public Beryllium push are no
   longer held by the Project Manager. Every public push still passes the
   installed gate and needs its own decision.
4. P2 `PMR-157` asks the Beryllium owner to remove the denylisted entries
   from the private internal copies (the embedded entry in the internal
   `release/release.py`, the planning pages and site configuration, and
   the page whose file name carries an entry) before any of that content
   is published, rewriting unpushed commits where needed, and to decide
   the disposal of the two push-disabled gate-run clones the private note
   names (carried over from `PMR-139` item 4). The gate remains the
   backstop.
5. The Beryllium session reported `done`, but its owner record says S3-D
   planning continues there; it stays a coordination lock, and
   `PMR-157`/`PMR-143` go to that session or a later one.

## What this record does not decide

It grants no release, publication, acceptance, approval, sign-off,
licensing, formal verification, or hardware validation; passing the gate
is not publication approval. It does not push, delete, or rewrite
anything, decide the Beryllium announcement, the CHERI work, the
remaining GitHub cache of the deleted snapshot objects, or the local
snapshot clones. Every other gate stays as recorded.

## Follow-up

- A Beryllium owner session takes `PMR-157` with `PMR-143` (gate
  adoption) when the responsible human chooses.

## Provenance

- Written by the `project-manager` agent from the statements and the
  read-only inspection above.
