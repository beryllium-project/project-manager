# security-reviewer GitHub repository replacement

- **Record ID:** `PMD-20261110-002`
- **Created:** 2026-11-10
- **Status:** recorded
- **Supersedes:** `PMD-20261108-002` (only its GitHub Support request and
  the timing of the return to public)
- **Superseded by:** None

## Scope

Record the responsible human's choice to remove the replaced
security-reviewer commits from GitHub by deleting and recreating
`beryllium-project/security-reviewer` from the repaired local clone,
instead of asking GitHub Support for a garbage collection, and set the
order of the human-run steps. Touches only Project Manager artifacts and
the private parent `../.publication-gate/P0-20261108-001.md`; no component
is written.

Observed when recorded (maintained read-only inspection, 2026-11-10T09:02Z,
on `lx2`): `../security-reviewer` clean on `main` at
`8055becd9b785ffa8bf389b15eb5adbafaf86036`, 0/0 with last-fetched
`origin/main`, no tags; the gate's `audit --all-refs` of the local clone
passes (3 refs, 268 items).

## Inputs

- Responsible-human question, exactly: `"can we delete and recreate
  security-reviewer on gh ?"` (about 08:56Z), then structured answers
  `check_first`, and, after running the read-only `gh` listings,
  `result=all_empty` (no issues, pull requests, or releases; stars and
  watchers do not matter) and `choice=replace` (about 09:01Z).
- `PMD-20261108-002` (temporary private containment; replacement named as
  the fallback if Support declines) and private note step 7.
- `PMD-20261108-001` (publication gate; a recorded public repository that
  cannot be read anonymously is scanned as public).

## Disposition

1. The GitHub repository `beryllium-project/security-reviewer` is replaced:
   the responsible human deletes it and creates a new **private**
   repository with the same name, then pushes only local `main` at
   `8055bec` from the existing clone. The clone's `origin` URL is
   unchanged, so no `git remote` change is needed. The GitHub Support
   request is no longer needed.
2. Order: delete; create private; push `main` (the installed gate scans it
   as public); `git fetch --prune --tags origin`; the Project Manager runs
   the gate's `audit --all-refs` of the clone; only after that passes, the
   human's `gh repo edit ... --visibility public` returns it to public; the
   Project Manager then confirms the live view with `audit --remote origin`.
3. Accepted losses, by the human's answer: stars, watchers, and repository
   settings; there are no issues, pull requests, or releases. GitHub may
   keep the deleted repository restorable by organization owners for a
   period; it is not publicly visible. Copies taken outside GitHub while
   the repository was public are beyond either option.
4. The P0 hold's security-reviewer clause stays until `PMR-140` lifts it
   with `PMR-139`; the replacement push and visibility change are the
   human's own commands under this record, each passing the gate. `PMR-141`
   and `PMR-151` are unaffected.

## What this record does not decide

This record is coordination evidence. It grants no acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation; passing the gate is not publication approval. The Project
Manager runs no `gh repo delete`, `gh repo create`, push, or visibility
change for this component. It does not change `PMR-139`, `PMR-140`, or the
P0 hold.

## Follow-up

- The responsible human runs the steps in `outbox/OWNER-RUNBOOK.md`
  "P1 security-reviewer repository replacement" and says `done`.

## Provenance

- Written by the `project-manager` agent from the responsible-human answers
  and the maintained read-only inspection above.
