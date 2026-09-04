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
- **Observed state:** see `../../COMPONENTS.md`

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

No general test runner exists.

## What the Project Manager may request

Human-gated inclusion of routed sources; resolution of the content license
before any public mirror.
