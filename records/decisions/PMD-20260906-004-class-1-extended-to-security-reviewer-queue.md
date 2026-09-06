# Class 1 of the standing carry authority extended to the security-reviewer queue

- **Record ID:** `PMD-20260906-004`
- **Created:** 2026-09-06
- **Status:** recorded
- **Supersedes:** None (extends class 1 of `PMD-20260904-003`; resolves
  item 3 of `PMD-20260906-003`)
- **Superseded by:** None

## Scope

Extends the file list of class 1 (queue status edits) of the standing carry
authority `PMD-20260904-003-standing-carry-authority.md` to the new
component's queue `../security-reviewer/outbox/pm-queue.md`. Touches
`../security-reviewer/` (observed clean `main` at
`9ca5071b450eae39f63f7e31f61ad3e7009070e0`, no remote) and this repository.
Nothing else in `PMD-20260904-003` changes: its conditions, prohibitions,
commit form, and the carry-ineligible components (`helium-te-poc/`,
`beryllium-repo`) stand.

## Inputs

- `PMD-20260906-003` item 3, which registered the queue for ledger-first pull
  and proposed, without granting, that class 1 apply to it, handing every
  printed status edit to the human until the responsible human decided.
- The responsible human's decision in the Project Manager session of
  2026-09-06 (20:39 local), in answer to the handoff question "does class 1
  of the standing carry authority extend to
  `../security-reviewer/outbox/pm-queue.md`?": "re open gate: yes".
- `../security-reviewer/outbox/pm-queue.md` and `AGENT-INTERFACE.md` at
  `9ca5071`: the component states that the Project Manager owns every status
  after `new` (`acknowledged`, `routed`, `integrated`, `declined`), edits only
  the `Status` and `Project Manager note` columns, and does so as a carried
  class-1 write; rows are never removed or renumbered.
- `scripts/pull-queues.sh` at this repository's `6682138`: source
  `security-reviewer` (prefix `SRQ`, awaiting status `new`) with the same PM
  status mapping as the threat-modeler queue (`routed` -> `routed`,
  `accepted` -> `integrated`, `duplicate`/`rejected` -> `declined`,
  `deferred` -> `acknowledged`).

## Disposition

1. Class 1 of `PMD-20260904-003` now reads, for its file list:
   `../analysis-workbook/outbox/pm-queue.md`,
   `../threat-modeler/outbox/pm-queue.md`, and
   `../security-reviewer/outbox/pm-queue.md`. The Project Manager applies, in
   the third file, exactly the status-column edits that
   `scripts/pull-queues.sh edits` prints for ledger rows with a final
   disposition, then records `yes YYYY-MM-DD` under "Source status applied"
   in `queue/LEDGER.md`, under every condition of `PMD-20260904-003` (a
   same-turn clean-worktree observation with no other session active, the
   component's local instructions read in that turn, only the queue file
   changed, a reviewed diff, a commit inside the component whose subject
   names the `PML` identifiers, with the Copilot co-author trailer).
2. The component's `Project Manager note` column is written only together
   with a status edit and only with the ledger's one-sentence note; nothing
   else in that file is written by the Project Manager. `owner-action` rows
   are routed by `PMR-NNN` like `source` rows; routing is never acceptance,
   implementation, or approval of the recommended action, which stays with
   the target owner.
3. The interim handling of `PMD-20260906-003` item 3 (edits handed to the
   human) ends with this record. No edit was due in the interval; the queue
   is empty at `9ca5071`.
4. The remaining Project Manager statements that described the extension as
   pending (`queue/README.md`, `AGENT-INTERFACE.md`,
   `.github/copilot-instructions.md`, `components/security-reviewer.md`,
   `scripts/pull-queues.sh` comment, `outbox/OWNER-RUNBOOK.md`, `HANDOFF.md`,
   and the `security-reviewer/` row of `../COMPONENTS.md`) are corrected in
   the same turn. `PMD-20260904-003` and `PMD-20260906-003` are not edited;
   this record is the authority for the third file.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not add any other class, file, or component to the
standing carry authority, does not make `security-reviewer/` scripts, tests,
templates, contracts, packages, or `HANDOFF.md` carry-eligible beyond class 3
where that text describes the Project Manager's role, and does not change the
carry-ineligible status of `helium-te-poc/` and `beryllium-repo`. Beryllium
remains accepted through R7; R8-H0 is a committed candidate and is not
accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium remains
a review-and-test proof of concept, not formally verified or hardware
validated. Open human gates unchanged by this record: `PMR-021` (the
component's backup remote), `PMR-022` (sibling target registration), and the
push of this turn's local commits.

## Follow-up

- When `bash ./scripts/pull-queues.sh list` first shows an `SRQ-NNN` row:
  add a `PML-NNNN` row, route it with a `PMR-NNN`, and, on its final
  disposition, carry the printed edit into
  `../security-reviewer/outbox/pm-queue.md` under Phase 4b of the skill.

## Provenance

- Written by the `project-manager` function in the recovery session of
  2026-09-06 from the inputs above; the responsible human's words are quoted
  verbatim. No component was written by this record; the queue file is
  unchanged at `9ca5071`.
