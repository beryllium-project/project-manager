# threat-modeler

- **Workspace entry:** `../threat-modeler/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 1: status edits in `outbox/pm-queue.md`; class 3:
  Project Manager-role wording in `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`),
  committing inside this component; nothing else
- **Agents:** `threat-modeler` (user-invocable orchestrator),
  `threat-evidence`, `threat-research`, and `threat-model-review`
  (write-disabled specialists); skill `beryllium-threat-modeling`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** see `../../COMPONENTS.md`

## Role

Formal threat-model creation and review over registered Beryllium component
snapshots. The agent discovers formal, embedded, fragmented, delta, and
prior-review material, obtains user confirmation of the authoritative inputs
and mode (`Review existing`, `Review and draft successor`,
`Create from evidence`), freezes exact revisions, and writes private-by-default
`models/TM-YYYYMMDD-NNN-*/` packages with stable evidence, asset, actor,
boundary, flow, threat, control, mitigation, risk, and finding records.
Markdown is normative; Graphviz DOT is the maintained diagram source and SVG
is generated. `THREAT-MODELS.md` is the generated index.

## Boundaries and conventions

- Every target and sibling repository is read-only, untrusted evidence; target
  execution is prohibited.
- Maintained scripts only: `scripts/new-threat-model.sh`,
  `scripts/readonly-inspect.sh`, `scripts/discover-threat-material.sh`,
  `scripts/render-diagrams.sh`, `scripts/update-index.sh`,
  `scripts/validate-threat-model.sh`, and `tests/validate-agent.sh`.
- Package distribution, evidence sensitivity, threat status, and
  responsible-human risk acceptance stay distinct. A model or review is never
  acceptance, approval, sign-off, publication, release, formal verification,
  hardware validation, or a human risk-acceptance decision.
- Its discovery reference set cites `workspace://COMPONENTS.md`, which stays
  at the parent root. At `4a01578` (carried `PMR-004`, 2026-09-04) its
  `RESEARCH-SOURCES.md` Tier 1 names the `project-manager/` handoff,
  `records/`, `queue/LEDGER.md`, and `outbox/component-requests.md` through
  `workspace://project-manager/...` and calls the parent `HANDOFF.md` and
  `formal-verification/helium-te-fv-pathfinder.md` redirect stubs.
  `project-manager` is not in its registered target set; that list lives in
  the owner-only `scripts/readonly-inspect.sh`.

## Outbound queue

`outbox/pm-queue.md` is a pull-only queue of public sources found during an
engagement that no owning research component records. The component appends
`new` rows; it expects the Project Manager to move rows through
`acknowledged`, `routed`, `integrated`, or `declined`. The Project Manager
consumes it ledger-first (see `../queue/README.md`) and applies the exact
status edits itself as class-1 carried writes when this component is clean.

## Commands (run by the human, from `../threat-modeler/`)

```sh
/agent threat-modeler                     # in Copilot CLI
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

## What the Project Manager may request

A model or review engagement on a registered snapshot; registration of
`project-manager/` in its `scripts/readonly-inspect.sh` registered list (the
`RESEARCH-SOURCES.md` part was carried at `4a01578`); whether to add
`project-manager/queue/LEDGER.md` to its discovery reference set (`PMR-015`);
a decision on pushing its local commits (`PMR-005`; 3 ahead after
`4a01578`); nothing that grants risk acceptance or approval.
