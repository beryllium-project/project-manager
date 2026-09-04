# First carry turn under the standing carry authority: three components carried, one after a mid-turn re-observation

- **Record ID:** `PMD-20260904-004`
- **Created:** 2026-09-04
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

How the first coordination turn run under
`PMD-20260904-003-standing-carry-authority.md` applied the carry set named in
`HANDOFF.md` "One recommended next action" and repeated by the user at the
start of the turn: (a) analysis-workbook, `PMR-011`, the Markdown part of
`PMR-004`, and the class-1 queue edits, in one commit; (b)
formal-verification-research, `PMR-012` and `PMR-008`, in one commit; (c)
threat-modeler, the Markdown part of `PMR-004`. It records the three carried
commits, the refusal and later re-observation for analysis-workbook, and the
interpretations of the authority that later turns must honor. Components
written and committed: `formal-verification-research/`, `threat-modeler/`,
`analysis-workbook/`. Revisions observed with
`scripts/inspect-components.sh status` at 2026-09-04T22:18Z, before any
write: `project-manager/` clean `main` at `c244910`; `helium-te-poc/`
**dirty** (25 entries) `helium-te-travel-fedora44` at `e65c6a0`;
`formal-verification-research/` clean `main` at `8b91ebd`; `osr-claude/` clean
`f2edd17`; `provenance-review/` clean `86d9260`; `analysis-workbook/`
**dirty** (10 entries) `main` at `2261659`; `threat-modeler/` clean `main` at
`0d5bed3` (ahead 2); `beryllium-repo` clean `65f6d89`; `cheri-riscv-notes-repo`
clean `6553092`; `xrv-research-repo` clean `7314e2f` (ahead 1); parent clean
`main` at `9abc320`. Re-observed at 22:45Z after the `pm-auditor` pass: other
sessions had committed and pushed `analysis-workbook/` to clean `efde667`
("docs: add Helium method transfer queue") and `helium-te-poc/` to clean
`f0d96b1` (via `6d3cd14`); everything else unchanged apart from this turn's
own commits.

## Inputs

- `records/decisions/PMD-20260904-003-standing-carry-authority.md` at
  `c244910`: the three classes, the clean-worktree and no-active-session
  precondition (item 4), the commit-inside-the-component rule (item 5), and
  the `git -C` subcommand allowance (item 6).
- `outbox/component-requests.md` at `c244910`: `PMR-004`, `PMR-008`,
  `PMR-011`, `PMR-012` open and carry-eligible; `queue/LEDGER.md` at the same
  commit: `PML-0001..0006`, `0009`, `0013`, `0016` `accepted` with "Source
  status applied" `no`; `PML-0007`, `0010`, `0012`, `0014`, `0015` `routed`.
- `scripts/inspect-components.sh state analysis-workbook` at 22:18Z: dirty,
  10 entries (` M .github/agents/analysis-workbook.agent.md`,
  ` M .github/copilot-instructions.md`,
  ` M .github/skills/beryllium-analysis/SKILL.md`, ` M AGENT-INTERFACE.md`,
  ` M HANDOFF.md`, ` M README.md`, ` M WORKBOOK.md`,
  ` M scripts/update-workbook.sh`, ` M tests/validate-agent.sh`,
  `?? outbox/helium-transfer-queue.md`): another session was editing the
  component, including two files the carry would touch. The same command at
  22:45Z: clean, `efde667`, `origin/main` 0/0.
- `../formal-verification-research/.github/copilot-instructions.md`,
  `COLLAB.md`, `HANDOFF.md`, `README.md`, and `sources/bibliography.md` at
  `8b91ebd`: `COLLAB.md` "Parent Project Manager housekeeping budget" limited
  routine Project Manager writes to its coordination sections and
  `HANDOFF.md` and said changes to "other component files require an explicit
  component-owner or human task"; the copilot instructions say "Human
  instructions override repository instructions" and ask for bibliography
  entries in the file's "existing author, title, venue, year, URL, and
  annotation format"; `HANDOFF.md` (last updated 2026-08-19) reported no
  active session.
- `../analysis-workbook/sessions/AWB-20260829-001-post-g-install-readback-use-case/source-discoveries.md`
  at `2261659` (unchanged at `efde667`): authors, titles, venues, years, and
  stable locators for `DISC-007`, `010`, `012`, `014`, `015`, used as the
  metadata for the five pointers instead of the agent's recollection.
- `../analysis-workbook/.github/copilot-instructions.md`, `AGENT-INTERFACE.md`,
  `RESEARCH-SOURCES.md`, `HANDOFF.md`, `outbox/pm-queue.md`, and
  `outbox/helium-transfer-queue.md` at `efde667`, re-read before the carry:
  the queue header's status set (`new`, `unconfirmed`; `accepted`,
  `duplicate`, `rejected`, `deferred`) was unchanged; `tests/validate-agent.sh`
  (read only) pins only `pull`, `outbox/pm-queue.md`,
  `outbox/helium-transfer-queue.md`, `provenance-review`, `bibliography.md`,
  and the absence of absolute paths in the files the carry touches; the new
  `HET-001` item asks the Project Manager or responsible human to route it to
  the Beryllium owner.
