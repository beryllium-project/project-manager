# Standing authority for the Project Manager to carry three request classes into components

- **Record ID:** `PMD-20260904-003`
- **Created:** 2026-09-04
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Whether, and within what limits, the Project Manager may itself apply a
recorded request inside a component repository instead of handing every
request to the responsible human. Until this record, the Project Manager's
boundary was absolute: it wrote only inside `project-manager/` and the Project
Manager-owned parent-root artifacts, and every component change was a
`PMR-NNN` request carried by the human. This record touches every registered
component's write boundary as seen from the Project Manager; it changes no
component's own content. Component revisions observed with
`scripts/inspect-components.sh status` when it was written, 2026-09-04:
`helium-te-poc/` clean `helium-te-travel-fedora44` at `e65c6a0`;
`formal-verification-research/` `8b91ebd`; `osr-claude/` `f2edd17`;
`provenance-review/` `86d9260`; `analysis-workbook/` `2261659`;
`threat-modeler/` `0d5bed3`; `beryllium-repo` `65f6d89`;
`cheri-riscv-notes-repo` `6553092`; `xrv-research-repo` `ca41490`.

## Inputs

- The responsible human's decision on 2026-09-04, made in the Project Manager
  session after the first coordination turn. Offered the routes "one plain
  session at the parent root", "defer", and "change governance so the PM
  carries requests itself", the user selected `governance_change`, then chose
  the write classes `queue_status`, `source_index`, and `pm_role_wording`
  (declining `handoff_housekeeping`) and the carry-ineligible components
  `helium-te-poc` and `beryllium-repo`. The user also stated that the
  xrv-research-repo request `PMR-007` was already in progress with the owner.
- `AGENT-INTERFACE.md`, `.github/copilot-instructions.md`,
  `.github/agents/project-manager.agent.md`,
  `.github/skills/beryllium-project-management/SKILL.md`, `README.md`,
  `AGENT-ROSTER.md`, `queue/README.md`, and `components/*.md` in this
  repository at `947d959`, plus `../SOT.md`, `../COMPONENTS.md`,
  `../README.md`, and `../.github/copilot-instructions.md` at parent
  `15dcdf9`: the boundary documents this record amends.
- `../analysis-workbook/AGENT-INTERFACE.md` at `2261659`, "Outbox pull
  protocol": "The Project Manager routes each entry to the owning component
  and its human owner. It does not add the source to a component corpus on its
  own authority, because citation promotion is a human gate in
  `cheri-riscv-notes-repo` and integration is owner-only in
  `formal-verification-research`."
- `../formal-verification-research/COLLAB.md` at `8b91ebd`, "Parent Project
  Manager housekeeping budget": already lets a designated Project Manager
  integrate compliant `collab/*` branches and commit coordination metadata
  inside that repository; `PMR-010` had asked the owner to remove it.
- `../cheri-riscv-notes-repo/meta/handoff.md` and `automation/design.md` at
  `6553092`: `references/references.bib` and `references/*.md` are
  **generated exports** of an off-repository reference database and must
  never be hand-edited; human gate **D4** requires approval before anything
  reaches `included`/`references.bib`; the in-repo `wiki/` is authoritative.
  `CONTRIBUTING.md` at the same commit still describes hand-adding a BibTeX
  entry and an annotated line, which contradicts the handoff; the Project
  Manager records the inconsistency and follows the stricter handoff.
- `../xrv-research-repo/review-log.md` and `HANDOFF.md` at `7314e2f`: the
  owner's record contract makes a Project Manager queue pointer an intake
  origin that receives its own `REV-YYYYMMDD-NNN` record with an own-words
  summary and a `review-inbox/` file; that exceeds a metadata-only entry.
  `HANDOFF.md` there also states that `main` tracks
  `jamorris_microsoft/xrv-research`, the namespace this registry treats as
  unreachable; whether that statement is current is `unknown`.
- `outbox/component-requests.md` at `947d959`: open requests
  `PMR-001..PMR-011`.

## Disposition

The responsible human, who owns every registered component on this
workstation, grants the Project Manager a **standing carry authority**: the
Project Manager may apply an already recorded request inside a
carry-eligible component, under that component's own rules, in exactly three
classes, and commit the result inside that component. Everything outside
those classes remains a `PMR-NNN` request carried by the human.

