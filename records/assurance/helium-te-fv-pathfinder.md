<!-- SPDX-License-Identifier: GPL-3.0-only -->
<!-- Copyright (C) 2026 James Morris <jamorris@linux.microsoft.com> -->

# Helium TE formal-verification pathfinder findings

## Provenance

- **Record type:** Project Manager assurance-transfer record.
- **Migrated from:** parent workspace path
  `formal-verification/helium-te-fv-pathfinder.md`, last changed there in
  parent commit `6d7f8236b92e12e02d236c2a96d03d042d5ae468` (2026-08-18) and
  moved into `project-manager/` from parent commit
  `767752792026622bbb06c3fcd29d240b0871a3e9` on 2026-09-04. Content below is
  unchanged by the move; the parent path now holds a redirect stub because
  sibling components cite it.
- **Boundary:** this record summarizes evidence produced and validated inside
  `helium-te-poc`; it does not add proof, review, approval, or acceptance.

## Status

- **Component:** `helium-te-poc`
- **Current development branch:** `helium-te-fv-tier7-capture-contract`
- **Tier 7 H6 candidate:** `7ca97a9833d451750bd09ac5a3e020cce9e5bd6f`
- **Reviewed Tier 6 source:** `e230cfddc265ba4a5710601a739ef27ed5a81be5`
- **Frozen Tier 6 H7 gate:** `c594b7fdb6aa584f23c1a3ea4287f7cc6fb9bd03`
- **Base:** `1ab289c066b69acdd8b55c9f77055b0145be1316`
- **Tier 1 implementation commit:** `f15ea35a01be2d33bb7537157591060da9250f2e`
- **Tier 2 implementation commit:** `6f5f67025e08cf9e8336130a55f78505fb8fc949`
- **Tier 3 implementation commit:** `5f3c6010ed7b4a3aea69127be9106100028d2cd3`
- **Tier 3 fixture correction:** `a194a804a39d76fbff32f627259b14311357ea50`
- **Tier 4 implementation commit:** `edd957c10fba863ccbe77d4abe4b6cf228aa6ccc`
- **Tier 4 handoff commit:** `d71ff59098c885f223055503784fe3744b867c29`
  (documentation-only successor)
- **Tier 5 implementation commit:** `1120ed5ab6dbfb0f246415711a4fbb0fb1ea88f3`
- **Tier 6 implementation commit:** `e230cfddc265ba4a5710601a739ef27ed5a81be5`
- **Tier 7 implementation commit:** `7ca97a9833d451750bd09ac5a3e020cce9e5bd6f`
- **Tier 7 review-target handoff:** `77803947f805c113b2f1773fb392869a18c72a75`
- **Canonical relocation correction:** `ff4a8a873e00412c7ef5ef025fc3e960400b7402`
  (linked-worktree policy and topology successor)
- **Evaluator checkout correction:** `779f32ba5bb5f4427e49fc7de01ecaa4be6dbe1b`
  (ordinary-checkout requirement and branch-only topology successor; no target
  behavior or machine-checked property change)
- **Pre-relocation WIP preservation:** `d87080a` branch ref
- **Canonical checkout topology:** one ordinary checkout on
  `helium-te-fv-tier7-capture-contract`; no registered linked worktrees
- **CBMC package in the rootless evaluator:**
  `cbmc-0:6.8.0-1.fc44.x86_64`
- **Current Tier 7 candidate result:** 17 maintained harnesses, 142 named
  claims, 16,233 all-success CBMC properties, and 16 required failing
  sensitivity mutations
- **Release state:** Tier 6 has a frozen approved H7 lineage; Tier 7 remains
  WIP with `publication-gate.conf` blocked pending fresh H6 review

Helium remains a review-and-test PoC, not a formally verified system and not
hardware validated. The pathfinder machine-checks selected fixed-profile C
properties only. Tier 7 validation is not responsible-human review.

## What the pathfinder established

### Tier 0: TE mechanism and fixed policy

CBMC checks the actual maintained `src/te.c` and `src/policy/te.c` for:

- invalid reset and denial before seal;
- complete one-time labeling and complete-set sealing;
- API-level post-seal monotonicity;
- exact one-rule-covers-all semantics;
- malformed and nonmatching rule denial;
- no composition of partial rules; and
- extensional equivalence of the linked fixed policy to an independent
  subject/resource permission matrix for symbolic raw subject, resource, and
  permission-byte inputs.

The host unit suite also enumerates every fixed subject/resource pair and all
256 raw permission bytes against the same independent specification.

