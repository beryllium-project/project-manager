# threat-modeler

- **Workspace entry:** `../threat-modeler/` (ignored canonical direct
  checkout)
- **Ownership:** agent-owned; its agents write only inside that component; the
  Project Manager writes here only to carry requests under the standing carry
  authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md` (class 1: status edits in `outbox/pm-queue.md`; class 3:
  Project Manager-role wording in `AGENT-INTERFACE.md`, `RESEARCH-SOURCES.md`,
  `COLLAB.md`, and `HANDOFF.md` where present), committing inside this
  component; nothing else
- **Agents:** `threat-modeler` (user-invocable orchestrator),
  `threat-model-maintainer` (repository maintenance, validation, and
  explicitly authorized Git delivery), `threat-evidence`,
  `threat-research`, and `threat-model-review` (write-disabled specialists);
  skill `beryllium-threat-modeling`. PMR-120 work `ca8fa3c` / return
  `bbbc534` installs a hidden maintenance-only `threat-modeler-owner`
  candidate, but its live response shape diverges from the established
  `OWNER_AGENT_RESPONSE_V1`, and durable `Result: Complete` is outside
  `templates/owner-return.md` values `completed`, `partial`, `blocked`,
  `needs_human`, `refused`, and `information`. Correction work `71bca3f` /
  return `e6aed9f` aligns both contracts. The profile is adopted but not
  native-handshaken or PM-invocable. At `e6aed9f` all six profiles,
  including the hidden owner, pinned superseded `gpt-5.6-sol`. Closed
  `PMR-121` (work `c156c0a0`, return `aba33507`, 2026-10-13) repinned all six
  to `claude-opus-5.5`, and the Project Manager read every profile at
  `aba33507`. The owner keeps invocation defaults `claude-opus-5.5` / `max` /
  `long_context`, and the dispatch pin in `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `README.md`, and the owner contract test match
  (owner-reported). No standing different-model, scope-review, or
  deep-security-review requirement existed; the skill's Phase 8
  `threat-model-review` step is now same-model.
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `AGENT-INTERFACE.md`, `HANDOFF.md`, `RESEARCH-SOURCES.md`
- **Observed state:** clean local `main` at `PMR-121` return
  `aba335079e437a9a9b1643a0d9d5d8e20fce59f5`, over work `c156c0a0` and
  corrected PMR-120 return `e6aed9fa`, 0 behind / 6 ahead of
  last-fetched `origin/main` `c4126b6`. The repository
  `beryllium-project/threat-modeler` is public, and on 2026-10-12 the
  responsible human chose to keep it public (`PMD-20261012-002`), so its
  pushed history, including the threat model, is publicly readable.
  Owner commit `5bf6a4b` added the complete private, paused
  `TM-20260911-001-helium-te-poc-astra` package; Project Manager carry
  `f4eb272` followed it; owner maintenance `c4126b6` reconciles delivery
  wording, records maintained validation, and registers `project-manager` and
  `security-reviewer` as exact-snapshot targets. Those predecessor commits are
  synchronized; all four PMR-120 commits and both PMR-121 commits are local
  and unpushed, and pushing them would publish them. `PMR-028`, `PMR-120`,
  and `PMR-121` are closed. The run remains paused.
  `PMD-20261002-002` stages a threat-modeler-only hidden-owner rollout after
  repeated human owner lifecycle cost. The human-started PMR-120 bootstrap is
  released, and the six exact paths plus 140/0 static validation are recorded.
  `PMD-20261003-001` records the initial response-contract gap;
  `PMD-20261003-002` selects the standard-V1 correction; and
  `PMD-20261003-003` closes corrected adoption while deferring the native
  handshake. PMR-064/117 remain open and parked P4.
  `PMD-20260915-001` keeps this independent personal-project repository under
  `beryllium-project`

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
- After `PMR-064`, the exact read-only Project Manager tasking resolver is a
  single startup-discovery exception outside a threat-model package. It is
  not target execution and grants no other sibling command.
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
  Until owner commit `c4126b6`, `project-manager` was not in its registered
  target set; that list lives in the owner-only
  `scripts/readonly-inspect.sh`. At `226d367` (carried
  `PMR-015`, 2026-09-05) the "Discovery reference set" also names
  `workspace://project-manager/queue/LEDGER.md`, so a source the Project
  Manager has already routed or that is accepted into an owner's index is not
  allocated again as a new `DISC-NNN` row.
- At owner commit `c4126b6`, `scripts/readonly-inspect.sh` registers both
  `project-manager` (`PMR-004`) and `security-reviewer` (`PMR-022`) as
  exact-snapshot targets. `PMR-022` is closed; the corresponding
  analysis-workbook registrations are also closed at PMR-004 work `5684317`
  and PMR-050 work `231cca4`.

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

A model or review engagement on a registered snapshot; nothing that grants
risk acceptance or approval. `PMR-015` (the ledger in the discovery
reference set) was carried at `226d367` on 2026-09-05. `PMR-005` (push of
the local commits) closed 2026-09-05: the owner pushed `main` to private
`origin` through the human-run `../scripts/owner-actions.sh`
(`affe17b..226d367`, four commits, verified with `ls-remote` in its log);
observed synchronized (0 behind, 0 ahead) at 19:10Z. Owner commit `c4126b6`
completes the threat-modeler halves of `PMR-004` and `PMR-022` and closes
delivery request `PMR-028`; it is synchronized with `origin/main`, which the
2026-10-12 audit found public (`PMD-20261012-002`).
`PMR-031` was carried at `f4eb272` on 2026-09-12. The run remains paused;
coordination does not resume it or accept any risk. `PMR-064` asks both
user-invocable entry points to map `check Project Manager tasking` to the
exact fail-closed resolver without session-history fallback.
`PMR-117` is the distinct owner-startup request to read current
`workspace://SOT.md` before target/sibling resolution or tasking. It may be
handled with PMR-064 but does not resume or modify the paused model. The
former human PMR-064/117 bootstrap is retired. Corrected PMR-120 work
`71bca3f` and return `e6aed9f` complete the component-owned standard-V1
profile. Both PMR-120 bootstrap bindings are consumed. No handshake request
exists and no direct dispatch proceeds until explicit later resumption.
`PMR-121`, the owner-only single-model repin under `PMD-20261006-001`, is
closed (2026-10-13) from work `c156c0a0` and return `aba33507`. It was
carried in a direct human-started session that read its row with
read-only file tools and ran no parent or sibling command, because
`PMR-064` has not yet admitted the parent resolver locally. It stayed
independent of parked `PMR-064` / `PMR-117` and changed no model package
or paused run (owner-reported).