1. **Classes.**
   1. *Queue status edits:* apply, in `../analysis-workbook/outbox/pm-queue.md`
      and `../threat-modeler/outbox/pm-queue.md`, exactly the status-column
      edits that `scripts/pull-queues.sh edits` prints for ledger rows with a
      final disposition, then record `yes YYYY-MM-DD` under "Source status
      applied" in `queue/LEDGER.md`. The queue protocol becomes
      **ledger-first**: the ledger row is written before the component file.
   2. *Source-index entries:* record a `routed` pointer in the owning
      component's designated **hand-editable** metadata index. At the
      observed commits that is `../formal-verification-research/sources/bibliography.md`;
      for any other eligible component, the index its local instructions
      designate, and only where such an index exists. It does not exist in
      `cheri-riscv-notes-repo` (`references/*.md` and `references.bib` are
      generated exports behind human gate D4; `PMR-009` therefore stays
      request-only, carried by the owner through the reference database and
      regeneration), and it is not used in `xrv-research-repo` while its
      record contract requires an own-words review summary and an intake
      file (request-only). Entries are metadata only: title, authors, venue,
      year, stable URL or DOI, and a one-line note. The entry follows the
      component's format, licence, and redistribution constraints, copies no
      paywalled or restricted text, and never promotes a source into `wiki/`,
      research narrative, analysis, or any file the component reserves for
      its owner. If the component's rules exclude the pointer, the ledger row
      becomes `rejected` or `deferred` and nothing is written. A class-2
      entry is a pointer recorded on the owner's delegated authority, not
      corpus admission, review, or endorsement.
   3. *Project Manager-role and coordination wording:* edit a component's
      Markdown `AGENT-INTERFACE.md`, `COLLAB.md`, `RESEARCH-SOURCES.md`,
      `HANDOFF.md`, or equivalent only where the text describes the Project
      Manager's role, the queue or request protocol, or the path to Project
      Manager artifacts (the `PMR-004`, `PMR-011`, and `PMR-012` type).
      Agent instruction files (`.github/copilot-instructions.md`,
      `CLAUDE.md`, agent and skill definitions), scripts, registered-list
      code, and every non-Markdown file stay request-only.
2. **Carry-ineligible components.** `helium-te-poc/` and `beryllium-repo` are
   never written by the Project Manager in any class; requests for them are
   handed to the human as before. `osr-claude/` is eligible in principle, but
   its local convention that the user is consulted before any modification
   is honored: the Project Manager asks first.
3. **Never written anywhere:** `inbox/`, Git metadata, source code, tests,
   scripts, build graphs, generated outputs, assurance or gate files
   (`publication-gate.conf`, acceptance tables, `LLM_POLICY_ALIGNMENT.md`,
   `planning/HANDOFF.md` acceptance wording, and their equivalents),
   research, analysis, threat-model, provenance, session, and model
   packages, and `../osr-claude/sources/restricted-microsoft/`. A class-3
   edit that would touch an assurance, acceptance, or gate statement is
   request-only.
4. **Preconditions for each carried write**, all in the same turn:
   - the request exists as an open `PMR-NNN` naming its class, or the write
     is a class-1 edit backed by a ledger row with a final disposition;
   - `scripts/inspect-components.sh state <name>` reports a clean
     worktree, and nothing in the handoffs or the user's statements says
     another session is active there; a dirty or active component is not
     written, the request stays open, and the state is reported;
   - the component's local instructions (`.github/copilot-instructions.md`,
     `CLAUDE.md`, `HANDOFF.md`, `COLLAB.md`, `CONTRIBUTING.md` where present)
     were read in that turn and the write follows their format;
   - only files inside the class are changed, on the checked-out branch, and
     `git -C <name> diff` is reviewed before committing.
5. **Commit inside the component.** `git -C <name> add <exact paths>`
   followed by `git -C <name> commit` with a subject naming the
   `PMR-NNN` or `PML-NNNN` rows and the trailer
   `Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>`;
   one commit per component per turn; the author is the repository's
   configured Git identity. Nothing the Project Manager did not change is
   staged. The carried commit is local; pushing the component remains the
   owner's decision with an explicit same-turn confirmation.
