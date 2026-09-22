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
  before a reference enters the canonical inventory, so `PMR-009` remains an
  owner triage request
- **Agent:** none
- **Local instructions to read first:** `README.md`, `CONTRIBUTING.md`,
  `meta/handoff.md` (non-standard handoff path), `automation/design.md`,
  `automation/schema.md`, and the `.github/` policy files; no
  `.github/copilot-instructions.md` observed. `CONTRIBUTING.md`,
  `meta/decisions.md`, and `meta/handoff.md` are reconciled at `ae09213`
- **Observed state:** clean `docs/reconcile-project-status` at owner return
  `9a4c5ef`, synchronized with private active
  `origin/docs/reconcile-project-status`; `main` / `origin/main` remain
  `6553092`. Inactive `gim-inactive` preserves the old internal home, and
  private `origin/archive/gim-wiki` preserves complete Wiki history through
  `cd7dc81`. `PMR-046`, `PMR-029`, and `PMR-020` are closed; `PMR-051`
  remains for the consolidated logical/physical path correction plus a
  structured current-head/validation/backup/session return

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
node automation/build-wiki.mjs ../wiki-build [owner/repo]
```

The topic branch adds a dependency-free corpus validator as a committed
maintained command:

```sh
node automation/validate-corpus.mjs
```

## What the Project Manager may request

Human-gated inclusion of routed sources (`PMR-009`, P3: the reference database
workflow is BibTeX-first at `ae09213`; no SQLite database is committed and any
temporary database must reconcile to `references/references.bib`. The two
`PMQ-008`/`PMQ-011` pointers require the owner's D4 admission decision before
any class-2 metadata entry; exact
metadata is in `../outbox/OWNER-RUNBOOK.md`); resolution of the content license before any
public mirror; and the path correction plus structured current-state return
still requested by `PMR-051`. The handoff/status already record the successful 2026-09-16
Validate run for preserved revision `ae09213` and successor topic history
through `9a4c5ef`. Topic backup is evidenced by the
matching active private `origin` ref at `9a4c5ef`; the authentication mechanism
remains `unknown` (`PMR-020` closed on the observed backup result).

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
