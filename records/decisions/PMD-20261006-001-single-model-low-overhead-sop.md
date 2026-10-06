# Single-model, low-overhead Beryllium SOP

- **Record ID:** `PMD-20261006-001`
- **Created:** 2026-10-06
- **Status:** recorded
- **Supersedes:** `PMD-20260916-001` (the role-to-model matrix) and the
  remainder of `PMD-20260915-007` (its retained review/evaluation
  preference);
  `PMD-20260930-001` in part (the `high` floor and `xhigh` allowance, the
  `beryllium-scope-review` agent, the `beryllium-scope-management` skill and
  its mandatory invocation, and the installer's managed scope assets; its
  `max` default and human-run install/check model remain);
  `PMD-20260930-002` in part (the hook's effort-floor and model rules;
  injection of missing values through `modifiedArgs` and denial of in-scope
  `run_dynamic_workflow` remain); and `PMD-20260930-005` (the Codex
  capability exception, including the direct `security-reviewer` Codex
  session rule)
- **Superseded by:** None

## Scope

Record and implement, inside the Project Manager boundary, the responsible
human's project-wide single-model, low-overhead standard operating procedure
relayed as `CRQ-004`, and route the component-owned remainder. This record
changes Project Manager agent profiles, skills, instructions, interface,
roster, README, the user-level governance hook/installer sources and their
tests, the parent `.github/copilot-instructions.md`, `README.md`, and
`COMPONENTS.md`, and the owner-request table. It writes no component
repository and no user-level configuration.

