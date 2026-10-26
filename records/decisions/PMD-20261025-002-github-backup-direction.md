# github backup direction

- **Record ID:** `PMD-20261025-002`
- **Created:** 2026-10-25
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's direction that important work be committed
and pushed, with GitHub as the backup, and state how the Project Manager
applies it within its boundaries: its own and the parent's pushes, component
pushes it never performs, and the line between backup and publication. It
touches Project Manager artifacts and parent-root records only; no component
is written.

Backup inventory observed when recorded (maintained read-only
`scripts/inspect-components.sh` `status`, `refs`, and `state`,
2026-10-25T22:37Z to 22:49Z on `l1`; remote-tracking refs are as of each
repository's last fetch, not a live check):

- Project Manager `main` is 2 ahead of public `origin/main` `e3c8e10`, and
  the parent `main` is 2 ahead of `upstream/main` `6639e86`.
- Beryllium's active `beryllium/mvp-m0` at `977dd4ee` is ahead of
  `origin/beryllium/mvp-m0` `1a6898e9`, the backup made on the human's
  2026-10-24 instruction; the commits after it, including plan revision
  M0-C's implementation and the 2026-10-25 lock refresh, are on no remote.
  Fifteen other local branch tips are on no remote-tracking ref:
  `beryllium/doc-repro-option-a-20260929` (`c6fa7a7c`),
  `beryllium/k3-b4-r6-wip` (`61e6b722`), `beryllium/k3-b4-r7-wip`
  (`c00176d1`), `beryllium/k3-b5-core-wip` (`3fbe4b6e`),
  `beryllium/k3-b5-tools-wip` (`db72a42c`), the five KVM0 branches
  (`b6972cb9`, `05456ddc`, `9a7ffbdb`, `7e2fc870`, `ec459169`),
  `beryllium/r8-c-h0-pmr-081` (`6e3b49e3`), `beryllium/r8-c-h0-pmr-081-v2`
  (`b0165f11`), `beryllium/tool-fix-r5-wip` (`f1f6eee5`),
  `beryllium/tool-fix-r7-wip` (`5e06612a`), and retired candidate
  `beryllium/r8-h0-pmr-080` (`6e93461f`), which `PMR-090` left unpushed.
- Threat-modeler `main` is 6 ahead and security-reviewer `main` 2 ahead of
  their public `origin/main` (`PMR-111` covers the latter).
- XRV `main` is 1 ahead of its private `origin/main`, and its 2026-10-23
  owner publication-preparation change set is uncommitted.
- Analysis-workbook content is fully on its private `origin`: local-only
  `analysis/dasics-cheri-fallback-private` tip `10c777a6` is contained in
  `origin/analysis/mpt-core-vs-extension-private` `add42644`.
- Every Helium local branch tip is on `origin` or `public`. OS-security,
  formal verification, provenance, and CHERI notes are 0 / 0; the CHERI
  notes remote's copy of the earlier history is unknown
  (`PMD-20261025-001`).
- The retained `../files` artifacts exist on `l1` outside Git.

## Inputs

- Responsible-human statement in this session on 2026-10-25, exactly:
  `"everything important should be committed and pushed, gh is a backup"`.
- Responsible-human structured answer later in the same session, exactly
  `publish_now` ("Publish now: push the Project Manager commits this turn
  (recommended)"), to a question that stated the Project Manager
  repository is public, that pushing it publishes three coordination
  commits summarizing private Beryllium, workbook, and XRV state, and that
  the private parent push proceeds as a backup either way. The other
  choices offered were a standing every-turn push and keeping the commits
  local.
- `PMD-20261012-001` (the Project Manager repository is public; later
  commits publish only on an exact same-turn confirmation) and
  `PMD-20261012-002` (threat-modeler, security-reviewer, provenance-review,
  and Helium's public remote stay public).
- The Project Manager repository instructions: every push needs an explicit
  same-turn confirmation, quoted in `HANDOFF.md`, and the Project Manager
  never pushes a component or runs `scripts/owner-actions.sh`.
- `component://beryllium-hypervisor/.github/copilot-instructions.md` at
  `977dd4ee883bc3499a37523fb9345a59894f92b8`: Beryllium pushes follow the
  responsible human's instruction, and any merge into the development
  branch needs its own.
- The uncommitted `component://cheri-hypervisor-research/HANDOFF.md` over
  `7361de4138ad733be46e8a72608a779d24ae488a`: publication is blocked on the
  owner's disclosure decision.

## Disposition

1. GitHub is the responsible human's backup. Work that exists on no remote
   is at risk, and backing it up is high priority. Every Project Manager
   handoff lists each local-only commit, branch, or uncommitted change set
   it observes, and its next actions put backup steps first, with exact
   commands.
2. In this turn the statement is the explicit same-turn confirmation for a
   plain fast-forward push, after validation, of the parent `main` to its
   private `upstream`, which is a backup. It does not by itself meet
   disposition 3 of `PMD-20261012-001` for the public Project Manager
   repository, whose push publishes, because the Project Manager had not
   yet said so. The Project Manager then said so in a structured question,
   and the responsible human answered `publish_now`, which is the exact
   same-turn confirmation for a plain fast-forward push of the Project
   Manager `main` to `origin` this turn only. No force, tag, remote change,
   or other repository is included, and both confirmations are consumed by
   this turn's pushes.
3. This record is not a standing push authorization; the responsible human
   declined the offered standing option. Each later Project Manager or
   parent push still needs an explicit same-turn confirmation unless the
   responsible human makes a standing authorization by a separate named
   record.
4. The Project Manager never pushes a component. It supplies one human-run
   script, `scratch/l1-backup-and-checks.sh`, which shows each push and
   asks y/N: Beryllium's `beryllium/mvp-m0` fast-forward to its private
   `origin`, refused unless GitHub reports the repository `PRIVATE`; then
   `owner-actions.sh` fast-forwards of threat-modeler and security-reviewer
   `main` to their public `origin`, each of which publishes; then a fetch
   of every reachable remote. XRV's change set needs an XRV session first,
   because it is uncommitted and XRV's own rules update its handoff before
   every push. Choosing which of Beryllium's
   fifteen other local-only branches to back up belongs to the human in a
   Beryllium session; retired candidate `6e93461f` stays unpushed unless
   the human revisits the `PMR-090` disposition.
5. Backup is not publication. A push to a private repository is a backup
   only. A push to a public repository publishes, and the human must intend
   it. Visibility changes, Pages deployment, history rewrites, force
   pushes, tags, and releases remain separate responsible-human gates;
   XRV's publication stays blocked on its disclosure decision.
6. The Project Manager avoids creating component commits that it cannot get
   backed up. This turn makes no carried write. The class-1 `duplicate`
   edits due for PMQ-053 and PMQ-054 wait, because a carried commit on the
   workbook session branch that holds those rows would need a separate push
   of that branch, which `owner-actions.sh` does not make (`push_awb`
   pushes `main` only) and the Project Manager never makes.
7. The retained `../files` artifacts have no GitHub backup. Whether they
   matter, and how to back them up, is the responsible human's choice; no
   request is allocated.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It is not a standing push authorization and approves no
publication: this turn's Project Manager push publishes under
`PMD-20261012-001` disposition 3 on the separate answer `publish_now`. It
changes no repository visibility or `PMD-20261012-001` /
`PMD-20261012-002` disposition. It does not decide which Beryllium local branches are
important, XRV's disclosure or history treatment, or the CHERI notes
history. It authorizes no force push, tag, remote creation, or Pages
deployment. Every responsible-human gate remains as recorded.

## Follow-up

- The responsible human runs
  `bash /home/jmorris/src/beryllium-project/project-manager/scratch/l1-backup-and-checks.sh`;
  the next coordination turn verifies each push from fetched refs.
- In an XRV session the human either commits the publication-preparation
  change set and pushes it to the private `origin` as a backup only, or
  makes the disclosure decision first.
- In a Beryllium session the human chooses which local-only branches to back
  up to the private `origin`.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  statement and the maintained read-only inspection above.
