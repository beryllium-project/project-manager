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
- **Agents:** `security-reviewer` (user-invocable orchestrator,
  currently `claude-fable-5.1`), `security-evidence`, `security-research`,
  and `security-finding-review` (write-disabled specialists, also currently
  Fable 5.1); `PMR-062` requests the project-wide Opus 5 / `max` /
  `long_context` substitution before the next engagement; skill
  `beryllium-security-review`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`,
  `contracts/REVIEW-PROVENANCE.md`
- **Observed state:** clean `main` at `79c664f`, four commits ahead of
  `origin/main`; the latest Project Manager class-3 carry closes `PMR-060`.
  Earlier carries close `PMR-030`, `PMR-031`, `PMR-033`, and `PMR-056`. No
  engagement has run.
  `PMD-20260914-003` keeps this independent review component separate; its
  placement remains under `beryllium-project` for now under
  `PMD-20260915-001`. `PMD-20260915-007` preserves non-Fable assignments
  and historical artifacts while routing this component's four active Fable
  profiles to owner request `PMR-062`

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
- Owner migration of the four active agent profiles, tests, instructions, and
  handoff from Fable 5.1 to Opus 5 with `max` / `long_context`
  (`PMR-062`; outside Project Manager carry authority).
- Deterministic `check Project Manager tasking` startup mapping, exact
  read-only resolver allowance, and no session-history fallback
  (`PMR-065`; owner-only, may share a commit with `PMR-062`).
- Pushes (owner-only; the default human-run `../scripts/owner-actions.sh`
  step `push_sr` fast-forwards `main -> origin`; the remote was created and
  first pushed on 2026-09-06, `PMR-021` closed).
