# Owner agent response v1

Use this live response shape when a Project Manager-invoked component owner
worker reports progress or returns control. The live response accelerates the
conversation; the component-owned handoff remains the durable return.

```yaml
protocol: OWNER_AGENT_RESPONSE_V1
component: <component>
owner_profile: <component>-owner
request_id: PMR-NNN

source:
  pm_commit: <commit>
  request_blob: <blob>
  expected_component_head: <commit>

state: progress | needs_human | completed | partial | blocked | refused
summary: <concise result or current position>

work:
  commits: []
  paths: []

handoff:
  path: <component-relative handoff path>
  checkpoint_commit: <commit-or-null>

validation:
  - command: <exact command or check>
    result: passed | failed | not_run
    note: <known failure or boundary>

repository:
  branch: <branch>
  head: <commit>
  clean: true | false
  upstream: <value-or-unknown>
  ahead: <integer-or-unknown>
  behind: <integer-or-unknown>
  active_session: self | none | other | unknown

requested_pm_action: continue | ask_human | verify_return | open_followup | record_blocker | none
question: null
push: null
```

For `needs_human`, replace `question: null` with:

```yaml
question:
  id: PMR-NNN-QNN
  kind: authorization | gate | priority | choice | missing_fact
  prompt: <one short human-facing question>
  blocking_reason: <why progress requires the answer>
  choices:
    - value: <stable value>
      label: <plain-language choice>
  recommended: <choice-value>
  exact_scope:
    operation: <operation-or-null>
    repository: <repository-or-null>
    target: <command-artifact-or-ref-tuple-or-null>
  authorizes: <exact effect of an affirmative answer>
  does_not_authorize: <explicit preserved boundaries>
```

Rules:

- `progress` is live-only and never closes or acknowledges a request.
- Before returning `needs_human`, `completed`, `partial`, `blocked`, or
  `refused`, update the component's existing `Project Manager return` section
  and commit that checkpoint when repository state permits.
- `completed` requires exact commits, paths, validation, a clean final
  worktree, and a durable handoff checkpoint.
- Preserve every known failure. Never return success-shaped evidence for a
  partial, blocked, refused, dirty, or active state.
- The owner worker never calls `ask_user`. The Project Manager validates the
  question, presents one blocking form, and relays the exact answer.
- A lost live agent handle is recovered from the PMR and component handoff,
  never from remembered conversation state.
- This response grants no implementation authorization, exact-target
  acceptance, review approval, risk acceptance, sign-off, licensing,
  redistribution, publication, release, formal verification, or hardware
  validation.
