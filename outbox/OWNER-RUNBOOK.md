# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-09-16
**Workspace root:** `/home/jmorris/src/beryllium-project`

The Project Manager does not execute this file's commands, run component
validation, modify carry-ineligible components, or push any repository.
Review each component's own handoff and diff before acting.
Before any repository write, confirm the worktree and active-session state;
a clean tree alone is not permission. If another agent is active, coordinate
through its handoff and wait for an explicit return.

From any registered component's workspace entry, current generated tasking can
be resolved without pasting request rows:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

The command fails rather than showing stale or unreachable tasking.

## First action: Beryllium tasking startup adoption

Security-reviewer `PMR-062` and `PMR-065` are complete at synchronized
`f2051a4`. Apply the startup contract next to the ordinary Beryllium owner
context whose failed lookup exposed the gap (`PMR-067`):

```sh
cd /home/jmorris/src/beryllium-project/beryllium-repo
pwd
pwd -P
git status --short --branch
copilot
```

Then use the exact approved resolver prompt in the tasking-adoption section
below and say `Complete PMR-067`.

## CRQ-002 successor-first sequence

`PMD-20260915-004` records the responsible human's `successor-first`
selection. It is sequencing only and authorizes no repository or source
operation.

| Order | Priority | Request | Required result |
| --- | --- | --- | --- |
| Done | - | `PMR-027` | OS-security is clean and synchronized at `e275544`. |
| 1 | P2 | `PMR-044`, `PMR-045` | Establish and verify the private OS-security and XRV successor homes and executable owner workflows; keep old homes inactive. |
| 2 | P2 | `PMR-052` | OS-security identifies and inspects, or precisely bounds as inaccessible, the public continuation beginning after the final archived March 2016 message; use `2016-04-01` as the acquisition start bound. |
| 3 | P3 | `PMR-053` | XRV reviews only materially relevant returned threads through its owner intake lifecycle. |
| 4 | P3 | `PMR-054` | Analysis-workbook adds the revision-bound follow-up inquiry and states whether Q-001 through Q-004 change. |

`PMR-055` is independent immediate workbook housekeeping: mirror `CRQ-002`
as `routed`, replace the packet's stale `OPEN-001` instruction with current
`OPEN-003`, and mark the superseded `OPEN-001` question row consistently.

## P2 repository actions and blockers

## Project-wide tasking startup adoption

`PMD-20260915-008` requires every registered owner context to map
`check Project Manager tasking` to:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

The command must be run from the registered logical workspace entry. If it
cannot be found or fails validation, stop and ask the human to relaunch from
that entry. Never search session history, task/todo databases, background
agents, prior chat, or memory for a fallback PMR.

If a Project Manager turn is still changing `outbox/component-requests.md`,
wait for its commit and regenerated views before starting an owner session.
For tracked symlinks, record `pwd` and `pwd -P`; if logical `PWD` is not
preserved, stop and use the `PM_TASKING_ROOT` / `PM_TASKING_WORKSPACE`
fallback documented by `PMD-20260915-008`.