Observed pre-change coordination revisions: parent
`f14bb0317868665f392bc35897fb2944e107e3cc`; Project Manager
`e35e95adc67323f668b75255dc6c541e0f9e0629`; authoritative request-table
blob `1b0808bbdf935985d2a0c954bf75e2848811d772`; `SOT.md` SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`.
Read-only component snapshot at 2026-10-06T16:03Z: `analysis-workbook`
clean `main` at `4cf44d0` (0 behind / 2 ahead); `beryllium-hypervisor` clean
`beryllium/k3-b3-bringup` at `afa4336` (0 / 1) with a human session the
responsible human reports active; `threat-modeler` clean at `e6aed9f`;
`provenance-review` clean at `9bfbab3`; `security-reviewer` clean at
`c2edac7`; `cheri-hypervisor-research` at `7361de4`, dirty only with two
untracked `review-inbox/*.pdf` files.

## Inputs

- Responsible-human instruction relayed verbatim by
  `component://analysis-workbook/outbox/requests/CRQ-004-single-model-low-overhead-sop.md`
  at `4cf44d0`: `"note a new SOP across the beryllium project: do not
  undertake iterative eval reviews with a different model, do not perform
  separate scope reviews, or deep security reviews as SOP. use only one model
  for all work, do not change model or downgrade for sub-agents or tasks. the
  default model is opus-5.5 max effort, long context. the general focus
  should be on efficiently completing deliverables while avoiding scope creep
  and additional complexity."`
- Responsible-human direction to the Project Manager on 2026-10-06:
  `"see CRQ-004 in the analysis-workbook and implement across the project.
  avoid collisions with the active beryllium-hypervisor session, defer that
  aspect if needed"` and `"and note that some repos are already partly
  updated"`.
- `component://analysis-workbook/.github/agents/` (`analysis-workbook`,
  `analysis-workbook-owner`, `analysis-evidence`) and
  `component://analysis-workbook/tests/validate-agent.sh` at `4cf44d0`:
  already pin `claude-opus-5.5`, as CRQ-004 states.
- `component://beryllium-hypervisor/.github/copilot-instructions.md` at
  `afa4336`: already records the 2026-10-06 SOP and pins `claude-opus-5.5`
  at `max` with `long_context` for all work, sub-agents, and tasks.
- `component://threat-modeler/.github/agents/*.agent.md` at `e6aed9f` (six
  profiles at `gpt-5.6-sol`), `component://provenance-review/.github/agents/*.agent.md`
  at `9bfbab3` (three profiles at `gpt-5.6-sol`), and
  `component://security-reviewer/.github/agents/*.agent.md` at `c2edac7`
  (four profiles at `gpt-5.3-codex` with `xhigh` / `default`).
- `PMD-20260904-003`: component agent profiles, skills, and tests lie
  outside the three carry classes; `beryllium-hypervisor/` is never written.
- `PMD-20260930-003`: user-level reinstall only while governed sessions are
  idle; a running session may execute a replaced hook script at its next
  originally matched call.

## Disposition

1. **One model for all work.** Every Beryllium orchestrator, agent,
   sub-agent, and task uses `claude-opus-5.5` with reasoning effort `max` and
   context tier `long_context`. There is no role-specific model, lower
   effort, other context tier, or silent fallback; if that exact selection is
   unavailable, stop and report. The `PMD-20260916-001` matrix, the `high`
   floor and `xhigh` allowance, and the `gpt-5.3-codex` / `xhigh` /
   `default` exception are retired prospectively.
2. **No standing extra reviews.** Different-model iterative evaluation
   reviews, separate scope reviews, and deep security reviews are not
   standard practice. A security review runs only on explicit
   responsible-human request, on the same model. The Project Manager's
   Phase 6 `pm-auditor` consistency audit remains one same-model pass without
   iteration.
3. **Delivery focus.** Work concentrates on completing deliverables
   efficiently and avoids scope creep and added complexity. No human gate is
   granted or inferred by this simplification.
4. **Scope-review retirement.** The Project Manager `beryllium-scope-review`
   agent and `beryllium-scope-management` skill are retired and removed from
   the repository; the orchestrator no longer invokes a scope review. This
   turn applied the SOP immediately and ran no separate scope review.
5. **Aligned hook source.** For in-scope `task` launches, absent, null, or
   empty `model`, `reasoning_effort`, or `context_tier` receive
   `claude-opus-5.5` / `max` / `long_context` through `modifiedArgs` without
   a permission decision; explicit other values are denied; in-scope
   `run_dynamic_workflow` remains denied; out-of-scope launches pass through.
   The installer manages only the hook script and hook configuration;
   `install` and `uninstall` remove exact-match retired scope-reviewer and
   skill copies, and `check` reports any that remain. `check` and install
   preflight also require the user default `model` `claude-opus-5.5` (with
   `planModel` unset or equal), alongside the existing `max` /
   `long_context` defaults; both keys appear in the local Copilot CLI
   1.0.93-1 settings schema. The script still never edits settings.
6. **Deferred reinstall.** Installing the aligned hook into the real user
   configuration is the aspect that could collide with the active
   `beryllium-hypervisor` session, so it is deferred. It is human-run and
   occurs only while every governed session is idle (`PMD-20260930-003`).
   Until then, any previously installed hook keeps the superseded rules for
   sessions that load it: explicit `claude-opus-5.5` / `max` /
   `long_context` task launches pass, but an in-scope launch of
   `security-evidence`, `security-research`, or `security-finding-review`
   that omits the model still receives `gpt-5.3-codex`, so pass all three
   values explicitly.
7. **Component routing.** `PMR-121` (threat-modeler), `PMR-122`
   (provenance-review), and `PMR-123` (security-reviewer, which also retires
   its Codex exception and records review-on-request) repin component
   profiles through owner sessions; `PMR-124` asks the analysis-workbook
   maintainer to mirror `CRQ-004` as `routed`. `analysis-workbook` and
   `beryllium-hypervisor` are already aligned; no Beryllium request is
   allocated while its session is active. Formal-verification, OS-security,
   CHERI notes, XRV, and Helium carry no model pin and need no request.
   The ordinary `owner-session.sh` packet runs the parent tasking resolver,
   which threat-modeler (until parked `PMR-064`) and provenance-review
   (until `PMR-066`) do not admit. `PMR-121` and `PMR-122` therefore use a
   recorded, bounded exception to the launcher rule: a direct human-started
   ordinary component session that reads its request row with read-only file
   tools and runs no parent or sibling command. Such a session takes neither
   the per-component writer lock nor the PMR-108 global reservation and
   writes no preflight log, so the human starts it only when the component
   is clean and no other Copilot session, `owner-session.sh`,
   `owner-recovery.sh`, or `maintenance-reservation.sh` run is active for it.
   No bootstrap is re-armed and `PMR-064`/`PMR-117` stay parked.
8. **History.** Historical records, review packages, threat models, session
   records, and comparison artifacts remain unchanged; each superseded record
   receives only a forward `Superseded by` pointer.

Platform limits remain explicit: direct custom-agent sessions, SDK-started
workflows, out-of-scope worktrees, disabled hooks, hook timeout, and
non-Copilot tooling are outside or beyond the command hook, and the main
session model comes from the human's launch and settings.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance,
approval, review approval, risk acceptance, sign-off, licensing,
redistribution, publication, release, formal verification, hardware
validation, implementation authority, component write authority, push,
remote change, or tag authority. Beryllium remains accepted through R7;
R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN` in Project Manager records.
Beryllium's committed instructions at `afa4336` state owner-local B0-B2
acceptance on COM260 and B3 not accepted; this record neither reconciles nor
relies on those statements, which remain an open responsible-human
question. Helium remains a review-and-test proof
of concept and is not formally verified or hardware validated. It does not
install or uninstall user-level configuration, interact with or restart the
active Beryllium session, perform `PMR-121`..`PMR-124`, or process
`CRQ-003`.

## Follow-up

- After `beryllium-hypervisor` and every other governed session are idle,
  the responsible human runs:

  ```sh
  cd /home/jmorris/src/l1/src/beryllium-project
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

- Owner sessions for `PMR-121`..`PMR-123` follow
  `outbox/OWNER-RUNBOOK.md`; their returns are verified through each
  component handoff under `PMD-20260914-002`.

## Provenance

- Written by the `project-manager` agent on `claude-opus-5.5` from the
  inputs above and the read-only snapshot of
  `scripts/inspect-components.sh`. No component repository or user-level
  Copilot configuration was modified.
