# Owner edits by the human-run helper, and request priorities

- **Record ID:** `PMD-20260906-001`
- **Created:** 2026-09-06
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Two coordination questions raised by the responsible human on 2026-09-06
after running `scripts/owner-actions.sh` with the two opt-in backup flags:
how the remaining owner-side items that the Project Manager cannot carry
(`PMR-002`, `PMR-003`, `PMR-004`, `PMR-009`, `PMR-014`, `PMR-019`, the lost
retained PM artifacts) are turned into exact, largely automated steps, and how
open items are prioritised so the human can act on the most important first.
This record touches only Project Manager artifacts: `scripts/owner-actions.sh`,
`outbox/component-requests.md` (new `Priority` column), `outbox/OWNER-RUNBOOK.md`
(new), `outbox/owner-edits/` (new), `templates/request-row.md`,
`scripts/validate-pm.sh`, `tests/validate-agent.sh`, and the documents that
describe the helper. Component revisions observed when it was written, all
clean: `analysis-workbook` `ff12f2f`, `osr-claude` `f2edd17`,
`formal-verification-research` `8246147` (now tracking its new `backup/main`),
`beryllium-repo` `65f6d89`, `helium-te-poc` `f0d96b1`, `threat-modeler`
`226d367`, `cheri-riscv-notes-repo` `6553092`, `xrv-research-repo` `7314e2f`.
No component file is changed by this record.

## Inputs

