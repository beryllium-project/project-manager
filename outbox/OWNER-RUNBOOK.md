# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-09-19
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

## Owner-worker closure results

`PMR-087` is closed by
`records/decisions/PMD-20260918-002-analysis-workbook-read-only-handshake-verified.md`.
The single native `analysis-workbook-owner` probe was bound to Project
Manager commit `0229525ee4af25f6016bd97e37c244e3ace45ba3`, request blob
`3c2115e9d491f7d76a8d6b0c7d67749228e434a2`, and analysis-workbook
`ea72522a7d6448dfa2f3af841c2511522d5bc228` / tree
`e157f199636944977fb613b89efce4b559d03404`. Its only tool call used
`GIT_OPTIONAL_LOCKS=0` read-only local Git identity/status queries against the
one analysis-workbook repository. Root, branch, HEAD, tree, clean status,
upstream, and ahead/behind state were unchanged; no path, handoff, Git
metadata, sibling repository, specialist, subagent, user question, other PMR,
or gate was touched.

The synchronous probe ended. Its returned `active_session: self` is released
and leaves no writer reservation. The `PMD-20260918-001` exception is consumed
and proves only this exact read-only handshake.

The responsible human then directed the distinct PMR-086 turn. After fresh
fingerprint, clean/idle, and one-writer checks, the Project Manager dispatched
only `PMR-086` from exact PM commit `9c81f57` / request blob `18a5343d`
against analysis-workbook `ea72522`. Verified work `efbfdb8` changes only
`tests/validate-agent.sh`; durable return `858a73b` changes only `HANDOFF.md`.
The component reports 357 passed / 0 failed, and Project Manager diff checks
confirm the transfer queue and every analysis/session artifact are unchanged.
The synchronous owner session ended with no reservation. `PMR-086` is closed;
no other PMR, specialist, push, or gate was combined. `PMR-063` remains
separate.

After a fresh preflight, exact PMR-038 was dispatched from Project Manager
`6da2b8f` / request blob `4d9661d` against clean analysis-workbook `858a73b`.
Historical correction commit `2374115` was not reapplied. Return `f7079fb`
and boundary checkpoint `5e037b1` change only root `HANDOFF.md`, report
357 / 0 and maintained queue/workbook checks passing, and leave clean
`main` twelve ahead. The owner returned `partial` only because the external
fleet todo table is outside its repository boundary; the Project Manager
verified the complete repository result and performed that bookkeeping.
`PMR-038` is closed. No analysis, source admission, sibling write, push,
other PMR, or gate was combined.

## Operational housekeeping closure

`PMD-20260918-003` stops further process expansion before development resumes.
Repository reorganization and the analysis owner-worker pilot are complete.
No project-wide owner rollout or Git-maintainer specialist is required.

The ordinary Beryllium owner session is complete and released at `416b2e9`;
`PMR-067` and `PMR-083` are closed. Analysis PMR-004 and PMR-050 are complete
at `5684317` / `635719e` and `231cca4` / `692caeb`. Finish only the three
remaining exact analysis-workbook housekeeping PMRs (`PMR-055`, `PMR-059`,
`PMR-063`) sequentially through the proven owner, with one
dispatch/return/verification per PMR.

Then declare the repository/PM housekeeping workstream operationally complete
and stop. Research, source admission, external dependencies, backup/push
gates, and opportunistic configuration remain visible but do not block
development.

## Repository reorganization complete

Do not rerun the former P1 migration lanes. The Project Manager verified and
closed all three requests:

| Request | Active private successor | Verified owner return | Remaining non-blocking item |
| --- | --- | --- | --- |
| `PMR-044` | `agentic-os-research/os-security-research` | `49fbfd6` | Personal quarantine exists empty; any restricted-file review/copy remains human-only |
| `PMR-045` | `agentic-os-research/cheri-hypervisor-research` | `456c70b` | `PMR-075`: decide whether to push the two local owner documentation commits |
| `PMR-046` | `agentic-os-research/cheri-riscv-notes` | `9a4c5ef` | Private hosted Wiki unavailable; complete history is preserved at `archive/gim-wiki` |

All three successors are private and active as `origin`; old homes remain
inactive references; no tracked workspace symlink moved. Publication,
licensing, redistribution, release, and assurance gates are unchanged.

## CRQ-002 successor-first sequence