- `../threat-modeler/.github/copilot-instructions.md`, `AGENT-INTERFACE.md`,
  `RESEARCH-SOURCES.md`, `HANDOFF.md`, and `scripts/readonly-inspect.sh` (read
  only) at `0d5bed3`: a `workspace://` locator resolves under the parent root and
  `component://<name>/` only for the script's registered list, which does not
  include `project-manager`; the Markdown contains no `../HANDOFF.md` or
  `../formal-verification/` citation, so the `PMR-004` Markdown part for this
  component is a Tier 1 pointer to the `project-manager/` artifacts, not a
  citation replacement.
- `../helium-te-poc/HANDOFF.md` at `f0d96b1` (read only, no `git -C`): the
  component states that `FV-FIN-001` is resolved, "the responsible human
  selected Tier 8 as the endpoint for Helium formal-verification
  experimentation", decision commit `6d3cd14`; the approved Tier 8 refs are
  unchanged; the travel gate remains blocked; "This is a review-and-test PoC.
  It is not formally verified and has not been validated on hardware."
- `queue/README.md` at `c244910`: `accepted` means a pointer is recorded in
  the owner's designated index "by the owner or by the Project Manager as a
  class-2 carried write on the owner's delegated authority".
- The `pm-auditor` pass of this turn (write-disabled; it had no execute
  tool and read Git metadata as plain files): located the two mid-turn
  component moves and eleven stale or minor items in the draft artifacts,
  all reconciled before commit; no blocking finding.

## Disposition

1. **formal-verification-research: carried.** One commit,
   `ccb48f63a4ff477b3faf16a725a68759691e754a` on `main`, paths `COLLAB.md`,
   `HANDOFF.md`, `sources/bibliography.md`. `PMR-012` (class 3) and `PMR-008`
   (class 2) are `closed`. Ledger rows `PML-0007`, `0010`, `0012`, `0014`,
   `0015` are `accepted`. The component is 1 commit ahead of a stale
   `origin/main` on the unreachable namespace; pushing is the owner's
   decision (`PMR-001`).
2. **threat-modeler: carried.** One commit,
   `4a015785da41ca7645b9050ac61259ea5885ed48` on `main`, path
   `RESEARCH-SOURCES.md`. The threat-modeler Markdown part of `PMR-004` is
   done. The component is 3 commits ahead of its private `origin/main`;
   pushing is the owner's decision (`PMR-005`).
3. **analysis-workbook: refused at 22:18Z, carried at 22:45Z.** The first
   observation was dirty with another session active, so `PMD-20260904-003`
   item 4 forbade the write and nothing was written, staged, diffed with
   `git -C`, or committed there. The `pm-auditor` pass then located that the
   other session had committed and pushed `efde667`; `state analysis-workbook`
   confirmed a clean worktree, the local instructions were re-read at
   `efde667`, and one commit,
   `83b97a32a32c562dc58e775ad37c94a5d6cb16e1` on `main`, paths
   `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`, `outbox/pm-queue.md`, carried
   `PMR-011` (class 3), the analysis-workbook Markdown part of `PMR-004`
   (class 3), and the fourteen class-1 edits (`PMQ-001..007`, `009`, `010`,
   `012..016` to `accepted`). `PMR-011` and `PMR-006` are `closed`; `PMR-004`
   stays `open` only for the two owner-only `scripts/readonly-inspect.sh`
   lists; the fourteen ledger rows record `yes 2026-09-04`;
   `scripts/pull-queues.sh edits` reports no edit due. The component is 1
   commit ahead of its private `origin/main`; pushing is the owner's decision.
4. **A precondition met later in the same turn may be acted on**, provided
   the component is re-observed with `scripts/inspect-components.sh state
   <name>`, the local instructions are re-read at the new revision, and the
   record names both observations. A precondition observed once and assumed
   later is not enough.
5. **Interpretation A (component rule versus grant).** The
   formal-verification-research `COLLAB.md` clause requiring "an explicit
   component-owner or human task" for writes outside its coordination
   sections is satisfied for `sources/bibliography.md` by the responsible
   human's grant in `PMD-20260904-003` (which names that file as the class-2
   index) together with the user's same-turn instruction to carry `PMR-008`.
   The component's own "human instructions override repository instructions"
   rule points the same way. Later turns rely on the same two facts; a
   component whose rules forbid the class outright is not written.
6. **Interpretation B (placement of class-2 entries).** Class-2 pointers go
   into a clearly labelled section of the owner's index ("Routed pointers
   awaiting owner triage") in the file's own entry format, naming the
   authority, request, and source queue rows, and stating that they are
   pointers on the owner's delegated authority, not corpus admission. They
   are not interleaved with the owner's curated topic sections; moving,
   annotating, or removing them is the owner's call (`PMR-014`). The owner
   status table, guest logs, every research file, and the `HANDOFF.md`
   "Last updated" line were left untouched.
