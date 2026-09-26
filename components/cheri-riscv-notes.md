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
  `automation/schema.md`, and the `.github/` policy files. PMR-071 adds
  `.github/copilot-instructions.md` and maintained
  `automation/validate-project-tasking.mjs`; `CONTRIBUTING.md`,
  `meta/decisions.md`, and `meta/handoff.md` remain controlling
- **Observed state:** dirty `docs/reconcile-project-status` at unchanged
  PMR-009 return HEAD `6cb15e3`, behind 0 / ahead 7 of last-fetched private
  active `origin/docs/reconcile-project-status` `9a4c5ef`; `main` /
  `origin/main` remain `6553092`. Thirteen modified paths span
  `meta/roadmap.md`, `meta/status.md`, three reference files, six SoK files,
  and two Wiki pages. The component handoff still contains only the verified
  PMR-009 return and no return for these edits. The responsible human
  classified this state as `unfinished`; it is an active coordination lock
  and no new CHERI owner session may launch. `PMR-009`, `PMR-051`, and
  `PMR-071` remain closed and must not be rerun. `PMR-093` and dependent
  `PMR-096` remain open but blocked until the existing owner session
  validates, commits or explicitly returns a blocked result, refreshes
  `meta/handoff.md`, and leaves the worktree clean. Inactive `gim-inactive`
  preserves the old internal home, and private `origin/archive/gim-wiki`
  preserves complete Wiki history through `cd7dc81`.

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
Validate run for preserved revision `ae09213` and successor topic history
through `9a4c5ef`. Topic backup is evidenced by the
matching active private `origin` ref at `9a4c5ef`; the authentication mechanism
remains `unknown` (`PMR-020` closed on the observed backup result). PMR-071 is also closed:
exact fail-closed startup instructions, a maintained 27-mutation regression,
and workflow validation are local through return `6ac70af`; PMR-093 tracks
their backup. PMR-009 adds canonical/curated metadata-only entries
`seaborn2015exploiting` and `ender2020unpatchable`; no third-party content or
D5/publication gate follows.

The current thirteen-file dirty owner session is separate from PMR-009 and is
unfinished by responsible-human statement. Preserve it in place; do not
launch PMR-093 or PMR-096, push, merge, publish, enable Pages, or infer a new
source or D5 disposition until the owner returns a clean durable checkpoint.

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
corpus or publication gate.