### Tier 1: policy-to-G-stage refinement

The implementation extracted the existing policy-derived mapping logic from
`src/main.c` into the production `src/enforcement.c` seam. The runtime, host
tests, and CBMC now use the same maintained functions.

CBMC checks:

- exact policy-derived R/W/X permissions after `open`;
- complete table clearing and exact Sv39x4 path links;
- non-mutating rejection of invalid resources, alignment, table overlap,
  permission sets, duplicate leaves, same-root aliases, and corrupt paths;
- exact leaf PPN and `V/U/A/R/W/X/D` bits for a symbolic valid backing page;
- complete writer and reader roots;
- mapping presence if and only if the independent spec grants `open`;
- each R/W/X bit if and only if the independent spec grants it;
- absence of both cross-private mappings;
- writer shared R/W versus reader shared R;
- absence of every additional leaf; and
- distinct valid VMID-zero roots.

The 2048-entry root and 512-entry lower-table loops use an unwind bound of
2050 with `--unwinding-assertions`. Smaller loops use 16. The harnesses contain
no `__CPROVER_assume`.

### Tier 2: pure runtime transition refinement

The fixed writer-to-reader sequencing moved from private `src/main.c` phase
variables into the production `src/runtime.c` state/event/action core.
`src/main.c` still owns exact trap origin, PC, GPA/GVA, sentinel, policy, PTE,
root, and privileged-effect checks; it submits an event only after those
checks pass and requires the exact returned action.

An independent seven-row relation in `verification/spec/runtime_spec.c` and
two CBMC harnesses establish:

- reset is exactly writer/start;
- every raw production transition equals the independent relation;
- every rejection leaves the state unchanged;
- invalid caller context, state, or event rejects;
- reader switching occurs only at exact writer completion;
- shutdown occurs only after reader cross-private denial and final completion;
- the canonical seven-event sequence has the exact action list and completes;
- every accepted seven-step shutdown execution is canonical; and
- a modeled terminal caller rejection cannot recover to completion.

The runtime harnesses use unwind 8 and contain no assumptions. The
`early-runtime-complete` mutation illegally permits shutdown before the reader
cross-private denial and must fail `HE-FV-RUN-007`.

### Tier 3: pure materialized trap-context refinement

The production-linked `src/trap_context.c` decoder consumes only a canonical
runtime state, trusted eight-PC profile, and one materialized snapshot. It
accepts seven exact event rows or the exact guest-failure ECALL. Fault rows
compare `STVAL` directly with the expected GPA and raw `HTVAL` directly with
`GPA >> 2`; they do not reconstruct a potentially wrapping GPA.

The exact guest-failure tuple is deterministic in all eight canonical runtime
states, including `READER/COMPLETE`, never becomes a runtime event, and cannot
mutate runtime state. Event decisions remain exactly five fields:
kind/event/expected-action/authority/resource. PC advancement is not decision
metadata.

An independent raw relation and two CBMC harnesses establish
`HE-FV-CTX-001..012` and `HE-FV-CMP-001..008`: exact row partition,
profile/origin/cause/PC/report/sentinel/address checks, direct shifted-HTVAL,
decode output non-mutation, complete tuple validation, authority gating,
exact post-state/action composition, canonical sequence, and terminal guest
failure. The ignored-PC, STVAL-only, and pre-authority-step mutations must
fail.

### Tier 4: pure effect-plan refinement

The pathfinder then separated action selection from effect arguments without
adding fields to the decision. `he_trap_effect_plan()` revalidates the exact
materialized row, five-field decision, and returned runtime action, then emits
one separate canonical plan:

- five continuation events derive exactly `next_sepc = trapped_sepc + 4`;
- writer completion derives the exact captured nonzero reader root; and
- final completion derives shutdown with zero unused arguments.

`HE-FV-EFF-001..010` compare that production planner with an independent raw
effect relation, prove rejection output non-mutation, exact arguments and
effect shapes, action/decision rejection, and complete decode/apply/plan
composition. The `double-pc-advance` mutation must fail. Actual CSR writes,
root/stack switching, console ordering, and platform shutdown remain in the
small `src/main.c` execution adapter and are not proved.

### Tier 5: pure materialized authority witness

`src/trap_authority.c` validates an already materialized, normalized
policy/G-stage witness before runtime state mutation. `HE-FV-AUT-001..008`
cover exact subject/resource binding, canonical witness shapes, false-authority
rejection, output/state non-mutation, and composition with the pure apply core.
The separate `HE-FV-CMP-001..008` result retains exact apply/runtime
post-state and action relations. Live policy/PTE queries and their
correspondence to the materialized witness remain outside the proof.

