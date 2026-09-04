# xrv-research-repo

- **Workspace entry:** `../xrv-research-repo` (tracked symlink to
  `../copilot/gim/xrv-research`)
- **Ownership:** private research survey; agent-owned; the Project Manager
  writes nothing here and only maintains the parent symlink object
- **Agent:** none
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `review-log.md`
- **Observed state:** see `../../COMPONENTS.md`

## Role

Private CHERI-first hypervisor survey. It separates incoming material,
reviewed material, and durable provenance through `review-inbox/`,
`review-done/`, and `review-log.md`. Reviewed non-CHERI comparisons include
Supervisor Domain Isolation / SmMTT.

## Boundaries and conventions

- Keep the focus CHERI-first and label non-CHERI systems as comparisons.
- Established results, architectural inference, and proposed future work must
  remain visibly distinct.
- Preserve the stable review IDs, status values, provenance history, and
  deletion rules in `review-log.md`.
- Update `HANDOFF.md` before every push from that repository and include the
  update in the pushed change set.

## Commands

No configured build, test, or lint toolchain.

## What the Project Manager may request

Review-queue intake of routed sources (most `PMQ` rows from the analysis
workbook suggest this owner); nothing that changes review IDs or statuses.