| Request | Priority | Component owner invocation | Exact task phrase after the approved resolver runs |
| --- | --- | --- | --- |
| `PMR-063` | P3 | `cd /home/jmorris/src/beryllium-project/analysis-workbook && copilot` | `Complete PMR-063 under PMD-20260915-008 in this ordinary configuration-maintenance session.` |
| `PMR-064` | P3 | `cd /home/jmorris/src/beryllium-project/threat-modeler && copilot`, then `/agent threat-model-maintainer` | `Complete PMR-064 under PMD-20260915-008; do not resume the paused model.` |
| `PMR-066` | P3 | `cd /home/jmorris/src/beryllium-project/provenance-review && copilot` | `Complete PMR-066 under PMD-20260915-008 in this ordinary configuration-maintenance session.` |
| `PMR-067` | P2 | `cd /home/jmorris/src/beryllium-project/beryllium-repo && copilot` | `Complete PMR-067; first report pwd and pwd -P, and do not combine implementation work.` |
| `PMR-068` | P3 | `cd /home/jmorris/src/beryllium-project/helium-te-poc && copilot` | `Complete PMR-068 without changing frozen refs or gates.` |
| `PMR-069` | P3 | `cd /home/jmorris/src/beryllium-project/formal-verification-research && copilot` | `Complete PMR-069 without changing research or bibliography dispositions.` |
| `PMR-070` | P3 | `cd /home/jmorris/src/beryllium-project/osr-claude`; use the owner's Claude workflow after the responsible human confirms the write | `Complete PMR-070 without opening restricted-microsoft.` |
| `PMR-071` | P3 | `cd /home/jmorris/src/beryllium-project/cheri-riscv-notes-repo && copilot` | `Complete PMR-071; first report pwd and pwd -P, with no corpus or publication change.` |
| `PMR-072` | P3 | `cd /home/jmorris/src/beryllium-project/xrv-research-repo && copilot` | `Complete PMR-072; first report pwd and pwd -P, with no research or review-ID change.` |

For each owner session, say:

```text
I approve this exact read-only startup command for this session:
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .

Run it now. Treat its validated output as discovery, not authorization. Do
not search session history, task databases, background agents, prior chat, or
memory. Then use the exact PMR-specific phrase from the matrix above.
Implement PMD-20260915-008 in owner instructions and maintained tests, and
append the structured Project Manager return with exact commit, validation,
branch, and backup state.
```

### PMR-044 - OS-security rehome and quarantine

Use the OS-security owner to design the active private
`agentic-os-research/os-security-research` repository and a separate private
quarantine repository `os-security-restricted-sources` in the responsible
human's personal account. It starts with clean new history; the responsible
human manually reviews and copies restricted files with their license
metadata. Port the active workflow to tool-neutral Copilot instructions. Do
not open or copy the restricted subtree in a Project Manager session. Do not
treat moving current files as making the existing Git history public-safe.

### PMR-045 - CHERI hypervisor research identity

Establish `agentic-os-research/cheri-hypervisor-research`, preserving the full
`REV-*` and `COLLAB.md` history. Keep the Microsoft-origin home inactive for
reference. Retargeting the tracked local symlink requires a later exact human
direction after the active repository and checkout are verified. Under
`PMD-20260915-004`, verify this successor before `PMR-052` begins.

### PMR-046 - CHERI-RISC-V SoK home

Establish `agentic-os-research/cheri-riscv-notes`, preserving the slug and branding
`sok/` as the CHERI-RISC-V SoK. The existing internal repository becomes an
inactive reference. No public or Pages action occurs until licensing,
authorship, corpus-integrity, and public-mirror gates close.

### PMR-026 - Helium checkout and handoff disagree

The clean checkout is detached at `1ab289c`, which is also
`for-review`/`origin/for-review`. Other observed refs include the travel
branch at `52cc71a` and `public/main` plus `v0.6.0` at `1c9e526`. In a Helium
owner session, confirm the intended operational checkout and reconcile
`HANDOFF.md`; do not infer release or approval from names:

```sh
cd /home/jmorris/src/beryllium-project/helium-te-poc
copilot
```

### PMR-032 - Verify the reappeared retained artifacts

The ignored parent `files` path now exposes candidate copies with all seven
names recorded in `PMD-20260906-002`, but their identity and suitability are
unknown. Run the maintained read-only search and hash check:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-actions.sh --files-search \
  --files-root /home/jmorris/src/beryllium-project/files
```

Report the log path and archive hash result. This does not select either H0
input or authorize H0 work.

### PMR-039 - XRV local backup decision

The responsible human reports the XRV deep-research run complete. Review the
current outgoing range:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh state xrv-research-repo
bash ./scripts/inspect-components.sh refs xrv-research-repo d618935
```

Then review the complete outgoing owner work and decide whether to push
`main` to reachable private `backup`.

### PMR-040 - XRV review of proposed architecture

Start the XRV owner and provide analysis-workbook commit `a46dba2`:

