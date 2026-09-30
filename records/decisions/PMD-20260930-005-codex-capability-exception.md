# Codex capability exception

- **Record ID:** `PMD-20260930-005`
- **Created:** 2026-09-30
- **Status:** recorded
- **Supersedes:** `PMD-20260916-001` disposition items 1 and 4 in part
  (deep/adversarial security-review effort and context only);
  `PMD-20260930-001` disposition items 1 and 2 in part (the same named role
  only); and `PMD-20260930-002` disposition items 4 and 5 plus directly
  related follow-up wording in part (only the Codex denial and pending-model
  portions)
- **Superseded by:** None

## Scope

Record and implement the responsible human's named capability exception for
the deep/adversarial security-review role without lowering the project-wide
reasoning floor, modifying a component repository, changing real user
configuration, or running a security engagement.

Observed pre-change coordination revisions are parent
`9622125e5aa78fc962d374de5b3adbbac9123e89`, Project Manager
`0bb6c1db0dcdfb5171d7822de982a9cae7948a78`, and authoritative request-table
blob `f1354da9c784a5e0e63867efd9f2f224c646c28c`. The read-only
`security-reviewer` snapshot is clean and synchronized at
`2e8d2054840af35ba6d64a00546ee99806a88dfb`.

## Inputs

- Responsible-human choice on 2026-09-30:
  `security_review_policy=codex_exception`.
- `PMD-20260916-001`: the deep/adversarial role is assigned
  `gpt-5.3-codex`, previously with `max` / `long_context`.
- `PMD-20260930-001`: `max` / `long_context` remains the project-wide
  default, with `high` as the absolute explicit effort floor.
- `PMD-20260930-002`: the current hook denies explicit
  `gpt-5.3-codex` and the three confirmed model-invocable security
  specialists pending a human model choice.
- `../security-reviewer/.github/copilot-instructions.md`, all four
  `../security-reviewer/.github/agents/*.agent.md` profiles,
  `../security-reviewer/.github/skills/beryllium-security-review/SKILL.md`,
  `../security-reviewer/tests/validate-agent.sh`, `../security-reviewer/README.md`,
  `../security-reviewer/AGENT-INTERFACE.md`, and
  `../security-reviewer/HANDOFF.md` at `2e8d205`: all four profiles name
  `gpt-5.3-codex`; exactly `security-evidence`, `security-research`, and
  `security-finding-review` are model-invocable, while the user-facing
  `security-reviewer` orchestrator is direct and not model-invocable.
- `scripts/beryllium-governance-hook.sh` and `tests/validate-agent.sh` at
  `0bb6c1d`: current permission-neutral argument rewriting, exact task and
  workflow scope, reviewer enforcement, and the Codex denial being replaced.

## Disposition

1. Keep the deep/adversarial security-review model
   `gpt-5.3-codex`. Its required reasoning effort is now exactly `xhigh` and
   its required context tier is exactly `default`. This is the sole named
   capability exception to the project-wide `max` / `long_context` default.
2. The exception does not lower or reinterpret any other role. Every
   non-Codex role and every explicit non-Codex selection retains the
   project-wide `max` default, the permitted explicit set `high | xhigh |
   max`, and the absolute `high` floor.
3. There is no silent model, effort, or context fallback. A Codex invocation
   outside the named role, or a named-role Codex invocation that explicitly
   requests anything other than `xhigh` / `default`, stops.
4. For in-scope `task` calls, the confirmed model-invocable security types
   remain exactly `security-evidence`, `security-research`, and
   `security-finding-review`. When one omits or empties `model`, the hook
   treats it as the named Codex role and injects missing, null, or empty
   `model: gpt-5.3-codex`, `reasoning_effort: xhigh`, and
   `context_tier: default` through `modifiedArgs` while preserving every
   other argument and returning no permission decision. An explicit
   `gpt-5.3-codex` on one of those types receives the same missing-field
   injection.
5. A confirmed type that explicitly names a non-Codex model follows ordinary
   policy: omitted effort becomes `max`; explicit `high`, `xhigh`, or `max`
   is accepted; lower or unknown effort is denied; its alternate model and
   context are not forced. Explicit `gpt-5.3-codex` on every other task agent
   type is denied as outside the named exception.
6. The built-in `security-review` type is not admitted to the exception by
   type. It and unrelated task types remain unaffected unless they explicitly
   select `gpt-5.3-codex`. The direct `security-reviewer` orchestrator is not
   intercepted by the `task` hook and must be started and kept at exact
   `gpt-5.3-codex` / `xhigh` / `default`.
7. Preserve exact `beryllium-scope-review` enforcement, in-scope
   `run_dynamic_workflow` denial, path/root/transaction behavior, and
   permission neutrality. Real user-level reinstall and live validation are
   deferred until governed sessions are idle.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
review approval, risk acceptance, sign-off, licensing, publication, release,
formal verification, hardware validation, component write authority, push,
remote change, tag authority, or permission to begin a security-review
engagement. It does not edit `security-reviewer`, alter real user
configuration, restart or contact an active session, admit the built-in
`security-review` type to the exception, or lower any non-Codex role.

## Follow-up

- The `security-reviewer` owner completes `PMR-109` and `PMR-110`, which may
  be handled in one human owner session, and returns the exact component
  commit, validation, backup state, and active-session state.
- After review and when governed sessions are idle, the responsible human
  runs:

  ```sh
  bash ./project-manager/scripts/beryllium-governance.sh install &&
  bash ./project-manager/scripts/beryllium-governance.sh check
  ```

## Provenance

- Written by the `project-manager` agent from the exact responsible-human
  choice, the named historical decisions, the current Project Manager hook
  and tests, and the read-only security-reviewer snapshot at `2e8d205`.
