# human owner session launcher

- **Record ID:** `PMD-20260922-003`
- **Created:** 2026-09-22
- **Status:** recorded
- **Supersedes:** Manual copy/paste owner-prompt handoffs in current Project
  Manager runbook and reporting surfaces; historical instructions remain
  evidence
- **Superseded by:** None

## Scope

Record the responsible human's requirement that direct component-owner
sessions launch from one prepared command rather than requiring the human to
copy, reconstruct, or paste agent instructions. The launcher applies to
ordinary human-started owner sessions for registered components without an
adopted hidden owner profile.

The initial live use targets are CHERI notes
`9a4c5effef3b87fc7529ec7ff265179ad1130d58` and CHERI hypervisor research
`d5d33a2a87909f0ee00e7a721bbba2c89bcd2176`.

## Inputs

- Responsible-human direction on 2026-09-22: always launch Copilot with
  `--yolo`; place the agent instructions where the launched session can use
  them; automate everything except critically required human actions.
- Installed GitHub Copilot CLI `1.0.88-2` local help: `--yolo` grants all
  tools/paths/URLs, `-i <prompt>` starts interactive mode and automatically
  executes the initial prompt, `-C <directory>` selects the working
  directory, while stdin and `-p` are one-shot and exit.
- `scripts/project-tasking.sh` at Project Manager
  `c8751d53f301f8626ee393a87ef0c180d5ea6872`: committed request selection,
  current PM/request fingerprints, component assignment checks, and
  fail-closed dispatch packet generation.
- `outbox/component-requests.md` at Project Manager `c8751d5`: the
  authoritative open-request actions and human gates.

## Disposition

Add human-run `scripts/owner-session.sh` with two modes:

- `prepare COMPONENT PMR...` performs the fail-closed checks and writes a
  private timestamped packet under ignored
  `scratch/owner-sessions/` without launching Copilot or reserving a writer.
- `launch COMPONENT PMR...` performs the same checks and starts interactive
  `copilot --no-auto-update --yolo -C LOGICAL_ENTRY -i PACKET_LOCATOR`,
  holding a per-component `flock` writer reservation until Copilot exits.

The packet binds the current committed Project Manager HEAD and request blob,
logical and physical component roots, expected clean component HEAD/branch,
and only directly assigned open PMRs. It includes the exact individual PMR
dispatch packets, local-instruction checklist, one-writer rule, collaboration
trigger, validation/commit/return contract, and no-gate/no-push boundary. The
short command-line prompt carries only the packet path, SHA-256, and expected
component HEAD; the human does not copy task text.

The Project Manager agent never uses this human-owned launcher to start owner
work against a live component or real Copilot binary. Maintained validation
exercises only sandbox preparation and an explicitly stubbed Copilot launch.
The launcher creates no component file before Copilot starts, invokes no
hidden owner worker, and does not expand the Project Manager's write or
execution authority.

## What this record does not decide

This record does not grant source admission, implementation authorization,
acceptance, approval, sign-off, licensing, redistribution, publication,
release, formal verification, hardware validation, push authority, remote
mutation, or an owner-worker profile. The human still answers genuine gates,
including PMR-009 D4 source-admission decisions, one short question at a
time. `--yolo` is a launch preference, not permission to exceed the packet or
component rules.

## Follow-up

- Run the prepared CHERI-notes batch with:
  `bash ./project-manager/scripts/owner-session.sh launch
  cheri-riscv-notes PMR-009 PMR-051 PMR-071`.
- In parallel, run the prepared XRV batch with:
  `bash ./project-manager/scripts/owner-session.sh launch
  cheri-hypervisor-research PMR-058 PMR-072`.

## Provenance

- Written by the `project-manager` agent from the inputs above.
