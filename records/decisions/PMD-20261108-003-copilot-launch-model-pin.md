# Every Copilot CLI launch names the single-model SOP explicitly

- **Record ID:** `PMD-20261108-003`
- **Created:** 2026-11-08
- **Status:** recorded
- **Supersedes:** `PMD-20260922-003` and `PMD-20260926-004` in part (the
  Copilot command line their launchers start gains
  `--model claude-opus-5.5 --reasoning-effort max --context long_context`;
  the rest of both records stands)
- **Superseded by:** None

## Scope

This record answers one coordination question: how every Copilot CLI
session that the Project Manager starts through a launcher, or tells the
responsible human to start, is bound to the single-model SOP of
`PMD-20261006-001`. It changes `scripts/owner-session.sh`,
`scripts/owner-recovery.sh`, `scripts/validate-pm.sh`,
`tests/validate-agent.sh`, every current Project Manager launch command in
instructions, the agent profile, the coordination skill, the interface,
roster, README, `REHYDRATE.md`, runbook, handoff, tasking README, and
component cards (including their command blocks), and the launch commands
in the parent `README.md`,
`HANDOFF.md`, and `.github/copilot-instructions.md`. It raises one owner
request for component-owned launch text.

Observed on `l1` from 2026-11-08T07:27Z to 07:31Z: the human-run
`scripts/owner-session.sh` had started the security-reviewer owner session for
`PMR-138` and `PMR-141` at 07:25:13Z as
`copilot --no-auto-update --yolo -C <entry> -i <prompt>`, with no model,
effort, or context option; the running Beryllium session (since 2026-11-05)
and this Project Manager session (since 2026-11-08T01:26Z) were also
started without one. The user-level Copilot settings name
`claude-opus-5.5`, effort `max`, and context tier `long_context` as
defaults, so those sessions most likely run on the SOP triple, but nothing
on their command lines pins it. Security-reviewer `main` was clean at the
published tip throughout.

## Inputs

- The responsible human's instruction at 2026-11-08T07:25:51Z (23:25:51 on
  2026-11-07 at UTC-8), quoted exactly: `"need to specify --model in any
  copilot invocations"`.
- `PMD-20261006-001`: one model, `claude-opus-5.5`, at reasoning effort
  `max` and context tier `long_context` for every orchestrator, agent,
  sub-agent, and task, with no silent fallback; the user-level hook covers
  only `task` and `run_dynamic_workflow`, and "the main session model comes
  from the human's launch and settings". The Project Manager instructions
  that carry it (`.github/copilot-instructions.md`) add: "Preserve
  historical artifacts and do not restart an already launched task merely
  to apply the SOP."
- `PMD-20260922-003` inputs: the responsible human's 2026-09-22 direction
  to "always launch Copilot with `--yolo`".
- The Copilot CLI 1.0.108-1 documentation (the version running this
  session), read through this build's documentation lookup on 2026-11-08:
  `--model <model>` sets the model;
  `--reasoning-effort <level>` accepts `max` among its values; `--context`
  sets the context window tier (`default` or `long_context`) and overrides
  the persisted setting; `--agent <agent>` selects a custom agent.
- `PMD-20260922-003` (the human-run owner-session launcher) and
  `PMD-20260926-004` (the human-run closed-dirty recovery launcher), whose
  launch command lines named no model.
- A read-only search of the registered components on 2026-11-08: only
  `component://security-reviewer/README.md` and
  `component://security-reviewer/AGENT-INTERFACE.md` (at the component's
  current `main`; exact commit in private parent records) give a
  Copilot launch command (`cd security-reviewer && copilot`, then
  `/agent security-reviewer`) without a model. The Beryllium matches are
  prose and test fixtures that name a terminal pane, not launch commands;
  no other component gives one.

## Disposition

1. **Rule.** Every Copilot CLI launch command that the Project Manager gives
   the responsible human, and every Project Manager launcher, names
   `--model claude-opus-5.5 --reasoning-effort max --context long_context`
   explicitly. The responsible human asked for `--model`; the effort and
   context options are added because `PMD-20261006-001` requires all three
   and this CLI build documents both options, so the session does not depend
   on persisted settings. The launchers keep `--no-auto-update --yolo`;
   direct-session commands take the form
   `copilot --model claude-opus-5.5 --reasoning-effort max --context long_context --yolo`,
   following the 2026-09-22 direction to always launch Copilot with
   `--yolo`. If the installed CLI ever rejects an option, the launch fails
   at once with an error and no session starts; the human reports it rather
   than dropping the option.
2. **Launchers.** `scripts/owner-session.sh` and `scripts/owner-recovery.sh`
   pass the three options from fixed constants, with no override, and print
   them in their launch line. Their maintained tests check, through the
   Copilot stub, that each option is immediately followed by its value.
3. **Validation.** `scripts/validate-pm.sh` refuses a Copilot launch command
   that does not name all three options on the same line, in every current
   Project Manager Markdown file and in the parent `README.md`, `HANDOFF.md`,
   `SOT.md`, and `.github/copilot-instructions.md`. Files under `records/`,
   generated tasking views, and the handoff's "What changed in this turn"
   history record what was run at the time and are exempt; this record does
   not rewrite them. The check is a guard on the usual one-line command
   shapes, not a proof: a launch through a path or variable, or split across
   lines, is not recognised, and wrapped prose that ends a line with a
   lowercase `copilot` is reported and must be rewrapped.
4. **Running sessions.** Following the instruction quoted above, an
   already running session is not restarted merely to apply this rule. The
   responsible human confirms a running session's settings: its footer shows
   the model and effort, and `/config` (Assistant > Model) shows the context
   tier. If they are not `claude-opus-5.5`, `max`, and `long_context`, the
   session does not satisfy the SOP. While its component is still clean,
   the human exits it and restarts it with a pinned command. Once it has
   edited files the launcher refuses, so the human keeps it and tells the
   Project Manager. The security-reviewer owner session that
   started at 07:25:13Z keeps its packet bound to Project Manager commit
   `d8fcec4`; if the human asks it to check Project Manager tasking again
   after this record's commit, it stops on the changed commit, and the human
   relaunches it with the pinned launcher.
5. **Component-owned launch text.** The Project Manager does not edit it.
   `PMR-151` asks the security-reviewer owner to pin the two launch commands
   above; it may be selected with that component's next owner session.

## What this record does not decide

This record is coordination evidence. It grants no acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation,
implementation authority, component write authority, push, remote change,
or visibility change, and no model, effort, or context exception. It does
not change the user-level governance hook or any Copilot setting, and it
restarts no session. Beryllium is accepted through R7; R8-H0 is a committed
candidate and is not accepted; H1-H4 are not authorized; K3 hardware is
`NOT RUN` in Project Manager records. Helium remains a review-and-test proof
of concept and is not formally verified or hardware validated.

## Follow-up

- The responsible human uses only pinned commands from now on, for example
  from the workspace root:

  ```sh
  cd project-manager && copilot --model claude-opus-5.5 --reasoning-effort max --context long_context --yolo
  ```

- The security-reviewer owner selects `PMR-151` in its next session.

## Provenance

- Written by the `project-manager` agent on `claude-opus-5.5` from the
  inputs above, maintained inspection, read-only process and settings
  observation, and this build's Copilot CLI documentation. No component
  repository, Copilot setting, or session was modified.
