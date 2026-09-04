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
- `COLLAB.md` at `8b91ebd` offers a "designated parent Project Manager" a
  housekeeping budget that includes integrating compliant `collab/*` branches
  and committing coordination metadata inside this repository. The
  `project-manager` component exercises only the narrower standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`: it never integrates `collab/*` branches or edits
  research, and it commits here only for carried class-2 and class-3
  requests. `PMR-012` (superseding `PMR-010`) aligns the wording.

## Commands

No configured build, test, or lint toolchain. Validation is editorial review
by the owner.

## What the Project Manager may request

Owner reconciliation of the owner-status table and `HANDOFF.md` after guest
integrations; a backup decision (the configured `origin` names the unreachable
`jamorris_microsoft` namespace, so this component has no working off-machine
backup); registration of sources routed from component queues under the
owner's rules; alignment of the `COLLAB.md` and `HANDOFF.md` Project Manager
role wording with the standing carry authority (`PMR-012`, carried by the
Project Manager itself).
