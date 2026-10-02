# Threat-modeler hidden owner rollout

- **Record ID:** `PMD-20261002-002`
- **Created:** 2026-10-02
- **Status:** recorded
- **Supersedes:** the `PMD-20260918-003` Disposition 2 deferral and
  Disposition 8 stop-expansion line as applied to the threat-modeler-only
  pilot, under the repeated-cost exception Disposition 2 already
  contemplated; every other component remains deferred
- **Superseded by:** None

## Scope

Whether repeated human lifecycle cost now justifies resuming the hidden
owner-worker rollout for threat-modeler maintenance only. This record stages
one component-owned bootstrap request; it does not create or prove an owner
profile, allocate the later native handshake, or dispatch component work.

Observed state at 2026-10-02T21:35Z: parent
`6fc10785fafe93a6efb8891ebb3f3f18fa077e02`, Project Manager
`8c9b24f44c8eb5b98a4c9a67e5982246c2b9f247`, request blob
`9c289ab88a4202efb20e5e88ae994f6572c59a75`, SOT SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`,
and clean synchronized threat-modeler `main` at
`c4126b6d77f7cd14f7477795e3b8b971b6b58b37`. `PMR-064` and `PMR-117`
were open, the model remained paused, and no durable owner return existed.

## Inputs

- Responsible-human selection on 2026-10-02:
  `"resume_hidden_owner_rollout"`, after asking why the Project Manager
  could not launch the owner work directly.
- `records/decisions/PMD-20260917-002-owner-worker-control-plane.md`: a
  component must first adopt a hidden owner, then pass a distinct read-only
  native discovery, repository-root, exact-task-fingerprint, and isolation
  handshake before any write-enabled Project Manager dispatch.
- `records/decisions/PMD-20260918-003-operational-housekeeping-closure.md`:
  wider rollout stays deferred unless real repeated owner-lifecycle cost
  justifies it.
- Three earlier human-started threat-modeler attempts produced no component
  edit or durable return. The latest observed attempt reached Copilot but
  stopped because owner-side scope-review and collaboration mechanisms were
  treated as mandatory. The corrected `-05` packet was prepared afterward
  but was not launched; it is not recorded as another failure.
- `../threat-modeler/.github/copilot-instructions.md`,
  `../threat-modeler/.github/agents/threat-model-maintainer.agent.md`,
  `../threat-modeler/AGENT-INTERFACE.md`, `../threat-modeler/README.md`,
  `../threat-modeler/tests/validate-agent.sh`, and
  `../threat-modeler/HANDOFF.md` at `c4126b6`: the component has a
  user-invocable maintainer but no hidden maintenance owner.
- Scope review `resume-threat-owner-rollout-20261002-06` returned `adjust`
  with authority `steering_only_no_approval_or_human_gate`. It reviewed the
  plan against source request blob `9c289ab...`, not the later exact
  `PMR-120` row bytes or their post-edit blob. Its required changes are
  applied below.

## Disposition

Resume the owner-worker rollout only for a maintenance-only
`threat-modeler-owner`, in this strict sequence:

1. Allocate P2 `PMR-120` for the component owner to add and validate the
   hidden profile. The exact allowed change paths are
   `.github/agents/threat-modeler-owner.agent.md`,
   `.github/copilot-instructions.md`, `AGENT-INTERFACE.md`, `README.md`,
   `tests/validate-agent.sh`, and `HANDOFF.md`.
2. The profile is `gpt-5.6-sol` with `max` reasoning and `long_context`,
   model-invocable, not user-invocable, and has no `ask_user`, delegation,
   web, or threat-modeling skill. It handles one exact directly assigned PMR,
   writes only this repository, and may execute only
   `tests/validate-agent.sh`; narrow local Git identity/diff, exact-path add,
   and validated work/return commits are separate. Push, fetch, remote
   mutation, tags, branch/history mutation, package scaffolding,
   threat-material discovery, target/sibling execution, package/model work,
   and human-gate decisions remain prohibited.
3. The hidden owner verifies the exact invocation component, profile, PMR,
   Project Manager commit, request blob, expected branch/HEAD, generated
   tasking/SOT fingerprint, clean state, and sole reservation before writing.
   It returns exactly `OWNER_AGENT_RESPONSE_V1`, records every non-progress
   result durably in `HANDOFF.md` when repository state permits, and never
   returns success-shaped evidence for a failure or partial result.
4. Replace, rather than extend, the one-time `--tasking-bootstrap` admission:
   only exact `threat-model-maintainer` / `threat-modeler` / `PMR-120` is
   admitted. The former `PMR-064 PMR-117` tuple fails closed. The packet is
   revision-bound to the post-edit request blob, unchanged SOT SHA-256 and
   component HEAD, while truthfully recording that the scope review saw the
   pre-edit blob and that the Project Manager applied the reviewed steering
   to the exact row and envelope.
5. `PMR-120` changes no user-facing threat-modeler or
   threat-model-maintainer behavior beyond registering the hidden owner. It
   changes no resolver/SOT entry point; those remain deliverables of
   `PMR-064` and `PMR-117`. It changes no model, package, queue, outbox,
   source, target, sibling, remote, or human gate.
6. After a verified `PMR-120` durable return and explicit release of its
   human-started session, a later turn may allocate one new PMR plus a
   single-use decision for the read-only native handshake. Neither this
   record nor owner appearance in a task list proves discovery or isolation.
   A fresh Project Manager session may be required; any startup or discovery
   setup waits for that later turn.
7. Only after that later handshake is verified and closed may separate later
   turns consider directly dispatching `PMR-064` and then `PMR-117`, one
   exact request per invocation. They remain open and blocked now.
8. Do not extend this rollout to another component without new responsible-
   human direction after threat-modeler proves both the read-only handshake
   and one write-enabled direct request.

This is the threat-modeler-only repeated-cost exception contemplated by
`PMD-20260918-003`. Its repository-reorganization and operational-closure
dispositions remain otherwise unchanged.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, or hardware validation. It does
not adopt or prove `threat-modeler-owner`, allocate or authorize the later
handshake, dispatch `PMR-064` or `PMR-117`, start or resume a threat model,
authorize a local component edit by the Project Manager, or authorize a push.

## Follow-up

- After the containing Project Manager and parent commits are complete and
  generated tasking is current, the responsible human runs exactly:
  `bash ./project-manager/scripts/owner-session.sh --tasking-bootstrap --agent threat-model-maintainer launch threat-modeler PMR-120`
  from the full workspace path recorded in `../COMPONENTS.md`.

## Provenance

- Written by the `project-manager` agent from the inputs above and bounded
  scope steering `resume-threat-owner-rollout-20261002-06`. No component was
  modified or invoked.
