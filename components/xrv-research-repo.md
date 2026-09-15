# xrv-research-repo

- **Workspace entry:** `../xrv-research-repo` (tracked symlink to
  `../copilot/gim/xrv-research`)
- **Ownership:** private research survey; agent-owned; the Project Manager
  maintains the parent symlink object and writes here only to carry requests
  under the standing carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`. XRV source intake remains
  request-only because its `review-log.md` contract requires owner-created
  review records and inbox notes; class 3 is limited to Project Manager-role
  wording
- **Agent:** none
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `COLLAB.md`, `review-log.md`
- **Observed state:** the symlink resolves to the clean canonical repository
  on `main` at `d618935`, one ahead of reachable private `backup/main` at
  `706e708`. The old `origin/main` remains at `ca41490` in the unreachable
  namespace. `706e708` reconciles the missing intake history; `d618935` adds
  the owner-controlled collaboration interface and four new intake records.
  The responsible human reports the deep-research session complete; no
  successor XRV commit is observed

## Role

Private CHERI-first hypervisor survey. It separates incoming material,
reviewed material, and durable provenance through `review-inbox/`,
`review-done/`, and `review-log.md`. Root `COLLAB.md` separately records
completed downstream consumption; it is not source intake. Reviewed
non-CHERI comparisons include Supervisor Domain Isolation / SmMTT.

## Boundaries and conventions

- Keep the focus CHERI-first and label non-CHERI systems as comparisons.
- Established results, architectural inference, and proposed future work must
  remain visibly distinct.
- Preserve the stable review IDs, status values, provenance history, and
  deletion rules in `review-log.md`.
- Historical IDs `REV-20260904-001..009` remain reserved. Their pointers are
  currently materialized as `REV-20260914-001..009` at `706e708`; this is a
  reconciliation, not identifier reuse or a reversal of historical ledger
  dispositions.
- `PMQ-017..020` are pointer-only `arrived` records
  `REV-20260914-010..013` at `d618935`, pending owner review as non-CHERI
  comparisons.
- Guest agents follow the exact append-only budget in `COLLAB.md`; only the
  XRV owner integrates a `collab/*` branch.
- Update `HANDOFF.md` before every push from that repository and include the
  update in the pushed change set.

## Commands

No configured build, test, or lint toolchain.

## What the Project Manager may request

`PMR-025` and `PMR-034` are closed by owner commits `706e708` and `d618935`.
The Project Manager may request owner review and disposition of
`REV-20260914-001..013` or report completed-use feedback through the
owner-controlled collaboration protocol. Nothing authorizes the Project
Manager to allocate or change review IDs, integrate guest branches, edit
research, or push. Pushing local commit `d618935` to reachable `backup`
remains a separate owner gate (`PMR-039`). `PMR-040` asks the XRV owner to
review the proposed architecture in analysis-workbook commit `a46dba2`.

After D0, the approved active identity is
`agentic-os-research/cheri-hypervisor-research`
(`PMD-20260914-003`, `PMR-045`). The former experimental/unknown name becomes
a historical name. It is not an alias unless the owner later chooses a
GitHub rename or transfer rather than the default new-active-repository
mechanism. The bounded local D0 inventory is `PMD-20260914-004`;
the guided owner inventory is closed by `PMD-20260915-001` / `PMR-049`, and
the successor starts private. The organization rename is complete
(`PMD-20260915-003`), so `PMR-045` is repository-owner actionable.
Microsoft-origin repository state remains an inactive historical
reference. The current local path and tracked symlink do not move without a
later explicit target-specific direction.
