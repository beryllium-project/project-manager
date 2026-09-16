# cheri-riscv-notes-repo

- **Workspace entry:** `../cheri-riscv-notes-repo` (tracked symlink to
  `../copilot/gim/cheri-riscv-notes`)
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
- **Observed state:** clean `docs/reconcile-project-status` at owner commit
  `ae09213`, synchronized 0/0 with
  `origin/docs/reconcile-project-status`. The commit preserves the former 21
  changed entries, including the corpus validator and workflow; `PMR-029` and
  remote-access request `PMR-020` are closed. `main` / `origin/main` remain at
  `6553092`. The committed handoff/status still describe the pre-push topic
  state (`PMR-051`)

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
node automation/build-wiki.mjs ../wiki-build <owner>/<repo>
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
public mirror; and reconciliation of the committed handoff/status with the
now-synchronized topic branch (`PMR-051`). Topic backup is evidenced by the
matching remote-tracking ref at `ae09213`; the authentication mechanism
remains `unknown` (`PMR-020` closed on the observed backup result).

The approved future active home is
`agentic-os-research/cheri-riscv-notes`, retaining the current slug
(`PMD-20260914-003`, `PMR-046`). The bounded local D0 inventory is
`PMD-20260914-004`; the guided owner inventory closes `PMR-049` in
`PMD-20260915-001`, and the organization rename is complete in
`PMD-20260915-003`. `PMR-046` is P1 under `PMD-20260916-002`: preserve
`main`, `docs/reconcile-project-status`, required refs, checked-in Wiki state,
and hosted issues 2 and 3; make the verified private successor `origin`;
retain the internal home as an inactive-reference remote; and leave the
tracked symlink unchanged. Repository creation, remote changes, hosted-state
migration, and pushes require explicit same-turn responsible-human
confirmation. No repository is public-approved now. The `sok/`
artifact is branded the
CHERI-RISC-V SoK and is the first publication/Pages candidate only after the
license, authorship, public-mirror, and corpus-integrity gates
close. The existing internal repository then remains an inactive reference;
no symlink or remote changes occur before owner verification. `PMR-071` asks
the owner-facing instructions to map `check Project Manager tasking` to the
exact fail-closed resolver without session-history fallback; it changes no
corpus or publication gate.