- The responsible human, 2026-09-06, quoted verbatim: "provide clear,
  specific instructions for [the script's "Still yours" list] ... I need this
  more automated" and "also, add a priority field to each item requiring
  attention / todo etc., so we can triage and act on the higest priority items
  quickly, then work on other high priority tasks generally, before tackling
  low-priority issues". In the `ask_user` form that followed the human chose
  `edits_scope=apply_excl_beryllium` ("Add opt-in --apply-edits for PMR-019
  (workbook mirror), PMR-002 (osr-claude), PMR-014 wording (FVR); PMR-003 in
  beryllium-repo stays a pasted command - recommended"), `files_step=true`
  (opt-in `--files-search` for the lost retained PM artifacts), and
  `pmr014_pointers=later` ("Decide per pointer later; the runbook lists them").
- `records/decisions/PMD-20260904-003-standing-carry-authority.md`: the
  Project Manager's own writes inside components are limited to three classes
  and never touch `helium-te-poc/` or `beryllium-repo`; every other request is
  carried by the human.
- `records/decisions/PMD-20260905-001-helium-transfer-queue-consumption.md`:
  the transfer queue is never edited by the Project Manager.
- `../analysis-workbook/AGENT-INTERFACE.md` at `ff12f2f`: the maintainer runs
  `scripts/validate-helium-transfer-queue.sh` (`--baseline` when a prior
  revision exists) before recording or mirroring a change.
- `../osr-claude/HANDOFF.md` at `f2edd17` "Infrastructure facts" (an HTTPS
  remote statement and a pending `mktemp` fix) against `tools/md-to-html.sh`
  at the same commit (`mktemp -t md-to-html.XXXXXX`) and the registry's
  observation that `origin` is reached over SSH.
- `../formal-verification-research/.github/copilot-instructions.md` and
  `README.md` at `8246147` against `COLLAB.md` at `ccb48f6` (`PMR-014`).
- `../beryllium-repo/planning/HANDOFF.md` at `65f6d89` (`PMR-003`) and the
  read-only `scripts/inspect-components.sh refs beryllium-repo 102f2b0`
  result: `102f2b0` ("r8: add bounded H0 profile freeze") exists on
  `beryllium/single-hart-runtime-r0` and on its remote-tracking branch.
- `../cheri-riscv-notes-repo/meta/handoff.md` at `6553092`: the reference
  corpus is a SQLite `refs` table in a Copilot session on another machine;
  `references/` exports are generated; gate D4 (`PMR-009`).

## Disposition

1. **Human-run edits.** `scripts/owner-actions.sh` gains the opt-in step
   `apply_edits` (`--apply-edits`). For each open request whose exact edit is
   recorded in `outbox/owner-edits/` it shows the diff, runs the component's
   own validator where one exists (the analysis-workbook transfer-queue
   validator with the current file as baseline), asks `y/N`, and on `y`
   commits inside the component with the request identifier in the subject
   and the Copilot co-author trailer. It refuses a dirty worktree, a file
   whose current text no longer matches the recorded text, and a failed
   precondition (for `PMR-002`: `origin` is an SSH remote and the `mktemp`
   fix is present). The recorded set is `PMR-019` (analysis-workbook; the
   appended rows are dated the day of application through an `@DATE@` token,
   and their text is based on, not identical to, the rows in
   `PMD-20260905-002`: the locators add the Project Manager commit `94888ea`),
   `PMR-002` (osr-claude), and the wording half of `PMR-014`
   (formal-verification-research: the agent-instruction bullet and both
   "Workspace relationship" sentences that describe the Project Manager;
   the request stays open for the five pointers). It never includes `helium-te-poc/` or
   `beryllium-repo`; the script dies if asked. Every such commit is the
   responsible human's, made under that component's rules with the diff in
   front of them; the Project Manager agent still writes inside a component
   only under `PMD-20260904-003` and never runs the script. The request text
   lives in `outbox/owner-edits/` so that the script carries no request
   wording and no repository URL.
2. **`PMR-003` stays a pasted command.** `beryllium-repo` remains outside every
   Project Manager tool; `outbox/OWNER-RUNBOOK.md` gives the exact
   replacement, computed against the checkout's own path at run time, for the
   human to paste and review. The wording keeps H0 not reviewed, blocked, and
   not accepted.
3. **Lost retained PM artifacts.** The opt-in step `files_search`
   (`--files-search`, `--files-root DIR`) performs a read-only search for the
   seven recorded names and a SHA-256 comparison for the archive; only when
   nothing is found does it offer to remove the broken parent `files` link,
   on `y`. The decision (record the loss, or a found location) is still the
   human's and is recorded by the next coordination turn from the log and the
   human's statement.
4. **Default pushes.** `push_osr` (osr-claude `main -> origin`) joins the
   default targets so that a `PMR-002` commit is backed up; `push_fvr` runs by
   default once the `backup` remote exists (creating it still needs
   `--fvr-backup`); `push_xrv` also pushes `main -> backup` once the owner adds
   a remote of that name (`PMR-013`).
5. **Priority field.** `outbox/component-requests.md` gains a `Priority`
   column after `Status`: `P1` act now (data-loss exposure, or blocks other
   work); `P2` next (unblocks coordination or another decision); `P3`
   housekeeping, when next working in that component; `P4` waits on an
   external input, another machine, or a gate that is not actionable now; `-`
   for closed, withdrawn, and superseded rows. `scripts/validate-pm.sh`
   enforces the vocabulary and that only open rows carry a priority;
   `tests/validate-agent.sh` covers both failures. The Project Manager
   proposes the value when it raises a request; the human may change any
   value, and the Project Manager records the change. `outbox/OWNER-RUNBOOK.md`
   orders every open item by priority with exact steps, and the script prints
   the open requests by priority at the end of every run instead of a
   hard-coded list (which had gone stale: it still named the closed
   `PMR-016`). The `../HANDOFF.md` blockers table carries the same values.
6. **Initial values** set by the Project Manager on 2026-09-06: `PMR-013` P1
   (`7314e2f` exists only on this workstation); `PMR-003` P2 (a former
   workstation path in an agent-read handoff invites the checkout-recovery
   incident that `../SOT.md` rule 3 forbids), `PMR-019` P2, `PMR-020` P2
   (unknown live backup state); `PMR-002`, `PMR-004`, `PMR-014` P3;
   `PMR-009` P4 (another machine, gate D4). Non-request items: the retained
   artifacts decision P2; the two H0 input selections P3 (their inputs are
   in the artifacts decision); H0 acceptance, H1-H4, and K3 P4.

Alternatives considered: a runbook only, with no scripted edits (offered;
the human chose the scripted set); including `beryllium-repo` in the scripted
edits (offered as `apply_all`; not chosen, keeping the carry-ineligible
components outside every Project Manager tool); a separate priority file
(rejected: the request table is already the single list of open requests, and
the validator can check one column).

## What this record does not decide

This record is coordination evidence. It widens no Project Manager write
authority: the agent's own writes inside components stay within
`PMD-20260904-003`, and `helium-te-poc/` and `beryllium-repo` stay outside
every Project Manager write and tool. It does not decide any owner-side
disposition: whether `HET-001` is mirrored to `recorded` or stops at
`routed`, whether the five routed pointers are kept, moved, or removed,
whether the `PMQ-008`/`PMQ-011` pointers enter the CHERI corpus, which remote
xrv-research-repo uses, how cheri-riscv-notes-repo authenticates, and whether
the retained artifacts are declared lost are all the human's or the owner's,
recorded afterwards from evidence. It grants no acceptance, review, approval,
sign-off, risk acceptance, licensing, redistribution, publication, release,
formal verification, or hardware validation. Beryllium is accepted through
R7; R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium remains a review-and-test proof
of concept, not formally verified or hardware validated. Pushing any
repository remains the owner's or the human's action.

## Follow-up

- Human: `bash ./scripts/owner-actions.sh --plan --apply-edits --files-search`
  from `project-manager/`, then the same without `--plan`; then the items the
  script cannot do, in the runbook's order (`PMR-013`, `PMR-003`, `PMR-020`).
- Next coordination turn: close each request whose commit or remote state is
  observed; remove the corresponding `outbox/owner-edits/` set; refresh the
  runbook and the priorities; record the retained-artifacts decision from the
  log and the human's statement.

## Provenance

- Written by the `project-manager` agent on 2026-09-06 from the inputs above,
  after the human's two messages and one `ask_user` form quoted in "Inputs".
  The two text-replacement functions of the new script step were copied into
  a throwaway shell library, sourced in a scratch directory, and exercised
  there against temporary copies of the component files; the scratch
  directory was deleted, and `scripts/owner-actions.sh` itself was not run in
  any mode. One execution-boundary deviation is disclosed: the agent ran `../analysis-workbook/scripts/validate-helium-transfer-queue.sh`
  once against a temporary copy to check that the recorded `PMR-019` edit
  passes the component's validator; the component was not modified. That
  validation belongs to the human-run step, and the agent should not repeat
  it. No component file was modified; no Git command was run inside a
  component.