`PMD-20260915-004` records the responsible human's `successor-first`
selection. It is sequencing only and authorizes no repository or source
operation.

| Order | Priority | Request | Required result |
| --- | --- | --- | --- |
| Done | - | `PMR-027` | OS-security is clean and synchronized at `e275544`. |
| Done | - | `PMR-044`, `PMR-045` | Private OS-security and XRV successors are verified; old homes remain inactive references. |
| Blocked | P4 | `PMR-052` | Wait for the cap-talk archive owners' response; only then may OS-security identify and inspect, or precisely bound as inaccessible, the public continuation from the `2016-04-01` start bound. |
| 2 | P3 | `PMR-053` | XRV reviews only materially relevant returned threads through its owner intake lifecycle. |
| 3 | P3 | `PMR-054` | Analysis-workbook adds the revision-bound follow-up inquiry and states whether Q-001 through Q-004 change. |

`PMR-055` is independent immediate workbook housekeeping: mirror `CRQ-002`
as `routed`, replace the packet's stale `OPEN-001` instruction with current
`OPEN-003`, and mark the superseded `OPEN-001` question row consistently.

`PMR-046` is also complete and was not a prerequisite for `CRQ-002`.

Under `PMD-20260917-001`, for `PMR-052`, `PMR-053`, and `PMR-054`, add this
before the task-specific instructions:

```text
Load and follow the `cross-repo-collaboration` skill before using sibling
research or analysis. Read the source repository's root COLLAB.md when
present and follow its guest budget. Complete and validate destination work
before logging use. If the source has no writable guest ledger, write nothing
there and return completed-use evidence through the source owner and Project
Manager.
```

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
| `PMR-063` | P3 | Project Manager invokes hidden `analysis-workbook-owner` after PMR-059 reconciliation | `Complete only PMR-063 under PMD-20260915-008; preserve every analysis result and do not combine another PMR.` |
| `PMR-064` | P3 | `cd /home/jmorris/src/beryllium-project/threat-modeler && copilot`, then `/agent threat-model-maintainer` | `Complete PMR-064 under PMD-20260915-008; do not resume the paused model.` |
| `PMR-066` | P3 | `cd /home/jmorris/src/beryllium-project/provenance-review && copilot` | `Complete PMR-066 under PMD-20260915-008 in this ordinary configuration-maintenance session.` |
| `PMR-068` | P3 | `cd /home/jmorris/src/beryllium-project/helium-te-poc && copilot` | `Complete PMR-068 without changing frozen refs or gates.` |
| `PMR-069` | P3 | `cd /home/jmorris/src/beryllium-project/formal-verification-research && copilot` | `Complete PMR-069 without changing research or bibliography dispositions.` |
| `PMR-070` | P3 | `cd /home/jmorris/src/beryllium-project/osr-claude && copilot`; use the successor's owner workflow after the responsible human confirms the write | `Complete PMR-070 without opening restricted-microsoft.` |
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

## P2 repository actions

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

### PMR-040 - XRV review of proposed architecture

Start the XRV owner and provide analysis-workbook commit `a46dba2`:

```sh
cd /home/jmorris/src/beryllium-project/xrv-research-repo
copilot
```

First say:

```text
Load and follow the `cross-repo-collaboration` skill before using sibling
research or analysis. Analysis-workbook has no root COLLAB.md, so do not
create one or write that repository; return completed-use evidence through
its owner and the Project Manager.
```

Ask the owner to review:

- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/cheri-hypervisor-security-model.md`;
- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/capability-resource-correspondence.md`;
- `../analysis-workbook/sessions/AWB-20260914-002-cheri-hypervisor-security-model/helium-cheri-parity-plan.md`.

Return `incorporate`, `qualify`, `defer`, or `decline` through XRV's handoff
with exact commit and paths. Do not select an implementation target, approve
a comparator baseline, or push without a separate human decision.

## Completed - do not rerun

`PMR-067` and `PMR-083` are closed at final owner return correction
`416b2e9`, following tasking implementation `9b726c1`, structured return
`32300c1`, section-boundary/Chromium remediation `b5bd8cc`, and fence-parser
hardening `364552c`. The responsible human's `"all ready"`, given in direct
response to the Project Manager's Beryllium owner-session release request,
releases the historical `active_session: self` lock.