### Tier 6: transactional pure trap pipeline

`src/trap_pipeline.c` composes decode, witness selection, authority validation,
runtime apply, and effect planning into explicit success and terminal outcomes.
`HE-FV-PIPE-001..010` cover exact ordering, resource-slot binding, canonical
results, rejection non-mutation, and rollback if post-apply consistency or
effect planning fails. The pipeline consumes already materialized inputs; it
does not establish live capture provenance.

### Tier 7: pure raw-capture materialization candidate

`src/trap_capture.c` validates caller-supplied scalar capture shape and
transactionally copies the exact ten-field snapshot plus the fixed
writer-private, reader-private, and shared authority slots.
`HE-FV-CAP-001..008` cover exact copying and binding, writer/reader subject
validation, six booleans per authority slot, canonical success iff input shape,
and rejection non-mutation/NULL behavior.

The exact Tier 7 candidate passed the complete native and rootless gates, but
it remains an H6 review target rather than an approved source. It proves no
live CSR/frame/sentinel/root read, policy/PTE query, subject selection,
once-only/call-time provenance, or linker-symbol correspondence.

These are Helium-local milestone names. They do not claim the research
strategy's future noninterference milestones.

## Assurance architecture that worked

1. **Independent extensional spec.**
   `verification/spec/te_spec.c` states the intended relation directly rather
   than inspecting production label/rule arrays. It also independently states
   expected PTE encoding.
2. **Production seam, not a proof-only model.**
   `src/enforcement.c` is target-linked code called by `src/main.c`; CBMC
   checks the same functions.
3. **Named property manifest.**
   `verification/cbmc/manifest.json` fixes every harness, source list, unwind
   bound, and `HE-FV-*` claim.
4. **No hidden assumptions.**
   Valid allow/deny/seal/map/root witnesses are assertions in the harnesses.
   The source-policy gate rejects `__CPROVER_assume`.
5. **Sensitivity checks.**
   The gate must reject a reader-shared-write rule mutation and a
   read-implies-write PTE mutation.
6. **First-class retained evidence.**
   `build/fv/` records exact CBMC identity, options, properties, source lists,
   unwind bounds, and mutation results. The rootless evaluator records the
   CBMC RPM closure and exports the proof results with the normal evidence
   bundle.
7. **Narrow claim language.**
   The component documents machine-checked C properties separately from
   unit tests, QEMU evidence, and every downstream trusted link.
8. **Pure state/effect split.**
   The machine-checked core returns `CONTINUE`, `SWITCH_READER`, `SHUTDOWN`, or
   `REJECT`; a second pure step derives exact effect arguments, while
   privileged execution remains in a concrete adapter that fails terminally
   on any unexpected plan.
9. **Materialize, authorize, plan, execute.**
   Live architecture facts are captured once, decoded into a minimal
   five-field decision, authority-gated before state mutation, and converted
   into a separate typed effect plan before the privileged adapter executes
   anything.
10. **Transactional pure composition.**
    The pipeline preserves explicit terminal outcomes and rolls state back if
    a later pure consistency or effect-plan check fails.
11. **Capture shape is not capture provenance.**
    A pure raw-capture boundary can prove exact copying and fixed slot binding
    while leaving live reads, query correctness, and once-only correspondence
    visibly unproved.

## Engineering friction and lessons

### Static composition logic needed a real module boundary

The highest-value theorem crossed static functions in `src/main.c`.
Duplicating them in a harness would have introduced model drift. Extracting a
small production enforcement seam made the theorem meaningful and reduced
runtime C without generalizing the fixed profile.

**Beryllium lesson:** define a small privileged enforcement API before
implementation growth. Verification should target the production boundary
that owns hardware authority.

### Full fixed arrays were directly tractable

CBMC discharged the real 2048/512-entry loops without replacing them with a
smaller test configuration. The fixed table shape and no-allocation design
were load-bearing.

**Beryllium lesson:** compile-time bounds, fixed table shapes, and no dynamic
allocation keep push-button verification credible. Do not silently introduce
a verification-only reduced configuration.

### Reachability should not depend on solver assumptions

The initial plan considered cover goals. Fedora CBMC 6.8.0 aborted in
`--cover cover` processing for this harness style. The final design instead
uses explicit successful allow/deny/seal/map/root assertions plus failing
mutations.

