---
name: cross-repo-collaboration
description: Coordinate owner and guest agents across local repositories through a root COLLAB.md ledger, narrowly scoped guest branches, local-only commits, and owner-only integration. Use when one project consumes another project's research or analysis and must record how and where it was applied.
---

# Cross-repository collaboration

Use `COLLAB.md` as a collaboration control plane, not as a substitute for the
source research or either repository's instructions.

## Establish the role

1. Locate and read the source repository's root `COLLAB.md` in full.
2. Determine whether this agent is the source repository's **owner** or a
   **guest consumer** working primarily in another project.
3. Read all applicable repository instructions. Human and repository
   instructions override this skill, and `COLLAB.md` may further narrow
   permissions.
4. Stop and ask the human when the role, destination project, allowed write
   surface, or branch ownership is ambiguous.

## Guest consumer protocol

- Treat the source repository as read-only except for the exact writes granted
  by its `COLLAB.md`.
- Consume cited research with its assumptions, source revisions, confidence
  levels, and claim limits intact.
- Perform implementation and normal edits only in the destination repository,
  under that repository's own instructions.
- After actual destination work is complete, append one uniquely headed guest
  section to the source `COLLAB.md`. Never edit owner-maintained text or another
  guest's section.
- Record the source files used, decisions adopted or rejected, destination
  repository-relative paths, destination branch and commit IDs, validation,
  stale assumptions, and feedback.
- Never copy secrets, proprietary source, credentials, or sensitive absolute
  paths into the ledger.

If the source ledger grants the standard local Git workflow:

1. Require a clean source worktree; never stash, reset, or clean someone else's
   changes.
2. Start a unique `collab/*` branch from the current local integration branch
   only when ready to write the log.
3. Edit and stage only `COLLAB.md`.
4. Check the unstaged and staged name-only diffs and `git diff --check`.
5. Create a local commit with a `collab:` subject.
6. Do not push, fetch, pull, add remotes, merge, rebase, amend, or alter the
   integration branch.
7. Switch back to the integration branch, leave the worktree clean, and report
   the guest branch and commit ID.

When the ledger grants a smaller write surface, follow the smaller surface.
When it grants no guest writes, provide the usage report to the owner without
editing the source repository.

## Required guest log

Use the ledger's template. At minimum, include:

- guest identity, date, status, collaboration branch, and source base commit;
- destination project, branch, and commit;
- a row for each research source showing how it affected a concrete destination
  path or decision;
- adopted and rejected recommendations;
- destination validation and evidence; and
- corrections, stale assumptions, or open questions for the owner.

Log completed use rather than plans. An explicit, reasoned "not adopted" entry
is preferable to silently omitting evaluated guidance.

## Owner protocol

- Keep `COLLAB.md` status, research map, caveats, and consumer hints current.
- Clearly state the guest write budget and make it append-only wherever
  practical.
- Periodically inspect local unmerged `collab/*` branches.
- Before integration, inspect every branch commit and the merge-base diff.
  Accept only the paths and operations authorized by `COLLAB.md`.
- Verify that each guest claim points to concrete destination evidence and does
  not overstate assurance.
- Merge locally as the owner. Preserve all independent guest sections when
  append-only branches conflict.
- Update owner status and the repository handoff document when that repository
  requires it.
- Never push merely because a guest branch was merged; publication remains a
  separate human-authorized action.
