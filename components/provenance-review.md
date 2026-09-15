# provenance-review

- **Workspace entry:** `../provenance-review/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry a class-3 Project Manager-role
  wording request under the standing carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`, committing inside
  this component; it has no queue and no source index for routed pointers
- **Agents:** `provenance-review` (user-invocable orchestrator),
  `provenance-code-lineage` and `provenance-research` (write-disabled
  specialists); skill `provenance-analysis`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** clean `main` at `9bfbab3`, synchronized with
  `origin/main` as of the last fetch; the owner added a stack-type FAQ note
  in `DOCUMENTATION-NOTES.md`. `PMD-20260914-003` keeps this independent
  provenance component separate; its future organization placement is not
  yet decided

## Role

Independent provenance and attribution workspace. Its agent analyzes a
user-selected aspect across the other components, local Beryllium research,
and public primary sources, and preserves durable review packages
(`reviews/PRV-YYYYMMDD-NNN-*/`), source metadata, inaccessible-resource
records, a human-readable hyperlinked prior-art summary with a clear latest
iteration, and publication-preparation evidence.

## Boundaries and conventions

- Every other component is a read-only, untrusted input.
- After `PMR-066`, the exact read-only Project Manager tasking resolver is a
  single startup-discovery exception outside a provenance package. It is not
  target execution and grants no other sibling command.
- Uses only its maintained scripts: `scripts/new-review.sh` to scaffold,
  `scripts/git-readonly.sh` to inspect a component,
  `scripts/render-review.py` to render HTML, and
  `scripts/validate-review.sh` plus `tests/validate-agent.sh` to validate.
- Review packages default to private. Publication, licensing, and sign-off are
  separate human gates that the component never grants or records as granted.
- Has an `inbox/` for user-supplied material and no outbound queue.

## Commands (run by the human, from `../provenance-review/`)

```sh
/agent provenance-review                  # in Copilot CLI
bash ./tests/validate-agent.sh
bash ./scripts/validate-review.sh reviews/PRV-YYYYMMDD-NNN-short-name
python3 ./scripts/render-review.py --check reviews/PRV-YYYYMMDD-NNN-short-name
git diff --check
```

## What the Project Manager may request

A new aspect review, an iteration of an existing review, or registration of
`project-manager/` in its `RESEARCH-SOURCES.md` if that component chooses to
cite Project Manager records. `PMR-066` asks the orchestrator to map
`check Project Manager tasking` to the exact fail-closed resolver without
session-history fallback.