The exact resolver startup mapping, fence-aware validation, and explicit
Chromium documentation gates passed. Full `make check` stops first on
unchanged R3 Node executable digest drift, not a PMR-067 semantic failure.
R8-C remains plan-only; candidate `6e93461` remains blocked and unaccepted;
H1-H4 remain unauthorized; K3 remains `NOT RUN`. No push occurred.

Analysis PMR-004 and PMR-050 are also complete. Hidden
`analysis-workbook-owner` added only `project-manager` at work `5684317` /
return `635719e`, then only `security-reviewer` at work `231cca4` / return
`692caeb`. Both returns report 357 / 0, clean local state, no push, and no
analysis or later-PMR work.

## Deferred P3 housekeeping

- **P3 PMR-085:** analysis-workbook clean `main` at `ea72522` is eight ahead
  of last-fetched private `origin/main` `1ef1ac6`, comprising Project Manager
  carry `c7cc0fa` plus seven PMR-084 owner commits. After authorized private
  access, review that exact range and decide whether to fast-forward push.
  No force, tag, publication, analysis disposition, or handshake authority.
- **P3 PMR-088:** after `PMR-085` is independently resolved, review only
  PMR-086 work `efbfdb8` and durable return `858a73b` with
  `git -C /home/jmorris/src/beryllium-project/analysis-workbook diff ea72522..858a73b -- tests/validate-agent.sh HANDOFF.md`.
  A later separately confirmed private fast-forward may back up those two
  commits. This request was not dispatched or combined with PMR-086; no
  force, tag, queue change, analysis disposition, publication, or gate.
- **P4 PMR-089:** do not act until PMR-063 closes and freezes the endpoint,
  and until `PMR-085` plus `PMR-088` are independently resolved. It will
  cover only the exact six-request housekeeping range after `858a73b`,
  beginning with HANDOFF-only commits `f7079fb` and `5e037b1`, followed by
  PMR-004 work `5684317` / return `635719e` and PMR-050 work `231cca4` /
  return `692caeb`. The request is undispatched; no force, tag,
  analysis/source change, publication, or gate is included.
- **P3 PMR-090:** active Beryllium return correction `416b2e9` is twelve ahead of
  last-fetched private `origin` at `f05ccb3`, and candidate branch
  `beryllium/r8-h0-pmr-080` at `6e93461` has no upstream. Live reachability
  is `unknown`; after authorized access returns, review the complete active
  range and exact candidate ref and decide whether to push. `PMR-090`
  supersedes `PMR-082`. Never push inactive `msft-downstream`; no push accepts
  H0, authorizes R8-C implementation, or authorizes H1-H4/K3.
- **P4 PMR-076:** parked by `PMD-20260918-003`. If explicitly resumed later,
  locate the responsible human's `kcopilotd` project, then
  design a Project Manager-owned OSS alignment skill/agent that maintains
  revision-bound comparisons with upstream and peer projects across LLM
  policy, development workflow, licensing/redistribution, governance/release,
  automation/CI, and contribution practices. Preserve fact/inference/proposal/
  unknown labels; do not write peer repositories or infer human gates.
- **PMR-075:** XRV owner documentation commits `22095a1` and `456c70b`
  remain local two ahead of last-fetched `origin/main` at `d618935`. The
  active credential could not reach that remote in the 21:53Z helper run, so
  wait for an authorized credential. Then review only that range and, if
  explicitly confirmed in the owner turn, push it without force:

  ```sh
  cd /home/jmorris/src/beryllium-project/xrv-research-repo
  git status --short --branch
  git log --oneline origin/main..main
  git diff --stat origin/main..main
  ```

  The successor research history and `PMR-045` are already complete; this is
  a non-blocking backup decision and includes no research or symlink change.
- **PMR-073:** withdrawn by `PMD-20260918-003`; the proven owner-worker path
  supplies the bounded need and no current request requires a separate
  Git-maintainer specialist.

- **PMR-014:** the formal-verification owner triages the five original routed
  bibliography pointers.
- **PMR-041:** the same owner triages the later `PMQ-021` and `PMQ-023`
  pointers at `c55065c` and `784be93`.
- **PMR-051:** in `cheri-riscv-notes-repo`, append only the structured
  current-head/paths/validation/backup/session return. Current `9a4c5ef`
  handoff/status already record the successful 2026-09-16 remote Validate run
  for preserved `ae09213` and successor topic history. No merge, new remote
  workflow run, visibility change, or publication decision is required.
