# Close D0 owner inventory

- **Record ID:** `PMD-20260915-001`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** `PMD-20260915-005` for disposition 9's Beryllium target
  identity only

## Scope

Record the responsible human's guided answers to the remaining D0 inventory
request `PMR-049` and identify which transition facts are now settled. This
record covers the parent coordination repository and all eleven registered
components. It does not perform an organization rename, create or move a
repository, alter a remote or symlink, transfer restricted content, change
visibility, push, or publish.

Observed state on 2026-09-15: parent `8b7a017`; Project Manager `12e4424`;
Helium `1ab289c`; formal-verification `784be93`; OS-security `f2edd17`;
provenance-review `9bfbab3`; analysis-workbook `b93722b`; threat-modeler
`f4eb272`; security-reviewer `c13c36e`; Beryllium `65f6d89`; CHERI-RISC-V
notes dirty at `6553092`; and XRV `d618935`.

## Inputs

- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
  at `12e4424`: approved future organization and repository topology.
- `records/decisions/PMD-20260914-004-d0-transition-inventory.md` at
  `12e4424`: bounded local inventory and the owner facts previously left
  `unknown`.
- `outbox/component-requests.md` at `12e4424`: `PMR-049` asks for complete
  Microsoft-origin scope, visibility, authorship, licensing/redistribution,
  publicability, hosted-service, and quarantine answers.
- Responsible-human guided answers on 2026-09-14 local time, recorded in
  "Disposition" below. The human explicitly directed that these answers are
  the authoritative owner inventory and that `PMR-049` close without a
  settings-page-by-settings-page inspection.

## Disposition

The responsible human states:

1. The known list is complete; there are no additional Microsoft-origin
   repositories in scope.
2. Every successor repository starts private. Any later public visibility,
   release, or Pages site requires a separate decision.
3. No additional restricted material is known beyond the already recorded
   OS-security restricted files and ordinary third-party papers and citations.
   This is an inventory statement, not a redistribution or licensing approval.
4. The OS-security quarantine will be a private repository in the responsible
   human's personal GitHub account, named
   `os-security-restricted-sources`.
5. The quarantine starts with clean new history and receives no existing
   OS-security Git history. The responsible human, not the Project Manager,
   manually reviews and copies any restricted files with their applicable
   license metadata.
6. Known hosted state to preserve includes the CHERI-RISC-V notes Wiki and
   issues `#2` and `#3`, plus repository Git refs. No additional Pages,
   Actions history, releases, packages, discussions, webhooks, or integrations
   are known to require migration.
7. Beryllium, OS-security, formal-verification, XRV, and CHERI-RISC-V notes
   are classified as employer-origin or mixed history for migration
   provenance. The newer `beryllium-project` coordination and evidence
   repositories are independent personal-project history. These labels are
   context, not copyright or redistribution decisions.
8. No repository is approved for public release now. CHERI-RISC-V notes
   remains only the first future publication candidate, after a separate
   license, authorship, corpus-integrity, and public-mirror review.
9. The exact private active targets are confirmed as
   `agentic-os-research/beryllium`,
   `agentic-os-research/cheri-hypervisor-research`,
   `agentic-os-research/os-security-research`, and
   `agentic-os-research/cheri-riscv-notes`.
10. `project-manager`, `analysis-workbook`, `threat-modeler`,
    `security-reviewer`, `provenance-review`, and
    `formal-verification-research` remain under `beryllium-project` for now.

The parent coordination repository also remains under `beryllium-project`.
Helium is not assigned a successor target by this inventory; its repository
target and hosted-service fields remain `unknown`, and its observed public ref
and tag do not establish publication or release approval.

These answers complete the owner inventory requested by `PMR-049`. The
request closes. A field described as "none known" remains an owner inventory
statement, not an independently authenticated negative finding.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, or hardware validation. It does not authorize the organization
rename, repository creation or transfer, history push, remote change, symlink
retarget, restricted-file copy, visibility change, Pages deployment, or
publication. Each remains a separate responsible-human action.

Beryllium remains accepted through R7. R8-H0 is a committed candidate and is
not accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium
remains a review-and-test proof of concept and is not formally verified or
hardware validated.

## Follow-up

- The organization owner reviews this record, then separately performs or
  authorizes the GitHub organization rename
  `Agentic-OS-Development` to `agentic-os-research` and returns the exact
  result before any repository creation or remote change.

## Provenance

- Written by the `project-manager` agent from the guided responsible-human
  answers above. No restricted content or private URL was requested or
  recorded.
