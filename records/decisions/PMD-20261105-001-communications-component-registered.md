# Communications component registered

- **Record ID:** `PMD-20261105-001`
- **Created:** 2026-11-05
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Records that the independent, agent-owned repository `../communications/`
is a registered Beryllium component, how it is registered in the Project
Manager and parent-root artifacts, and its intended GitHub identity.
Touches `../communications/` (read only; observed with maintained
inspection at 2026-11-05T04:53Z: clean `main` at
`1f668021ddefa230dd4a2df207ead532836e0ec0`, "Refresh the handoff with the
public repository's current state", its only branch, no remote, no
remote-tracking ref, and no tag), this repository, and the parent root.
`../beryllium-hypervisor/` and `../analysis-workbook/` were active owner or
direct-human sessions by the responsible human's statement and were
observed only with lock-free maintained inspection.

## Inputs

- The responsible human's direction in the Project Manager session at
  2026-11-05T04:45Z (2026-11-04 20:45 at UTC-8): `"register the new
  communications component, this will be a private repo in the gh
  beryllium project; note that beryllium-hypervisor is active, do not
  interfere with it."`, followed by `"so is analysis workbook"`.
- `../communications/README.md` at `1f66802`: the repository holds
  public-facing writing about Beryllium (conference proposals, an internal
  white paper, and later papers, talks, and blog posts); public-safe copy
  uses only committed Beryllium and Helium content and public primary
  sources, checked against Beryllium's forbidden-phrasing list before every
  commit; internal drafts may use private peer research only behind a
  visible `PRIVATE-SOURCE` marker naming the source component; submission, publication,
  push, adding a remote, opening a pull request, and sending email are
  responsible-human actions requiring explicit consent at the time. It also
  records drafts produced in human-run sessions on other models.
- `../communications/HANDOFF.md` at `1f66802`: two conference proposals
  are recorded as submitted by the human (2026-10-31 and 2026-11-01); the
  repository is on `main` with no remote and not yet registered; its next
  action was to prepare a Project Manager registration request. Its later
  list asks that request to report stale registry rows (Beryllium branch,
  workbook branch, Helium tag) and asserts that Beryllium release candidate
  3 board evidence has overtaken the parent's assurance wording that K3
  hardware is `NOT RUN`; its source pins also cite a public Beryllium
  snapshot of `beryllium-project/beryllium-hypervisor` `main`.
- `../communications/.github/copilot-instructions.md` at `1f66802`: write
  only inside the repository; "Never stage, commit, or ignore it from the
  parent repository; parent registration goes through a Project Manager
  request carried by the responsible human"; read siblings for evidence
  only, pinned to exact commits; never read
  `osr-claude/sources/restricted-microsoft/`; claim discipline; the
  single-model `claude-opus-5.5` / `max` / `long_context` session
  configuration. The responsible human's direct request to the Project
  Manager is that registration route, and the parent `.gitignore` entry is
  a Project Manager-owned parent artifact, so the rule is honored.
- `records/decisions/PMD-20260906-003-security-reviewer-component-registered.md`:
  the registration precedent this record follows.
- `records/decisions/PMD-20260904-003-standing-carry-authority.md`,
  `records/decisions/PMD-20261011-001-workspace-rehydration-contract.md`,
  and `records/decisions/PMD-20261025-002-github-backup-direction.md`.

## Disposition

1. **Component registered.** `communications/` is an ignored canonical
   direct checkout, agent-owned, with the write boundary "own repository
   only". It is added to the parent `.gitignore`, `COMPONENTS.md` (backup
   and component tables), and `README.md`; and to `AGENT-ROSTER.md`,
   `components/communications.md`, `REHYDRATE.md`,
   `scripts/inspect-components.sh` (`registered_direct`),
   `tests/validate-agent.sh`, and the `fetch_snapshot` step of the
   human-run `scripts/owner-actions.sh`; the registry's target-identity
   notes record its intended identity. Generated tasking includes a
   `communications` view, which lists no open request. Unlike the
   `PMR-022` precedent, no request asks the workbook, threat-modeler, or
   security-reviewer owners to add `communications` to their owner-only
   `scripts/readonly-inspect.sh` target lists, because none of them
   consumes it yet.
