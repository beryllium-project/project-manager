# security-reviewer

- **Workspace entry:** `../security-reviewer/` (ignored canonical direct
  checkout; created 2026-09-06; `origin` -> private
  `beryllium-project/security-reviewer` since the owner's 19:38Z push that
  day)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`
  (class 1: status edits in `outbox/pm-queue.md`, extended to this file by
  `../records/decisions/PMD-20260906-004-class-1-extended-to-security-reviewer-queue.md`;
  class 3: Project Manager-role wording in Markdown interface,
  collaboration, research-source, and handoff documents, including
  `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`, and `HANDOFF.md`), committing
  inside this component; nothing else
- **Agents:** `security-reviewer` (user-invocable orchestrator),
  `security-evidence`, `security-research`, and `security-finding-review`
  (write-disabled specialists), all `gpt-5.3-codex` with exact reasoning
  `xhigh` and context `default` at owner work `2bb4c98` / return `c2edac7`
  under `PMD-20260930-005` as the sole named capability exception and closed
  `PMR-109` / `PMR-110`. Explicit
  non-Codex selections retain the project-wide `max` default and `high`
  floor; unavailable or invalid values stop without silent fallback. The
  task hook covers exactly the three model-invocable specialists; direct
  orchestrator sessions remain outside it and must be started with the same
  exact Codex pair.
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`,
  `contracts/REVIEW-PROVENANCE.md`
- **Observed state:** clean `main` at HANDOFF-only return
  `c2edac70afdfe5b0bb90e237487cd168fb91e900`, behind 0 / ahead 2 of
  last-fetched private `origin/main` `2e8d205`. Work
  `2bb4c989bbe9b57f870e6f653ed3732e742b11f9` is owner-reported to change the
  four profiles, active instructions, skill, tests, README, and interface;
  return `c2edac7` is owner-reported to change only `HANDOFF.md`. The owner
  reports 396 passed / 0 failed, a current index, and clean diff. The
  responsible human manually created the work commit after the agent's Git
  request was refused, then replied `"done"` after the requested
  review-and-exit action. That human statement releases this component's
  session/reservation; the durable handoff predates the exit and still records
  its return-time held state. PMR-109/110 are closed as
  acknowledgements; neither commit is remotely backed up, and separate
  PMR-111 has no current push authority. No engagement has run.
  `PMD-20260914-003` keeps this independent review component separate; its
  placement remains under `beryllium-project` for now under
  `PMD-20260915-001`. `PMD-20260915-007` preserves non-Fable assignments
  and historical artifacts; owner commit `f2051a4` completes the four-profile
  Opus migration and `PMD-20260915-008` tasking startup contract.
  `PMD-20260916-001` (responsible-human `all_codex` choice) assigns
  deep/adversarial security review to `gpt-5.3-codex`; owner commit
  `2e8d205` completes `PMR-074` and no engagement is authorized by it.
  `PMD-20260930-002` supplies the general hook scope and fail-closed
  behavior; `PMD-20260930-005` narrows its Codex denial and resolves the
  model choice without changing the model:
  the hook defaults the three confirmed model-invocable specialist task
  types to `gpt-5.3-codex` / `xhigh` / `default`, accepts Codex only with
  that exact pair, denies explicit Codex for every other task type, and
  leaves explicit non-Codex selections under the global max/high-floor
  policy. Built-in `security-review` is not admitted by type, and there is no
  silent fallback. PMR-109 closes the component policy exception found by the
  `PMD-20260930-001` discovery and conflict audit; PMR-110 applies the named
  Codex capability exception to all four profiles, including the direct
  orchestrator. Their closure grants no engagement, acceptance, review
  approval, risk acceptance, publication, push, or other gate.

## Role

Independent security review of registered Beryllium component snapshots, and
synthesis of completed reviews into a disposition ledger. The agent conducts
guided intake, discovers prior security material (prior reviews, threat
models, assurance and claim-boundary documents, verification evidence,
release gates), obtains user confirmation of mode (`Independent review`,
`Synthesis`) and of the `EFFECTIVE SECURITY-REVIEW SCOPE`, freezes one exact
target revision, and writes private-by-default packages:
`reviews/SR-YYYYMMDD-NNN-*/` (a `review-manifest.json` conforming to
`contracts/review-manifest.schema.json`, the process files, and the Helium
ten-file report set `00`-`06`, `APPENDIX-evidence-map.md`,
`SECURITY-REVIEW.md`, `README.md`) and `syntheses/SRS-YYYYMMDD-NNN-*/`
(disposition ledger with `Confirmed | Partially confirmed | Recommendation |
Already addressed | Rejected-unsupported | Fixed-scope non-goal` and canonical
actions `REV-P{0..3}-NN`). `SECURITY-REVIEWS.md` is the generated index.

