# Threat owner response contract gap

- **Record ID:** `PMD-20261003-001`
- **Created:** 2026-10-03
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether the PMR-120 threat-modeler hidden-owner bootstrap can be acknowledged
as a validated owner-worker adoption and followed by the planned native
read-only handshake. This record reconciles a delivered profile/response
contract mismatch without changing the component.

Observed state at 2026-10-03T06:22Z: clean parent
`a47d008257f8b49c050f2086f588ee6e12e19814`, clean Project Manager
`8e6610fc18d03eb8d07e70cc57174edc3456e668`, and clean threat-modeler
`main` at return commit
`bbbc5349943c3a7d64ced24f19f90d6e0c50ea06`, 0 behind / 2 ahead of
last-fetched private `origin/main`
`c4126b6d77f7cd14f7477795e3b8b971b6b58b37`.

## Inputs

- Responsible-human statement on 2026-10-03: `"done above"`. This supplies
  the release confirmation requested by the PMR-120 return for the
  human-started bootstrap session; it grants no handshake, dispatch, push, or
  other authority.
- `../threat-modeler/HANDOFF.md` at `bbbc534`: reports PMR-120 work
  `ca8fa3cf9a043cffbb083f5c0bc5f5eb8b61cba7`, return `SELF`, all six
  authorized paths, source PM `8e6610f`, request blob `7508420`, SOT SHA,
  baseline `c4126b6`, agents-only validation 140/0, `git diff --check`,
  clean 0/2 state, no push, and released/not-held reservation.
- Maintained `inspect-components.sh state/refs`: both PMR-120 commits exist
  on clean local `main`; work subject is `PMR-120: add hidden threat model
  owner`, return subject is `PMR-120: record hidden owner return`, and
  `origin/main` remains `c4126b6`.
- `../threat-modeler/.github/agents/threat-modeler-owner.agent.md` at
  `bbbc534`: the profile has the requested model, invocation defaults, tool
  and repository boundaries, one-PMR checks, local commit lifecycle, and no
  push.
- `records/decisions/PMD-20260917-002-owner-worker-control-plane.md`
  Disposition 4 and `templates/owner-agent-response.md`: live
  `OWNER_AGENT_RESPONSE_V1` uses field `state` with values `progress`,
  `needs_human`, `completed`, `partial`, `blocked`, or `refused`; it also
  carries structured source, work, handoff checkpoint, validation,
  repository, question, and push fields.
- `records/decisions/PMD-20261002-002-threat-modeler-hidden-owner-rollout.md`:
  allocated PMR-120 and sequenced a later read-only handshake only after a
  validated adoption.
- `records/decisions/PMD-20260918-001-read-only-owner-handshake-exception.md`:
  its analysis-workbook-specific probe required `state: progress`, empty work
  lists, and null checkpoint/question/push; that single-use exception is
  consumed and is precedent only for the no-write shape.
- The delivered profile instead defines field `result` with only
  `COMPLETE`, `PARTIAL`, or `BLOCKED`, and omits the standard state,
  checkpoint, question, and push fields. Component tests assert only the
  string `OWNER_AGENT_RESPONSE_V1`, not the established schema.
- The durable component return separately reports `Result: Complete` and
  `Known failures: None`, while `templates/owner-return.md` uses
  `completed`, `partial`, `blocked`, `needs_human`, `refused`, or
  `information`. The Project Manager's partial disposition therefore differs
  explicitly from both component-reported vocabularies.
- Scope review `threat-owner-bootstrap-return-20261003-08` returned
  `adjust`, authority `steering_only_no_approval_or_human_gate`. It requires
  preserving the mismatch, forbids adapting the handshake silently, and
  requires a human choice before any corrective PMR/session or protocol
  variant.
- The guided choice was presented with recommended
  `correct_standard_v1`, alternatives `adopt_threat_variant` and
  `defer_rollout`; the responsible human was unavailable. Under
  `PMD-20260915-002`, preserve the partial intake and do not infer a choice.

## Disposition

Record PMR-120 as a **partial bootstrap result**, not a validated hidden-owner
adoption:

1. The exact six-path work and two local commits are verified, and the
   responsible human has released the bootstrap session.
2. PMR-120 stays open P2 because its `OWNER_AGENT_RESPONSE_V1` requirement is
   not satisfied by the established control-plane schema. Static 140/0
   validation did not detect that semantic divergence.
3. The installed `threat-modeler-owner` is a component-local **candidate
   profile**. It is not recorded as PM-invocable, native-discovered,
   isolated, or write-dispatchable.
4. Do not allocate PMR-121 or a single-use handshake decision. A no-write
   probe cannot truthfully use PMD-20260918-001's `progress` shape under the
   delivered profile, and converting it into a HANDOFF-writing probe would
   violate the required read-only boundary.
5. Do not rerun the original PMR-120 bootstrap packet. The changed
   authoritative request note makes its old request-blob binding stale, and
   the live component HEAD `bbbc534` differs from its reviewed baseline
   `c4126b6`; either mismatch makes the maintained launcher fail closed.
6. PMR-064 and PMR-117 remain open and blocked on a fully corrected PMR-120,
   explicit release of any correction session, and a later separately
   allocated and closed native no-write handshake.
7. The next unresolved human choice is:
   - `correct_standard_v1` (recommended): correct the profile and tests to the
     existing V1 contract through exact component-owner maintenance;
   - `adopt_threat_variant`: design and record a wider threat-specific
     protocol variant; or
   - `defer_rollout`: retain the candidate profile but stop direct dispatch.
8. Until that choice is returned, create no follow-up PMR, owner session,
   fresh-session discovery setup, or protocol change.

This narrows `PMD-20261002-002` Disposition 6: a later handshake is not merely
waiting on a return; it is also waiting on response-contract resolution. It
does not supersede that record's threat-only rollout or other boundaries.
The earlier record's Follow-up command is consumed and must not be rerun.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, or hardware validation. It does
not accept a nonstandard response schema, close PMR-120, allocate or execute a
handshake, authorize PMR-064/117, invoke the candidate owner, change a
component, or authorize a push. The responsible human has not yet selected
the response-contract resolution.

## Follow-up

- Preserve the pending guided choice. No component command is safe until the
  responsible human selects one of the three stable options above. Review
  `../threat-modeler/.github/agents/threat-modeler-owner.agent.md` at
  `bbbc534` against `templates/owner-agent-response.md`.

## Provenance

- Written by the `project-manager` agent from the inputs above, maintained
  state/refs inspection, exact component files, and the bounded scope review.
  No component was modified or invoked.
