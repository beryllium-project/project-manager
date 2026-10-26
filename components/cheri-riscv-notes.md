# cheri-riscv-notes

- **Workspace entry:** `../cheri-riscv-notes` (tracked symlink to
  `../agentic-os-research/cheri-riscv-notes`)
- **Ownership:** internal GIM research repository; agent-owned; the Project
  Manager maintains the parent symlink object and writes here only to carry a
  class-3 Project Manager-role wording request under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`.
  At `ae09213`, `references/references.bib` is the durable canonical
  inventory and `references/*.md` are curated views; class 2 has a
  hand-editable target, but owner gate D4 requires explicit human approval
  before a reference enters the canonical inventory. The PMR-009 owner return
  records that path and two separate explicit D4 approvals
- **Agent:** none
- **Local instructions to read first:** `README.md`, `CONTRIBUTING.md`,
  `meta/handoff.md` (non-standard handoff path), `automation/design.md`,
  `automation/schema.md`, and the `.github/` policy files. PMR-071 added
  `.github/copilot-instructions.md` and maintained
  `automation/validate-project-tasking.mjs` (last recorded before the
  2026-10-21 replacement; both are absent from the current checkout);
  `CONTRIBUTING.md`,
  `meta/decisions.md`, and `meta/handoff.md` remain controlling
- **Observed state:** **unresolved** (`PMD-20261023-001`,
  `PMD-20261025-001`). On `l1` at 2026-10-25T22:38Z, after the
  responsible human's rsync from `lx2`, the checkout is in the state the
  128th turn recorded on `lx2`: `main` only at `888f658`, 0 / 0, one pack,
  empty reflogs, the same `ORIG_HEAD`, `FETCH_HEAD`, and `packed-refs`, and
  none of the recorded commits. No local copy of the three never-pushed
  commits (`8d1bc9d`, `7fb49f4`, `7f67154`) is therefore known on any
  workstation; they are presumed lost unless the human holds another copy,
  and their content (PMR-114 startup adoption, PMR-119 handoff wording) can
  be re-requested once the checkout is resolved. As first observed on
  `lx2` at 2026-10-23T03:15Z, the symlink target holds only `main` at
  `888f658a9d3c428543d3306ce3eae9de0742562b`, clean and 0 behind / 0 ahead
  of its only remote-tracking ref `origin/main`. Its working-tree files are
  dated 2026-10-21 and `meta/handoff.md` reads "As of: 2026-10-20". It has
  no `.github/copilot-instructions.md`, no
  `automation/validate-project-tasking.mjs`, and no Project Manager tasking
  startup, and its `meta/decisions.md` records D5 licensing (CC BY 4.0 for
  prose, MIT for code) as adopted, component-side. Maintained ref checks
  find none of the recorded commits below (`6553092`, `7f67154`,
  `34a8b50`, `8d1bc9d`, `7fb49f4`, `41e4125`, `4deec95`, `ae09213`,
  `9a4c5ef`, `cd7dc81`). The 128th-turn audit found, and the Project
  Manager confirmed by reading the checkout's Git metadata, that it is the
  same registered repository: its only remote, `origin`, is
  `agentic-os-research/cheri-riscv-notes`; `ORIG_HEAD` is the recorded
  `main` `6553092`; `FETCH_HEAD` is `34a8b50` from that remote's
  `docs/reconcile-project-status`; and `packed-refs` holds only `main` and
  `origin/main` at `888f658`. Its earlier history was replaced and pruned,
  and when it last fetched or pushed, the remote's `main` was `888f658`;
  file and metadata times place the replacement on 2026-10-21 between
  06:25:09Z (the workbook's DASICS session record still saw `7f67154`) and
  08:06:13Z (`packed-refs`), with no fetch since 2026-09-29. The Project
  Manager infers no cause, and the remote's current contents
  are unknown. The responsible human answered `unresolved` on 2026-10-23;
  the `l1` copy, then the only known location of the three unpushed
  commits, now holds none of them (`PMD-20261025-001`). The human-run
  read-only check is in `../outbox/OWNER-RUNBOOK.md` "P1 CHERI-RISC-V notes
  history check". Until a named decision resolves the checkout, the
  Project Manager makes no carry here and relies on nothing in this
  checkout's history. The last recorded state, on `l1`, follows: clean
  `docs/reconcile-project-status` at PMR-119 carry
  `7f671548a18bc426133b5b2102fa83a70cb3f9bc`, 0 behind / 3 ahead of the
  last-fetched private `origin/docs/reconcile-project-status` `34a8b50`;
  `main` /
  `origin/main` were then `6553092`. Owner work `41e4125` integrates exactly the
  thirteen D4-approved content paths; return `4deec95` changes only
  `meta/handoff.md`. Maintained validation passed, no remote operation
  occurred, and the recovery wrapper exited 0 with clean post-status and
  released reservation. PMR-106 carry `34a8b50` then updates only the stale
  handoff date and next action. `PMD-20260927-005` closes PMR-104 as
  acknowledgement only. PMR-105 is closed by exact private fast-forward
  `9a4c5ef -> 34a8b50`; other refs were preserved, final state is clean 0/0,
  and the single-use authorization is consumed. PMR-114 owner work
  `8d1bc9d` and handoff-only return `7fb49f4` add the SOT-bound startup
  contract and refresh current checkout paths; they were never pushed.
  Project Manager class-3 carry `7f67154` then changes only
  `meta/handoff.md`'s opening date and `Exact next action`, closing PMR-119;
  it was never pushed either, and none of the three has a known local copy
  since 2026-10-25 (`PMD-20261025-001`).
  The Project Manager verified both commit objects and the return parent
  through maintained inspection, and observed the branch clean with no owner
  writer lock at its last `l1` check before the 2026-10-21 replacement.
  `PMR-009`, `PMR-051`, `PMR-071`,
  `PMR-101`, `PMR-103`, `PMR-104`, `PMR-106`, `PMR-114`, and `PMR-119`
  remain closed; PMR-102 is
  superseded; `PMR-093` and `PMR-096` are withdrawn. As last recorded on
  `l1`, inactive `gim-inactive` preserved the old internal home, and private
  `origin/archive/gim-wiki` preserved complete Wiki history through
  `cd7dc81`; the current checkout has neither, and the remote's current
  contents are unknown. `PMD-20260928-001` selects a dedicated human-run
  `outbox/pmr105-push.sh`: corrected preflight and execution verified active
  account `xjamesmorris`, private target, `ADMIN`, writer lock, exact
  `9a4c5ef -> 34a8b50`, three heads, zero tags, other-ref preservation, and
  final clean 0/0. Do not rerun it.

## Role

Internal CHERI / CHERI-RISC-V knowledge base and SoK corpus. The in-repo
`wiki/` tree is the source of truth for the generated GitHub Wiki;
`references/references.bib` is the complete durable canonical citation
inventory; the annotated reference indexes are curated views and need not be
one-to-one with it.

## Boundaries and conventions

- Keep `wiki/` authoritative over the generated GitHub Wiki; use relative links
  in maintained pages.
- Every non-obvious factual claim carries a stable citekey with primary-source
  verification. Unverifiable sources are marked `[UNVERIFIED]` and tracked.
- Keep shared citekeys and metadata synchronized between
  `references/references.bib` and any curated view containing the same
  reference. Automation cannot accept a reference into the canonical
  inventory without human approval.
- The repository is internal, not public; licensing is unresolved. Follow its
  public-mirror checklist before any public distribution.

## Commands (run by the human, from the repository root)

Last recorded before the 2026-10-21 replacement; the current checkout lacks
`automation/validate-project-tasking.mjs`, so its second command fails
until the checkout is resolved (`PMD-20261023-001`).

```sh
node --check automation/*.mjs
node automation/validate-project-tasking.mjs
node automation/build-wiki.mjs ../wiki-build [owner/repo]
node automation/validate-corpus.mjs
```

## What the Project Manager may request

PMR-009 is closed: under the BibTeX-first canonical workflow, its owner return
records PMQ-008 and PMQ-011 after separate D4 approvals at work `e95922f` /
return `6cb15e3`; no SQLite database is committed, and D5
licensing/redistribution/publication remains open. Future source admission
remains human-gated. The Project Manager may request resolution of the content
license before any public mirror. PMR-051 is closed: the handoff/status record corrected current
paths, remote-run evidence, and a structured return. The successful 2026-09-16
Validate run covers preserved revision `ae09213` and successor topic history
through `9a4c5ef`. Topic backup is evidenced by the
matching active private `origin` ref at `9a4c5ef`; the authentication mechanism
remains `unknown` (`PMR-020` closed on the observed backup result). PMR-071 is also closed:
exact fail-closed startup instructions, a maintained 27-mutation regression,
and workflow validation are local through return `6ac70af`. Historical
backup requests PMR-093/096 are withdrawn by `PMD-20260926-003`. PMR-009 adds
canonical/curated metadata-only entries
`seaborn2015exploiting` and `ender2020unpatchable`; no third-party content or
D5/publication gate follows.

The exact thirteen-file dirty set is separate from PMR-009. PMR-101 returned
`blocked` because `references/references.bib` and dependent
reference/synthesis corrections require a distinct D4 citation-review
decision. The responsible human deferred that fingerprint, then separately
authorized only two corrections in `meta/status.md`: align the Phase 0–9
headline with the Phase 9 scaffold/submission-open boundary, and remove the
resolved Intel MPX venue/DOI item from the missing-documents list. PMR-103
completed exactly that proposal revision and returned fingerprint
`8bfec674…` without staging content. `PMD-20260927-004` records
responsible-human D4 `approve_exact` for that exact set. PMR-104 completed:
work `41e4125` commits exactly those thirteen paths and return `4deec95`
records successful validation and a released reservation. The clean topic
branch was privately backed up through `34a8b50` (last recorded; the
remote's current contents are unknown); PMR-106 refreshes only the
handoff at that same tip. PMR-105 is closed and its authorization consumed.
Do not rerun its script, merge to `main`, publish, enable Pages, or infer a
new source or D5 disposition.

The active private home is
`agentic-os-research/cheri-riscv-notes`, retaining the current slug
(`PMD-20260914-003`, `PMR-046`, closed at owner return `9a4c5ef`). The bounded local D0 inventory is
`PMD-20260914-004`; the guided owner inventory closes `PMR-049` in
`PMD-20260915-001`, and the organization rename is complete in
`PMD-20260915-003`. The successor preserves
`main`, `docs/reconcile-project-status`, required refs, checked-in Wiki state,
and hosted issues 2 and 3; private `archive/gim-wiki` retains the full prior
Wiki history because the current organization plan has no private hosted
Wiki. The verified successor is `origin`, and the internal home is
`gim-inactive`. No repository is public-approved now. The `sok/`
artifact is branded the
CHERI-RISC-V SoK and is the first publication/Pages candidate only after the
license, authorship, public-mirror, and corpus-integrity gates
close. The existing internal repository remains the inactive
`gim-inactive` reference. The responsible human later renamed and retargeted
the workspace symlink to the verified active successor. `PMR-071` asks
the owner-facing instructions to map `check Project Manager tasking` to the
exact fail-closed resolver without session-history fallback; it changes no
corpus or publication gate. `PMR-114` is closed as acknowledgement of owner
work `8d1bc9db` and handoff-only return `7fb49f40`, which add the
SOT-bound startup/status anchor and refresh only the current checkout path
facts. The owner reports 35/35 negative tasking mutations and other listed
validation passed. The two commits remain unpushed; no corpus, citation,
D4/D5, merge, Pages, or publication gate changed. Project Manager class-3
carry `7f671548` closes PMR-119 by changing only `meta/handoff.md`'s opening
date and `Exact next action` to current PMR-114 state. The clean topic was
then 0 behind / 3 ahead; the carry was never pushed, has no known local
copy since 2026-10-25 (`PMD-20261025-001`), and changed no research,
corpus, source, gate, ref, remote, Pages, merge, or publication state.
