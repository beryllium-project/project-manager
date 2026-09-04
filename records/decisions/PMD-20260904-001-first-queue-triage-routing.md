# First queue triage: route PML-0001..PML-0016 to their suggested owners

- **Record ID:** `PMD-20260904-001`
- **Created:** 2026-09-04
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

How the Project Manager disposes of the sixteen analysis-workbook queue rows
`PMQ-001..PMQ-016`, ledgered as `PML-0001..PML-0016`, during the first
coordination turn on 2026-09-04. The record touches `analysis-workbook/`
(the queue source) and the three suggested owners `xrv-research-repo`,
`formal-verification-research/`, and `cheri-riscv-notes-repo`. Revisions
observed with `scripts/inspect-components.sh status` at 2026-09-04T16:15Z:
`analysis-workbook/` clean `main` at `2261659`; `xrv-research-repo` clean
`main` at `ca41490`; `formal-verification-research/` clean `main` at
`8b91ebd`; `cheri-riscv-notes-repo` clean `main` at `6553092`.

## Inputs

- `../analysis-workbook/outbox/pm-queue.md` at `2261659`: sixteen `new`
  rows, each with a stable URL or DOI, a suggested owner, sensitivity
  `public`, and a redistribution value (`approved` for PMQ-006, PMQ-010,
  PMQ-016; `not-approved`, metadata only, for the paywalled PMQ-014 and
  PMQ-015; `unknown` for the rest).
- `../analysis-workbook/sessions/AWB-20260829-001-post-g-install-readback-use-case/source-discoveries.md`
  at `2261659`: rows `DISC-001..DISC-016` give the workbook's reason for each
  suggestion and its own index check (`IDX-SET-001`) that found every source
  absent from the suggested owner.
- `../xrv-research-repo/review-log.md`, `references.md`,
  `riscv-hypervisors-research-stream.md`,
  `riscv-confidential-computing-research-stream.md`,
  `cheri-hypervisor-research-survey.md`, `review-inbox/`, and `review-done/`
  at `ca41490`: a read-only text search for XSA-286, XSA-321, XSA-302,
  XSA-148, XSA-304, RFC 9334 / RATS, Thunderclap, CVE-2022-1158, and Svvptc
  found no entry. The latest review record is `REV-20260817-001`.
- `../formal-verification-research/sources/bibliography.md`, `notes/`,
  `workstreams/`, and `comparison/` at `8b91ebd`: no bibliography entry for
  Petroni et al. 2004 (Copilot), NIST SP 800-193, Kauer 2007 (OSLO), IEC
  61508-2:2010, or Seshadri et al. 2004 (SWATT). IEC 61508 is named
  generically in
  `workstreams/beryllium/separation-kernels-and-certification.md` without a
  source entry for Part 2.
- `../cheri-riscv-notes-repo/references/` (`papers.md`, `blogs-articles.md`,
  `specs-standards.md`, `references.bib`), `wiki/`, and `sok/` at `6553092`:
  no entry for the Project Zero Rowhammer report or Ender et al. 2020
  (Starbleed).
- `../osr-claude/` at `f2edd17` (excluding `sources/restricted-microsoft/`):
  the names Kauer, SWATT, Thunderclap, Rowhammer, RFC 9334, and Svvptc occur
  only inside raw archived corpus text (mailing-list archives, paper text,
  QEMU series), not in a curated index. This is context only; `osr-claude/`
  is not a suggested owner.
- `queue/README.md` in this repository: `routed` means an owning component is
  identified and a `PMR-NNN` request raised; it maps to no analysis-workbook
  status edit, because the header of `../analysis-workbook/outbox/pm-queue.md`
  accepts only `accepted`, `duplicate`, `rejected`, or `deferred` from the
  Project Manager.
- `../analysis-workbook/AGENT-INTERFACE.md` at `2261659`, "Outbox pull
  protocol": names a different Project Manager-written set (`acknowledged`,
  `routed`, `integrated`, `declined`) for the same column. The two component
  documents conflict; the conflict was located by the `pm-auditor` pass of
  this turn and is raised as `PMR-011`.

## Disposition

1. Every one of `PML-0001..PML-0016` is set to `routed` on 2026-09-04. No row
   is a duplicate: the Project Manager's own read-only search of each
   suggested owner's index agrees with the workbook's `IDX-SET-001` check. No
   row is rejected: each source is within the stated scope of its suggested
   owner (hypervisor and RISC-V ISA material for `xrv-research-repo`;
   assurance, attestation, and certification precedent for
   `formal-verification-research/`; hardware-attack lineage relevant to
   tagged memory and FPGA implementations for `cheri-riscv-notes-repo`).
2. The routes are recorded as three owner requests: `PMR-007`
   (`xrv-research-repo`: PMQ-001, 002, 003, 004, 005, 006, 009, 013, 016),
   `PMR-008` (`formal-verification-research`: PMQ-007, 010, 012, 014, 015),
   and `PMR-009` (`cheri-riscv-notes-repo`: PMQ-008, 011).
3. The suggested owner is kept for every row. For PMQ-007, PMQ-010, PMQ-012,
   and PMQ-015 the Project Manager notes that `osr-claude/` is a plausible
   alternate home for integrity-monitoring and attestation precedent; if the
   `formal-verification-research/` owner declines, the Project Manager will
   re-route by a superseding ledger note rather than decide admission itself.
4. Because `routed` produces no source status edit under the queue file's own
   header, `scripts/pull-queues.sh edits` legitimately prints nothing for
   `../analysis-workbook/outbox/pm-queue.md` after this turn. Edits will be
   handed over when an owner reports a source as recorded (`accepted`) or
   already present (`duplicate`), or declines it (`rejected` or `deferred`).
   If the workbook owner answers `PMR-011` by adopting the
   `AGENT-INTERFACE.md` vocabulary instead, `queue/README.md` and
   `scripts/pull-queues.sh` will be updated and `routed` edits handed over
   then; the Project Manager writes no status the queue file's header does
   not accept.
5. The redistribution values from the source rows travel with the requests.
   `PMQ-014` and `PMQ-015` are metadata-only pointers to paywalled texts;
   `PMQ-006`, `PMQ-010`, and `PMQ-016` are marked `approved` by the workbook,
   which is the workbook's assessment and not a Project Manager licensing
   position.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not admit any source into any component's corpus; each
owner retains sole authority to record, decline, or defer a pointer under its
own rules and redistribution constraints. It does not assert that any source
has been read by the owner, and it does not change the workbook's
redistribution assessments. The responsible human carries `PMR-007..PMR-009`
to the owners and applies any resulting status edits in the workbook queue;
that human action remains open.

## Follow-up

- Carry `PMR-007`, `PMR-008`, and `PMR-009` from `outbox/component-requests.md`
  to the three owners; when an owner reports its result, update the matching
  `PML-` rows in `queue/LEDGER.md` and run
  `bash ./scripts/pull-queues.sh edits` to hand over the exact workbook edits.

## Provenance

- Written by the `project-manager` agent from the inputs above during the
  first coordination turn on 2026-09-04, from read-only inspection only; no
  component file was modified.
