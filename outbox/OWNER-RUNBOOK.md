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

From any registered component's workspace entry, current generated tasking can
be resolved without pasting request rows:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

The command fails rather than showing stale or unreachable tasking.

## First action: verify D0 and preserve local-only work

1. **PMR-049 - authenticated D0 verification.** Review
   `records/decisions/PMD-20260914-004-d0-transition-inventory.md`, which
   closes the bounded local inventory `PMR-047`. From authenticated owner
   views, replace each decision-relevant `unknown` and name any additional
   Microsoft-origin repository in scope. For every repository, verify:

   - current and target active remote;
   - visibility and owning namespace;
   - authorship context (`personal`, `employer`, or `unknown`);
   - third-party license and redistribution state;
   - publicability class;
   - active branch, clean/active-session state, and backup state;
   - old-name/path/API references;
   - Wiki, tags/releases, issues/discussions;
   - Pages, Actions, packages, webhooks, and integrations;
   - quarantine boundary and target repository, using `unknown` until chosen.

   Return facts without credentials, private URLs, serial numbers, or
   restricted content. Never inspect
   `osr-claude/sources/restricted-microsoft/` in a Project Manager session.
   Every Microsoft repository remains an inactive reference after a verified
   successor is active; do not push new work there.

2. **PMR-028 - Threat-model package committed but not backed up.** The clean
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

3. **PMR-029 - CHERI notes topic work is uncommitted.** The active
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

### Organization rename - responsible human

After closing `PMR-049`, the organization owner may rename:

```text
Agentic-OS-Development
  -> GitHub organization Settings
  -> Danger zone
  -> Rename organization
  -> agentic-os-research
```

Confirm the target name in the authenticated form immediately before the
rename. GitHub redirects repository links after an organization rename, but
the old organization profile/API name does not redirect and the old name can
be reused. Record the exact result before changing any repository remote.

### PMR-043 - Beryllium active rehome

After `PMR-049` and the organization rename, create the private active home
`agentic-os-research/beryllium`, verify the complete active branch history,
and update the Beryllium owner handoff and remote. Keep the Microsoft
repository unchanged as an inactive reference. `beryllium-repo` is
carry-ineligible; the Project Manager performs none of these actions.

### PMR-044 - OS-security rehome and quarantine

First resolve `PMR-027` and `PMR-049`, then rename the organization. Use
the OS-security owner to design the active private
`agentic-os-research/os-security-research` repository and a separate private
quarantine repository visible only to the responsible human. Port the workflow
to tool-neutral Copilot instructions. Do not open or copy the restricted
subtree in a Project Manager session. Do not treat moving current files as
making the existing Git history public-safe.

### PMR-045 - CHERI hypervisor research identity

After `PMR-049` and the organization rename, establish
`agentic-os-research/cheri-hypervisor-research`, preserving the full
`REV-*` and `COLLAB.md` history. Keep the Microsoft-origin home inactive for
reference. Retargeting the tracked local symlink requires a later exact human
direction after the active repository and checkout are verified.

### PMR-046 - CHERI-RISC-V SoK home

After `PMR-029`, `PMR-049`, and the organization rename, establish
`agentic-os-research/cheri-riscv-notes`, preserving the slug and branding
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

- **PMR-038:** in `/home/jmorris/src/beryllium-project/analysis-workbook`,
  use `/agent analysis-workbook` to mirror `CRQ-001` from `routed` to
  `completed` using closed `PMR-034` and XRV commit `d618935`, and refresh
  the related handoff wording. Preserve that completion is coordination
  state, not source review or approval. Also correct the stale "two
  queue/surface" text, the handoff's "pending commit" sentence, and the
  `PMQ-023` note's `PMR-014` reference to `PMR-041`. The security-model
  session is now committed at `a46dba2`.
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
- **PMR-014:** the formal-verification owner triages the five original routed
  bibliography pointers.
- **PMR-041:** the same owner triages the later `PMQ-021` and `PMQ-023`
  pointers at `c55065c` and `784be93`.
- **PMR-033:** in the next Project Manager turn, or through the component
  owner, clarify `security-reviewer/HANDOFF.md` so the `9ca5071` 0/0 statement
  is explicitly pre-carry and current `main` is `c13c36e`, one ahead. This is
  deliberately deferred; no security-reviewer write was attempted now.
- **PMR-037:** in `formal-verification-research`, refresh the owner-maintained
  handoff to state that the restored clone tracks the reachable
  `beryllium-project` repository as `origin`. The bibliography-format half
  was carried at `784be93`.

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
- `analysis-workbook` owner commits `4c771c0`, `62ee356`, `a46dba2` and
  carries `8899176`, `0501243`, `b93722b` (`PML-0018..0027`);
- `xrv-research-repo` `706e708` is backed up on `backup/main`; owner commit
  `d618935` is local one ahead, unpushed pending `PMR-039`;
- `formal-verification-research` `c55065c`, `784be93`
  (`PMR-035`, `PMR-037`, `PML-0022`, `PML-0024`);
- `threat-modeler` `f4eb272` (`PMR-031`, stacked after owner commit
  `5bf6a4b`);
- `security-reviewer` `c13c36e` (`PMR-030`, `PMR-031`).

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