**Beryllium lesson:** treat non-vacuity as a maintained property, but avoid
making one optional CBMC feature a critical dependency. Require witnesses and
mutation sensitivity even when coverage tooling is available.

### Mutation checks should be focused

A mutation against the complete-root harness produced excessive failure
output for the Node runner. Moving the PTE mutation to a focused symbolic leaf
harness retained the security signal and kept the result bounded.

**Beryllium lesson:** use broad harnesses for the theorem and focused harnesses
for sensitivity diagnostics.

### Evidence integration is part of the verification cost

The C proofs themselves were not the only work. A maintainable result also
required:

- tool installation and exact version checks;
- container dependency provenance;
- normalized, path-portable output;
- exact result namespace validation;
- evidence-generator and verifier updates;
- negative evidence fixtures;
- evaluator override clearing;
- documentation, diagrams, and claim controls; and
- clean-commit and rootless validation.

**Beryllium lesson:** budget the proof artifact, evaluator, provenance, and
claim-maintenance path from the start. A local successful solver invocation is
not a maintained assurance result.

### Runtime sequencing became tractable after separating facts from state

The original phase machine mixed trusted progress with trap PCs, fault
addresses, sentinels, policy decisions, PTE inspection, and privileged
effects. The pathfinder extracted only the finite transition relation. This
made exhaustive raw-state equivalence and canonical-sequence uniqueness
straightforward while keeping the architecture-specific checks explicit in
the caller.

**Beryllium lesson:** model the privileged control core as a pure transition
relation that authorizes effects; do not hide hardware-context validation
inside the formal state machine.

### Concrete trap validation needed a materialized boundary

Trying to verify live CSR reads, linker symbols, policy/PTE queries, and
privileged operations in one handler would have mixed several trust layers.
Materializing the once-captured values made exact cause/PC/address/sentinel
rows tractable while leaving live correspondence explicit.

**Beryllium lesson:** capture architecture state once into a small typed
record, compare raw architectural encodings directly, and prove the pure
decoder independently. Do not treat reconstructed values or enum identity as
authority.

### Effect arguments should not become event metadata

An earlier design pressure would have added a PC-advance flag to the trap
decision. The final design kept the decision minimal and derived continuation,
reader-root, and shutdown arguments only after the authority-gated runtime
action succeeded.

**Beryllium lesson:** keep policy/event decisions free of execution flags.
Return a separate canonical effect plan, prove its exact arguments, and keep
the privileged executor small enough for direct review or a later refinement
layer.

### Authority and composition needed separate typed boundaries

Materialized policy/PTE facts became a typed witness checked before state
mutation. Decode, authority, apply, and effect planning then became one
transactional pure pipeline with explicit rollback rather than an informal
call-order claim.

**Beryllium lesson:** represent authority evidence and pipeline outcomes as
small total types, prove ordering and rollback in production-linked pure C, and
leave live fact acquisition as a separately reviewable correspondence layer.

### Pure capture closes shape, not hardware correspondence

Tier 7 proves exact copying from supplied scalars into the maintained snapshot
and authority set. It deliberately does not claim that the scalars came from
the right CSR, frame, symbol, policy query, PTE query, or point in time.

**Beryllium lesson:** a raw-capture seam is useful only when its caller
obligations remain explicit. Do not relabel structural copying as proof of live
capture.

## What remains unverified

The pathfinder does not cover:

- live NULL-frame rejection, CSR/frame/sentinel/root reads, linker-symbol
  profile wiring, policy/PTE query correctness, subject selection, or
  once-only/call-time correspondence in `src/main.c`;
- correct execution of the planned `SEPC` write, root/stack switch, console
  ordering, or platform shutdown;
- assembly, register clearing, CSR writes, fences, `SRET`, or SBI calls;
- architectural G-stage translation or Sail correspondence;
- compiler, assembler, linker, ELF loading, or C-to-binary refinement;
- OpenSBI, QEMU, the RISC-V implementation, or physical hardware;
- arbitrary trusted-HS writes to the C policy state;
- arbitrary guests, liveness, availability, or general VM lifecycle;
- confidentiality, noninterference, covert channels, or side channels; or
- any scope beyond the fixed one-hart, two-subject profile.

## Recommended carry-forward for Beryllium

1. Preserve a declared microverification core that alone owns privileged
   hardware authority.
2. Keep policy intent in an independent specification, not a report generated
   solely from implementation data.
3. Make the production enforcement seam total and proof-friendly before adding
   runtime complexity.
