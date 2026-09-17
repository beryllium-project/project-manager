## Project Manager return

Use this section in the component-owned handoff document named by its Project
Manager card when returning work tied to a Project Manager request or ledger
row. The component owner writes it; the Project Manager reads and verifies it.

| Related IDs | Result | Evidence | Validation | Repository state | Requested Project Manager action |
| --- | --- | --- | --- | --- | --- |
| `PMR-NNN`; `PML-NNNN` if applicable | `completed`, `partial`, `blocked`, `needs_human`, `refused`, or `information` | Commit and repository-relative paths | Commands/checks and known failures | Branch, upstream, ahead/behind, push or backup state, and active-session state | Exact request closure, human question ID, ledger update, follow-up request, blocker, or registry refresh |

Rules:

- Name exact commits and paths; do not report only a conversational summary.
- Preserve known validation failures and claim limits.
- State whether another session remains active, even if the worktree is clean.
- Before a PM-invoked owner worker returns `needs_human`, `completed`,
  `partial`, `blocked`, or `refused`, commit this checkpoint when repository
  state permits. If dirty or active state prevents a checkpoint, state that
  explicitly and report no success-shaped result.
- `progress` belongs only in the live `OWNER_AGENT_RESPONSE_V1` channel; it is
  not a durable result and never acknowledges a request.
- A `needs_human` return names the stable question ID from
  `templates/owner-agent-response.md`; the owner never calls `ask_user`.
- Do not treat the return as Project Manager acknowledgement; acknowledgement
  is the verified closure of the related `PMR-NNN`.
- Do not grant acceptance, approval, sign-off, licensing, publication,
  release, formal verification, hardware validation, or risk acceptance.
