# Organization rename completed

- **Record ID:** `PMD-20260915-003`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's completion of the approved GitHub organization
rename from `Agentic-OS-Development` to `agentic-os-research`. This changes
the live organization identity and clears the organization-rename dependency
from the four approved private successor targets. It changes no local
component path, symlink, repository remote, repository visibility, or
publication state.

Observed local state when recorded: parent `0f5d17b`; Project Manager
`fd085a8`; Beryllium `65f6d89`; XRV `d618935`; OS-security `f2edd17`; CHERI
notes topic `ae09213`; all other component revisions match
`../COMPONENTS.md`.

## Inputs

- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
  at `fd085a8`: records the responsible human's prior approval to rename
  `Agentic-OS-Development` to `agentic-os-research`.
- `records/decisions/PMD-20260915-001-close-d0-owner-inventory.md` at
  `fd085a8`: confirms the four private successor names and closes the
  inventory gate.
- Responsible-human return on 2026-09-14 local time: "done"; in the immediate
  guided confirmation, "Yes - it is now agentic-os-research."

## Disposition

The organization rename is recorded complete. The active organization name
is `agentic-os-research`; `Agentic-OS-Development` is the former organization
name.

The organization-rename dependency is removed from `PMR-043`, `PMR-044`,
`PMR-045`, and `PMR-046`. Their repository-specific dependencies remain:

- `PMR-043`: create and verify the private Beryllium successor through its
  owner.
- `PMR-044`: first resolve `PMR-027`, then create and verify the private
  OS-security successor and separately perform the human-only quarantine
  transfer.
- `PMR-045`: create and verify the private CHERI hypervisor research
  successor before any symlink change.
- `PMR-046`: private successor establishment is actionable; licensing,
  authorship, public-mirror, and corpus-integrity gates remain before any
  publication action.

No automatic remote redirect, repository transfer, repository creation,
membership change, or local configuration change is inferred from an
organization rename.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, or hardware validation. It does not authorize the Project
Manager to create a repository, change a remote, push history, retarget a
symlink, change visibility, move restricted material, or publish.

## Follow-up

- Start the Beryllium owner session in `../beryllium-repo` and ask it to check
  Project Manager tasking for `PMR-043`. Repository creation, push, and remote
  changes remain separately confirmed owner actions.

## Provenance

- Written by the `project-manager` agent from the responsible human's exact
  completion statement and guided confirmation. The Project Manager did not
  execute or independently authenticate the rename.