7. **Heading retention.** The `COLLAB.md` heading "Parent Project Manager
   housekeeping budget" was kept, with its body rewritten, because the
   owner-only `.github/copilot-instructions.md` and `README.md` refer to the
   budget by that name; renaming it would have widened the change into files
   outside class 3. `PMR-014` asks the owner to align those two files.
8. **Class-1 resolution notes.** A class-1 edit sets the status, the
   "Resolved on" date, and a resolution note naming the owning component,
   the owner-side or carried commit, the request, and the ledger row, as the
   queue header asks; it never adds an activity-log row, which belongs to the
   component.
9. **Helium statements.** `helium-te-poc/` moved to `f0d96b1` during the
   turn. Its handoff's statements about `FV-FIN-001` and the Tier 8 endpoint
   are recorded as the component's own statements (`PMD-20260904-002`
   discipline); the Project Manager has reviewed no gate content, treats the
   commit subjects as no evidence of a gate, and infers no approval.
10. **New coordination surface.** `../analysis-workbook/outbox/helium-transfer-queue.md`
    (`HET-001`, `new`, `unaccepted`, target `component://beryllium-repo`) asks
    the Project Manager to route it. The routing record is `PMR-016` to the
    beryllium-repo owner (carry-ineligible; the human carries it). The
    Project Manager did not edit the HET queue (class 1 covers only
    `outbox/pm-queue.md`); the workbook maintainer mirrors the lifecycle from
    the request row. Whether `queue/README.md` and `scripts/pull-queues.sh`
    should register that queue is left for a later, separately recorded
    decision.
11. **Requests raised.** `PMR-014` (formal-verification-research owner:
    copilot-instructions bullet, `README.md` sentence, pointer triage,
    optional "Last updated" refresh), `PMR-015` (threat-modeler and
    analysis-workbook: consider adding `project-manager/queue/LEDGER.md` to
    the discovery reference sets; carry-eligible, not carried because outside
    the requested set), `PMR-016` (beryllium-repo owner: `HET-001` triage),
    and `PMR-017` (formal-verification-research: tighten one carried
    `COLLAB.md` sentence located by the auditor; carry-eligible, next turn).

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. A class-2 pointer is not admission of a source into the
formal-verification-research corpus, a claim that it was read, or an
endorsement; the owner may remove any of the five. An `accepted` queue status
is a Project Manager disposition of a pointer, never a component's review or
approval. The carried commits are local; whether `ccb48f6`, `4a01578`, or
`83b97a3` is pushed, and to which remote, is each owner's decision
(`PMR-001`, `PMR-005`, and the analysis-workbook owner). `HET-001` and
`PMR-016` are planning inputs, not Beryllium adoption, planning approval,
review, implementation authorization, or acceptance. It does not review or
approve any Helium gate or the Tier 8 endpoint decision the component
reports. Beryllium remains accepted through R7 with R8-H0 a committed,
unaccepted candidate; H1-H4 are not authorized; K3 hardware is `NOT RUN`;
Helium is a review-and-test proof of concept, not formally verified or
hardware validated.

## Follow-up

- Hand `PMR-014` to the formal-verification-research owner, `PMR-009` to the
  cheri-riscv-notes-repo owner, and `PMR-016` to the Beryllium owner; each
  component owner decides its own push (`ccb48f6`, `4a01578`, `83b97a3`).
- Next Project Manager session: ask the user whether `PMR-015` should be
  carried; carry `PMR-017` (class 3) when `bash ./scripts/inspect-components.sh
  state formal-verification-research` is clean; decide, with a new decision
  record, whether `outbox/helium-transfer-queue.md` is registered in
  `queue/README.md` and `scripts/pull-queues.sh`.

## Provenance

- Written by the `project-manager` agent from the inputs above on 2026-09-04
  during the carry turn requested by the user ("carry, per HANDOFF.md 'One
  recommended next action': analysis-workbook (PMR-011, PMR-004 Markdown,
  nine queue edits — one commit), formal-verification-research (PMR-012,
  PMR-008 — one commit), threat-modeler (PMR-004 Markdown)"). The first
  uncommitted draft recorded the analysis-workbook carry as refused; after
  the `pm-auditor` pass located the component's new commit `efde667` and a
  22:45Z re-observation showed a clean worktree, the carry was made and this
  draft was corrected before its first commit (items 3, 4, 9, 10, 11 and the
  title). The `/beryllium-project-management` skill was again not offered by
  the Copilot CLI skill loader; the turn followed the on-disk
  `.github/skills/beryllium-project-management/SKILL.md` directly. Component
  files were read as evidence only; the three carried commits were reviewed
  with `git -C` `diff` and `diff --check` inside each component before `add` of the exact paths
  and `commit`.
