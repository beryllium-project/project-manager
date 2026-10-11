# full path initial cd

- **Record ID:** `PMD-20261002-001`
- **Created:** 2026-10-02
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record how the Project Manager presents an initial directory-change command
to the responsible human in chat and turn reports. This is a user-facing
command-format convention; it does not require a blanket rewrite of stored
documentation examples, scripts, templates, agent definitions, or skills,
and it changes no component repository or component-owned instruction.

## Inputs

- Responsible-human direction on 2026-10-02, stated exactly: `"also remember
  to use a full pathname when giving me an initial cd command"`.
- `../SOT.md` and `../COMPONENTS.md` at parent
  `576a574b4e6db43efb1de4e9f23d043c49f94048`: the canonical workspace root
  then recorded was the temporary `lx2` placement under `~/src/l1/src`;
  topology must be re-resolved rather than remembered after a move.
- `HANDOFF.md` at Project Manager
  `1c2abfca25c6a79ee00336518d512e06cffb834c`: user-facing next actions
  require exact commands and restartable context.

## Disposition

When a user-facing command sequence begins with `cd`, the Project Manager
uses the full absolute pathname resolved from the current `SOT.md` and
`COMPONENTS.md`. It does not use a relative path or `~` for that initial
directory change. Later commands in the same sequence may be relative to the
established directory. Every later turn re-resolves the current root before
rendering the command, so this convention does not preserve a stale
workstation path.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, hardware
validation, component execution, repository write, push, tag, or remote
authority. It does not change canonical topology, component instructions, or
the ownership of any command.

## Follow-up

- Apply this convention to the next reported owner-session command. If that
  command starts from the current workspace root, begin with `cd` and the
  absolute current root recorded in `../COMPONENTS.md`.

## Provenance

- Written by the `project-manager` agent from the responsible-human direction
  and current Project Manager-owned topology records above.
- Locator wording updated on 2026-10-10 under `PMD-20261010-001` after the
  return to `l1`; the disposition is unchanged.
