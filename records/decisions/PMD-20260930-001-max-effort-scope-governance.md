# Beryllium max-effort and scope-management governance

- **Record ID:** `PMD-20260930-001`
- **Created:** 2026-09-30
- **Status:** recorded
- **Supersedes:** `PMD-20260916-001` in part (narrows only its named-task
  effort exception; preserves its role-to-model assignments and
  `long_context` defaults)
- **Superseded by:** None

## Scope

Establish the active Beryllium Copilot CLI reasoning-effort floor,
scope-management review contract, and user-level enforcement/install gate
without modifying a component repository or the active Beryllium session.
This record directly changes only the Project Manager repository and its
owned parent policy/registry summaries.

Observed coordination revisions before the change: parent
`7e61330e5ac2a092f1c985f2f1cc616bcca8466c`; Project Manager
`fc92e1454cf08a981bd92f09bb686155acd96b9d`; authoritative request-table blob
`f8b85d96992842ee6932a5d5d91bc788fddef1bf`. The reported
`beryllium-hypervisor` session remains active and is not inspected,
restarted, or modified by this change.

## Inputs

- Responsible-human direction on 2026-09-30:
  `"Reasoning effort is max by default across every Beryllium
  agent/repository."`
- Responsible-human direction on 2026-09-30:
  `"`high` is the absolute minimum. Routine, general-purpose, mechanical,
  convenience, or cost reasons never permit `medium`, `low`, `minimal`, or
  unset effort."`
- Responsible-human direction on 2026-09-30: create a scope-management skill
  invoked before non-trivial plans, at reassessment/re-plan, and on new human
  steering, requirements, priorities, constraints, acceptance criteria, or
  material direction changes; each review is a separate read-only
  `claude-opus-5.5` / `max` / `long_context` task that returns bounded
  anti-scope-creep steering and grants no approval or human gate.
- Completed max-effort scope review disposition on 2026-09-30: `adjust`.
  Keep one decision, one Project Manager-owned reviewer and skill, one small
  user-level hook plus human installer/check script, narrow active-policy
  edits, static/sandbox validation, and independent review. Do not copy the
  reviewer or skill into every component and do not allocate blanket
  component PMRs; later work may verify user-level discovery/conflicts and
  create only evidence-based exceptions.
- `records/decisions/PMD-20260916-001-project-wide-role-model-matrix.md` at
  `fc92e14`: current model-by-role assignments and `max` /
  `long_context` defaults, including its broader named-task exception.