```sh
cd /home/jmorris/src/beryllium-project/xrv-research-repo
copilot
```

Ask the owner to review:

- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/cheri-hypervisor-security-model.md`;
- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/capability-resource-correspondence.md`;
- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/helium-cheri-parity-plan.md`.

Return `incorporate`, `qualify`, `defer`, or `decline` through XRV's handoff
with exact commit and paths. Do not select an implementation target, approve
a comparator baseline, or push without a separate human decision.

## P3 housekeeping

- **PMR-073:** Project Manager designs and implements the planned
  `git-maintainer` specialist. Required design inputs:
  - only `project-manager` can invoke it; component agents submit durable
    requests through PM tasking or owner returns;
  - every invocation names exact repository, operation, paths/refs, expected
    initial state, validation, and requested evidence;
  - refuse unregistered, dirty, or active repositories unless a separately
    recorded contract explicitly handles the exact state;
  - in component repositories, no reset, clean, checkout/switch, stash,
    rebase, amend, force, or other destructive/history-rewriting operation;
    any future exception requires a new superseding decision and explicit
    same-turn responsible-human confirmation;
  - no remote creation/change, push, tag, publication, or release under the
    current specialist authority;
  - produce reviewed diffs/status, exact commit/ref evidence, and a
    restartable result for the Project Manager;
  - add synthetic tests for allowed/refused operations and prove component
    agents cannot invoke it directly.

- **PMR-038:** in `/home/jmorris/src/beryllium-project/analysis-workbook`,
  use `/agent analysis-workbook` to finish the partial owner result at
  `2374115`: change the remaining `AGENT-INTERFACE.md` sentence that says the
  outbox contains two surfaces, reconcile `HANDOFF.md` with the clean
  committed `2374115` state, and append the structured Project Manager
  return. The `CRQ-001` completion mirror and `PMQ-023` reference correction
  are already present. Preserve that completion is coordination state, not
  source review or approval.
- **PMR-004 and PMR-050:** threat-modeler completed both registrations at
  synchronized owner commit `c4126b6` and threat-owned `PMR-022` is closed.
  The analysis-workbook owner decides whether its owner-only
  `scripts/readonly-inspect.sh` target list should add `project-manager` and
  `security-reviewer`; scripts are outside the Project Manager carry
  authority. Review and add the two names to the existing array:

  ```sh
  registered_components=(
      project-manager
      security-reviewer
      # keep every existing entry below
  )
  ```

  Then run analysis-workbook's `readonly-inspect.sh components` mode and
  maintained validation before committing with `PMR-004` and `PMR-050`.
- **PMR-014:** the formal-verification owner triages the five original routed
  bibliography pointers.
- **PMR-041:** the same owner triages the later `PMQ-021` and `PMQ-023`
  pointers at `c55065c` and `784be93`.
- **PMR-051:** in `cheri-riscv-notes-repo`, refresh `meta/handoff.md` and
  `meta/status.md` to state that topic commit `ae09213` is committed and
  synchronized with `origin/docs/reconcile-project-status`, report the actual
  hosted workflow-run state (or `unknown`), and add the structured Project
  Manager return with exact validation. No merge to `main` or remote workflow
  run is required.
- **PMR-037:** in `formal-verification-research`, refresh the owner-maintained
  handoff to state that the restored clone tracks the reachable
  `beryllium-project` repository as `origin`. The bibliography-format half
  was carried at `784be93`.
- **PMR-055:** in the same analysis-workbook owner session as `PMR-038` if
  convenient, mirror `CRQ-002` to `routed` from `PMD-20260915-004` and
  `PMR-052..PMR-054`, and change the execution packet's stale `OPEN-001`
  instruction to current `OPEN-003`; mark the already-superseded `OPEN-001`
  row `Superseded`. Keep the two request IDs distinct in the owner return.
- **PMR-058:** after `PMR-045`, the XRV owner triages `PMQ-027`,
  `PMQ-028`, and corrected `PMQ-030` under `review-log.md`; `PMQ-029` is not
  separately pursued because `PMQ-030` supersedes it.
- **PMR-059:** owner commit `1ef1ac6` preserves and backs up
  `AWB-20260915-001`; Project Manager carry `c7cc0fa` applies the exact
  `PMQ-029` rejection. Refresh repository `HANDOFF.md` and append the
  structured Project Manager return naming the owner commit, changed paths,
  validation results, branch, and backup state.

## Additional P3 source triage

- **PMR-009:** the CHERI notes owner decides whether to record
  analysis-workbook rows `PMQ-008` (Rowhammer/PTE privilege
  escalation) and `PMQ-011` (Starbleed). The current queue rows remain
  `new`; ledger rows `PML-0008` and `PML-0011` remain `routed`. Use these
  metadata-only pointers under the component's current human inclusion gate:

  | Field | PMQ-008 | PMQ-011 |
  | --- | --- | --- |
  | Title | Exploiting the DRAM rowhammer bug to gain kernel privileges | The Unpatchable Silicon: A Full Break of the Bitstream Encryption of Xilinx 7-Series FPGAs (Starbleed) |
  | Authors | Mark Seaborn; Thomas Dullien | Maik Ender; Amir Moradi; Christof Paar |
  | Year / type / venue | 2015 / blog / Google Project Zero | 2020 / paper / USENIX Security |
  | Stable locator | The Project Zero URL in `../analysis-workbook/outbox/pm-queue.md` row `PMQ-008` | The USENIX presentation URL in row `PMQ-011` |
  | Scope note | Hardware-fault counter-source: PTE bit flips as a privilege-escalation path outside a capability model | FPGA-readback counter-source: configuration-interface secrets recovered from the device |

## Open Beryllium input gates

The responsible human still must select the normative Fedora 44 H0 static OCI
and the proposed H1/H2 path inventory. Candidate copies of two relevant
inputs have reappeared under the ignored `files` path, but `PMR-032` has not
verified them. No selection, acceptance, or authorization is inferred.

## Push the completed coordination carries

After reviewing the listed local component commits and the Project
Manager/parent commits, the responsible human may use the maintained helper.
It now targets parent `main -> upstream`:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-actions.sh --plan
bash ./scripts/owner-actions.sh
```

