---
name: beryllium-publication-gate
description: Gate every push to a public remote from a Beryllium repository. Check the remote's visibility, scan the push (or the whole history about to become visible) against the private denylist, stop on any finding, and keep non-public model identifiers out of public text. Use when told "check publication gate", and before any public push, public repository creation, visibility change, public snapshot refresh, release or tag for a public remote, or public pull-request, issue, release, or wiki text.
---

# Beryllium publication gate

The normative source is Project Manager decision `PMD-20261108-001`
(`project-manager/records/decisions/PMD-20261108-001-public-push-publication-gate.md`).
It covers public pushes only; a push to a private remote is outside the gate.
Passing the gate is not publication approval and grants no human gate.

## Triggers

- The phrase `check publication gate`, or an obvious variant.
- Before any `git push` whose remote may be public, including a component
  backup to a public repository.
- Before `gh repo create --public`, `gh repo edit --visibility public`, adding
  a public remote, refreshing a public snapshot, or pushing a release or tag
  to a public remote.
- Before writing pull-request, issue, review, release, wiki, or repository
  description text on a public repository.

## Procedure

The gate is installed per workstation at
`~/.config/beryllium/publication-gate/bin/publication-gate`. Run it with
`python3 -I -B` from the repository being published:

1. **Push preview.**
   `python3 -I -B ~/.config/beryllium/publication-gate/bin/publication-gate check --repo . --remote <remote> [<ref>...]`
   The default ref is the checked-out branch. Exit 0 means pass, or a
   private or local remote; exit 1 means a finding; exit 2 means the gate is
   not installed, the denylist is unusable, or visibility cannot be
   determined. Stop on 1 or 2.
2. **Whole-history audit.** Before a visibility change to public, a new
   public repository, or a first push to an empty public remote, fetch every
   ref that will become visible, tags included, then run
   `... publication-gate audit --repo . --all-refs` (or name the refs).
   `check` is not enough there: it covers only the pushed refs, it passes a
   private remote that is not recorded public unscanned, and a pre-push hook
   cannot see a visibility change.
3. **Files outside Git.** For a snapshot directory, a generated site, or text
   about to be submitted, run `... publication-gate scan-tree <path>...`
   (`-` reads standard input).
4. **Advisory pass.** Add `--advisory` to also count private-key headers,
   token formats, home paths, private addresses, session identifiers, and the
   Codasip name. Advisory results are for review and do not block.
5. **On any finding, stop.** Do not push. Remove the finding from the files,
   then amend or rewrite only **unpushed** commits until no reachable commit
   carries it, or exclude the path from the public-bound copy. Re-run until
   the gate prints `PASS`.
6. **Already public.** `... publication-gate audit --repo . --remote <remote>`
   scans what a public remote serves now, and refuses when a live tip is not
   present locally (fetch first). If a finding is in commits a public remote
   already holds, report it to the responsible human at once as a P0. Containment
   (temporary private visibility), history rewrite, a force push with lease,
   and a GitHub Support cache-purge request are responsible-human actions.
   While a recorded public repository is private for containment, the gate
   still scans pushes to it as public, and `audit --remote` refuses it:
   fetch every ref and use `audit --repo . --all-refs` instead.
7. **Push.** The push itself still needs the responsible human's explicit
   same-turn confirmation and the repository's own push rules. Once
   installed, the pre-push hook runs the same scan again.

## Wording rules for public text

- Call a non-public model `unlisted`, and say nothing else about it: no
  vendor, base model, family, version, suffix, size, date, relationship to
  another model, or comparison.
- Where public-bound files record model provenance, use `unlisted` and
  explain the redaction without reproducing the identifier; never retain the
  unredacted identifier elsewhere in the public-bound copy.
- Internal records excluded from every public path may keep an exact name
  only where the repository's own rules allow it. Gate any text before it
  moves from such a record into a public-bound path.
- Never write a denylisted term into a public commit message, branch or tag
  name, file name, issue, pull request, review comment, release note, wiki,
  or repository description.

## Prohibitions

- `git push --no-verify`, `-c core.hooksPath=...`, or any other hook bypass
  for a push to a public remote.
- Encoding, splitting, reversing, transliterating, base64-encoding, or
  picturing a term to get past the gate; embedding a term in code or tests in
  any form; copying the denylist or any entry into a repository; printing the
  denylist.
- Sending a denylisted term to any external service, web search included.
- Treating `PASS` as approval of publication, release, or any human gate.

## Installation

The responsible human installs and checks the gate on each workstation; the
Project Manager never runs the installer against real user configuration:

`bash <workspace root>/project-manager/scripts/publication-gate-setup.sh install`

`install` copies the gate, its hook dispatcher, this skill, and the private
denylist from the parent repository's `.publication-gate/denylist`, adds
scoped Git `includeIf` entries, and ends with `check`; every run logs under
the Project Manager's ignored `scratch/publication-gate-setup/`. If the gate
is not installed, its command exits 2: do not push to a public remote, and
ask the human to install it. Until then a direct `git push` is not hooked;
only this procedure and `owner-actions.sh` stop it.

## Report

State the remote and its visibility, the refs, the exact command and exit
status, and either the `PASS` line or the finding count by variant class.
Never quote a matched string, an entry, or a carrying file name. End with the
next action and who takes it.
