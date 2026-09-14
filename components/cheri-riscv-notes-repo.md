# cheri-riscv-notes-repo

- **Workspace entry:** `../cheri-riscv-notes-repo` (tracked symlink to
  `../copilot/gim/cheri-riscv-notes`)
- **Ownership:** internal GIM research repository; agent-owned; the Project
  Manager maintains the parent symlink object and writes here only to carry a
  class-3 Project Manager-role wording request under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`. Class 2 does not apply: `references/*.md` and
  `references.bib` are generated exports of the owner's reference database
  behind human gate D4 (`meta/handoff.md`: never hand-edit; approval before
  anything reaches `included`/`references.bib`), so source pointers stay
  request-only (`PMR-009`)
- **Agent:** none
- **Local instructions to read first:** `README.md`, `CONTRIBUTING.md`,
  `meta/handoff.md` (non-standard handoff path; records the reference
  database, gate D4, CRLF and commit-trailer conventions), `automation/design.md`,
  `automation/schema.md`, and the `.github/` policy files; no
  `.github/copilot-instructions.md` observed. `CONTRIBUTING.md`'s hand-add
  reference steps contradict `meta/handoff.md`; the stricter handoff is
  followed
- **Observed state:** dirty `docs/reconcile-project-status` at `6553092`,
  with no upstream and 21 changed entries (19 modified tracked paths plus
  untracked `.github/workflows/` and
  `automation/validate-corpus.mjs`). The component handoff identifies this as
  an active 2026-09-11 integrity pass (`PMR-029`); the Project Manager leaves
  it untouched

## Role

Internal CHERI / CHERI-RISC-V knowledge base and SoK corpus. The in-repo
`wiki/` tree is the source of truth for the generated GitHub Wiki;
`references/references.bib` and the annotated reference indexes are generated
exports of the research corpus.

## Boundaries and conventions

- Keep `wiki/` authoritative over the generated GitHub Wiki; use relative links
  in maintained pages.
- Every non-obvious factual claim carries a stable citekey with primary-source
  verification. Unverifiable sources are marked `[UNVERIFIED]` and tracked.
- Do not hand-edit generated bibliography exports. Automation cannot promote a
  reference to the included corpus without human approval.
- The repository is internal, not public; licensing is unresolved. Follow its
  public-mirror checklist before any public distribution.

## Commands (run by the human, from the repository root)

```sh
node automation/build-wiki.mjs ../wiki-build <owner>/<repo>
```

The current dirty topic branch introduces a dependency-free corpus validator,
but it is not yet committed and therefore is not registered here as a durable
maintained command.

## What the Project Manager may request

Human-gated inclusion of routed sources (`PMR-009`, P4: the reference database
is a SQLite store in a Copilot session on another machine, so the two
`PMQ-008`/`PMQ-011` pointers are entered there; exact metadata in
`../outbox/OWNER-RUNBOOK.md`); resolution of the content license before any
public mirror; and, since 2026-09-06, a decision on how this workstation
authenticates to `origin` (`PMR-020`, P2: the human-run
`../scripts/owner-actions.sh` fetch failed with an authentication error on
2026-09-05 and 2026-09-06, so the live backup state is `unknown`; the
worktree is now dirty on the no-upstream topic branch under `PMR-029`).

The approved future active home is
`agentic-os-research/cheri-riscv-notes`, retaining the current slug
(`PMD-20260914-003`, `PMR-046`). The `sok/` artifact is branded the
CHERI-RISC-V SoK and is the first publication/Pages candidate only after the
current branch, license, authorship, public-mirror, and corpus-integrity gates
close. The existing internal repository then remains an inactive reference;
no symlink or remote changes occur before owner verification.