- **PMR-037:** in `formal-verification-research`, refresh the owner-maintained
  handoff to state that the restored clone tracks the reachable
  `beryllium-project` repository as `origin`. The bibliography-format half
  was carried at `784be93`.
- **PMR-055:** after the PMR-050 reconciliation is committed and tasking
  regenerated, dispatch this request alone. Mirror `CRQ-002` to `routed` from
  `PMD-20260915-004` and `PMR-052..PMR-054`, change the execution packet's
  stale `OPEN-001` instruction to current `OPEN-003`, and mark the already
  superseded `OPEN-001` row `Superseded`. Do not combine another PMR.
- **PMR-058:** `PMR-045` is closed; the XRV owner may now triage `PMQ-027`,
  `PMQ-028`, and corrected `PMQ-030` under `review-log.md`; `PMQ-029` is not
  separately pursued because `PMQ-030` supersedes it. Load
  `cross-repo-collaboration` only if triage becomes substantive destination
  use; analysis-workbook has no root `COLLAB.md`, so write no source ledger.
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

## External Beryllium dependency

**P4 `PMR-077`:** K3 COM260 (normalized from the responsible human's
externally unverified `Com260` term) bring-up is in progress in a separate
environment/project. Wait for the responsible human's minimal readiness
return before any Beryllium hardware bring-up. Do not access or import that
project through this request, and return no serial numbers, credentials,
keys, tokens, private URLs, or restricted content. Its completion does not
accept H0, authorize H1-H4, or establish Beryllium hardware validation.

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

- `analysis-workbook` clean `main` `692caeb` is sixteen ahead of last-fetched
  `origin/main` `1ef1ac6`: Project Manager carry `c7cc0fa`, seven PMR-084
  owner commits through `ea72522`, and PMR-086 commits `efbfdb8` and
  `858a73b`, followed by PMR-038 HANDOFF-only commits `f7079fb` and
  `5e037b1`, then PMR-004 work `5684317` / return `635719e` and PMR-050 work
  `231cca4` / return `692caeb`. The first range remains exact backup request
  `PMR-085`; separate dependent `PMR-088` tracks only the two PMR-086 commits;
  prospective `PMR-089` will freeze the post-`858a73b` closure range at
  PMR-063;
- `beryllium-repo` active/default return `416b2e9` is twelve ahead of last-fetched
  `origin`; local candidate branch `beryllium/r8-h0-pmr-080` is `6e93461`
  with no upstream. It is excluded from generic helper delivery and remains
  exact backup request `PMR-090`;
- `xrv-research-repo` reviewed history through `d618935` is backed up on
  active private `origin/main`; local owner documentation commits `22095a1`
  and `456c70b` remain two ahead under `PMR-075`; inactive
  `legacy-backup/main` remains `706e708`;
- `formal-verification-research` `c55065c`, `784be93`
  (`PMR-035`, `PMR-037`, `PML-0022`, `PML-0024`);
- `threat-modeler` is already backed up through synchronized owner maintenance
  `c4126b6` (`PMR-028` closed; includes `5bf6a4b` and `f4eb272`);
- `security-reviewer`: owner commit `2e8d205` (`PMR-074`, four profiles to
  `gpt-5.3-codex`) is synchronized with private `origin/main`; no
  `push_sr` action is due.

The current helper's `push_fvr` path expects a remote named `backup`, while
the restored formal-verification clone has only `origin`. It will not push
`c55065c` or `784be93` by default. The owner must either push those commits through the
component's own approved workflow or direct a later Project Manager change to
retarget the helper; do not create a duplicate remote implicitly.

For XRV, `push_xrv` now targets active private `origin` and corresponds only
to deferred `PMR-075`; inactive `legacy-backup` is not a push target.

The helper prompts before every push, warns on a dirty worktree and skips it
automatically only under `--yes`, never forces, and does not publish. Report
its log path and result to the next Project Manager turn.

## Human gates unchanged

Beryllium is accepted through R7. R8-C plan target `f47ae60` is accepted as
plan text only and grants no implementation authority. Exact H0 candidate
`6e93461` remains blocked, unreviewed, and unaccepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN`. Helium is a review-and-test proof of
concept, not formally verified or hardware validated. No coordination action
grants acceptance, approval, risk acceptance, sign-off, licensing,
publication, or release.
