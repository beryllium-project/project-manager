# Governance findings remediation

- **Record ID:** `PMD-20260930-002`
- **Created:** 2026-09-30
- **Status:** recorded
- **Supersedes:** `PMD-20260930-001` in part (corrects only the active
  command-hook enforcement and availability statements; preserves its
  role-to-model matrix, scope-review contract, and human gates)
- **Superseded by:** None

## Scope

Apply the scope-reviewed safe-default remediation for four governance review
findings without modifying a component repository, user configuration, the
active Beryllium session, or `PMR-109`. The change is limited to the Project
Manager governance hook, hook template, maintained tests, active
Project Manager/parent policy summaries, and restart handoff.

Observed pre-change coordination revisions are parent
`64751266aa86279ff859e4a9edc56e70e8ba1131`, Project Manager
`ce1cef64d2218dcfb055458c5128696210e823d7`, and authoritative request-table
blob `f1354da9c784a5e0e63867efd9f2f224c646c28c`. Security-reviewer evidence is
read-only at clean synchronized commit
`2e8d2054840af35ba6d64a00546ee99806a88dfb`.

## Inputs

- Responsible-human implementation direction on 2026-09-30: apply only the
  safe default approved by scope review; do not write a component, alter real
  user configuration, restart or contact the active Beryllium session, create
  a PMR, change `PMR-109`, or select a replacement security model.
- `scripts/beryllium-governance-hook.sh`,
  `scripts/beryllium-governance-hook.json.in`,
  `scripts/beryllium-governance.sh`, and `tests/validate-agent.sh` at
  `ce1cef64d2218dcfb055458c5128696210e823d7`: the current task-only hook,
  copied-file installer/checker, and maintained sandbox coverage.
- GitHub Copilot hooks reference read on 2026-09-30: camelCase
  `preToolUse` may return `modifiedArgs` without a `permissionDecision`;
  omitting a decision preserves normal permission handling. Matchers are
  full-value regular expressions. Command-hook failures are fail-closed,
  while hook timeouts fail open.
- Copilot CLI 1.0.90-5 model/help evidence assessed by scope review:
  `gpt-5.3-codex` does not advertise the required `max` reasoning effort or
  `long_context` tier.
- `../security-reviewer/.github/agents/security-reviewer.agent.md`,
  `security-evidence.agent.md`, `security-research.agent.md`, and
  `security-finding-review.agent.md` at `2e8d205`: all four name
  `gpt-5.3-codex`, while only `security-evidence`, `security-research`, and
  `security-finding-review` are model-invocable
  (`disable-model-invocation: false`). The user-facing `security-reviewer`
  orchestrator is not model-invocable.

## Disposition

1. Preserve `max` as the default and `high` as the absolute explicit floor.
   For an in-scope `task` call whose `reasoning_effort` is absent, null, or
   empty, the command hook rewrites the complete original argument object
   with `reasoning_effort: "max"` through `modifiedArgs`. It returns no
   `permissionDecision`, so normal permission handling remains in force.
   Explicit `medium`, `low`, `minimal`, or unknown values remain denied;
   only explicit `high`, `xhigh`, and `max` are accepted.
2. Extend the hook matcher to exactly `task|run_dynamic_workflow`. An
   in-scope `run_dynamic_workflow` is denied because its nested agents are
   not command-hook enforceable. Outside recognizable Beryllium scope it
   passes through unchanged.
3. Resolve scope before denying broken root configuration. A usable
   `BERYLLIUM_PARENT_ROOT` retains canonical-root and tracked-symlink
   behavior, and the installed `BERYLLIUM_TRACKED_TARGETS` snapshot retains
   stale-root coverage. If the root variable is unset or unusable, walk the
   resolved working directory's ancestors for the canonical marker pair
   `SOT.md` plus `project-manager/`: deny inside that boundary as broken
   governance configuration, but return `{}` outside recognizable scope.
   Malformed in-scope task arguments remain fail-closed.
4. Preserve the exact `beryllium-scope-review` requirement:
   `claude-opus-5.5`, effective effort `max` after default injection,
   `long_context`, and synchronous execution. Separately deny any explicit
   `model: gpt-5.3-codex` and only the three model-invocable custom
   security agent types confirmed above. Do not deny the built-in
   `security-review` type, the non-model-invocable `security-reviewer`
   orchestrator name, or unconfirmed names merely by name.
5. Deep or adversarial security review is fail-closed pending a
   responsible-human model decision. The recorded matrix row remains
   `gpt-5.3-codex`; no substitute model, effort, or context tier is selected
   by this record.
6. Keep the installer behavior unchanged. Its copied-file SHA-256 checks make
   tracked hook/config changes visible as installed-copy drift until the
   responsible human reinstalls and rechecks the managed user-level files.
7. Record enforcement limits accurately. The command hook does not enforce
   direct custom-agent sessions, SDK-started workflows, worktrees outside the
   canonical root and configured tracked targets, disabled user hooks, or a
   hook timeout. The timeout path is fail-open by platform contract.
8. Create no component write, no component-local policy copy, and no new
   PMR. `PMR-109` remains unchanged.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, publication, release,
formal verification, hardware validation, component implementation authority,
component write authority, push, remote change, tag authority, or a model
substitution. The responsible human still owns the deep/adversarial security
model choice and the later user-level reinstall/check. The active Beryllium
session remains untouched and does not provide live validation of the new
hook.

## Follow-up

- After reviewing the Project Manager and parent commits, the responsible
  human selects a supported deep/adversarial security model or explicitly
  revises the requirement, then reinstalls and checks the copied governance
  files from the workspace root:

  ```sh
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

  This affects only newly started Copilot CLI sessions. Do not restart the
  active Beryllium session for this change.

## Provenance

- Written by the `project-manager` agent from the responsible-human
  implementation scope, the recorded pre-change revisions, the authoritative
  GitHub Copilot hook contract, CLI 1.0.90-5 scope-review evidence, and the
  four read-only security-reviewer profiles at commit `2e8d205`.
