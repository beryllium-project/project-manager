# visibility audit keep public

- **Record ID:** `PMD-20261012-002`
- **Created:** 2026-10-12
- **Status:** recorded
- **Supersedes:** `PMD-20260915-001` disposition 8, for
  `beryllium-project/threat-modeler`, `beryllium-project/security-reviewer`,
  `beryllium-project/provenance-review`, and `beryllium-project/helium-te-poc`
  only
- **Superseded by:** None

## Scope

This record covers four things: the `PMR-128` visibility audit results,
the closure of `PMR-128`, the responsible human's decisions on the four
repositories the audit found public without a recorded decision, and the
human's confirmation of the `PMR-129` workbook split. It touches Project
Manager artifacts and the parent registry; no component is read or
written.

Observed in the ignored human-run logs:

- `scratch/owner-actions/pmr128-visibility-audit-20261012T052523Z.log`, run
  2026-10-12T05:25:23Z to 05:25:34Z as `xjamesmorris`, with `ADMIN` on every
  resolved identity. It covered 14 identities:
  - 8 are `PRIVATE` as expected: `beryllium-project/beryllium-project`,
    `beryllium-project/beryllium-hypervisor`,
    `beryllium-project/helium-te-poc-historical`,
    `beryllium-project/formal-verification-research`,
    `agentic-os-research/os-security-research`,
    `beryllium-project/analysis-workbook`,
    `agentic-os-research/cheri-riscv-notes`, and
    `agentic-os-research/cheri-hypervisor-research`.
  - 5 are `PUBLIC`: `beryllium-project/project-manager`, which is already
    decided by `PMD-20261012-001`; `beryllium-project/threat-modeler`;
    `beryllium-project/security-reviewer`;
    `beryllium-project/provenance-review`; and Helium's `public` remote
    `beryllium-project/helium-te-poc`.
  - 1 is unresolved: `jamorris_microsoft/beryllium-project`, the parent's
    personal-fork `origin`, which is documented as not needed. The log's
    reason is `absent-not-visible-to-xjamesmorris-or-query-failed`.
- The same log's workbook exposure facts:
  - `beryllium-project/analysis-workbook` is now `PRIVATE`. It was created
    2026-08-28T07:13:19Z, and its last push was 2026-10-11T15:53:50Z.
  - It has two heads, `main` at `4cf44d0` and
    `analysis/k3-a100-service-design-private` at `353c431`, both
    unprotected, and no tags, pull requests, or listed forks.
  - Traffic for 2026-09-27 to 2026-10-10 shows 17 clones by 12 unique
    cloners and no views. That window ends before 2026-10-11, the day the
    private branch was pushed and the repository made private, so it shows
    nothing about that day.
  - The optional audit-log dates were not reported.
- `scratch/owner-actions/pmr129-workbook-split-20261012T052534Z.log`
  (`--plan`) ended `eligible=yes`:
  - The source is private, with `ADMIN` permission and default branch
    `main`. It holds exactly `main` `4cf44d0` and the private branch
    `353c431`, with no tags and no pull requests, open or closed.
  - The private branch is unprotected. Ruleset status is unknown, because
    the rules query did not return.
  - The destination is absent.
  - The `l1` checkout is clean, with the pre-split layout. Tasking was
    current, and the writer lock was held.

## Inputs

- The responsible human's answers on 2026-10-12 to the structured question
  about the four public repositories: `threat_modeler=keep_public`,
  `security_reviewer=keep_public`, `provenance_review=keep_public`, and
  `helium_public=keep_public`.
- The responsible human's report `"done above"` after running the audit and
  `--plan`, and again after the `lx2` push-disable command.
- The responsible human's answer `confirm` to the question "Do you confirm
  running the workbook split (PMR-129 `--execute`)?" (2026-10-12).
- `PMD-20260915-001` dispositions 2 and 8, `PMD-20261011-002`, and
  `PMD-20261012-001`.

## Disposition

1. **`PMR-128` closes.** The human ran the audit, and the Project Manager
   read and recorded the log above.
2. **Keep-public decisions.** The responsible human keeps
   `beryllium-project/threat-modeler`, `beryllium-project/security-reviewer`,
   `beryllium-project/provenance-review`, and
   `beryllium-project/helium-te-poc` public. This is the separate decision
   that `PMD-20260915-001` disposition 2 requires, so disposition 8 no
   longer holds for these four repositories.
   - Their pushed history is public.
   - Every later push to them publishes, and still needs its owner's rules
     and a same-turn responsible-human confirmation.
   - The `owner-actions.sh` default steps `push_tm` and `push_sr` publish,
     and so does the security-reviewer fast-forward of `PMR-111`.
3. **Records corrected.** Project Manager statements that these
   repositories' remotes are private are corrected. The components'
   private-by-default package rules belong to their owners and are
   unchanged.
4. **Split confirmation.** The responsible human reported the `lx2`
   push-disable done and then confirmed the `PMR-129` split. The human runs
   `--execute` next, and the Project Manager verifies the result in a later
   turn.
5. **Unresolved identity.** `jamorris_microsoft/beryllium-project` stays a
   documented, unused parent remote; nothing follows.

## What this record does not decide

This record is coordination evidence. It keeps four repositories public,
which they already were; it changes no visibility. It approves no release,
including Helium's release gate (`publication-gate.conf`). It approves no
licensing, redistribution, risk acceptance, acceptance, sign-off, formal
verification, hardware validation, or specific future push. Whether
private-intended content already in those repositories should stay there
is not decided; the owners' private-by-default rules govern what they add.
Open gates: the workbook publication decision of `PMD-20261011-002`, and
verification of the `PMR-129` result.

## Follow-up

- From `project-manager/`, the responsible human runs
  `bash ./outbox/pmr129-workbook-split.sh --execute`, types `PMR-129` at the
  prompt, and reports the printed log path.

## Provenance

- Written by the `project-manager` agent from the two human-run logs and the
  responsible human's answers.
