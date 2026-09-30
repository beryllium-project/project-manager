---
name: beryllium-scope-management
description: Require one bounded independent scope review before non-trivial Beryllium plans and on material re-planning or human steering, then apply anti-scope-creep steering without creating review loops or granting approval.
user-invocable: false
disable-model-invocation: false
---

# Beryllium scope management

The orchestrator owns scope management. The reviewer supplies bounded
steering under `PMD-20260930-001`; it never owns the plan, approves work, or
satisfies a human gate.

## Mandatory triggers

Invoke this skill:

1. before adopting any non-trivial implementation, coordination, review, or
   research plan;
2. whenever evidence, failure, or a changed dependency causes a material
   reassessment or re-plan; and
3. after new human steering, requirements, priorities, constraints,
   acceptance criteria, or any other material direction change.

A plan is non-trivial when it crosses files, repositories, ownership
boundaries, policy surfaces, generated artifacts, installation state, human
gates, or more than one independently verifiable action.

## Non-triggers

Do not invoke for:

- one read-only lookup or factual answer;
- one exact mechanical edit already covered by a valid scope review;
- validation commands already named in the reviewed plan;
- final reporting with no new scope;
- a reviewer response itself; or
- cosmetic wording or formatting that changes no requirement, boundary, or
  acceptance criterion.

The scope reviewer never invokes this skill. There is no review recursion.

## Launch contract

Each review is a fresh, separate, synchronous read-only task. Do not reuse an
existing agent and do not use background, async, or detached execution. Use
the custom-agent selector exposed by the current task schema:

```yaml
agent_type: beryllium-scope-review
name: beryllium-scope-review
model: claude-opus-5.5
reasoning_effort: max
context_tier: long_context
```

If the task schema labels the custom-agent selector differently, map that
field to the exact agent name `beryllium-scope-review`; do not substitute
`general-purpose`, another reviewer, another model, a lower effort, or the
default context tier.

Invocation mode is synchronous: call the task normally and wait for its
result. Do not pass or select background, async, or detached execution.

The task prompt is exactly one `SCOPE_REVIEW_REQUEST_V1` document:

```yaml
protocol: SCOPE_REVIEW_REQUEST_V1
review_id: <stable identifier unique within the turn>
trigger: non_trivial_plan | reassessment | human_steering
objective: <one bounded sentence>
authoritative_requirements:
  - <requirement>
candidate_plan:
  - <planned action>
constraints:
  - <constraint>
acceptance_criteria:
  - <criterion>
known_evidence:
  - <revision-bound fact or unknown>
explicitly_deferred:
  - <deferred item>
```

Keep the request bounded:

- at most 12 authoritative requirements;
- at most 12 candidate-plan items;
- at most 10 constraints;
- at most 10 acceptance criteria;
- at most 10 evidence items; and
- at most 8 explicitly deferred items.

Do not paste broad repository content. Provide only facts needed to assess
scope.

## Response handling

Accept only the exact `SCOPE_REVIEW_V1` contract from
`beryllium-scope-review`:

```yaml
protocol: SCOPE_REVIEW_V1
review_id: <matching identifier>
verdict: keep | adjust | stop
summary: <bounded sentence>
keep: []
cut_or_defer: []
required_changes: []
scope_risks: []
questions_for_orchestrator: []
authority: steering_only_no_approval_or_human_gate
```

Validate the protocol, matching `review_id`, verdict, authority marker, field
set, and reviewer list caps. Treat extra fields, prose outside the document,
wrong identity, wrong model/effort/context, or a malformed response as
failure.

On launch failure or contract failure, retry once with a fresh separate task
and the same bounded request. If the retry fails, stop scope-expanding work.
The orchestrator may continue only already-reviewed, non-expanding work or
report the blocker.

At most three scope-review tasks, including a retry, may run in one
orchestrator turn. If a fourth mandatory trigger would occur, stop
scope-expanding work and report the review-cap blocker rather than weakening
the review or silently proceeding.

## Applying steering

- `keep`: proceed with the reviewed plan.
- `adjust`: retain `keep`, apply `required_changes`, remove or defer
  `cut_or_defer`, and make `scope_risks` explicit.
- `stop`: do not adopt or expand the plan until the orchestrator or
  responsible human resolves the stated scope/authority conflict.

Apply steering once. Do not ask the reviewer to approve the revised plan and
do not create a review loop. Invoke a later review only when a mandatory
trigger occurs, subject to the per-turn cap.

Scope review is steering, not approval. It never grants implementation
authorization, exact-target acceptance, review approval, risk acceptance,
sign-off, licensing, redistribution, publication, release, push, tag, formal
verification, or hardware validation.
