# threat-modeler

- **Workspace entry:** `../threat-modeler/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 1: status edits in `outbox/pm-queue.md`; class 3:
  Project Manager-role wording in `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`),
  committing inside this component; nothing else
- **Agents:** `threat-modeler` (user-invocable orchestrator),
  `threat-model-maintainer` (repository maintenance, validation, and
  explicitly authorized Git delivery), `threat-evidence`,
  `threat-research`, and `threat-model-review` (write-disabled specialists);
  skill `beryllium-threat-modeling`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** clean `main` at `f4eb272`, two commits ahead of
  `origin/main` after the owner commit `5bf6a4b` and the Project Manager's
  class-3 `PMR-031` carry. `5bf6a4b` added the complete private, paused
  `TM-20260911-001-helium-te-poc-astra` package and the maintainer workflow.
  The run stays paused; `PMR-028` asks the owner to reconcile its delivery
  wording and decide the push. `PMD-20260914-003` keeps the component
  separate; its future organization placement is not yet decided

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
  `workspace://project-manager/...`. At `f4eb272` (`PMR-031`) it records the
  parent `HANDOFF.md` as the remaining compatibility redirect and points
  current assurance lookup directly to `project-manager/records/assurance/`.
  `project-manager` is not in its registered target set; that list lives in
  the owner-only `scripts/readonly-inspect.sh`. At `226d367` (carried
  `PMR-015`, 2026-09-05) the "Discovery reference set" also names
  `workspace://project-manager/queue/LEDGER.md`, so a source the Project
  Manager has already routed or that is accepted into an owner's index is not
  allocated again as a new `DISC-NNN` row.

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
/agent threat-model-maintainer            # maintenance, validation, and authorized Git delivery
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

## What the Project Manager may request

A model or review engagement on a registered snapshot; repository delivery of
the complete private, paused `TM-20260911-001` package through
`/agent threat-model-maintainer` (`PMR-028`); registration of
`project-manager/` in its `scripts/readonly-inspect.sh` registered list (the
`RESEARCH-SOURCES.md` part was carried at `4a01578`); nothing that grants
risk acceptance or approval. `PMR-015` (the ledger in the discovery
reference set) was carried at `226d367` on 2026-09-05. `PMR-005` (push of
the local commits) closed 2026-09-05: the owner pushed `main` to private
`origin` through the human-run `../scripts/owner-actions.sh`
(`affe17b..226d367`, four commits, verified with `ls-remote` in its log);
observed synchronized (0 behind, 0 ahead) at 19:10Z. `PMR-022` (open, P3,
2026-09-06) asks the owner to add `security-reviewer` to the same
owner-only registered list; both script edits fit one owner commit. `PMR-031` was carried at `f4eb272` on 2026-09-12. The run remains paused;
coordination does not resume it or accept any risk.
