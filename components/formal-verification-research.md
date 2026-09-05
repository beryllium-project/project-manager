# formal-verification-research

- **Workspace entry:** `../formal-verification-research/` (ignored direct
  checkout)
- **Ownership:** owner-maintained research repository; guests follow
  `COLLAB.md`; the Project Manager writes here only to carry requests under
  the standing carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 2: metadata-only entries in
  `sources/bibliography.md`; class 3: Project Manager-role wording in
  `COLLAB.md` and `HANDOFF.md`), committing inside this repository; research
  content and `collab/*` integration stay owner-only
- **Agent:** none
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `COLLAB.md`, `HANDOFF.md`
- **Observed state:** see `../../COMPONENTS.md`

## Role

Owner-maintained Markdown research on verified systems, proof tooling, and
verification strategy for Beryllium. `notes/` contains one subject study per
file, `comparison/` synthesizes them, `sources/bibliography.md` records
primary sources, and `workstreams/` holds longer investigations. The
`workstreams/beryllium/` material consumes a read-only Helium reference and
produces verification strategy for Beryllium; it does not change Helium or
claim that Helium is formally verified.

## Boundaries and conventions

- Cross-project consumption is governed by `COLLAB.md`. Unless explicitly
  acting as the repository owner, the research is read-only except for the
  narrowly defined local `collab/*` branch and the guest agent's own ledger
  section. Only the owner integrates guest branches; guests must not push.
- One subject study per Markdown file under `notes/`; workstream directories
  for sustained inquiry; `comparison/` for synthesis.
- Non-obvious factual claims carry inline citations to primary papers,
  repositories, specifications, or vendor documentation. Vendor claims stay
  visually distinct from independently checked facts; disagreement and
  uncertainty are stated explicitly.
- Downloaded PDFs stay out of Git; stable URLs and DOI metadata go in
  `sources/bibliography.md`.
- Guest agents must not edit research, handoff, scratch, reference-clone, or
  another agent's ledger content.
- `COLLAB.md` at `8b91ebd` offered a "designated parent Project Manager" a
  housekeeping budget that included integrating compliant `collab/*` branches
  and committing coordination metadata inside this repository. At `ccb48f6`
  (carried `PMR-012`, 2026-09-04) `COLLAB.md` and `HANDOFF.md` describe the
  narrower standing carry authority
  `../records/decisions/PMD-20260904-003-standing-carry-authority.md`
  instead: the Project Manager never integrates `collab/*` branches or edits
  research, and it commits here only for carried class-2 and class-3
  requests. The heading "Parent Project Manager housekeeping budget" was kept
  because the owner-only `.github/copilot-instructions.md` and `README.md`
  refer to it; those two files still describe the old budget (`PMR-014`).
  At `8246147` (carried `PMR-017`, 2026-09-05) the "Ledger integration
  procedure" attributes the `git switch main` / `git branch --no-merged`
  block to the research owner alone; the Project Manager runs none of those
  commands and only reports what its read-only inspection observes.
- `bash ./scripts/inspect-components.sh refs formal-verification-research`
  (read-only, 2026-09-05T05:15Z, at `8246147`) listed two local `collab/*`
  branches, `collab/helium-te-fv-gpt56sol-20260811-pathfinder` (`14f06d5`)
  and `collab/helium-te-fv-gpt56sol-20260812-trap-effect` (`ff67d02`), both
  merged into `main` (no unmerged `collab/*` branch), consistent with the
  owner-status table's two integrated guest logs; `origin/main` is stale at
  `8b91ebd`.
- Class-2 pointers carried by the Project Manager live in the
  `sources/bibliography.md` section "Routed pointers awaiting owner triage",
  in the file's own entry format, never interleaved with the owner's curated
  topic sections; the owner moves, annotates, or removes them
  (`PMD-20260904-004`). Five were recorded at `ccb48f6` (`PMR-008`).

## Commands

No configured build, test, or lint toolchain. Validation is editorial review
by the owner.

## What the Project Manager may request

Owner reconciliation of the owner-status table and `HANDOFF.md` after guest
integrations; a backup decision (the configured `origin` names the unreachable
`jamorris_microsoft` namespace, so this component has no working off-machine
backup, and the carried commits `ccb48f6` and `8246147` are local; `PMR-001`);
alignment of the owner-only `.github/copilot-instructions.md` bullet and
`README.md` sentence with the carried `COLLAB.md` wording, and triage of the
five routed pointers (`PMR-014`). `PMR-012` and `PMR-008` were carried by the
Project Manager itself on 2026-09-04 (`ccb48f6`) and `PMR-017` on 2026-09-05
(`8246147`).
