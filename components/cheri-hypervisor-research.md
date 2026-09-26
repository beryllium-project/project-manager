# cheri-hypervisor-research

- **Workspace entry:** `../cheri-hypervisor-research` (tracked symlink to
  `../agentic-os-research/cheri-hypervisor-research`)
- **Ownership:** private research survey; agent-owned; the Project Manager
  maintains the parent symlink object and writes here only to carry requests
  under the standing carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`. XRV source intake remains
  request-only because its `review-log.md` contract requires owner-created
  review records and inbox notes; class 3 is limited to Project Manager-role
  wording
- **Agent:** none
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `COLLAB.md`, `review-log.md`
- **Observed state:** the renamed tracked symlink resolves to clean `main` at
  `60d5ceb`, synchronized behind 0 / ahead 0 with private active
  `origin/main`. The current handoff records the responsible human's explicit
  private push scope as all nine previously local commits after `d618935`
  plus a separate current research-review change set. This independently
  closes backup-only `PMR-075`, `PMR-092`, and `PMR-094`; the broader push
  does not convert the later source review into a Project Manager
  disposition. `legacy-backup/main` remains `706e708`; `msft-inactive/main`
  remains `ca41490` and was previously unreachable with the active
  credential. `PMR-040`, `PMR-045`, `PMR-058`, and `PMR-072` remain closed.

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
- `PMQ-017..020` entered as pointer-only `arrived` records
  `REV-20260914-010..013` at `d618935`. The owner handoff at `60d5ceb`
  reports all current review-log records incorporated; that later research
  state is not a Project Manager queue or source-admission decision.
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
research, or push. `PMR-039` is superseded because active private
`origin/main` preserves `d618935`. The later responsible-human-authorized
private fast-forward through synchronized `60d5ceb` also backs up owner
documentation commits `22095a1` and `456c70b`, PMR-040 commits `38a69bd` and
`d5d33a2`, and the PMR-058/072 range through `07e86ab`; backup-only
`PMR-075`, `PMR-092`, and `PMR-094` are closed on that observed state.
`PMR-040` is closed by qualified selective incorporation work `38a69bd` and
HANDOFF-only return `d5d33a2`: source-aware record `REV-20260922-001`
incorporates immutable mutation-record and cross-layer assurance obligations
as proposed architecture, corrects rollback wording, and defers the Helium
parity plan without selecting a target or comparator baseline. `PMR-092`
tracks those two local commits after PMR-075.
PMR-058 is closed by work `81ba24e`, provenance correction `40e076f`, and
return `07e86ab`: unique pointer-only `REV-20260922-002..004` are `arrived`
and awaiting review, with no source adoption, support claim, or Beryllium
implication. PML-0028/0029/0031 source statuses were mirrored at
analysis-workbook carry `5a646df`. PMR-072 is closed by work `4c567fa` and
the same final return: exact tasking startup and current path wording are
active without research or review-ID changes.
The later owner research review at synchronized `60d5ceb` reports those and
the repository's other current review records incorporated. It does not
retroactively change PMR-058's bounded pointer-arrival return, the queue
ledger, or any Project Manager support, adoption, or publication gate.
After `PMR-052`, `PMR-053` separately asks the owner to review only materially
relevant returned cap-talk threads.

The active private identity is
`agentic-os-research/cheri-hypervisor-research`
(`PMD-20260914-003`, `PMR-045`, closed at owner return `456c70b`). The former experimental/unknown name is
a historical name. It is not an alias unless the owner later chooses a
GitHub rename or transfer rather than the default new-active-repository
mechanism. The bounded local D0 inventory is `PMD-20260914-004`;
the guided owner inventory is closed by `PMD-20260915-001` / `PMR-049`, and
the successor starts private. The organization rename is complete
(`PMD-20260915-003`). The verified successor is `origin`; the
existing private backup and old Microsoft-origin home remain explicit
inactive-reference remotes. History through `d618935`, including `REV-*` and
`COLLAB.md`, is reachable. Owner documentation commits `22095a1` and
`456c70b`, PMR-040 commits `38a69bd` and `d5d33a2`, and the PMR-058/072 range
`d5d33a2..07e86ab` are now contained by synchronized private
`origin/main` at `60d5ceb`; their three backup requests are closed.
Microsoft-origin repository state remains an inactive historical
reference. The responsible human later renamed and retargeted the workspace
symlink to the verified active successor. PMR-072 is closed: the owner context
maps `check Project Manager tasking` to the exact fail-closed resolver without
session-history fallback and the handoff records current paths. No research,
review-ID, collaboration, component push, or publication change was included.
