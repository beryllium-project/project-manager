# The Beryllium release proceeds outside the P0 hold

- **Record ID:** `PMD-20261108-004`
- **Created:** 2026-11-08
- **Status:** recorded
- **Supersedes:** `PMD-20261108-001` in part (disposition 9: the hold's
  Beryllium clause no longer applies to the Beryllium release; the rest of
  that record stands)
- **Superseded by:** `PMD-20261110-003` (fulfilled; the hold is lifted)

## Scope

This record answers one coordination question: whether the P0 hold of
`PMD-20261108-001` disposition 9 still applies to the Beryllium release. It
records the responsible human's decision, the parts of the hold that remain,
and how the publication gate still applies. It touches Project Manager
coordination records only: this record, the `PMR-139` and `PMR-140` notes in
`outbox/component-requests.md`, `HANDOFF.md`, `outbox/OWNER-RUNBOOK.md`, the
Beryllium component card, `AGENT-ROSTER.md`, the `Superseded by` field of
`PMD-20261108-001`, the parent `COMPONENTS.md`, and the private incident
note `../.publication-gate/P0-20261108-001.md`. It writes no
component, runs no component command, and changes no gate, denylist, hook,
tooling, remote, or visibility.

Observed on `l1` from 2026-11-08T20:03Z to 20:06Z, read-only:

- the gate's anonymous probe still reads the public review snapshot
  `beryllium-project/beryllium-hypervisor`, so it is not yet deleted, and
  reads `beryllium-project/beryllium-hypervisor-internal` as private;
- maintained inspection shows the canonical checkout `beryllium-hypervisor/`
  clean on `main` `c7be2498f2e0edf6affa4ac4fdb9ef1cd42e0a5a`, 0/0 with its
  private `origin`, with seven local release branches, `beryllium/mvp-release-step-2`, `beryllium/mvp-release-step-3`, `beryllium/mvp-release-step-3-plan`, `beryllium/mvp-release-step-5`, `beryllium/mvp-release-step-5-plan`, `beryllium/mvp-release-step-6`, and `beryllium/mvp-release-step-6-plan` (the step-6 pair new since
  10:15Z); only `beryllium/mvp-release-step-2` has a remote-tracking copy,
  and no tag exists. The Beryllium session started on
  2026-11-05 still runs there;
- the gate's `audit` of the clean release repository
  `beryllium-hypervisor-clean/` passes (2 refs, 5,029 items, no denylisted
  term), and its `check` refuses only because that repository has no
  `origin` remote yet, so the release's public target is unknown;
- the log of the responsible human's 08:38:02Z gate install ends
  `all checks passed`.

## Inputs

- The responsible human's statements, quoted exactly:
  `"snapshot will be deleted soon"` (2026-11-08T10:13:50Z, 02:13 at
  UTC-8); `"let me finish the be release first"` (about 10:15Z); and
  `"Be release can bypass the P0 hold as it is part of the P0 solution"`
  (20:00:35Z, 12:00 at UTC-8). The last answers the Project Manager's
  report at about 10:16Z that the hold still covered the release
  publication and that publishing was the responsible human's decision,
  which the Project Manager would record.
- `PMD-20261108-001`: disposition 4 (the global pre-push hook and
  `owner-actions.sh` gate every public push), disposition 6 (Project
  Manager use of the gate's read-only modes, including against the
  Beryllium publication clones), and disposition 9 (hold: no public
  Beryllium review-snapshot refresh, merge of the internal release branch
  into `main`, or release publication until `PMR-139` closes).
- The 135th-turn records: the hold's Project Manager clause ended when the
  security-reviewer rewrite landed, and its security-reviewer clause lasts
  until `PMR-140` lifts the hold after `PMR-139` closes.
- `PMR-139` and `PMR-140` in `outbox/component-requests.md`.

## Disposition

1. **Exemption.** By the responsible human's decision, the hold no longer
   applies to the Beryllium release, which the responsible human describes
   as part of the P0 solution: the release publication, and any other step
   the release itself takes, proceed outside the hold. What the release
   comprises, and where and when it is published, are the responsible
   human's and the Beryllium owner's;
   the Project Manager neither enumerates nor approves the release's steps.
2. **What stays held.** Outside the release, a refresh of the public review
   snapshot and a merge of the internal release branch into `main` stay held
   until `PMR-139` closes. The responsible human states that the snapshot
   will be deleted soon; it was still public at 20:03Z. The hold's
   security-reviewer clause is unchanged: further security-reviewer pushes
   stay held until `PMR-140` lifts the hold. The hold's Project Manager
   clause ended in the 135th turn.
3. **The gate still applies.** Every public push the release makes passes
   the installed gate's pre-push hook, and `owner-actions.sh` for its push
   steps. `--no-verify` and every other hook bypass stay prohibited; a
   refusal is resolved by removing the finding from the content, never by
   bypassing the hook or editing the denylist. Before a public repository
   is created for the release, a first push to an empty public remote, or a
   visibility change, the gate's `audit --all-refs` runs after a full fetch
   in the repository published from (`PMD-20261108-001` disposition 4).
   Publication outside Git (release archives and assets, release notes,
   GitHub release or repository text, site builds) is outside the hook, so
   before upload the installed gate's `scan-tree` scans the unpacked tree
   each release archive is built from, or an extracted copy, and every
   text file: `scan-tree` reads a compressed archive only as raw bytes and
   cannot see inside it. Passing the gate is not publication approval.
4. **Requests.** `PMR-139` stays open. Following the responsible human's
   `"let me finish the be release first"`, its re-scoping waits until the
   release is finished. Then the Project Manager observes the release and
   the snapshot deletion and asks the responsible human how to narrow or
   close it: its snapshot-tool part may become moot once the snapshot is
   deleted, as the responsible human decides, while the embedded entry in
   the internal `release/release.py`, the snapshot-bound planning pages,
   the planning-site configuration, the page whose file name carries the
   entry, and the two push-disabled gate-run clones remain to be decided.
   `PMR-140` still closes, and the hold is lifted, when `PMR-139` closes.

## What this record does not decide

This record is coordination evidence. It grants no release approval,
publication approval, acceptance, review approval, risk acceptance,
sign-off, licensing, redistribution, formal verification, hardware
validation, implementation authority, component write authority, push,
force push, tag, remote change, or visibility change. The release and its publication are the
responsible human's own actions, recorded component-side. It does not
decide the release's content, target repository, visibility, or timing; the
deletion of the public review snapshot, which is the responsible human's
action; or the narrowed scope of `PMR-139`. It does not relax any other
public push, and it changes no gate, denylist, hook, or tooling. Beryllium
is accepted through R7; R8-H0 is a committed candidate and is not accepted;
H1-H4 are not authorized; K3 hardware is `NOT RUN` in Project Manager
records; any component-side acceptance recorded for the release stays an
open reconciliation question for the responsible human.

## Follow-up

- When the responsible human reports the release finished (`done`), the
  Project Manager observes the published release and the snapshot deletion
  through the gate's anonymous probe (`classify`, and `audit --remote` from
  the publication clone once it has a public remote), records both, and
  asks how to narrow or close `PMR-139`.
- Before uploading any release file outside Git, the responsible human
  extracts each archive and runs
  `python3 -I -B ~/.config/beryllium/publication-gate/bin/publication-gate scan-tree .`
  from the directory that holds the unpacked release files.

## Provenance

- Written by the `project-manager` agent on `claude-opus-5.5` from the
  inputs above, maintained inspection, and the gate's read-only `classify`,
  `audit`, and `check` modes. No component repository was modified.
