# beryllium direct checkout

- **Record ID:** `PMD-20260922-001`
- **Created:** 2026-09-22
- **Status:** recorded
- **Supersedes:** `PMD-20260915-005` only for the Beryllium workspace
  integration form and prior private-target assumption; its branch selection,
  historical evidence, and gate boundaries remain recorded
- **Superseded by:** None

## Scope

Record the responsible human's relocation of the canonical Beryllium
implementation from tracked external symlink `beryllium-repo` to ignored
direct checkout `beryllium-hypervisor/`, and reconcile Project Manager
discovery, tasking, and publication wording. The observed Beryllium revision
is `416b2e9a3fe94689483a46c1fb374cce75b281db`.

## Inputs

- Responsible-human direction on 2026-09-21: the Beryllium repository was
  moved into the workspace because its origin is now in the public project.
- `../beryllium-hypervisor/planning/HANDOFF.md` at
  `416b2e9a3fe94689483a46c1fb374cce75b281db`: the durable Beryllium owner
  return and exact R0-R8 boundary.
- `../beryllium-hypervisor/.github/copilot-instructions.md` at
  `416b2e9a3fe94689483a46c1fb374cce75b281db`: the component identifies
  Beryllium as an open-source defensive security project while retaining
  explicit publication gates.
- `scripts/inspect-components.sh status` at 2026-09-22T04:22:44Z: the direct
  checkout is clean on `beryllium/single-hart-runtime-r0` at `416b2e9`,
  tracking `origin/beryllium/single-hart-runtime-r0` behind 0 / ahead 12;
  the two remaining tracked symlinks resolve.

## Disposition

`beryllium-hypervisor/` is the canonical direct Beryllium checkout in this
workspace and is ignored by the parent repository. The former
`beryllium-repo` symlink is retired and removed from active component
discovery, registry, tasking, and helper paths. Historical records retain the
old logical name and path as evidence.

The responsible human's statement establishes the intended public-project
placement. The local read-only inspector does not independently authenticate
remote visibility. Because `origin` is now described as public, open
`PMR-090` is a publication-gated review and push decision rather than a
private-backup action.

The carry-ineligible component recorded in `PMD-20260904-003` as
`beryllium-repo` is the same component now at `beryllium-hypervisor/`; its
carry-ineligibility is unchanged.

## What this record does not decide

This record is coordination evidence. It does not authorize a push or grant
acceptance, review approval, sign-off, licensing, publication, release,
formal verification, or hardware validation. PMR-090 remains open for exact
ref review, the component publication gate, and a separate responsible-human
publication decision. Beryllium remains accepted through R7; R8-H0 candidate
`6e93461` is not accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`.

## Follow-up

- Review `../COMPONENTS.md`,
  `components/beryllium-hypervisor.md`, and open `PMR-090` in
  `outbox/component-requests.md`; do not push either Beryllium ref without a
  new exact responsible-human publication authorization.

## Provenance

- Written by the `project-manager` agent from the inputs above.
