# Governance destination filesystem guard correction

- **Record ID:** `PMD-20260930-004`
- **Created:** 2026-09-30
- **Status:** recorded
- **Supersedes:** `PMD-20260930-003` item 5 in part, only its
  unqualified same-filesystem guarantee; preserves every other disposition,
  follow-up, and human gate in that record
- **Superseded by:** None

## Scope

Correct the governance installer's destination-filesystem preflight without
broadening the transaction, rollback, interface, or live-user scope. The
change is limited to explicit symlink dereference during device resolution, a
complete device preflight before backups or commit, one deterministic sandbox
regression, this additive decision, the Project Manager handoff, and the
parent component registry.

Observed pre-change coordination revisions are parent
`a39fa71dd6ff862702671c279a9c4f07fb00cc79`, Project Manager
`fe527aaee6123808fedd7181b4212cf4ec77b7e7`, and authoritative request-table
blob `f1354da9c784a5e0e63867efd9f2f224c646c28c`.

## Inputs

- Responsible-human implementation direction on 2026-09-30: apply only the
  scope-reviewed filesystem-guard correction; do not alter real user
  configuration, run the real installer or check, restart or contact active
  sessions, edit components, or broaden the existing transaction.
- Scope-review disposition on 2026-09-30: destination-directory device checks
  must dereference symlinks; unresolved device identity or a mismatch must
  fail closed before backups or commit; add one sandbox regression using a
  writable distinct device when available.
- `records/decisions/PMD-20260930-003-governance-reinstall-safety.md`,
  `scripts/beryllium-governance.sh`, and `tests/validate-agent.sh` at
  `fe527aa`: the recorded transaction guarantee, the non-dereferencing
  destination-directory `stat`, and the maintained sandbox harness corrected
  here.
- Scope-review observation on 2026-09-30: the live `~/.copilot` managed
  destination directories were ordinary directories resolving to the same
  device as the install staging location. The pending responsible-human
  reinstall was therefore not exposed to this symlink-device defect.

## Disposition

1. Resolve the staging and every managed destination directory's device
   identity with explicit symlink dereference. Quote each path and terminate
   option parsing before passing it to `stat`.
2. Complete device resolution and comparison for every destination before
   creating any backup or committing any managed file. Failure to resolve
   either device identity, or any device mismatch, fails closed and removes
   the private staging directory.
3. Preserve the existing staged-file verification, copy-before-replace
   backups, per-file atomic commit, rollback, interface, and messages except
   for the new device-resolution failure diagnostic.
4. The live managed destination directories observed during review were
   ordinary same-device directories, so the still-pending live reinstall was
   not exposed to the corrected symlink case. This record does not run or
   validate that reinstall.
5. Matching `st_dev` values are necessary for the intended rename path but
   are not universally sufficient. A bind mount or another mount topology can
   still produce `EXDEV` despite matching values. That residual remains
   explicitly deferred; the existing commit-failure rollback remains the
   bounded fallback, and this record authorizes no broader hardening.
6. Maintained validation creates a managed destination-directory symlink to a
   writable temporary directory on a distinct dereferenced device when one is
   available. It proves refusal before managed-file mutation, unchanged
   original hashes and modes, no managed write through the symlink, and no
   unrelated-file removal. If no such device exists, the suite emits one
   explicit diagnostic that is not counted as a pass and does not claim
   coverage.
7. The human reinstall command, idle-session recommendation, deep-security
   model choice, active-session locks, PMRs, and every acceptance,
   publication, release, push, and hardware gate remain unchanged.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation, component
implementation authority, component write authority, push, remote change, or
tag authority. It does not claim that matching device numbers eliminate all
cross-mount rename failures, authorize bind-mount probing or broader
hardening, inspect or alter real user configuration, validate a live session,
select a deep/adversarial security model, restart the reported active
Beryllium session, approve R8-H0, authorize H1-H4, or run K3.

## Follow-up

- After reviewing the Project Manager and parent commits, wait until governed
  sessions are idle, then run the unchanged command from the workspace root:

  ```sh
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

  Do not restart the reported active Beryllium session merely to perform this
  reinstall. The responsible-human deep/adversarial security model choice and
  every existing component/session gate remain open.

## Provenance

- Written by the `project-manager` agent from the responsible-human scope,
  completed scope review, named historical record, current governance
  implementation, and supplied live-directory observation. No component,
  real user configuration, or active session was modified, contacted, or
  checked.
