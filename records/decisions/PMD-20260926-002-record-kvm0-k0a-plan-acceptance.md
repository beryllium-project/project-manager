# record kvm0 k0a plan acceptance

- **Record ID:** `PMD-20260926-002`
- **Created:** 2026-09-26
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the exact responsible-human KVM0 K0-A plan decision now present in the
Beryllium component and reconcile the plan-only action requested by PMR-099.

The live component is dirty at
`1795400868c6d6cb3a6a9fed8ce069424c7bc2ef`. This record acknowledges only
the immutable plan decision already recorded in committed component evidence;
it does not treat the current dirty work as returned or authorized.

## Inputs

- `../beryllium-hypervisor/planning/k3-kvm0-plan-k0a-review-summary.md` at
  `1795400`: responsible-human acceptance on 2026-09-25 of exact KVM0 Plan
  revision K0-A target
  `5227266ceddb664a1595e22e5a92da57a013652f`, parent
  `8348b18a2c00c992e8fbf744f2004dfcd55500e6`, tree
  `2a716a0ca69a7d0ada92b978bd77704fbfc8910b`, by the exact instruction
  `5227266ceddb664a1595e22e5a92da57a013652f is accepted exactly`.
- `../beryllium-hypervisor/planning/roadmap.md` at `1795400`: current K0-A
  status, the superseded original target, and the separate K0-P/K0-I/K0-S/
  K0-X/K0-R gates.
- `../beryllium-hypervisor/planning/HANDOFF.md` at `1795400`: the
  documentation-only `record-k0a-acceptance` return and local-only backup
  boundary.
- Maintained inspection on 2026-09-26: dirty active branch at `1795400`,
  behind 0 / ahead 6 of last-fetched `origin` `80345e1`, with eight modified
  `tests/kvm0/` paths and no canonical PMR-099 owner-return row.

## Disposition

Record exact K0-A plan target `5227266ceddb664a1595e22e5a92da57a013652f`
as responsible-human accepted plan text on 2026-09-25 and close PMR-099 on
its plan-only result. Original target `459184dd8fe9c5da20e27a9e277a076685a520cb`
and packet `8348b18a2c00c992e8fbf744f2004dfcd55500e6` remain superseded and
unaccepted.

The accepted plan satisfies only K0-P:

```text
kvm0_gate_k0p=satisfied-by-exact-plan-acceptance
kvm0_gate_k0i=blocked-not-authorized
kvm0_gate_k0s=blocked-source-evidence-not-ready
kvm0_gate_k0x=blocked-not-authorized
kvm0_gate_k0r=blocked-no-result
kvm0_result=NOT-RUN
beryllium_k3_hardware=NOT-RUN
r8_k3_hardware=NOT-RUN
development_kernel_bsp=UNDECIDED
publication=blocked
```

Allocate PMR-100 as a distinct coordination-only request for the committed
post-`80345e1` KVM0 series and the current dirty owner session to return exact
scope, validation, authority, active-session, backup/ref, and publication
state. PMR-098 remains open for the earlier `416b2e9..80345e1` series.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not authorize K0-I tooling, K0-S source preparation or
evidence import, K0-X native execution, K0-R result acceptance, K3 access,
B0, B1, a retained H0 successor, R8 H1-H4, development-kernel/BSP selection,
root integration, checker or pin changes, push, tag, publication, migration,
release, or upstream work. KVM0 and Beryllium/R8 K3 remain `NOT RUN`.

## Follow-up

- Preserve the current Beryllium owner work. After that existing session
  validates and returns clean, verify PMR-098 and PMR-100 as distinct
  reconciliation scopes before considering any later K0 gate.

## Provenance

- Written by the `project-manager` agent from the inputs above.