2. **Intended identity: private `beryllium-project/communications`.** The
   responsible human states that the repository will be private in the
   `beryllium-project` organization. The Project Manager performed no
   GitHub operation and does not know whether it exists. Creating it,
   adding remote `origin`, and pushing are responsible-human actions: the
   Project Manager's execution boundary excludes `gh`, remote changes, and
   component pushes, and the component's own rules reserve adding a remote
   and pushing to the human. The human's one-line step is
   `gh repo create beryllium-project/communications --private --source /home/jmorris/src/beryllium-project/communications --remote origin --push`.
   Until it runs, the `l1` checkout is the only copy of the repository,
   including the two as-submitted proposal texts (`PMD-20261025-002`). No
   `owner-actions.sh` push step is added; later pushes stay with the human
   under the component's rules.
3. **Carry authority applies as written.** Communications is not one of
   the two carry-ineligible components of `PMD-20260904-003`. It has no
   Project Manager queue (class 1) and no designated source index
   (class 2). Class 3 covers only Project Manager-role and registration
   wording in its Markdown README and handoff. Their "not yet registered"
   sentences and the handoff's next action of preparing a registration
   request become stale with this record and are left to the component's
   next session; they are a class-3 candidate for a later clean, idle turn,
   not carried now, and no request is raised. Its
   `.github/copilot-instructions.md` is an agent instruction file and stays
   request-only.
4. **No custom agent; no tasking request.** The component has repository
   instructions only and is worked in an ordinary Copilot session started
   in `communications/`. Its README directs reading the parent `SOT.md`
   before resolving a sibling path; it has no
   `check Project Manager tasking` mapping. This is an explicit deferral of
   the `PMD-20260915-008` startup mapping for this component: with no
   request open for it, no adoption request is raised now, and the first
   request routed to it will include that adoption.
5. **Component-side claims recorded, not adopted.** The recorded
   submissions are the human's acts. The README's record of drafts made in
   human-run sessions on other models is a component-side record of the
   human's choices; Project Manager records carry no exception to
   `PMD-20261006-001`. The handoff's claims about Beryllium release
   candidate 3 board evidence and a public Beryllium snapshot of
   `beryllium-project/beryllium-hypervisor` are unverified by the Project
   Manager; the second conflicts with PMR-098's owner-reported `PRIVATE`
   visibility. Neither changes assurance wording or a gate; both belong to
   the open responsible-human Beryllium stage reconciliation. The registry
   rows the handoff names as stale are refreshed this turn from maintained
   inspection; Helium's local tag `v0.6.0` was already recorded under
   `PMR-026`.
6. **Active sessions respected.** Beryllium and the analysis workbook were
   observed only with lock-free maintained inspection; nothing was written
   there, and no fetch or push touching them is recommended until their
   sessions are idle. The unregistered, untracked `beryllium-cheri/`
   (files modified 2026-11-05T04:41Z) is not registered by this record.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance,
approval, sign-off, licensing, publication, release, formal verification,
or hardware validation. It does not create the GitHub repository, add a
remote, push, or choose visibility beyond recording the human's stated
intent. It approves no submission, publication, or public-safe status of
any communications artifact, does not review the component's claims, and
does not register `beryllium-cheri/`. Beryllium remains accepted through
R7; R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium remains a review-and-test
proof of concept, not formally verified or hardware validated. Open human
gates: creating the private repository and its first push (item 2); every
submission, publication, push, remote, pull request, and email of the
component.

## Follow-up

- Human: run
  `gh repo create beryllium-project/communications --private --source /home/jmorris/src/beryllium-project/communications --remote origin --push`
  with the `gh` account that administers the `beryllium-project`
  organization active. The next coordination turn verifies
  `origin/main` with `bash ./scripts/inspect-components.sh refs communications`.
- Communications session (human-started, when next used): update the
  README and handoff registration wording under this record.

## Provenance

- Written by the `project-manager` agent in the 130th coordination turn
  from the inputs above. Before registration, the Project Manager listed
  and read files in `../communications/`, including its `.git/HEAD` and
  `.git/config`, with read-only `ls`, `find`, and `cat`; it ran no Git
  command there. After adding the entry to `registered_direct`, it used
  only `scripts/inspect-components.sh`. Nothing was written in any
  component.