- `records/decisions/PMD-20260917-002-owner-worker-control-plane.md` at
  `fc92e14`: hidden, non-user-invocable specialist precedent; one exact task;
  bounded concurrency; durable authority boundaries.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md` at
  `fc92e14`: the Project Manager may not use this policy change to edit a
  component outside its three carry classes, and never writes Beryllium.
- Copilot CLI 1.0.90-5 local help, SDK types, bundled changelog, and GitHub
  Copilot hooks reference read on 2026-09-30: custom-agent
  `reasoning-effort`, `high` / `xhigh` / `max`, user agents under
  `~/.copilot/agents`, user skills under `~/.copilot/skills`, user hooks
  under `${COPILOT_HOME:-$HOME/.copilot}/hooks`, camelCase `preToolUse`,
  task matcher `task`, command-hook deny output, and
  `${COPILOT_HOME:-$HOME/.copilot}/settings.json`.

## Disposition

1. Preserve the `PMD-20260916-001` model matrix. Planning, coding,
   coordination, orchestration, and maintenance remain `gpt-5.6-sol`;
   review, evaluation, audit, and finding iteration remain
   `claude-opus-5`; deep or adversarial security review remains
   `gpt-5.3-codex`; all retain `long_context`.
2. Make reasoning effort `max` the active default across every Beryllium
   Copilot CLI agent and repository. A responsible human may override a
   named task only to `high`, `xhigh`, or `max`; `high` is the absolute
   floor. `xhigh` is admitted because the current CLI exposes it as a
   distinct supported level above `high`. Unset, `medium`, `low`, and
   `minimal` are prohibited. If a selected model cannot provide the required
   level, stop rather than silently falling back below `high`.
3. Add hidden Project Manager specialist `beryllium-scope-review`, the sole
   explicit `claude-opus-5.5` exception to the model matrix. Each invocation
   is a separate read/search-only task with `max` effort and
   `long_context`; it never writes, executes, uses the web, delegates,
   recurses, or grants approval, authorization, acceptance, or another human
   gate.
4. Add `beryllium-scope-management`. The orchestrator invokes it before
   adopting a non-trivial plan, at every material reassessment/re-plan, and
   after new human steering, requirements, priorities, constraints,
   acceptance criteria, or material direction changes. It validates one
   exact `SCOPE_REVIEW_V1` response, retries once on launch/contract failure,
   then fails closed for scope-expanding work. A turn has a bounded review
   cap and does not re-review applied steering absent a genuine new trigger.
5. Install no user-level files automatically. Human-run
   `scripts/beryllium-governance.sh install` copies, never symlinks, the
   reviewer, skill, command hook, and rendered hook configuration into
   `${COPILOT_HOME:-$HOME/.copilot}`. `check` is read-only and verifies
   `jq`, exact SHA-256 content, hook-disable settings, and effective
   user session defaults plus user plan defaults or session fallback at
   `max` / `long_context`. `uninstall` removes only exact matching managed
   files. The script never silently edits settings.
6. The user-level camelCase `preToolUse` command hook matches only `task`.
   Inside the canonical parent root and the resolved targets of its tracked
   symlinks, it denies missing or below-`high` effort and requires exact
   `claude-opus-5.5` / `max` / `long_context` for
   `beryllium-scope-review`. It returns no `allow` decision, so valid calls
   retain normal permission handling. Valid task launches outside the
   Beryllium scope pass through. Malformed input fails closed. The hook
   writes no telemetry, state, or database.
7. User-level installation is the project-wide reach mechanism for
   registered component Copilot CLI sessions. Hook, agent, and skill
   discovery occurs only in sessions started after installation; an already
   active Beryllium session is not restarted or interacted with.
8. This enforcement applies to Copilot CLI agents and tools operating under
   Beryllium. Non-Copilot tooling is outside this enforcement unless it is
   separately integrated.
9. Do not copy the reviewer or skill into components and do not create
   blanket component requests now. A later task verifies user-level
   discovery and conflicts, then raises only evidence-based exception PMRs.
10. Historical records remain unchanged. The new decision and active policy
    documents state the narrower rule prospectively.

Platform limitations remain explicit: a user can disable user hooks; command
hook timeouts fall through to normal permission handling; settings or model
availability can prevent the requested effort/context from applying; and
already running sessions do not reload the installation. The installer and
tests detect the locally checkable user defaults, but repository/local
settings, command-line choices, live session overrides, and the human origin
of a permitted `high`/`xhigh` named-task override require later
per-workspace/policy verification. Neither this record nor the hook claims
enforcement outside those supported surfaces.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation, component
implementation authority, component write authority, push, remote change, or
tag authority. It does not alter the active Beryllium session, approve
R8-H0, authorize H1-H4, run K3, or establish hardware validation. Scope
review output is steering only and never satisfies a responsible-human gate.

## Follow-up

- After the two local coordination commits are reviewed, the responsible
  human runs:

  ```sh
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

  New Copilot CLI sessions then discover the user-level policy; do not
  restart the already active Beryllium session.
- A later Project Manager todo verifies discovery/conflicts across registered
  component sessions and raises exception PMRs only where evidence requires
  them.

## Provenance

- Written by the `project-manager` agent from the exact responsible-human
  direction, the completed scope-review adjustment, the named prior records,
  and the current local Copilot CLI hook/agent/skill schemas. No component
  repository or user-level Copilot configuration was modified.
