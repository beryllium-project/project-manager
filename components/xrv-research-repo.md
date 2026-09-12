# xrv-research-repo

- **Workspace entry:** `../xrv-research-repo` (tracked symlink to
  `../copilot/gim/xrv-research`)
- **Ownership:** private research survey; agent-owned; the Project Manager
  maintains the parent symlink object and writes here only to carry requests
  under the standing carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 2: pointer-only
  records under the `review-log.md` record contract or `references.md`;
  class 3: Project Manager-role wording), committing inside this repository
- **Agent:** none
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `review-log.md`
- **Observed state:** the relocated symlink resolves to the clean canonical
  repository on `main` at `ca41490`, 0 behind / 0 ahead of `origin/main` as
  of the last fetch. That remote remains in the unreachable
  `jamorris_microsoft` namespace, so live backup state is unknown. The
  previously recorded commit `7314e2f` is absent from this repository, and
  its `review-log.md` lacks the nine `REV-20260904-001..009` rows
  (`PMR-025`)

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

Reconciliation of the nine source-intake records formerly observed at
`7314e2f` (`PMR-025`, P1), including a reachable backup decision for any
restored or replacement records, then ordinary review-queue intake of routed
sources. The current canonical repository's remote-tracking `origin/main` is
present at `ca41490`, but live reachability is unknown; the former backup
request `PMR-013` is superseded by the combined missing-record and backup
reconciliation. Nothing here authorizes the Project Manager to invent, reuse,
or change owner review IDs.
