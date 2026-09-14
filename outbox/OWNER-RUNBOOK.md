# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-09-14
**Workspace root:** `/home/jmorris/src/beryllium-project`

The Project Manager does not execute this file's commands, run component
validation, modify carry-ineligible components, or push any repository.
Review each component's own handoff and diff before acting.
Before any repository write, confirm the worktree and active-session state;
a clean tree alone is not permission. If another agent is active, coordinate
through its handoff and wait for an explicit return.

## First action: preserve current local-only work

Two current states have the highest data-loss exposure:

1. **PMR-028 - Threat-model package committed but not backed up.** The clean
   `threat-modeler/main` is two commits ahead of `origin/main`: owner commit
   `5bf6a4b` contains the complete private, paused
   `TM-20260911-001-helium-te-poc-astra` package, and Project Manager carry
   `f4eb272` updates only its current coordination pointer. Start the
   maintainer and ask it to inspect the complete outgoing diff, reconcile the
   stale delivery sentence in `HANDOFF.md`, run its maintained checks, and
   push only after your explicit confirmation:

   ```sh
   cd /home/jmorris/src/beryllium-project/threat-modeler
   copilot
   # then: /agent threat-model-maintainer
   ```

2. **PMR-029 - CHERI notes topic work is uncommitted.** The active
   `docs/reconcile-project-status` worktree has 21 changed entries and no
   upstream. Continue in the owning session; review and validate before
   committing:

   ```sh
   cd /home/jmorris/src/beryllium-project/cheri-riscv-notes-repo
   git status --short --branch
   git diff --check
   node automation/validate-corpus.mjs  # uncommitted validator on this topic branch
   ```

   Do not run a Project Manager carry or source-pointer triage there until
   the owner reports the work committed, intentionally parked, or discarded.

## P2 coordination blockers

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

### PMR-027 - OSR checkout one commit behind

The clean local `main` is at `f2edd17`; `origin/main` is at the already
recorded owner correction `e275544`. If the older local state is not
intentional:

```sh
cd /home/jmorris/src/beryllium-project/osr-claude
git status --short --branch
git pull --ff-only origin main
tools/md-to-html.sh --check
```

The owner should report the resulting HEAD. The Project Manager never opens
`sources/restricted-microsoft/`.

### PMR-003 - Beryllium handoff remains stale

From the carry-ineligible implementation repository, use its own owner
session to update `planning/HANDOFF.md` to the current canonical path and
state that R8-H0 is committed as candidate `102f2b0`, not accepted:

```sh
cd /home/jmorris/src/beryllium-project/beryllium-repo
git status --short --branch
copilot
```

Preserve: R0-R7 accepted; R8-H0 not accepted; H1-H4 unauthorized; K3
hardware `NOT RUN`.

### PMR-020 - CHERI notes remote verification

After `PMR-029` is resolved, verify the current internal `origin` using the
owner's credentials:

```sh
cd /home/jmorris/src/beryllium-project/cheri-riscv-notes-repo
git fetch origin
git status --short --branch
```

Report whether the remote is reachable and the topic branch's backup state.

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

## P3 housekeeping

- **PMR-038:** in `/home/jmorris/src/beryllium-project/analysis-workbook`,
  use `/agent analysis-workbook` to mirror `CRQ-001` from `routed` to
  `completed` using closed `PMR-034` and XRV commit `d618935`, and refresh
  the related handoff wording. Preserve that completion is coordination
  state, not source review or approval. Wait for the active untracked
  `AWB-20260914-002-cheri-hypervisor-security-model` session to hand off
  before this owner action.
- **PMR-004 and PMR-022:** the analysis-workbook and threat-modeler owners
  decide whether their owner-only `scripts/readonly-inspect.sh` target lists
  should add `project-manager` and `security-reviewer`; scripts are outside
  the Project Manager carry authority. In each repository, review and add the
  two names to the existing array:

  ```sh
  registered_components=(
      project-manager
      security-reviewer
      # keep every existing entry below
  )
  ```

  Then run that component's `readonly-inspect.sh components` mode and
  maintained validation before committing with both request IDs.
- **PMR-014:** `formal-verification-research` is available again. Its owner
  may now triage the five earlier routed bibliography pointers plus the new
  metadata-only `PMQ-021` pointer carried at `c55065c`.
- **PMR-023:** the Beryllium owner decides whether its existing `origin` is
  the accepted off-workstation home or whether to add a reachable private
  backup. No local-only Beryllium commit is currently observed.
- **PMR-033:** in the next Project Manager turn, or through the component
  owner, clarify `security-reviewer/HANDOFF.md` so the `9ca5071` 0/0 statement
  is explicitly pre-carry and current `main` is `c13c36e`, one ahead. This is
  deliberately deferred; no security-reviewer write was attempted now.
- **PMR-037:** in `formal-verification-research`, refresh the owner-maintained
  handoff to state that the restored clone tracks the reachable
  `beryllium-project` repository as `origin`, and normalize the routed-pointer
  heading and `PMQ-021` author style. This is deliberately deferred; no
  formal-verification-research write was attempted now.

### PMR-039 - XRV local work and active research

Do not write or push `xrv-research-repo` while the reported deep-research
session is active. After its owner return, re-run:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh state xrv-research-repo
bash ./scripts/inspect-components.sh refs xrv-research-repo d618935
```

Then review the complete outgoing owner work and decide whether to push
`main` to reachable private `backup`.

## P4 source triage

- **PMR-009:** after `PMR-029`, the CHERI notes owner decides whether to
  record analysis-workbook rows `PMQ-008` (Rowhammer/PTE privilege
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

- `analysis-workbook` `eab5f8b` (`PMR-031`);
- `analysis-workbook` owner commits `4c771c0`, `62ee356` and carries
  `8899176`, `0501243` (`PML-0018..0022`);
- `xrv-research-repo` `706e708` is backed up on `backup/main`; owner commit
  `d618935` is local one ahead and intentionally unpushed. The user reports
  an active XRV deep-research session; do not push or write there until it
  hands off;
- `formal-verification-research` `c55065c` (`PMR-035`, `PML-0022`);
- `threat-modeler` `f4eb272` (`PMR-031`, stacked after owner commit
  `5bf6a4b`);
- `security-reviewer` `c13c36e` (`PMR-030`, `PMR-031`).

The current helper's `push_fvr` path expects a remote named `backup`, while
the restored formal-verification clone has only `origin`. It will not push
`c55065c` by default. The owner must either push that commit through the
component's own approved workflow or direct a later Project Manager change to
retarget the helper; do not create a duplicate remote implicitly.

The helper prompts before every push, skips dirty worktrees, never forces, and
does not publish. Report its log path and result to the next Project Manager
turn.

## Human gates unchanged

Beryllium is accepted through R7. R8-H0 is a committed candidate and is not
accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium is a
review-and-test proof of concept, not formally verified or hardware
validated. No coordination action grants acceptance, approval, risk
acceptance, sign-off, licensing, publication, or release.
