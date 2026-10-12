# project manager backup published

- **Record ID:** `PMD-20261012-001`
- **Created:** 2026-10-12
- **Status:** recorded
- **Supersedes:** `PMD-20261011-003` disposition 2's hold, which this
  decision releases, and `PMD-20260915-001` disposition 8, both for
  `beryllium-project/project-manager` only
- **Superseded by:** None

## Scope

Record the responsible human's decision to publish the held Project Manager
backup, and the pushes it authorizes. This touches Project Manager
artifacts, the parent registry, and two remotes:
`beryllium-project/project-manager`, which is public, and
`beryllium-project/beryllium-project`, which is not. No component is read or
written.

Observed at about 2026-10-12T02:47Z, before this record:

- Project Manager: clean `main` at `2b39df0`, 0 behind / 24 ahead of
  `origin/main` `43e7e82`.
- Parent: clean `main` at `ff4f598`, synchronized with `upstream/main`.
  The 110th turn pushed `4f96358..ff4f598`, and live `ls-remote` verified
  it: only `refs/heads/main` at `ff4f598`, 0 behind / 0 ahead.

## Inputs

- Responsible-human direction, exactly `"just finish the backup
  publicly"` (2026-10-12 UTC).
- `PMD-20261011-003`: `beryllium-project/project-manager` is publicly
  readable, and its push waits for the responsible human's visibility or
  publication decision plus a same-turn push confirmation.
- `PMD-20260915-001` dispositions 2 and 8: later public visibility needs a
  separate decision, and no repository was approved for public release.
- The 110th-turn direct content review of `43e7e82..4eaf144` and of the
  changes committed as `2b39df0`. It found no credential pattern, private
  URL, workstation path outside the canonical root, gitlink, binary, or
  file over 1 MB.

## Disposition

1. **Publication decision.** The responsible human's direction is the
   separate decision that `PMD-20260915-001` disposition 2 requires, for
   `beryllium-project/project-manager` only. It approves publishing Project
   Manager `main` after `43e7e82` through `2b39df0` (24 commits), plus the
   commit that records this decision, in that public repository. The
   repository stays public, so `PMD-20260915-001` disposition 8 no longer
   holds for it.
2. **Push confirmation.** The same direction confirms this turn's pushes:
   Project Manager `main` to `origin/main`, then parent `main` to
   `upstream/main` to back up the registry binding. Each push is a plain
   fast-forward: exact refspec `refs/heads/main:refs/heads/main`, tag
   following disabled, and no force. Before pushing, the Project Manager
   rechecks the live tips and scans the new commits. Any rejection or remote
   change stops without retry, fetch reconciliation, rebase, or merge. This
   turn consumes the confirmation.
3. **Later pushes.** Every later push to `beryllium-project/project-manager`
   publishes. Each still needs a new same-turn confirmation, and the Project
   Manager says that it publishes when it asks. The human-run
   `owner-actions.sh` default and `--yes` runs include `push_pm`, so they
   publish too; `--skip push_pm` avoids that.
4. **Earlier record.** The finding of `PMD-20261011-003` stands; this
   decision releases only its hold.

## What this record does not decide

This record is coordination evidence. It approves publishing only the named
Project Manager commits. It approves no release, licensing, redistribution,
or publication of any component or its content, which Project Manager
records only summarize. It changes no repository visibility:
`beryllium-project/project-manager` was already public, and the parent stays
non-public. It grants no other approval, and no acceptance, sign-off, risk acceptance,
formal verification, or hardware validation. Open gates: the workbook
decisions of `PMD-20261011-002`, and every component's own visibility, push,
and publication gates.

## Follow-up

- From `project-manager/`, run the read-only
  `bash ./outbox/pmr128-visibility-audit.sh --run`. Its
  `beryllium-project/project-manager` line reports `MISMATCH` against the
  private default; this record makes that line expected.

## Provenance

- Written by the `project-manager` agent from the responsible human's
  direction and the inputs above.