4. Keep proof-critical loops statically bounded; any SMP, interrupts,
   DMA/IOMMU, dynamic policy, relabeling, or generic page-table growth requires
   a new verification strategy review.
5. Require exact property manifests, complete unwinding, no hidden
   assumptions, witnesses, and mutation sensitivity.
6. Record proof tools and outputs as evaluator artifacts with narrow,
   property-specific claims.
7. Keep the pure runtime transition layer distinct from concrete trap/CSR
   validation, then treat assembly/CSR, ISA, and binary correspondence as
   additional proof layers rather than implying them from the state result.
8. Materialize live trap facts once, validate raw architectural encodings in a
   pure decoder, and keep the decision tuple minimal.
9. Derive a separate typed effect plan after authority-gated state mutation;
   do not place execution flags or mutable effect arguments in policy/event
   decisions.
10. Use a typed materialized authority witness before mutation, then compose
   decode, authority, apply, and effect planning transactionally with explicit
   outcomes and rollback.
11. Introduce a pure capture/materialization boundary without claiming live
   CSR, policy, PTE, linker, or timing correspondence that it does not prove.
12. Keep CBMC as the first restricted-C tool. Evaluate Serval only as a
   separately contained research spike; its public repositories are old.
13. Track RISC-V Sail H-extension/Sv39x4 progress, but do not make it a schedule
   dependency until the needed semantics and tests are stable.
14. If the production Beryllium core changes to Rust, make an explicit tooling
   decision around Verus or RefinedRust rather than carrying this C proof
   architecture over mechanically.

## Exact component evidence

- `verification/README.md`
- `verification/cbmc/manifest.json`
- `verification/cbmc/harnesses/`
- `verification/spec/te_spec.c`
- `verification/spec/runtime_spec.c`
- `verification/spec/trap_context_spec.c`
- `src/enforcement.c`
- `src/runtime.c`
- `src/trap_context.c`
- `src/trap_authority.c`
- `src/trap_pipeline.c`
- `src/trap_capture.c`
- `scripts/run-formal-verification.mjs`
- `tests/check-formal-verification-results.mjs`
- `docs/formal-verification.md`
- `build/fv/summary.json`
- `build/fv/results/trap-context-decode.json`
- `build/fv/results/trap-runtime-composition.json`
- `build/fv/results/trap-effect-plan.json`
- `build/fv/results/trap-authority.json`
- `build/fv/results/trap-pipeline.json`
- `build/fv/results/trap-capture.json`
- `build-rootless-logs/evidence/build/fv/`
- `build-rootless-logs/evidence/evaluator-provenance/rpm-packages.json`

## Validation completed

- Tier 6 exact source `e230cfddc265ba4a5710601a739ef27ed5a81be5`
  completed its H6/H7 cycle; frozen gate commit
  `c594b7fdb6aa584f23c1a3ea4287f7cc6fb9bd03` records that exact source.
- Tier 7 exact candidate
  `7ca97a9833d451750bd09ac5a3e020cce9e5bd6f` passed `./he check`,
  exact `./he evidence-check`, and `./he evaluate`.
- The Tier 7 candidate records 17 harnesses, 142 claims, 16,233 successful
  properties, and 16 rejected mutations.
- `./he publication-check` remains blocked for Tier 7, as required.

The next Helium gate is responsible-human H6 review of the exact Tier 7
candidate against reviewed Tier 6 source. Automation must not infer that
review, create the H7 gate-only child, push, or release.

The externally invoked host `evidence-check` is intentionally bound to the
operator-selected local QEMU/OpenSBI paths. It validates the native clean
bundle on this host. Rootless export correspondence is checked inside the
evaluator transaction, where the recorded container tool identities match.

## Research provenance

Applied from `formal-verification-research` commit
`0a8f89643d3fecafef56b7651ffcc91f6eb5a559`:

- `workstreams/beryllium/strategy.md`
- `workstreams/beryllium/codebase-assessment.md`
- `workstreams/beryllium/scaffolding-needed-now.md`
- `workstreams/beryllium/verified-systems-survey.md`
- `workstreams/beryllium/sel4-grade-effort.md`
- `notes/fv-primer-and-tooling.md`

Applied from `osr-claude` commit
`6a60ed399d0654fd8ba89afbc87058a424c294a8`:

- `mac-labels-on-capabilities-survey.md`

The OS-security survey informed TE/reference-monitor terminology and the
decision not to overstate policy conformance as noninterference.