The relevant local component commits are:

- `analysis-workbook` carry `c7cc0fa` (`PML-0030`) is the only outgoing
  commit; owner `1ef1ac6` and predecessors are already synchronized;
- `xrv-research-repo` `706e708` is backed up on `backup/main`; owner commit
  `d618935` is local one ahead, unpushed pending `PMR-039`;
- `formal-verification-research` `c55065c`, `784be93`
  (`PMR-035`, `PMR-037`, `PML-0022`, `PML-0024`);
- `threat-modeler` is already backed up through synchronized owner maintenance
  `c4126b6` (`PMR-028` closed; includes `5bf6a4b` and `f4eb272`);
- `security-reviewer`: owner commit `2e8d205` (`PMR-074`, four profiles to
  `gpt-5.3-codex`) is one ahead of private `origin/main`; helper step
  `push_sr` fast-forwards it. `f2051a4` and predecessors are synchronized.

The current helper's `push_fvr` path expects a remote named `backup`, while
the restored formal-verification clone has only `origin`. It will not push
`c55065c` or `784be93` by default. The owner must either push those commits through the
component's own approved workflow or direct a later Project Manager change to
retarget the helper; do not create a duplicate remote implicitly.

XRV `d618935` remains pending the separate `PMR-039` decision. If running the
general helper before that decision, skip `push_xrv` or answer `N`.

The helper prompts before every push, skips dirty worktrees, never forces, and
does not publish. Report its log path and result to the next Project Manager
turn.

## Human gates unchanged

Beryllium is accepted through R7. R8-H0 is a committed candidate and is not
accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium is a
review-and-test proof of concept, not formally verified or hardware
validated. No coordination action grants acceptance, approval, risk
acceptance, sign-off, licensing, publication, or release.