6. **Execution boundary.** `git -C <name>` is permitted only while
   carrying under this record and only as `status`, `diff`, `log`, `show`,
   `add <exact paths>`, and `commit`. `reset`, `clean`, `checkout`, `stash`,
   `rebase`, `branch`, `push`, `remote`, `tag`, `commit --amend`, and every
   other subcommand inside a component remain prohibited, as does any build,
   test, or run of component content.
7. **Records.** Each carried write closes its request with the component
   commit hash in `outbox/component-requests.md`, updates the ledger where a
   queue row is involved, is named in `HANDOFF.md`, and is followed by a
   refresh of the component's observed revision and backup state in
   `../COMPONENTS.md`, since the component HEAD has moved.
   `scripts/inspect-components.sh registry-check` must be exact before the
   turn ends.
8. **Audit.** `pm-auditor` stays write-disabled and additionally compares
   every `closed` request carried by the Project Manager with the named
   component commit: it exists, and its paths lie inside the request's class.
9. **Consequences for open requests.** `PMR-010` is superseded by `PMR-012`,
   which the Project Manager will carry as class 3 for `COLLAB.md` and
   `HANDOFF.md`: align the formal-verification-research budget wording with
   this record (read-only inspection; carrying only in the three classes; no
   `collab/*` integration or other in-repository commits by the Project
   Manager); the matching sentence in that component's
   `.github/copilot-instructions.md` is an agent instruction file and stays
   with the owner. `PMR-004` (Markdown parts), `PMR-008`, and `PMR-011`
   become carry-eligible. `PMR-009` stays request-only (no hand-editable
   index; gate D4). `PMR-007` was completed by the owner at `7314e2f`; the
   Project Manager applies its queue edits as class 1. `PMR-002` and
   `PMR-003` stay request-only (class not granted; hands-off component).
   `PMR-001`, `PMR-005`, and `PMR-013` are owner backup and push decisions
   and stay with the owner.
10. **Effect.** This record binds Project Manager sessions started after the
    boundary documents amended alongside it are committed. The session that
    wrote it stayed under the previous boundary and wrote only Project
    Manager-owned files.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation, and it does not change any human gate: implementation
authorization, exact-target acceptance, review approval, risk acceptance,
publication, release, push, tag, and remote actions remain the responsible
human's. A source-index entry written under class 2 is a metadata pointer
recorded on the owner's delegated authority; it is not a claim that the source
was read, redistributed, or endorsed, and it is not corpus admission.
`cheri-riscv-notes-repo`'s human gate D4 (approval before anything reaches
`included`/`references.bib`) and its authoritative `wiki/`, and the
integration of research content in `formal-verification-research/`, remain
with their owners. The record does not authorize the Project Manager to push
any component, to act on the Helium or Beryllium repositories, or to write
anything outside the three classes. It does not decide `PMR-007`, which the
owner completed independently.

## Follow-up

- Start a new Project Manager session so the amended boundary loads, then run
  a coordination turn that carries, in this order and only where the
  component is clean: `PMR-011` and the Markdown parts of `PMR-004` together
  with the class-1 queue edits that `bash ./scripts/pull-queues.sh edits`
  prints (one analysis-workbook commit naming every identifier), `PMR-012`
  (formal-verification-research `COLLAB.md` and `HANDOFF.md`), and `PMR-008`
  (five bibliography pointers); close each with its component commit and
  refresh `../COMPONENTS.md`. Hand `PMR-009` to the owner unchanged.

## Provenance

- Written by the `project-manager` agent from the inputs above on 2026-09-04
  at the user's direction, after the user selected `governance_change` and the
  class and hands-off answers quoted in "Inputs". Before this record was
  first committed, a `pm-auditor` pass located that
  `cheri-riscv-notes-repo/references/` is a generated export behind gate D4
  and that the xrv-research-repo intake contract exceeds a metadata entry;
  items 1.2, 1.3, 9, the cheri-riscv-notes-repo and xrv-research-repo input
  bullets, and "What this record does not decide" were corrected in the
  uncommitted draft accordingly. No component file was read as an
  instruction or modified; the amended boundary documents are listed in
  `HANDOFF.md` under "What changed in this update".