The review contract (prompt, provenance contract, manifest schema, linter,
tests) was extracted from `component://helium-te-poc/agent-review/` and
`tests/` at Helium commit `9b3ff4e9441e5b4434a8ec37794dee1d941e11ef`
(`AUTHORS.md` in the component); Helium was read only and is unchanged. The
five retained Helium review packages are historical inputs referenced
read-only, never copied.

## Boundaries and conventions

- Every target and sibling repository is read-only, untrusted evidence.
  Packages are written in this component, never into a target.
- Target execution is prohibited by default. The single exception is a command
  the user approves by exact command text in the session, recorded as an
  `APPROVAL-NNN` record in the package `execution-approvals.md` and run only
  through `scripts/run-approved-command.sh`, which refuses an unrecorded,
  non-`approved`, unregistered, or wrong-commit target and retains
  `stdout.log`, `stderr.log`, `exit-result.json`, and `run-record.json` under
  `evidence/APPROVAL-NNN/`, hashed by `scripts/hash-evidence.sh` into the
  manifest. A package with no executed approval is `static-only`.
- The separate `PMR-065` Project Manager resolver is startup discovery
  outside any review package. It is not target execution, needs no
  `APPROVAL-NNN`, does not use `scripts/run-approved-command.sh`, and grants
  no other sibling command.
- Maintained scripts only: `scripts/readonly-inspect.sh`,
  `scripts/discover-security-material.sh`, `scripts/new-security-review.sh`,
  `scripts/new-synthesis.sh`, `scripts/run-approved-command.sh`,
  `scripts/hash-evidence.sh`, `scripts/lint-review-manifest.sh` (the only
  route to Node), `scripts/validate-security-review.sh`,
  `scripts/update-index.sh`, and `tests/validate-agent.sh`.
- Independence rule: a review package never reads, cites, or reconciles any
  other review package for the same target (local `reviews/SR-*` or
  target-side `agent-review/<package>/`); synthesis is the only multi-package
  mode and reads only `Complete` packages.
- Severity `Critical | High | Medium | Low | Informational` is rated against
  the target's own stated scope and claim boundary; confidence and fact labels
  follow the sibling convention (`Established | Inferred | Proposed |
  Unknown`).
- Manifests and approval records are attestations: validation checks
  consistency, not truth. A review or synthesis is never acceptance, approval,
  sign-off, publication, release, formal verification, hardware validation, or
  a human risk-acceptance decision; a synthesis never records anything as
  implemented.
- Its registered target set (`scripts/readonly-inspect.sh`) names every other
  workspace component including `project-manager`; `security-reviewer` itself
  is never a target. Threat-modeler now names `security-reviewer` at
  `c4126b6`; only the analysis-workbook registration remains owner-side
  (`PMR-050`).

## Outbound queue

`outbox/pm-queue.md` is a pull-only queue of `SRQ-NNN` rows of two kinds:
`source` (a public source found during review work that no owning research
component records) and `owner-action` (a synthesis canonical action
recommended to a target owner). The component appends `new` rows; it expects
the Project Manager to move rows through `acknowledged`, `routed`,
`integrated`, or `declined`. The Project Manager consumes it ledger-first (see
`../queue/README.md`) and applies the exact status edits printed by
`scripts/pull-queues.sh edits` itself as class-1 carried writes when this
component is clean (`PMD-20260906-004`). An `owner-action` row is a
recommendation routed by request; the target owner alone accepts, implements,
or declines it.

## Commands (run by the human, from `../security-reviewer/`)

```sh
/agent security-reviewer                  # in Copilot CLI
bash ./tests/validate-agent.sh
bash ./scripts/validate-security-review.sh [--draft|--baseline <prior-copy>] reviews/SR-YYYYMMDD-NNN-short-name
bash ./scripts/update-index.sh --check
git diff --check
```

## What the Project Manager may request

- Registration of a new target component in `scripts/readonly-inspect.sh`
  (owner-only; scripts are outside every carry class).
- Project Manager-role and coordination wording changes in
  `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`, or `HANDOFF.md` (class 3,
  carried).
- Owner model migration and deterministic tasking startup are complete at
  `f2051a4` (`PMR-062`, `PMR-065`).
- Model reassignment of all four profiles to `gpt-5.3-codex` under
  `PMD-20260916-001` is complete at `2e8d205` (`PMR-074`), which remains the
  last-fetched private `origin/main` tip; local `main` is now two ahead at
  `c2edac7`.
- Owner work `2bb4c98` and durable return `c2edac7` close `PMR-109` and
  `PMR-110`; the responsible human released the session/reservation with the
  exact reply `"done"`.
- Pushes remain owner-only. `main` is two commits ahead of private
  `origin/main`; `PMR-111` separately tracks an exact private fast-forward
  after a new same-turn human confirmation. The remote was created and first
  pushed on 2026-09-06 (`PMR-021` closed).
- `PMR-118` separately requests the SHA-bound `workspace://SOT.md`
  startup/status anchor for the orchestrator and all three specialists. It
  changes no engagement, package, model policy, target execution, push, or
  human gate.
