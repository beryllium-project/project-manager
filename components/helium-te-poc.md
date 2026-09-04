# helium-te-poc

- **Workspace entry:** `../helium-te-poc/` (ignored canonical direct checkout)
- **Ownership:** agent-owned Helium line; the Project Manager reads for
  coordination and writes nothing here
- **Agent:** none user-invocable; maintained skill `helium-documentation`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`, `LLM_POLICY_ALIGNMENT.md`
- **Observed state:** see `../../COMPONENTS.md` (single source; not repeated
  here)

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
and raw-capture materialization C properties. The trap decision remains exactly
five fields; authority, state mutation, and effect planning remain separate
pure boundaries. Tier 7 begins with caller-supplied scalar facts: it does not
prove live CSR/frame/sentinel/root capture, live policy/PTE query
correspondence, linker-symbol wiring, privileged effect execution, assembly,
compiler, ISA, emulator, hardware, or noninterference.

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
./he build             # build the fixed TE image
./he demo              # two-subject demonstration
./he test              # host, QEMU, target-assurance, and report tests
./he fv-check          # fixed-profile CBMC properties
./he check             # complete local validation
./he docs-check        # regenerate and validate documentation
./he evaluate          # rootless independent evaluation
make help              # lower-level targets
make unit-gcc; make unit-clang; make qemu-gcc; make toolcheck
tests/test-qemu-trace-validator.sh
```

The C unit tests are one monolithic `tests/unit/test_main.c` binary without a
per-case selector. Individual shell or Node harnesses under `tests/` run from
the Helium root.

## What the Project Manager may request

Responsible-human H6 review of an exact candidate against its Tier 6 source;
handoff reconciliation; preservation of frozen refs; a backup push decided by
the component owner. The Project Manager never creates an H7 gate, pushes, or
releases.
