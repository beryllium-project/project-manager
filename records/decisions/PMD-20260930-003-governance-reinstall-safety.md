# Governance reinstall safety

- **Record ID:** `PMD-20260930-003`
- **Created:** 2026-09-30
- **Status:** recorded
- **Supersedes:** `PMD-20260930-002` item 6 and its Follow-up
  session-effect sentence in part; preserves every other disposition and
  human gate in `PMD-20260930-001` and `PMD-20260930-002`
- **Superseded by:** None

## Scope

Apply the scope-reviewed minimal correction for governance reinstall
transaction safety and already-running-session effects. The change is limited
to the Project Manager governance installer, deterministic sandbox tests,
this corrective record, directly affected Project Manager instructions and
handoff/README wording, and Project Manager-owned parent policy/registry
wording. It does not modify a component repository, real user configuration,
or the reported active Beryllium session.

Observed pre-change coordination revisions are parent
`566d5a5622ce28ea105c355d82e17eebaceffbff`, Project Manager
`072ba215ed0c5782d97ec390b3de9175464cbfad`, and authoritative request-table
blob `f1354da9c784a5e0e63867efd9f2f224c646c28c`.

## Inputs

- Responsible-human implementation direction on 2026-09-30: apply only the
  reviewed correction; preserve the install command; add no flags, process
  discovery, locks, daemons, telemetry, content-addressed versions, timing
  loops, watchers, or test-only installer controls; do not alter real user
  configuration or contact/restart the active Beryllium session.
- Scope-review disposition on 2026-09-30: `adjust`. Limit the change to one
  superseding decision, copy-before-replace transaction semantics, a real
  filesystem-failure rollback test, accurate session-effect wording, and
  directly affected coordination surfaces.
- `records/decisions/PMD-20260930-001-max-effort-scope-governance.md` and
  `records/decisions/PMD-20260930-002-governance-findings-remediation.md` at
  `072ba21`: the active governance policy and the inaccurate unchanged-
  installer/new-session-only statements corrected here without rewriting
  either historical record.
- `scripts/beryllium-governance.sh`,
  `scripts/beryllium-governance-hook.sh`,
  `scripts/beryllium-governance-hook.json.in`, and
  `tests/validate-agent.sh` at `072ba21`: the copied-file transaction, fixed
  installed hook path, exact matcher/environment template, and maintained
  sandbox harness.
- Responsible-human chronology: the reported active Beryllium session
  predates the initial user-level governance installation. This turn did not
  inspect that session and does not claim direct observation of its loaded
  hooks, agents, skills, matcher, or environment.

## Disposition

1. Hook configuration, matcher, and environment are loaded by new sessions.
   A session retains that originally loaded matcher and environment until it
   is restarted.
2. A registered command hook executes its fixed installed script path for
   each matched tool call. Therefore, atomically replacing that script body
   can affect an already-running governed session at its next matching call.
   Script replacement alone does not change that session's loaded matcher or
   environment, and the session does not gain new
   `run_dynamic_workflow` coverage.
3. Agent and skill reread behavior in running sessions is unknown and must
   not be asserted. This record makes no claim that a running session reloads
   or retains either surface.
4. Reinstall is recommended only while governed sessions are idle. Add no
   unverifiable process scanner, session-discovery claim, acknowledgement
   flag, or other command-line control.
5. Before changing any live managed destination, the installer stages and
   verifies every new file's SHA-256 and permissions, verifies same-filesystem
   atomic replacement, and makes a verified same-filesystem backup copy of
   every existing regular destination while leaving each live file present.
6. Commit atomically renames each staged file over its destination one at a
   time. On commit or post-install verification failure, every replaced prior
   file is restored by atomically renaming its backup over the live
   destination without first deleting that destination. A destination absent
   before a failed first install has only its newly installed managed file
   removed.
7. Preserve non-regular-file refusal, SHA-256 checking, exact managed
   permissions, rollback diagnostics, read-only `check`, drift-safe
   `uninstall`, and the unchanged human command. Uninstall warns that a
   registered running session may still point at removed hook or
   configuration paths and is likewise recommended only while governed
   sessions are idle.
8. Maintained sandbox validation covers first install, ordinary reinstall,
   drift repair, no move-aside implementation, real later-destination
   filesystem commit failure after earlier replacements, complete hash/mode
   rollback with no missing managed destination, and check/uninstall
   behavior and messages.
9. No PMR, component write, user-configuration write, live-session
   interaction, model substitution, or security-policy relaxation follows.
   The deep/adversarial security model gate remains open.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation, component
implementation authority, component write authority, push, remote change, or
tag authority. It does not prove the state of any already-running session,
select a deep/adversarial security model, restart the reported active
Beryllium session, approve R8-H0, authorize H1-H4, or run K3.

## Follow-up

- After reviewing the Project Manager and parent commits, wait until governed
  sessions are idle, then run the unchanged command from the workspace root:

  ```sh
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

  Do not restart the reported active Beryllium session merely to perform this
  reinstall. The separate responsible-human deep/adversarial security model
  choice remains open.

## Provenance

- Written by the `project-manager` agent from the responsible-human scope,
  the completed scope-review adjustment, the named historical decisions, and
  the current Project Manager governance implementation. No component
  repository, real user configuration, or live session was modified or
  inspected.
