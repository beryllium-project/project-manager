## Project Manager return

Use this section in the component-owned handoff document named by its Project
Manager card when returning work tied to a Project Manager request or ledger
row. The component owner writes it; the Project Manager reads and verifies it.

| Related IDs | Result | Evidence | Validation | Repository state | Requested Project Manager action |
| --- | --- | --- | --- | --- | --- |
| `PMR-NNN`; `PML-NNNN` if applicable | `completed`, `partial`, `blocked`, or `information` | Commit and repository-relative paths | Commands/checks and known failures | Branch, upstream, ahead/behind, push or backup state, and active-session state | Exact request closure, ledger update, follow-up request, or registry refresh |

Rules:

- Name exact commits and paths; do not report only a conversational summary.
- Preserve known validation failures and claim limits.
- State whether another session remains active, even if the worktree is clean.
- Do not treat the return as Project Manager acknowledgement; acknowledgement
  is the verified closure of the related `PMR-NNN`.
- Do not grant acceptance, approval, sign-off, licensing, publication,
  release, formal verification, hardware validation, or risk acceptance.
