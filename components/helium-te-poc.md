# helium-te-poc

- **Workspace entry:** `../helium-te-poc/` (ignored canonical direct checkout)
- **Ownership:** agent-owned Helium line; the Project Manager reads for
  coordination and writes nothing here. Carry-ineligible under `../records/decisions/PMD-20260904-003-standing-carry-authority.md`: every
  change is a `PMR-NNN` request handed to the human
- **Agent:** none user-invocable; maintained skill `helium-documentation`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `LLM_POLICY_ALIGNMENT.md`
- **Observed state:** clean detached HEAD at
  `1ab289c066b69acdd8b55c9f77055b0145be1316` on 2026-09-12; local
  `for-review` and `origin/for-review` point to the same commit. The ref
  listing also contains `helium-te-travel-fedora44` at `52cc71a` and
  `public/main`, `helium-te-final-release-h7-approved`, and tag `v0.6.0` at
  `1c9e526`. The Project Manager records those refs but infers no release,
  review, or acceptance from their names or commit subjects (`PMR-026`)

## Role

Standalone fixed RV64 Type Enforcement (TE) security-monitor experiment and
the bounded-verification pathfinder for Beryllium:

```text
OpenSBI M-mode
  -> Helium HS-mode monitor
     -> writer VS subject
     -> fenced G-stage root switch
     -> reader VS subject
```

The fixed policy in `src/policy/te.c` labels three domains and six memory
resources. The generic TE mechanism in `src/te.c` seals and authorizes that
policy; `src/memory.c` converts policy-derived permissions into two Sv39x4
G-stage roots; `src/main.c` composes policy, mappings, subject transitions, and
fail-closed trap handling. Assembly and CSR transitions are isolated in
`src/entry.S`, `src/trap.S`, and `src/guest.S`.

Tests cover different assurance layers: the host unit binary checks the TE,
policy, and page-table cores; repeated QEMU runs exercise the privileged
runtime with GCC and Clang images; target-assurance tests inspect build
isolation, negative payloads, entry state, and disassembly. Evidence,
documentation, evaluation, and publication checks are part of the maintained
assurance workflow.

The Helium FV line adds CBMC machine checks for selected fixed-profile TE,
policy, enforcement, G-stage, pure runtime-transition, materialized
trap-context, trap-authority witness, effect-plan, transactional trap-pipeline,
raw-capture materialization, and (as the component reports at `e65c6a0` and
restates at `f0d96b1`) atomic capture-plus-pipeline transaction C properties.
The trap decision remains exactly five fields; authority, state mutation, and
effect planning remain separate pure boundaries. Tier 7 begins with
caller-supplied scalar facts and Tier 8 composes that materialization with the
Tier 6 pipeline:
neither proves live CSR/frame/sentinel/root capture, live policy/PTE query
correspondence, linker-symbol wiring, privileged effect execution, assembly,
compiler, ISA, emulator, hardware, or noninterference. The component's own
statements about its tiers, refs, and gates are recorded, without review, in
`../records/assurance/helium-te-fv-pathfinder.md`. At `f0d96b1`,
`../helium-te-poc/HANDOFF.md` states that `FV-FIN-001` is resolved, that "the
responsible human selected Tier 8 as the endpoint for Helium
formal-verification experimentation" (decision commit `6d3cd14`), and that no
Tier 9 or final methods spike will be pursued. The Project Manager records
those as the component's statements; it has not reviewed the endpoint
decision or any Tier 7/8 gate content, and infers no approval from the
statements, commit subjects, branch names, clean worktree, evaluator results,
or the existence of a ref. On 2026-09-05 the read-only
`bash ../scripts/inspect-components.sh refs helium-te-poc <refs>` listing
(run from `project-manager/`) confirmed that the eleven assurance-relevant
refs the handoff names exist locally; that is an existence observation, not
gate review. The newest observed statement set is in
`../records/assurance/helium-te-fv-pathfinder.md`, section "Observed component
statements, 2026-09-05 (`f0d96b1`)"; the same direction reaches the Project
Manager as the analysis workbook's `HET-001` (`PMR-016`, closed 2026-09-05
when the responsible human, acting as the Beryllium owner, triaged it;
`../records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`
records the lifecycle disposition `recorded`, planning inputs only, and
`PMR-019` is closed after the workbook mirror and handoff refresh).

## Boundaries and conventions

- Read `HANDOFF.md` before maintenance and preserve any frozen history it
  identifies. Do not add parent-project planning or unrelated experiments.
- Fixed scope: one hart, two sequential synthetic VS subjects, six memory
  resources, two G-stage roots, one memory class, and
  `open/read/write/execute`. Exactly one policy, `src/policy/te.c`, is linked.
  SMP, interrupts, DMA/IOMMU, devices, runtime policy loading, or relabeling
  require explicit review.
- Project name Helium; identifiers `he_` / `HE_`. Maintained sources use
  `SPDX-License-Identifier: GPL-3.0-only` and identify James Morris
  `<jamorris@linux.microsoft.com>` as the responsible human copyright holder.
- The Makefile owns the production source list, tools, flags, linker script,
  payload selection, and output roots; do not bypass its validated build graph.
- Maintained documentation lives under `docs/`; generated HTML under
  `docs/html/`; Graphviz sources under `docs/diagrams/`; generated SVG under
  `docs/public/diagrams/`. Regenerate with `./he docs-check`; never edit
  generated HTML directly.
- Describe Helium as a review-and-test PoC, never as formally verified or
  hardware validated. Selected C properties are machine-checked by CBMC only
  with the exact source/property/tool boundary and unverified links documented
  by the component.
- Exact H6 source review and the human-created H7 gate-only commit are separate
  gates. A validated candidate, approved predecessor branch, or inherited gate
  does not approve a successor tier.
- Automation must not approve `publication-gate.conf`, add a human
  `Signed-off-by`, claim responsible-human review, add a remote, or push a
  review/release branch.
- Complete `./he evaluate` runs reject linked-worktree Git pointers; the
  component uses one canonical ordinary checkout. Approved, candidate, and
  preserved states are distinct branch refs (for example
  `helium-te-fv-pre-relocation-wip`), not additional worktrees.

## Commands (run by the human or the component's own agent, from `../helium-te-poc/`)

```sh
npm ci                 # locked documentation dependencies
./he help              # full subcommand list
./he build             # build the fixed TE image
./he demo              # two-subject demonstration
./he test              # host, QEMU, target-assurance, and report tests
./he fv-check          # fixed-profile CBMC properties
./he check             # complete local validation
./he docs-check        # regenerate and validate documentation
./he evaluate          # rootless independent evaluation
./he evidence-check COMMIT [BUNDLE]   # verify a bundle against an exact clean commit
./he docs-preview      # serve generated HTML
./he publication-check # check the responsible-human public release gate
make toolcheck         # lightweight tools/syntax/policy/host-fixture gate
```

The C unit tests are one monolithic `tests/unit/test_main.c` binary without a
per-case selector. Individual shell or Node harnesses under `tests/` run from
the Helium root.

## What the Project Manager may request

Responsible-human reconciliation of the current detached checkout,
`HANDOFF.md`, and the separately observed review, travel, and public refs
(`PMR-026`); preservation of frozen refs; and decisions on what, if anything,
may proceed. The backup push recorded by `PMR-018` remains historical
evidence. A remote-tracking ref or tag is not publication evidence or gate
review by the Project Manager. The Project Manager never creates an H7 gate,
pushes, publishes, or releases.
