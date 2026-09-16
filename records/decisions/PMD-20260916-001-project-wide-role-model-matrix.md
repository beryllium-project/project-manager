# Project-wide role-to-model matrix

- **Record ID:** `PMD-20260916-001`
- **Created:** 2026-09-16
- **Status:** recorded
- **Supersedes:** `PMD-20260915-007` in part (extends it; supersedes only
  its statement that the orchestrator model was unchanged; its Fable-to-Opus
  review substitution is retained as row 2 of the matrix below)
- **Superseded by:** None

## Scope

Record the responsible human's project-wide model assignment by role,
covering the Project Manager orchestrator itself, Project Manager
delegations, and every active registered component agent profile. This
record touches Project Manager configuration directly and creates owner
tasking for `security-reviewer`. Observed component revisions at writing:
`security-reviewer` clean `main` at `f2051a4`, synchronized with private
`origin/main`; `analysis-workbook` `c7cc0fa`; `threat-modeler` `c4126b6`;
`provenance-review` `9bfbab3`; `project-manager` `c5307f5`.

## Inputs

- Responsible-human direction in the 2026-09-16 (UTC) Project Manager
  session: `"this agent should now use gpt-5.6-spol max effort 1.1m context
  for planning, coding etc. and opus 5 max effort max context for review/eval
  iteration. use got-5.3 codex max context max effort for deep security
  review, remember this across the project unless otherwise specified
  later"`. The Project Manager read `gpt-5.6-spol` as `gpt-5.6-sol`,
  `got-5.3 codex` as `gpt-5.3-codex`, and `1.1m context` / `max context` as
  context tier `long_context`; the human confirmed this reading in the same
  turn through the structured question below.
- Structured `ask_user` question on the `security-reviewer` mapping
  (`PMD-20260915-002` intake): the human selected `all_codex`, "All four
  security-reviewer profiles -> gpt-5.3-codex", over the recommended split,
  keep-Opus, and defer options.
- `records/decisions/PMD-20260915-007-project-wide-review-model-preference.md`:
  the review/evaluation substitution and its inventory of active profiles.
- `.github/agents/project-manager.agent.md` at `c5307f5`: pins
  `claude-fable-5.1` for the coordination orchestrator.
- `.github/agents/pm-auditor.agent.md` at `c5307f5`: `claude-opus-5`, with
  `max` / `long_context` supplied at invocation.
- `../security-reviewer/.github/agents/security-reviewer.agent.md`,
  `security-evidence.agent.md`, `security-research.agent.md`, and
  `security-finding-review.agent.md` at `f2051a4`: all pin `claude-opus-5`
  and `tests/validate-agent.sh` asserts it (owner return closing `PMR-062`).
- `PMD-20260915-007` inventory: threat-model, provenance, and analysis roles
  already use `gpt-5.6-sol`; Helium and Beryllium have no custom agent
  profile; formal-verification-research, XRV, and CHERI-RISC-V notes have no
  custom agent profiles; OS-security has a Claude skill without a model pin.

## Disposition

1. Project-wide, active agent roles use the following matrix unless the
   responsible human explicitly specifies otherwise for a named task:

   | Role | Model | Reasoning effort | Context tier |
   | --- | --- | --- | --- |
   | Planning, coding, coordination, orchestration, maintenance | `gpt-5.6-sol` | `max` | `long_context` |
   | Review, evaluation, audit, iteration on findings | `claude-opus-5` | `max` | `long_context` |
   | Deep or adversarial security review | `gpt-5.3-codex` | `max` | `long_context` |

2. The `project-manager` orchestrator is a planning/coordination role and
   moves from `claude-fable-5.1` to `gpt-5.6-sol`. This supersedes the
   `PMD-20260915-007` statement that the orchestrator model was unchanged.
3. `pm-auditor` remains `claude-opus-5` with `max` / `long_context`
   (review/audit row). Claude Fable 5.1 is no longer a default in any active
   project role; the human may select it explicitly for a later task.
4. Per the human's `all_codex` selection, all four `security-reviewer`
   profiles (`security-reviewer`, `security-evidence`, `security-research`,
   `security-finding-review`) move to `gpt-5.3-codex` with `max` /
   `long_context`. This is owner action `PMR-074`; the Project Manager does
   not edit component agent definitions, tests, or instructions.
5. Existing `gpt-5.6-sol` assignments in analysis, threat-model, and
   provenance roles already satisfy row 1 and are unchanged. Components with
   no model pin are not asked to add one by this record.
6. Historical package directory names, model records, reports, review
   manifests, and provenance remain immutable and are not renamed.
7. An already launched task is not restarted merely to apply the matrix.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize a security-review engagement, change review
scope, rewrite historical provenance, or change component write boundaries.
The Beryllium runtime remains accepted through R7 only; R8-H0 is a committed
candidate and is not accepted; H1-H4 are not authorized; K3 hardware is
`NOT RUN`. Whether a given future security task counts as "deep or
adversarial" is decided by the responsible human when tasking it, not
inferred by the Project Manager.

## Follow-up

- Complete `PMR-074` in `security-reviewer` before its next engagement, then
  return the exact component commit, validation results, and backup state in
  `../security-reviewer/HANDOFF.md` per `PMD-20260914-002`.
- Human-side runtime `/subagents` preferences are outside this repository;
  the human aligns them to the matrix if they differ.

## Provenance

- Written by the `project-manager` agent from the responsible human's exact
  direction, the same-turn structured intake answer, and a read-only
  inventory of active registered agent profiles.
