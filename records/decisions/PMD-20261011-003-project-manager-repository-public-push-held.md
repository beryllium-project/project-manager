# project manager repository public push held

- **Record ID:** `PMD-20261011-003`
- **Created:** 2026-10-11
- **Status:** recorded
- **Supersedes:** `PMD-20261011-001` follow-up backup step
  (`owner-actions.sh --only push_pm`) only, while
  `beryllium-project/project-manager` is public
- **Superseded by:** `PMD-20261012-001` for disposition 2's hold only,
  released by the responsible human's publication decision

## Scope

The responsible human directed exactly `"proceed with coordination backup"`,
the P2 item that pushes the Project Manager and parent coordination
repositories so a fresh checkout carries their local commits. Before
pushing, the Project Manager checked both remotes. This record states what
the check found, what this turn pushes, and what is held. It touches Project
Manager artifacts and the parent remote only; no component is read or
written.

Observed on `l1` at about 2026-10-11T23:10Z:

- Project Manager: clean `main` at `4eaf144`, 0 behind / 23 ahead of
  `origin/main` `43e7e82`. An authenticated `git ls-remote` of `origin`,
  `beryllium-project/project-manager`, returned only `refs/heads/main` at
  `43e7e82` and no tag.
- Parent: clean `main` at `e600564`, 0 behind / 4 ahead of `upstream/main`
  `4f96358`. Remote `upstream`, `beryllium-project/beryllium-project`,
  returned only `refs/heads/main` at `4f96358` and no tag.
- Each remote has one fetch and one push URL, with no URL rewriting. Git's
  credential helper is `gh auth git-credential`, and neither repository has
  an active hook.
- An anonymous probe ran `git ls-remote https://github.com/<owner>/<name>.git
  HEAD` from an empty temporary directory, with system and global Git
  configuration disabled, no credential helper, and terminal prompts
  disabled. It returned `43e7e82` for `beryllium-project/project-manager`.
  For `beryllium-project/beryllium-project` it failed, because credentials
  were required.

## Inputs

- Responsible-human direction, exactly `"proceed with coordination backup"`
  (2026-10-11).
- One structured question to the responsible human about the Project
  Manager push. The tool reported the human unavailable, so no answer was
  received; the question is preserved in `HANDOFF.md`.
- `PMD-20260915-001` dispositions 2, 8, and 10: every successor starts
  private, later public visibility needs a separate decision, no repository
  is approved for public release, and `project-manager` stays under
  `beryllium-project`.
- `PMD-20261011-001`, which makes Git the only transfer mechanism, and
  `PMD-20261011-002`, which records the analysis-workbook found public.
- The ninety-first-turn push precedent in `HANDOFF.md`: an intent record,
  exact refspecs, tag following disabled, and a stop on any rejection or
  remote change.

## Disposition

1. **Finding.** `beryllium-project/project-manager` is publicly readable.
   Anyone can read its pushed history through `43e7e82` (2026-10-02). No
   Project Manager record approves this; `PMD-20260915-001` approves no
   repository for public release. When it became public, and whether forks
   exist, is unknown. `PMR-128` reports visibility with authenticated
   queries, and the organization audit log may date the change.
2. **Project Manager push held.** Pushing the local Project Manager commits
   would publish them. A backup direction is not a publication decision,
   and the Project Manager infers none. The push resumes only after one of:
   - the responsible human makes `beryllium-project/project-manager`
     private, a later turn's anonymous probe is refused, and the human gives
     a new same-turn push confirmation; or
   - a recorded responsible-human publication decision names the exact
     commits to publish, and the human then gives a new same-turn push
     confirmation.
3. **Parent push.** The parent remote refused anonymous access and matched
   its recorded tip, so its push is a plain fast-forward to a non-public
   repository, within the confirmed backup. This turn pushes parent `main`
   to `upstream/main` with the explicit refspec
   `refs/heads/main:refs/heads/main`, tag following disabled, and no force,
   after the review of its outgoing range passes. It then verifies the live
   tip. Any rejection or remote change stops without retry, fetch
   reconciliation, rebase, or merge. The confirmation is consumed by this
   turn.
4. **Gap until then.** A clone of `beryllium-project/project-manager` lacks
   every Project Manager commit after `43e7e82`, including `REHYDRATE.md`
   and the records it cites. The parent registry names that gap.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It changes no visibility, publishes nothing, accepts no exposure,
and authorizes no component push, tag, force, or remote change. The parent's
visibility is known only to be non-public: private or internal is unknown.
Open responsible-human gates: the visibility of
`beryllium-project/project-manager`, or a publication decision at exact
commits; a later same-turn confirmation for the held push; and the
workbook gates of `PMD-20261011-002`.

## Follow-up

- The responsible human makes `beryllium-project/project-manager` private
  (GitHub repository Settings, General, Danger Zone, Change visibility),
  then asks the Project Manager in a new turn to re-check and push it.
  Running `bash ./outbox/pmr128-visibility-audit.sh --run` from
  `project-manager/` first shows whether any other repository is public.

## Provenance

- Written by the `project-manager` agent from the read-only preflight on
  2026-10-11 and the inputs above.
