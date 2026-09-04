# cheri-riscv-notes-repo

- **Workspace entry:** `../cheri-riscv-notes-repo` (tracked symlink to
  `../copilot/gim/cheri-riscv-notes`)
- **Ownership:** internal GIM research repository; agent-owned; the Project
  Manager writes nothing here and only maintains the parent symlink object
- **Agent:** none
- **Local instructions to read first:** repository `README.md` and any
  contributor notes; no `.github/copilot-instructions.md` observed
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
