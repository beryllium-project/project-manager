# Security-reviewer component created from the Helium review contract and registered

- **Record ID:** `PMD-20260906-003`
- **Created:** 2026-09-06
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Records that a new independent, agent-owned component repository
`../security-reviewer/` exists in the Beryllium workspace, how it was
created, and how it is registered in the Project Manager and parent-root
artifacts. Touches `../security-reviewer/` (new; observed clean `main` at
`9ca5071b450eae39f63f7e31f61ad3e7009070e0`, initial commit, no remote),
`../helium-te-poc/` (read only; observed clean `helium-te-travel-fedora44` at
`9b3ff4e9441e5b4434a8ec37794dee1d941e11ef`, unchanged), `../threat-modeler/`
(read only; the structural model, read at `226d367`; observed clean `main` at
`dae994be` at 19:03Z, the owner's own commit of 2026-09-06, synchronized with
`origin/main`), this repository, and the parent root.

## Inputs

- The responsible human's request of 2026-09-06: "create a new agent for the
  project, security-reviewer, initially extracted from the agent-review
  artifacts & components in the helium-te-poc repo here. re-use as much of
  that as needed, and also extend as apprpopriate. this agent will be used
  for future security reviews in the project." The session that planned the
  work crashed (Node heap exhaustion, 18:21 local); this record is written by
  the recovery session that carried the plan out.
- `../helium-te-poc/agent-review/REVIEW-PROMPT.md`, `REVIEW-PROVENANCE.md`,
  `review-manifest.schema.json`, `review-manifest.template.json`,
  `../helium-te-poc/tests/lint-review-manifest.mjs`,
  `tests/test-review-manifest.mjs`, and the method and vocabulary sections of
  `../helium-te-poc/docs/review-remediation.md`, all at `9b3ff4e`: the
  independent-review prompt, the static-only versus execution-backed
  provenance contract, the manifest schema and dependency-free linter, and the
  cross-package synthesis method with its `P0`-`P3` and disposition
  vocabulary. Extraction sources only; nothing in Helium was changed.
- `../threat-modeler/` at `226d367`: the sibling structure that the new
  component mirrors (orchestrator, write-disabled specialists, skill,
  maintained scripts, templates, validator, generated index, outbox queue,
  contract suite).
- `../security-reviewer/AUTHORS.md`, `HANDOFF.md`, `README.md`,
  `AGENT-INTERFACE.md`, `contracts/REVIEW-PROVENANCE.md`, and
  `outbox/pm-queue.md` at `9ca5071`: the component's own statements of its
  derivation, boundaries, validation commands, package contract, and queue
  protocol. Its `tests/validate-agent.sh` reported `259 passed, 0 failed` and
  its linter tests `PASS (93 checks)` in the authoring session; that is the
  component's own observation, not a Project Manager validation.

## Disposition

1. **Component recognized.** `security-reviewer/` is an ignored canonical
   direct checkout, agent-owned, with the write boundary "own repository
   only". It is added to the parent `.gitignore`, `COMPONENTS.md` (backup and
   component tables), and `README.md`; to `AGENT-ROSTER.md`,
   `components/security-reviewer.md`, `scripts/inspect-components.sh`
   (`registered_direct`), `scripts/pull-queues.sh` (source
   `security-reviewer`, file `security-reviewer/outbox/pm-queue.md`, prefix
   `SRQ`, awaiting status `new`, the threat-modeler status mapping),
   `queue/README.md`, `tests/validate-agent.sh`, and the human-run
   `scripts/owner-actions.sh` (default `push_sr` once a remote exists; opt-in
   `--sr-backup` to create the private `beryllium-project/security-reviewer`
   and add remote `origin`; `security-reviewer` in `fetch_snapshot`).
2. **Execution boundary noted, not approved.** Unlike the threat-modeler, the
   component may run a target command, but only one the user approves by
   exact command text in the session, recorded as an `APPROVAL-NNN` record
   and run through its `scripts/run-approved-command.sh`, which refuses an
   unrecorded, non-`approved`, unregistered, or wrong-commit target and
   retains hashed evidence in the package. The Project Manager records this
   as the component's stated contract; it does not review or approve the
   script.
3. **Queue registered for pull; class-1 extension proposed, not granted.**
   `PMD-20260904-003` class 1 names two queue files. The Project Manager does
   not extend its own carry authority: every status edit due in
   `../security-reviewer/outbox/pm-queue.md` is handed to the human until the
   responsible human states that class 1 applies to that file. If granted, a
   superseding record will cite the confirmation. Until then
   `scripts/pull-queues.sh edits` still prints the edit; the human applies it.
4. **Class 3 applies as written.** The component's `AGENT-INTERFACE.md` and
   `RESEARCH-SOURCES.md` describe the Project Manager's role; class-3 wording
   carries are available there under the existing authority. Its `HANDOFF.md`
   at `9ca5071` names the Project Manager registration as pending; that
   sentence becomes stale with this record and is left to the component (a
   class-3 carry candidate for a later clean-worktree turn, not carried now).
5. **Requests raised.** `PMR-021` (P2): the component has no remote; the
   human decides and creates one (`--sr-backup`). `PMR-022` (P3): the
   analysis-workbook and threat-modeler owners decide whether to add
   `security-reviewer` to their `scripts/readonly-inspect.sh` registered
   target lists (owner-only scripts, request-only), alongside `PMR-004`.
6. **No engagement, no review claim.** No review or synthesis package exists.
   Nothing here is a security review of any component, and the future
   existence of a package will not be acceptance, approval, sign-off, or
   release.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not extend the standing carry authority (item 3 is a
proposal to the responsible human). It does not review the component's
scripts, prompt, or contract for correctness. Beryllium remains accepted
through R7; R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium remains a review-and-test proof
of concept, not formally verified or hardware validated. Open human gates:
the class-1 extension (item 3); the backup remote (`PMR-021`); the sibling
registrations (`PMR-022`).

## Follow-up

- Human: `cd project-manager && bash ./scripts/owner-actions.sh --plan`, then
  `bash ./scripts/owner-actions.sh --sr-backup` to create the private remote
  and push `security-reviewer` `main` (`PMR-021`), which also pushes this
  turn's `project-manager/` and parent commits.
- Human: say whether class 1 of `PMD-20260904-003` extends to
  `../security-reviewer/outbox/pm-queue.md` (item 3).
- Human, when a first review is wanted: `cd security-reviewer && copilot`,
  then `/agent security-reviewer`; the component's `HANDOFF.md` names a
  static-only first engagement against `helium-te-poc` at its exact clean
  commit as the suggested start.

## Provenance

- Written by the `project-manager` function in the recovery session of
  2026-09-06 from the inputs above; the component tree was authored in that
  session with GitHub Copilot CLI and committed inside `../security-reviewer/`
  as `9ca5071` with the Copilot co-author trailer. The only Git commands run
  against a component were inside the new `security-reviewer/` repository
  before it had an owner agent (init, add, commit); `helium-te-poc/` and
  `threat-modeler/` were read only.
