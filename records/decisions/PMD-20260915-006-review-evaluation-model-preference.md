# Review and evaluation model preference

- **Record ID:** `PMD-20260915-006`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's default model, reasoning-effort, and context
preference for future Project Manager review and evaluation delegations. This
applies to the Project Manager's delegated review/evaluation specialists,
currently including `pm-auditor`; it does not change component-owned agent
configuration.

## Inputs

- Responsible-human direction in the 2026-09-15 Project Manager session:
  `"after this session, use Opus 5 max effort max context for review/eval
  purposes in place of fable 5.1 unless otherwise specified, to reduce
  costs."`
- `.github/agents/pm-auditor.agent.md` at pre-change Project Manager
  `5ff7e09`: the specialist default was `claude-fable-5.1`.
- The required `pm-auditor` pass for this coordination turn was already
  launched before the direction and remains part of this session.

## Disposition

1. Beginning with the next Project Manager session, delegated review and
   evaluation tasks default to model `claude-opus-5`, reasoning effort
   `max`, and context tier `long_context`.
2. An explicit user instruction for a particular task overrides this default.
3. `pm-auditor`'s checked-in model default is changed from
   `claude-fable-5.1` to `claude-opus-5`. The orchestrator and skill record
   the invocation-time `max` reasoning and `long_context` requirement.
4. The audit already launched in this session is not restarted or duplicated;
   the preference is effective after this session as requested.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not select models for component-owned agents, change the
user-facing Project Manager model, or authorize additional review scope.

## Follow-up

- On the next delegated review/evaluation call, pass
  `model=claude-opus-5`, `reasoning_effort=max`, and
  `context_tier=long_context` unless the responsible human specifies
  otherwise.

## Provenance

- Written by the `project-manager` agent from the responsible human's exact
  direction. No in-flight task was restarted.
