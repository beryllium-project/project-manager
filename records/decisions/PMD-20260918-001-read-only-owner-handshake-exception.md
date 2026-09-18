# Single-use read-only owner handshake exception

- **Record ID:** `PMD-20260918-001`
- **Created:** 2026-09-18
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether the first native invocation of hidden profile
`analysis-workbook-owner` may prove discovery, repository rooting, exact
Project Manager task identity, and one-repository isolation without writing a
component handoff. This is a single-use coordination exception for
`PMR-087`; it changes only Project Manager-owned artifacts.

The physical root is itself a required proof value, so this record quotes the
absolute workstation path from the current root in `../COMPONENTS.md`. That
single-use evidence citation does not change the general workspace-relative
or `component://` locator rule for Project Manager records.

Pre-publication inspection at 2026-09-18T01:11Z observed parent
`3d8b6ab179d873c58f7a8fe6ff32db50cad24f67`, Project Manager
`04746d89f93e3c0e4e0e369b608d94dfbff57ddd`, and analysis-workbook clean
`main` at `ea72522a7d6448dfa2f3af841c2511522d5bc228`, behind 0 / ahead 8 of
last-fetched `origin/main`. The selected Project Manager runtime registers
the hidden `analysis-workbook-owner` profile; native selection, physical
rooting, task-fingerprint delivery, and isolation remain unproven until the
live probe.

## Inputs

- `PMD-20260917-002` at `04746d8`: the owner-worker control plane requires a
  read-only native discovery/root/task-fingerprint/isolation proof before
  write-enabled use.
- `templates/owner-agent-response.md` at `04746d8`: `progress` is the only
  schema-valid successful no-write state and may use a null checkpoint, while
  `completed` requires a durable component handoff checkpoint.
- `../analysis-workbook/.github/agents/analysis-workbook-owner.agent.md` at
  `ea72522`: the hidden profile is model-invocable, not user-invocable, has no
  `ask_user`, and permits bounded read-only local Git identity and status
  checks.
- `HANDOFF.md` at `04746d8`: the responsible human explicitly released the
  PMR-084 bootstrap session; no component writer remains reserved by that
  session.
- `outbox/component-requests.md` at `04746d8`: `PMR-086` is open P2 and
  blocked on the handshake; `PMR-087` was the next unused request identifier.

## Disposition

Allocate `PMR-087` as the dedicated P1 read-only capability probe and adopt
the following single-use exception:

1. The probe itself is read-only. It creates no component work or handoff
   checkpoint. Project Manager-side evidence may verify and close only
   `PMR-087` without a component handoff write. The owner's `progress`
   response neither acknowledges nor closes the request; closure, if
   warranted, is a later Project Manager-side disposition in PM-owned
   artifacts.
2. Success requires native selection of exact profile
   `analysis-workbook-owner`, physical root
   `/home/jmorris/src/beryllium-project/analysis-workbook`, request
   `PMR-087`, the post-publication Project Manager commit and
   `outbox/component-requests.md` blob from its generated tasking, branch
   `main`, and full component HEAD
   `ea72522a7d6448dfa2f3af841c2511522d5bc228`.
3. Pre- and post-probe repository identity, HEAD, tree, and clean status must
   be unchanged. The owner may call no `ask_user`, specialist or subagent,
   write-capable operation, staging operation, or other PMR, and may write no
   path or Git metadata. The invocation must remain isolated to the one
   analysis-workbook repository. For this probe, the profile must perform the
   root, branch, HEAD, clean-state, task-fingerprint, and isolation
   confirmations even though no first write follows.
4. The only admissible live result is exactly one
   `OWNER_AGENT_RESPONSE_V1` document with `state: progress`,
   `work.commits: []`, `work.paths: []`,
   `handoff.checkpoint_commit: null`, `question: null`, and `push: null`.
   The response must copy the exact invocation identity and report unchanged
   repository state.
5. The Project Manager independently verifies the pre/post live state and
   persists the disposition in Project Manager-owned artifacts. Any failed,
   malformed, stale, widened, write-shaped, or unverifiable result leaves
   `PMR-087` open and blocked and leaves `PMR-086` blocked.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation, source
admission, or implementation authorization. It does not start or authorize
`PMR-086` or any other write-enabled task, alter the component owner response
schema generally, permit a component handoff write for the probe, authorize a
push, or grant the Project Manager general component write or execution
authority.

## Follow-up

- After the containing Project Manager commit is published locally and exact
  generated tasking is current, invoke only `PMR-087`, verify the response and
  unchanged live state against this record, and persist the PM-side
  disposition. Do not start `PMR-086` unless `PMR-087` is later verified and
  closed.

## Provenance

- Written by the `project-manager` agent from the inputs and explicit
  responsible-human authorization above. No owner was invoked and no
  component was modified.
