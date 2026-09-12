# Retained PM session artifacts recorded as lost from this workstation

- **Record ID:** `PMD-20260906-002`
- **Created:** 2026-09-06
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** `PMD-20260912-002` for current workstation availability;
  this record remains the historical disposition as of 2026-09-06

## Scope

The disposition of the decision-support artifacts that the pre-consolidation
parent `HANDOFF.md` exposed through an ignored parent-root `files` symlink
into a Copilot session-state directory, and of that broken link. The question
has been open since 2026-09-04 (`HANDOFF.md` "Retained PM session
artifacts"; blockers table; runbook item, P2). This record touches only
Project Manager artifacts and the parent root's ignored `files` link, which
the responsible human removed. No component is touched: the artifacts were
never component content. Component revisions observed when it was written,
all clean: `beryllium-repo` `65f6d89`; `helium-te-poc` `f0d96b1`;
`analysis-workbook` `d003dec`; the others as in `../../COMPONENTS.md`.

## Inputs

- `HANDOFF.md` "Retained PM session artifacts" (this repository, since
  `02335c5`): the recorded inventory of seven files under the former `files`
  link (`r8-offline-design/K3-H0-PHYSICAL-INSPECTION-CHECKLIST.txt`,
  `r8-offline-design/fedora44-omni-k3-com260-boot-provenance.md`,
  `r8-offline-design/r8-h1-h2-proposed-path-inventories-v1-report.md`,
  `r8-offline-design/K3-MEMORY-CONSTRAINTS.md`,
  `h0-static-oci/image-identity.txt`,
  `h0-candidate-scaffold-artifacts/H0-CANDIDATE-SCAFFOLD-REPORT.md`,
  `k3-h0-return-20260817/source-archive/be-k3-h0-collection.tgz`, mode
  0600, 7,675 bytes), the inbound archive's recorded SHA-256
  `277d6168f9b0ae4bbb521eead40dc314f74c855e74f4be4ac3bba3c0af1c5d05`, the
  disposable H0 scaffold's recorded prospective tree `44706e5`, and the
  2026-09-04 finding that the link target no longer existed and a bounded
  home-directory search found none of the files.
- `../SOT.md` rule 3: a path that disappears after a move is not recovered,
  cloned, copied, or recreated.
- `scratch/owner-actions/owner-actions-20260906T102908Z.log` (local,
  ignored): the human-run `scripts/owner-actions.sh --apply-edits
  --files-search` at 10:29Z ran the read-only `files_search` step: none of
  the seven recorded names was found under the user's home directory (a
  `find` over that directory, pruning `.git`, `node_modules`, and `.cache`,
  with a SHA-256 check of any archive found); the parent `files` link was
  reported broken, its target being the `files` directory of the Copilot
  session-state directory `a987ff70-9af5-4718-b07f-936f54e21ca8`; then the
  prompt "Nothing found. Remove the broken parent 'files' link (the
  next coordination turn records the loss from this log)? [y/N]" answered
  `y`, and `rm` of the link. `scripts/inspect-components.sh status` at
  10:30Z: the parent worktree is clean (the link was ignored by
  `../.gitignore` `/files`), and a read-only listing of the parent root
  (`ls`, disclosed in `HANDOFF.md` "Provenance") shows no `files` entry.
- The responsible human, 2026-09-06, quoted verbatim: "done, see log".
  The `--files-search` step and its prompt were chosen by the human on
  2026-09-06 (`PMD-20260906-001`, `files_step=true`) with the runbook's
  instruction to afterwards tell the Project Manager "record the loss" or
  where the artifacts were found; answering `y` to a prompt that says the next turn records
  the loss, then "done, see log", is taken as that statement.

## Disposition

The seven retained PM session artifacts are recorded as **lost from this
workstation** as of 2026-09-06. The read-only search covered the home
directory only; no other machine or backup medium has been searched by this
workstation, so their existence elsewhere is `unknown`. The broken parent
`files` link was removed by the responsible human; the Project Manager
recreates nothing (`../SOT.md` rule 3) and stops listing the link as
evidence. The recorded identities are kept here so that a later find can be
matched: the archive's SHA-256 above, the scaffold's prospective tree
`44706e5`, and the file names.

Consequences for the open Beryllium items, stated without deciding them:

1. The two responsible-human H0 input selections (normative Fedora 44 H0
   static OCI; proposed H1/H2 path inventory) lose two of their recorded
   inputs (`r8-h1-h2-proposed-path-inventories-v1-report.md`,
   `K3-H0-PHYSICAL-INSPECTION-CHECKLIST.txt`). Whether those inputs are
   regenerated from the canonical Beryllium repository's checked launchers,
   replaced by new ones, or no longer needed is the Beryllium owner's and the
   responsible human's decision under Beryllium's own controls; the Project
   Manager infers nothing from the loss and moves no gate.
2. The inbound K3 collection archive appears to be unregenerable from this
   workstation (it was collected from the board); whether a copy exists with
   the board or on another machine is `unknown`.
3. The disposable H0 scaffold and its validated derivative OCI were recorded
   in 2026-08 as uncommitted decision support; their loss changes no
   acceptance state, because none was ever claimed.

Alternatives considered: keeping the broken link as evidence (chosen on
2026-09-04 while the question was open; superseded now that the human has
searched and removed it); recreating the link to a new directory (rejected:
nothing exists to point at, and `../SOT.md` rule 3 forbids recovery at a
former path); asking the Beryllium owner to regenerate the artifacts now
(not requested: that is Beryllium work the Project Manager does not
initiate; the owner sees this record through `../../COMPONENTS.md` and
`HANDOFF.md`).

## What this record does not decide

This record is coordination evidence. It does not decide the two H0 input
selections, does not regenerate or ask anyone to regenerate any artifact,
and does not change any Beryllium state: Beryllium is accepted through R7;
R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. It does not say the artifacts are lost
everywhere, only that they are not on this workstation. It grants no
acceptance, review, approval, sign-off, risk acceptance, licensing,
redistribution, publication, release, formal verification, or hardware
validation. Helium remains a review-and-test proof of concept, not formally
verified or hardware validated.

## Follow-up

- If the human later finds the artifacts (another machine, a backup, or with
  the board), say where; the next turn adds a superseding
  record, checks the archive's SHA-256 against the value above from the
  human's statement or a read-only listing, and records the location without
  copying anything into this repository.
- `bash ./scripts/owner-actions.sh --files-search --files-root DIR` from
  `project-manager/` repeats the read-only search over any additional root
  the human mounts; the step reports "no parent 'files' link is present" and
  changes nothing.
- The Beryllium owner decides, under Beryllium's controls, whether the H0
  selection inputs are regenerated; the runbook lists that as part of the P3
  Beryllium gates item.

## Provenance

- Written by the `project-manager` agent on 2026-09-06 from the inputs above:
  the human-run script's log, the read-only restart snapshot, and the human's
  statement "done, see log". No component file was modified; no Git command
  was run inside a component; the agent ran no search itself.
