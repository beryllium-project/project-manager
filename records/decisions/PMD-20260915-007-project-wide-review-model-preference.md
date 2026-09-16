# Project-wide review and evaluation model preference

- **Record ID:** `PMD-20260915-007`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** `PMD-20260915-006`
- **Superseded by:** `PMD-20260916-001` (in part: the orchestrator-model
  statement only; the review/evaluation substitution is retained)

## Scope

Extend the responsible human's model preference from Project Manager
delegations to every active project review/evaluation role that currently
uses Claude Fable 5.1. Preserve active non-Fable model assignments and
historical artifact names. This touches Project Manager configuration and
creates owner tasking for `security-reviewer`.

## Inputs

- Responsible-human direction in the 2026-09-15 Project Manager session:
  `"also, project-wide, substitute Opus 5 for Fable 5.1 in review/eval
  roles, to save costs. I will specify Fable 5.1 later as needed."`
- `records/decisions/PMD-20260915-006-review-evaluation-model-preference.md`:
  the earlier Project Manager-only future default.
- Project Manager `pm-auditor` configuration at `5f68f0c`: already
  `claude-opus-5`; reasoning `max` and context `long_context` are recorded.
- Read-only active-agent inventory on 2026-09-15:
  - `../security-reviewer/.github/agents/security-reviewer.agent.md`;
  - `security-evidence.agent.md`;
  - `security-research.agent.md`; and
  - `security-finding-review.agent.md`
  all pin `claude-fable-5.1` at component commit `79c664f`.
- The same inventory found no other active Fable 5.1 review/evaluation
  profile: threat-model review roles and provenance-review roles use
  `gpt-5.6-sol`; analysis roles use `gpt-5.6-sol`; Helium and Beryllium have
  no user-invocable custom agent profile.
- Formal-verification-research, XRV, and CHERI-RISC-V notes have no custom
  agent profiles; OS-security has a Claude skill without a model pin.

## Disposition

1. Project-wide, an active review/evaluation profile that would otherwise use
   Claude Fable 5.1 uses `claude-opus-5` instead.
2. Such review/evaluation work uses reasoning effort `max` and context tier
   `long_context` unless the responsible human explicitly specifies
   otherwise.
3. Existing active non-Fable assignments are unchanged. This record does not
   replace GPT-5.6 Sol in threat-model, provenance, or analysis roles.
4. Historical package directory names, model records, reports, and
   provenance remain immutable and are not renamed.
5. The responsible human may select Fable 5.1 explicitly for a later task.
6. Project Manager configuration is updated directly. The four
   security-reviewer profiles and their component-owned tests/instructions
   are owner action `PMR-062`; the Project Manager does not edit them.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize a security-review engagement, change review
scope, restart an in-flight task, rewrite historical provenance, or change a
non-Fable model assignment. It does not change the user-facing
`project-manager` orchestrator model; that profile is a coordination role,
not a review/evaluation role.

## Follow-up

- Complete `PMR-062` in `security-reviewer` before its next engagement, then
  return the exact component commit and validation results.

## Provenance

- Written by the `project-manager` agent from the responsible human's exact
  direction and a read-only inventory of active registered agent profiles.
