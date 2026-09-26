# closed dirty owner recovery

- **Record ID:** `PMD-20260926-004`
- **Created:** 2026-09-26
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Define the bounded recovery path when a responsible human confirms that the
previous component-owner session is closed but its exact worktree remains
dirty and must be preserved.

The first use is CHERI-RISC-V notes PMR-101 at branch
`docs/reconcile-project-status`, exact HEAD
`6cb15e3a6931a9d3f3c6a0f7884246c869151895`, with thirteen modified tracked
paths. This record controls only how a new owner context may safely resume
that preserved state.

## Inputs

- Responsible-human structured response on 2026-09-25: the original CHERI
  Copilot session is `closed`.
- `PMD-20260926-001`: the thirteen-path CHERI state is unfinished owner work
  and a coordination lock.
- `PMD-20260926-003`: PMR-101 is the sole open CHERI request, delivered
  without human prompt relay.
- Maintained inspection at 2026-09-26T04:06:58Z: CHERI remains dirty at
  `6cb15e3`, behind 0 / ahead 7, with the exact thirteen paths recorded in
  `outbox/owner-recovery/PMR-101.tsv`.
- `scripts/owner-session.sh`: ordinary owner launch intentionally refuses a
  dirty component, so it cannot recover this closed-session state.

## Disposition

Add human-run `scripts/owner-recovery.sh` as a separate fail-closed recovery
launcher. It is not an agent execution surface. The Project Manager prepares
and commits an exact TSV specification naming one component, one directly
assigned open PMR, branch, full HEAD, prior-session state `closed`, and every
porcelain status line plus the SHA-256 of the tracked full-index binary diff.

The launcher:

- requires clean, committed, current Project Manager tasking and a committed
  recovery specification;
- requires exactly one visible component request;
- shares the ordinary owner-session `flock` writer lock;
- requires exact branch, HEAD, dirty status, and tracked-diff SHA-256
  agreement and rejects merge conflicts and untracked recovery states;
- writes only ignored Project Manager packet, transcript, and state-log files
  before and after Copilot;
- preloads the exact dispatch packet into interactive
  `copilot --no-auto-update --yolo`; and
- never cleans, stashes, resets, stages, commits, pushes, changes a remote, or
  writes a component before Copilot begins.

If any recorded state changed, the launcher stops and a new Project Manager
turn must inspect and record it. A clean component uses
`scripts/owner-session.sh`; dirty recovery is never a general bypass.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not retroactively authorize any dirty content, grant D4
reference approval, resolve D5, authorize a commit, backup, push, merge,
Pages, publication, remote change, or sibling write, or prove that the
recovered owner will complete PMR-101. The owner must return `blocked` if its
own authority or provenance is insufficient.

## Follow-up

- After this Project Manager turn is committed and recovery tasking is
  current, the responsible human runs exactly:
  `bash ./project-manager/scripts/owner-recovery.sh launch
  cheri-riscv-notes PMR-101` from the workspace root.

## Provenance

- Written by the `project-manager` agent from the inputs above.
