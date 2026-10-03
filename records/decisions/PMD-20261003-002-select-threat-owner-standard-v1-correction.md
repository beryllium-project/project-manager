# Select threat-owner standard V1 correction

- **Record ID:** `PMD-20261003-002`
- **Created:** 2026-10-03
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Resolve the PMR-120 response-contract choice preserved by
`PMD-20261003-001` and define the exact additional single-use correction
packet needed before the threat hidden-owner candidate can be acknowledged or
handshaken.

Observed state at 2026-10-03T06:56Z: parent
`ec485e7477dbc1c9377ab5ee46fb4f8b5e5781fc`, Project Manager
`dbb76c7dc0c386798454504b94b97b95f1539317`, request blob
`0d7e84201e160c94080055fec121ff2dbf5540a8`, SOT SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`,
and clean threat-modeler `main`
`bbbc5349943c3a7d64ced24f19f90d6e0c50ea06`, 0 behind / 2 ahead.

## Inputs

- Responsible-human steering on 2026-10-03:
  `"You aren't done until you have fully completed the task."`,
  `"You have open questions or ambiguities - make good decisions and keep working"`,
  and `"Keep working autonomously until the task is truly finished"`.
  The human did not explicitly name `correct_standard_v1`; the Project
  Manager selects it as the already-presented recommended default under this
  delegated coordination autonomy. This is not implementation authorization
  outside PMR-120 and is not a push, publication, risk, acceptance, or other
  gate.
- `PMD-20261003-001`: the installed candidate diverges from both established
  live and durable response vocabularies; its Disposition 7 lists
  `correct_standard_v1` as the recommended choice.
- `PMD-20260917-002` and
  `templates/owner-agent-response.md` at the containing Project Manager
  commit: sole live V1 schema source.
- `templates/owner-return.md` at the containing Project Manager commit: sole
  durable return vocabulary source.
- `../threat-modeler/.github/agents/threat-modeler-owner.agent.md` and
  `../threat-modeler/tests/validate-agent.sh` at `bbbc534`: current
  candidate and static tests to correct; current tests check the protocol
  name but not the full schema.
- Scope review `threat-owner-standard-v1-correction-20261003-09` returned
  `adjust`, authority `steering_only_no_approval_or_human_gate`. It retains
  one exact PMR-120 correction and a single-use human bootstrap, cuts every
  attempted PM/custom/generic autonomous writer route, and defers handshake
  details until a verified correction return.

## Disposition

Select `correct_standard_v1` and continue open PMR-120 without allocating a
new request:

1. Authorize one additional, single-use PMR-120 correction envelope at
   baseline `bbbc534`, limited by the existing six-path ceiling. Expected
   changes are the hidden profile, schema-level component tests, and only
   directly coupled contract documentation/return wording.
2. The exact live schema is
   `templates/owner-agent-response.md` at the correction packet's source PM
   commit. Require fields `protocol`, `component`, `owner_profile`,
   `request_id`, structured `source`, `state`, `summary`, structured `work`,
   structured `handoff`, `validation`, structured `repository`,
   `requested_pm_action`, `question`, and `push`.
3. Require every V1 state exactly: `progress`, `needs_human`, `completed`,
   `partial`, `blocked`, and `refused`. `progress` remains the standard
   live-only no-write state and may use empty work with null handoff
   checkpoint, question, and push. This is standard V1 behavior, not an early
   handshake authorization.
4. Require durable return results exactly from `templates/owner-return.md`:
   `completed`, `partial`, `blocked`, `needs_human`, `refused`, and
   `information`. Preserve truthful failures and the return/checkpoint rules.
5. Component tests must assert all required fields, all six live states, all
   six durable values, progress empty/null invariants, completed checkpoint
   invariants, the needs-human question structure, and null push. A string
   presence assertion is insufficient.
6. Preserve every existing repository, execution, model, tool, commit,
   no-push, no-package, no-delegation, and human-gate boundary. Do not perform
   PMR-064 or PMR-117.
7. Retarget `scripts/owner-session.sh --tasking-bootstrap` as one additional
   exact binding: component `threat-modeler`, agent
   `threat-model-maintainer`, sole PMR-120, this review ID, the final
   correction request blob, unchanged SOT SHA, and threat baseline
   `bbbc534`. It amends only `PMD-20261002-002` Disposition 4 and answers
   `PMD-20261003-001` Disposition 7.
8. The consumed first PMR-120 binding remains historical and unusable. Any
   later request-table, SOT, component-HEAD, component, agent, PMR-set,
   cleanliness, lock, or tasking drift fails closed.
9. The Project Manager prepares and validates the packet but never launches
   it. The exact remaining principal is the responsible human running the
   human-only launcher. Candidate/profile selector exposure does not grant a
   compliant shortcut.
10. Allocate no handshake PMR or decision until the correction return is
    verified and its session explicitly released.

This answers `PMD-20261003-001` Disposition 7 and discharges its
Disposition 8: the recorded Project Manager selection replaces the awaited
human return. No new PMR, handshake, or protocol change is created.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, or hardware validation. It does
not adopt or invoke the candidate owner, run a component command, authorize a
generic writer, close PMR-120, allocate the handshake, dispatch PMR-064/117,
change a package/model, or authorize a push.

## Follow-up

- After the containing PM and parent commits and exact tasking regeneration,
  the responsible human runs the one re-armed PMR-120 correction command
  recorded in `outbox/OWNER-RUNBOOK.md`. The Project Manager then verifies
  the corrected return before doing anything else in this lane. Its command
  text is byte-identical to `PMD-20261002-002`'s consumed Follow-up; the
  launcher regenerates a new packet with the new embedded binding, and the
  old packet file is never reused.

## Provenance

- Written by the `project-manager` agent from the inputs above, exact current
  component/PM state, and bounded scope steering. No component was modified
  or invoked.
