# communications

- **Workspace entry:** `../communications/` (ignored canonical direct
  checkout; registered 2026-11-05 by
  `../records/decisions/PMD-20261105-001-communications-component-registered.md`)
- **Ownership:** agent-owned; its sessions write only inside that component.
  The Project Manager writes here only to carry a class-3 Project
  Manager-role or registration wording request in its Markdown README or
  handoff under the standing carry authority
  `../records/decisions/PMD-20260904-003-standing-carry-authority.md`,
  committing inside this component; it has no queue and no source index
  for routed pointers
- **Agents:** no custom agent or skill; an ordinary Copilot session started
  in `communications/` follows its `.github/copilot-instructions.md`, which
  adopts the single-model `claude-opus-5.5` / `max` / `long_context`
  configuration
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `README.md`
- **Observed state:** clean `main` at `1f66802` ("Refresh the handoff with
  the public repository's current state"), its only branch, with no remote,
  remote-tracking ref, or tag (maintained inspection,
  2026-11-05T04:53Z on `l1`). The responsible human states that it will be
  the private `beryllium-project/communications`; until the human creates
  that repository and pushes, the `l1` checkout is its only copy

## Role

Public-facing writing about Beryllium: conference proposals, an internal
white paper, and later papers, talks, and blog posts. At `1f66802` it holds
two conference proposals that its handoff records as submitted by the human
(2026-10-31 and 2026-11-01), their superseded drafts, a deep review of the
first draft, and the rewrite prompt. A white paper under `papers/` is
planned after the human authorizes that phase.

## Boundaries and conventions

- Every other component is a read-only input; facts are pinned to exact
  commits from committed content, never a dirty worktree. Beryllium and
  Helium have no `COLLAB.md`, so source-use evidence returns through their
  owners and the Project Manager.
- Public-safe copy uses only committed Beryllium and Helium content and
  public primary sources and is checked against Beryllium's
  forbidden-phrasing list before every commit. Internal drafts may use
  private peer research only behind a visible
  `[PRIVATE-SOURCE: <component>]` marker and are not publication-eligible
  until the human and the source owners clear each passage.
- Submission, publication, push, adding a remote, opening a pull request,
  and sending email are responsible-human actions, each with explicit
  consent at the time.
- Never reads `../osr-claude/sources/restricted-microsoft/`.
- Its README records drafts produced in human-run sessions on other models;
  these are component-side records of the human's choices, and Project
  Manager records carry no exception to `PMD-20261006-001`.
- Its handoff at `1f66802` asserts that Beryllium release candidate 3 board
  evidence has overtaken the parent's assurance wording that K3 hardware
  is `NOT RUN`, and cites a public Beryllium snapshot of
  `beryllium-project/beryllium-hypervisor` `main`, which conflicts with
  PMR-098's owner-reported `PRIVATE` visibility. These are unverified
  component-side claims; Project Manager assurance wording stays unchanged
  pending the open responsible-human Beryllium stage reconciliation.

## Commands (from `../communications/`; the Project Manager runs none)

```sh
copilot                                    # ordinary session; no custom agent
```

Before each commit of public-safe copy, the component's sessions run the
workstation phrasing checker its README names against an exact Beryllium
commit; that checker lives outside every repository.

## What the Project Manager may request

Class-3 registration wording in its README and handoff (stale after
`PMD-20261105-001`; left to its next session, no request raised), a
source-use report back to a source owner through the Project Manager, or
sibling evidence it should cite. Creating the private
`beryllium-project/communications` repository and pushing `main` are the
human's actions (`../outbox/OWNER-RUNBOOK.md`).
