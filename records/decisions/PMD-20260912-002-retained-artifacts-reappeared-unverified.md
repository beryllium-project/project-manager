# Retained artifact candidates reappeared, identity unverified

- **Record ID:** `PMD-20260912-002`
- **Created:** 2026-09-12
- **Status:** recorded
- **Supersedes:** `PMD-20260906-002` only for current workstation
  availability; that record remains the historical disposition as of
  2026-09-06
- **Superseded by:** `PMD-20260916-004` for current availability,
  expected-name coverage, and the inbound-archive SHA-256 result only

## Scope

Records that the ignored parent-root `../files` path, absent on 2026-09-06,
now resolves and contains candidate files with all seven names recorded in
`PMD-20260906-002`. Their content identity, archive hash, provenance, and
suitability as Beryllium H0 decision inputs remain unverified. This touches
only Project Manager coordination records and no component.

## Inputs

- `PMD-20260906-002`: the seven recorded names, the archive's expected
  SHA-256
  `277d6168f9b0ae4bbb521eead40dc314f74c855e74f4be4ac3bba3c0af1c5d05`,
  and the prior observation that the link and files were absent from this
  workstation.
- The write-disabled `pm-auditor` pass of 2026-09-12: `../files` resolves and
  exposes entries matching all seven recorded names:
  `r8-offline-design/K3-H0-PHYSICAL-INSPECTION-CHECKLIST.txt`,
  `r8-offline-design/fedora44-omni-k3-com260-boot-provenance.md`,
  `r8-offline-design/r8-h1-h2-proposed-path-inventories-v1-report.md`,
  `r8-offline-design/K3-MEMORY-CONSTRAINTS.md`,
  `h0-static-oci/image-identity.txt`,
  `h0-candidate-scaffold-artifacts/H0-CANDIDATE-SCAFFOLD-REPORT.md`, and
  `k3-h0-return-20260817/source-archive/be-k3-h0-collection.tgz`.
- The auditor did not establish the link target, file hashes, byte identity,
  provenance, or fitness for current use. The Project Manager did not open or
  copy the files.

## Disposition

The seven paths are no longer described as lost from this workstation.
They are **reappeared candidate copies with identity unverified**. No
Beryllium input is restored to trusted use until the responsible human runs
the recorded read-only verification and confirms the result. `PMR-032`
tracks that action. The ignored link and its targets remain outside parent
Git.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not establish that any candidate is byte-identical to the
previous artifacts, authentic, current, complete, or suitable for an H0
decision. It does not select the normative Fedora 44 H0 static OCI or the
proposed H1/H2 path inventory. Beryllium remains accepted through R7; R8-H0
is a committed candidate and is not accepted; H1-H4 are not authorized; K3
hardware is `NOT RUN`.

## Follow-up

- The responsible human runs:

  ```sh
  cd /home/jmorris/src/beryllium-project/project-manager
  bash ./scripts/owner-actions.sh --files-search \
    --files-root /home/jmorris/src/beryllium-project/files
  ```

  and reports the log path and hash result. The next Project Manager turn
  records the verified identity or mismatch without copying the artifacts.

## Provenance

- Written by the `project-manager` agent from the write-disabled auditor's
  located discrepancy and `PMD-20260906-002`. No artifact content was opened
  or copied, and no component was modified.
