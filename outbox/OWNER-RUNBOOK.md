# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-10-10
**Workspace root:** parent of `project-manager/`; exact current root is
recorded in `../COMPONENTS.md`

The Project Manager does not execute this file's commands, run component
validation, modify carry-ineligible components, or push any repository.
In addition to open `PMR-NNN` rows, this runbook may list Project
Manager-owned non-request coordination items explicitly marked `no PMR`.
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

## Human-run script output

Responsible-human preference, stated exactly on 2026-09-21: `"next time,
script should log the output and you retrieve it"`. Future human-run scripts
must write timestamped output under a Project Manager-owned ignored
`scratch/` path, print the exact log path, and leave retrieval to the Project
Manager instead of asking the human to paste command output. If logging cannot
be made reliable, stop and explain that exception before asking for output.
The current recovery launcher writes its state log and private terminal
transcript under ignored `scratch/owner-recoveries/` and prints both paths.
The transcript may contain sensitive interactive output and is never copied
wholesale into a durable record.
The ordinary owner-session preflight log is the narrow exception to the
print-path convention: its path is intentionally not printed so launcher
stdout/stderr and Copilot arguments remain unchanged. The Project Manager
retrieves the newest component/PMR-matched file directly from fixed ignored
`scratch/owner-sessions/preflight/`; it contains only the documented
fixed-field state, never command output or a transcript.

## P2 User-level governance on `l1` (no PMR)

User-level Copilot configuration is machine-local and was not part of the
`~/src/l1/src` transfer, and the installed hook configuration binds the
absolute workspace root current at install time (`PMD-20261010-001`). The
earlier human-reported install (`"done above"`, below) configured `lx2`, so
the hook state on `l1` is unknown: absent, older, or bound to another root.
First run the read-only check. It edits nothing and is safe while other
sessions run:

```sh
cd /home/jmorris/src/beryllium-project
bash ./project-manager/scripts/beryllium-governance.sh check
```

Then, only after every governed Copilot session is idle
(`PMD-20260930-003`) and after rechecking immediately beforehand that no
other session is running, install from the same root:

```sh
cd /home/jmorris/src/beryllium-project
bash ./project-manager/scripts/beryllium-governance.sh install && bash ./project-manager/scripts/beryllium-governance.sh check
```

`check` and install preflight verify the user-level defaults: `model`
`claude-opus-5.5`, `effortLevel` `max`, and `contextTier` `long_context`, with
`planModel`, `planEffortLevel`, and `planContextTier` unset or equal to those
values. If `install` or `check` reports a mismatch, change only the reported
user setting (for example `/config model claude-opus-5.5`) and rerun the
command. `check` does not inspect `/subagents` defaults; this Project Manager
session on `l1` reports a required `research` default of `gpt-5.6-terra`,
which conflicts with `PMD-20261006-001`, so set that default to
`claude-opus-5.5` as well. The Project Manager never runs this script
against real user configuration. Until the install, pass `claude-opus-5.5` /
`max` / `long_context` explicitly on every task launch.

## P2 Analysis-workbook origin visibility and private branch (no PMR)

The workbook handoff at `353c431` (2026-10-07) states that you directed the
K3 A100 design to a local branch that is not pushed "after the configured
origin was observed public". Project Manager records describe that origin as
private, and the Project Manager performs no network check. Two decisions
are yours:

1. **Visibility.** Confirm the workbook origin's visibility on GitHub. If it
   is public, everything already pushed through `3c9d2a3` may be visible,
   and any later workbook push is a publication step. This bears on the
   push-evidence reconciliation of PMR-085/088/089/095/097.
2. **Branch disposition.** `analysis/k3-a100-service-design-private`
   (`353c431`) is checked out with no upstream; local `main` stays at
   `4cf44d0`. Keep it checked out (recommended until you decide; nothing
   moves), merge it into local `main` without pushing, or switch back to
   `main` with the branch kept aside. Switching away without merging hides
   PMQ-034..036, so `pull-queues.sh check` fails for PML-0035..0037 until
   those rows are back in the checked-out tree.

Tell the next Project Manager turn both answers. It then routes PMQ-034..036
(public metadata pointers; none is a duplicate in the XRV index at
`7361de4`) to the XRV owner, and PMR-124/126 can run on the branch you chose.
No push, publication, or gate follows from either answer.

## P3 PMR-127: Beryllium post-transfer housekeeping

On 2026-10-11 the responsible human reported that the Beryllium session is
done and relayed the owner's request to cite `563cca14`. The Project
Manager then ran the full read-only inspection. `563cca14` ("docs: record the
B7 re-check on l1") is the owner's record of its 2026-10-10 session on `l1`,
and the canonical root was already re-registered by `PMD-20261010-001`. Two
owner-side follow-ups remain, both in `PMR-127`:

1. The Beryllium `planning/HANDOFF.md` Repository state and New-session
   restart sections still name the `lx2` checkout path.
2. Maintained `quiescence` reports all 12 Beryllium linked-worktree
   registrations prunable: five under the old root's `worktrees/be-*`, two
   under the old root's `beryllium-hypervisor/build/.../scratch-diagnosis/`,
   and five under a former `~/.copilot/session-state/` directory that
   likely lives only on `lx2`.

Keep the `lx2` copy, including that `~/.copilot/session-state/` directory,
until the owner reports. Copying that one directory to the same path on
`l1` is optional; it still needs owner repair. Then start one owner session:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-session.sh launch beryllium-hypervisor PMR-127
```

The launcher binds the checked-out `beryllium/k3-b7-bringup`. The owner
updates only those handoff paths, lists the worktrees, runs
`git worktree repair <new-path>...` from the primary checkout only where a
directory exists at its new location, preserves uncommitted content, never
prunes as a fix, commits locally, returns in `planning/HANDOFF.md`, and does
not push. The Project Manager never runs these commands.

The open P3 no-PMR Beryllium B-stage reconciliation is separate: the
component's committed instructions now record responsible-human acceptance
of B0-B7 on the component side, while K3 hardware is `NOT RUN` in Project
Manager records. It is reconciled only from a named responsible-human record;
no gate follows from this runbook.

## P3 CRQ-004 single-model SOP alignment (`PMD-20261006-001`)

The responsible human's `CRQ-004` instruction
(`component://analysis-workbook/outbox/requests/CRQ-004-single-model-low-overhead-sop.md`
at `4cf44d0`) is recorded by `PMD-20261006-001`: every agent, sub-agent, and
task uses `claude-opus-5.5` with reasoning effort `max` and context tier
`long_context`; different-model iterative evaluation reviews, separate scope
reviews, and deep security reviews are not standard practice; and a security
review runs only on explicit responsible-human request, on the same model.
Component agent profiles lie outside the Project Manager's carry classes, so
each alignment below is an owner request performed in an owner session.
The analysis-workbook profiles and the Beryllium instructions are already
aligned, so no Beryllium SOP request is allocated; `PMR-127` is separate
post-transfer housekeeping.

Start an owner session only after the Project Manager commits this turn and
regenerates tasking; the launcher refuses a dirty Project Manager worktree or
stale tasking. `owner-session.sh` accepts an optional
`--agent <component-agent>` but has no model option. The commands below
select no agent: each component's existing profiles still pin a superseded
model, and the ordinary default context performs owner maintenance.

**Model check for every session below.** The session must run on
`claude-opus-5.5` / `max` / `long_context`. As soon as Copilot opens (press
`esc esc` if the first turn has already started), run `/model`. If it shows
another model, effort, or context tier, switch to `claude-opus-5.5` with
`max` effort and the `long_context` tier, check `/subagents` if sub-agent
defaults were customized, and then let the owner continue. Do not let the
owner edit on any other model.

**Direct carry for PMR-121 and PMR-122.** The ordinary `owner-session.sh`
packet requires the owner to run the parent tasking resolver before editing.
Threat-modeler forbids running sibling content until parked P4 `PMR-064`
admits that resolver (the conflict that stopped the first PMR-064/117
launch), and provenance-review limits trusted execution to its own scripts
and read-only inspection until `PMR-066` lands. The Project Manager therefore
uses the existing human-carry path for these two requests: start an ordinary
session directly in the component with the one-line request below. The owner
reads its request row with read-only file tools and runs no parent or
sibling command. This neither adopts tasking startup nor un-parks `PMR-064`.
These two direct ordinary sessions are a recorded exception, under
`PMD-20261006-001`, to the rule that the human receives one exact launcher
command instead of prompt text. They take neither the per-component writer
lock nor the PMR-108 global reservation, and they write no preflight log.
Before starting either session, confirm that the component is clean and that
no other Copilot session, `owner-session.sh`, `owner-recovery.sh`, or
`maintenance-reservation.sh` run is active for that component. If the owner
reports any mismatch, it stops.

### P3 PMR-121: threat-modeler repin

```sh
cd /home/jmorris/src/beryllium-project/threat-modeler
copilot --no-auto-update --yolo -i "Carry Project Manager request PMR-121 under this repository's own rules. Read its row in /home/jmorris/src/beryllium-project/project-manager/outbox/component-requests.md with read-only file tools and run no parent or sibling command. Do only that request, validate with this repository's own tests, commit locally, append the owner return to HANDOFF.md using /home/jmorris/src/beryllium-project/project-manager/templates/owner-return.md, and do not push."
```

The owner repins all six profiles (`threat-modeler`, `threat-modeler-owner`,
`threat-research`, `threat-evidence`, `threat-model-maintainer`, and
`threat-model-review`) to `claude-opus-5.5`. It updates the dispatch pin,
interface, README, owner contract test, and handoff only as directly
required, commits locally, and appends a durable `HANDOFF.md` return. It
does not touch `models/TM-*`, resume paused `TM-20260911-001`, perform parked
`PMR-064` / `PMR-117`, or push. `threat-model-maintainer` also pins
`gpt-5.6-sol`; if you switch to it in the session, repeat the `/model` check.

### P3 PMR-122: provenance-review repin

```sh
cd /home/jmorris/src/beryllium-project/provenance-review
copilot --no-auto-update --yolo -i "Carry Project Manager request PMR-122 under this repository's own rules. Read its row in /home/jmorris/src/beryllium-project/project-manager/outbox/component-requests.md with read-only file tools and run no parent or sibling command. Do only that request, validate with this repository's own tests, commit locally, append the owner return to HANDOFF.md using /home/jmorris/src/beryllium-project/project-manager/templates/owner-return.md, and do not push."
```

Keep open P3 `PMR-066` for a separate later session. The owner repins the
three profiles (`provenance-review`, `provenance-code-lineage`, and
`provenance-research`) to `claude-opus-5.5`, updates instructions, tests,
README, and handoff only as directly required, changes no `reviews/PRV-*`
package, commits locally, returns in `HANDOFF.md`, and does not push.

### P3 PMR-123: security-reviewer repin and Codex-exception retirement

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-session.sh launch security-reviewer PMR-123
```

Do not add `--agent security-reviewer`; that profile pins `gpt-5.3-codex`
until this request lands. To handle open P3 `PMR-118` in the same session,
use `bash ./scripts/owner-session.sh launch security-reviewer PMR-118 PMR-123`
instead; under `PMD-20261006-001`, `PMR-118`'s clause preserving the Codex
pair no longer applies. The owner repins all four profiles, removes the
Codex-exception, `high` / `xhigh` floor, and `claude-fable-5.1` allowance
wording, records that security reviews run only on explicit
responsible-human request, preserves the tasking resolver and every
historical record, starts no engagement, commits locally, returns in
`HANDOFF.md`, and does not push. `PMR-111` stays separate. The hook state on
`l1` is unknown until the P2 governance `check` above, so any
`security-evidence`, `security-research`, or `security-finding-review` task
launch in this session must pass `claude-opus-5.5` / `max` /
`long_context` explicitly.

### P3 PMR-124 and PMR-126: analysis-workbook CRQ-004 and CRQ-003 mirrors

First settle the branch decision in "P2 Analysis-workbook origin visibility
and private branch" above: the launcher binds whatever branch is checked out
as the expected branch, so the owner would otherwise commit on the private
design branch. Then use exactly one of two paths for each request, never
both. A later Project Manager coordination turn may dispatch the hidden
`analysis-workbook-owner`, already pinned to `claude-opus-5.5` / `max` /
`long_context`, under `PMD-20260917-002` after its readiness,
current-tasking, clean-state, and one-writer checks; that path needs no
human command. Otherwise run:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-session.sh launch analysis-workbook PMR-124 PMR-126
```

The owner mirrors `CRQ-004` to `routed`, citing `PMD-20261006-001` and
`PMR-121..PMR-123`, and `CRQ-003` to `routed`, citing `PMR-125`; appends one
activity-log row per mirror; changes no other row; commits locally; returns
in `HANDOFF.md`; and does not push.

## Human-reported completed user-level governance reinstall (no PMR)

On 2026-10-01 the responsible human stated exactly `"there is no other
running session"` and later reported the exact command below completed with
the reply `"done above"`:

```sh
bash ./project-manager/scripts/beryllium-governance.sh install &&
bash ./project-manager/scripts/beryllium-governance.sh check
```

This is responsible-human evidence only. The Project Manager did not run the
command against real user configuration, inspect its output, establish
install-time session state, or independently verify the resulting files.
That report concerns the user configuration on `lx2` and does not carry to
`l1` (`PMD-20261010-001`).
The report changes no component, PMR, acceptance, review approval, risk
acceptance, publication, release, or assurance gate. Agent/skill reread
behavior in already-running sessions remains unknown.

## No-PMR workspace housekeeping

### Completed workspace worktree container

The responsible human directed that the growing set of linked worktrees stop
accumulating at the workspace top level. Workspace-root `worktrees/` now
exists as the ignored shared container for linked worktrees across project
repositories, using:

```text
worktrees/<repository>/<purpose-or-branch>
```

The responsible human manually moved six Beryllium linked worktrees into
temporary flat paths under the container and then ran `git worktree repair`.
Human-supplied `git worktree list --porcelain` output records the repaired
paths and tips; the exact root-relative inventory is in `../../COMPONENTS.md`.
The Project Manager did not move or repair a worktree and infers no owner
coordination, cleanliness, idleness, validation, acceptance, or publication
gate from the relocation.
Before repair, the move was accidentally staged in the parent as six
mode-`160000` gitlinks. The responsible human ran `git reset --hard`; the
parent remained at `7584292`, the staged entries were removed, and no gitlink
is tracked. This records a boundary near-miss, not authority to repeat the
operation.

### P3 worktree namespacing follow-up

The Beryllium paths repaired on `lx2` are flat under `worktrees/` and do not
yet follow `worktrees/<repository>/<purpose-or-branch>`. They were usable
temporary placements on `lx2`; after the 2026-10-10 transfer their
registrations are prunable, and repair is owner request `PMR-127`. Any later rename uses Beryllium-owner `git worktree move` after
fresh tasking, worktree, and one-writer checks. The Project Manager never
moves, removes, repairs, prunes, or judges these worktrees obsolete.
Additional registered Beryllium worktrees still exist at the workspace top
level. A later owner inventory decides whether to leave or move them; this
turn does not list, classify, or touch them. Any namespacing follows the
post-transfer repair in "P3 PMR-127" above.

## Completed PMR-108: global startup status and quiescence gate

`../SOT.md` is the existing global topology/status anchor. It now records the
2026-10-10 return to the usual `l1` workstation, the canonical root
`~/src/beryllium-project`, and the noncanonical former `lx2` copy under
`~/src/l1/src` (`PMD-20261010-001`).

Do not rerun the rollout. The responsible human stated exactly `"I confirm
no other session is running."` inside the held reservation. Both the initial
and immediate pre-write quiescence checks passed every automated row; manual
handoff/runtime review found no current owner session. The tasking generator
now binds `workspace://SOT.md` by SHA-256 and fails closed if the anchor is
absent, symlinked, or changed.

No child repository changed in the Project Manager rollout. Beryllium
PMR-112 has since completed locally at work `2313cbe0`, return `55b568b4`,
and checkpoint `93819fd9`. Remaining owner adoption is separate: `PMR-113`
Helium, `PMR-116` OS-security, `PMR-117` threat-modeler, and `PMR-118`
security-reviewer remain owner-owned. CHERI notes PMR-114 and XRV PMR-115
have also completed locally. Project Manager, analysis-workbook,
formal-verification-research, and provenance-review already read the SOT
anchor. PMR-108 is closed; PMR-098/100 returns are now acknowledged, while
the remaining child requests and every human gate remain independent.

## P3 PMR-111: security-reviewer private backup

PMR-109 and PMR-110 are closed as acknowledgements of owner work
`2bb4c989bbe9b57f870e6f653ed3732e742b11f9` and HANDOFF-only return
`c2edac70afdfe5b0bb90e237487cd168fb91e900`. The responsible human replied
exactly `"done"` after being directed to review the return and exit the
existing security-reviewer owner session, releasing only that component's
session/reservation. The two commits remain local and unpushed; no engagement
ran.

PMR-111 is a separate backup-only request. Before any push, require a new
exact same-turn responsible-human confirmation, clean idle `main` at
`c2edac70`, and live private `origin/main` still at
`2e8d2054840af35ba6d64a00546ee99806a88dfb`. Then the responsible human may
run the maintained helper from the workspace root:

```sh
bash ./project-manager/scripts/owner-actions.sh --only push_sr
```

The Project Manager never runs this command. The human retrieves the
timestamped helper log from `project-manager/scratch/owner-actions/`; closure
requires exact remote containment and final clean branch state. No force,
tag, remote mutation, engagement, review approval, risk acceptance,
publication, release, or other gate is combined.

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
`PMD-20261002-002` now makes one threat-modeler-only exception after repeated
human owner lifecycle cost and the responsible human's
`"resume_hidden_owner_rollout"` selection. Every other component remains
deferred.

The ordinary Beryllium PMR-067/083 owner session completed and released its
historical lock at `416b2e9`; both requests remain closed. The later
thirteen-commit owner series and distinct fourteen-commit KVM0 series now
have canonical PMR-098/100 return `1f38e699` and released-session checkpoint
`4c6acbed`; this does not reopen the completed process-expansion workstream.
All six exact analysis-workbook
housekeeping requests are complete through PMR-063 return `8b5a301`. The
repository/PM housekeeping workstream is operationally complete. Stop process
expansion. Research, source admission, external dependencies, backup/push
gates, and opportunistic configuration remain visible but do not block
development.

## Repository reorganization complete

Do not rerun the former P1 migration lanes. The Project Manager verified and
closed all three requests:

| Request | Active private successor | Verified owner return | Remaining non-blocking item |
| --- | --- | --- | --- |
| `PMR-044` | `agentic-os-research/os-security-research` | `49fbfd6` | Personal quarantine exists empty; any restricted-file review/copy remains human-only |
| `PMR-045` | `agentic-os-research/cheri-hypervisor-research` | `456c70b` | Backup follow-ups `PMR-075`, `PMR-092`, and `PMR-094` are closed from synchronized private `60d5ceb` |
| `PMR-046` | `agentic-os-research/cheri-riscv-notes` | `9a4c5ef` | Private hosted Wiki unavailable; complete history is preserved at `archive/gim-wiki` |

All three successors are private and active as `origin`; old homes remain
inactive references. At that closure checkpoint no tracked workspace symlink
had moved; on 2026-09-22 the responsible human renamed and retargeted the
CHERI notes and XRV links to the verified successors. Publication, licensing,
redistribution, release, and assurance gates are unchanged.

## CRQ-002 successor-first sequence

`PMD-20260915-004` records the responsible human's `successor-first`
selection. It is sequencing only and authorizes no repository or source
operation.

| Order | Priority | Request | Required result |
| --- | --- | --- | --- |
| Done | - | `PMR-027` | OS-security is clean and synchronized at `e275544`. |
| Done | - | `PMR-044`, `PMR-045` | Private OS-security and XRV successors are verified; old homes remain inactive references. |
| Blocked | P4 | `PMR-052` | Wait for the cap-talk archive owners' response; only then may OS-security identify and inspect, or precisely bound as inaccessible, the public continuation from the `2016-04-01` start bound. Independent synchronized backlog integration `86645d4` does not execute this request. |
| 2 | P3 | `PMR-053` | XRV reviews only materially relevant returned threads through its owner intake lifecycle. |
| 3 | P3 | `PMR-054` | Analysis-workbook adds the revision-bound follow-up inquiry and states whether Q-001 through Q-004 change. |

Independent workbook housekeeping `PMR-055` is complete at work `70bea16` /
return `6d5d03d`: CRQ-002 is `routed`, the packet names current `OPEN-003`,
and superseded `OPEN-001` is marked consistently.

`PMR-046` is also complete and was not a prerequisite for `CRQ-002`.

Under `PMD-20260917-001`, the generated owner-session packet automatically
carries the `cross-repo-collaboration` trigger, source-ledger budget rule, and
completed-use return path for PMR-052/053/054. Do not ask the human to paste a
second prompt.

## Beryllium drift reconciliation and new planning

On 2026-10-06T16:03Z maintained inspection observed clean
`beryllium/k3-b3-bringup` at `afa4336`, behind 0 / ahead 1 of last-fetched
`origin/beryllium/k3-b3-bringup` `6358ed2`, with a human session the
responsible human reports active; the Project Manager infers nothing from
the branch name. The last recorded (104th-turn) state was clean
active/default `beryllium/single-hart-runtime-r0` at documentation-only
PMR-077 return `a8e137e`, behind 0 / ahead 6 of last-fetched private
`origin` `4141cf6`. Maintained refs inspection at 2026-10-06T18:16Z shows
that local branch now at `f213555`, behind 0 / ahead 22 of
`origin/beryllium/single-hart-runtime-r0` `4141cf6`. As of the last fetch,
which is not a live remote check, `f213555`, PMR-077 return `a8e137e`,
PMR-112 work `2313cbe0`, return `55b568b4`, and checkpoint `93819fd9`, and
PMR-098/100 return `1f38e699` and checkpoint `4c6acbed` are all contained
in remote-tracking `origin/beryllium/k3-b0-bringup`, `k3-b1-bringup`,
`k3-b2-bringup`, and `k3-b3-bringup`; `afa4336` is on no remote-tracking
branch. That containment grants no push, publication, or gate.
PMR-077 is closed as acknowledgement by `PMD-20261004-001`; the return
selects no H0 input and grants no successor or hardware authority. PMR-112
work `2313cbe0`, return `55b568b4`, and checkpoint `93819fd9` adopt
SOT-first startup. Canonical
return `1f38e699` covers the distinct thirteen-commit PMR-098 range
`416b2e9..80345e1` and fourteen-commit PMR-100 KVM0 range
`80345e1..2b404ca`; checkpoint `4c6acbed` releases the owner session. Both
commits change owner-stated `planning/HANDOFF.md`.
Maintained refs resolve every named commit/subject. The K0-S source target
`c1c7e254` is absent from Beryllium and remains owner-stated sibling
containment evidence. `PMD-20260926-002` still limits plan-only PMR-099 to
exact K0-A target `5227266` and K0-P. Any later writer requires fresh
tasking, worktree, and one-writer checks. Do not infer current-package
readiness, import, execution, backup approval, publication, or any assurance
gate.

The responsible human selected `defer` when asked whether the Project Manager
should confirm, reject, or defer the component acceptance claim.
`PMD-20260925-001` therefore keeps the Project Manager boundary unchanged:
Beryllium is accepted through R7; R8-H0 is a committed candidate and is not
accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN` in Project
Manager records.

**PMR-098 and PMR-100 are closed as acknowledgements of the canonical
return.** Do not rerun the combined owner session. The closures grant no
implementation, acceptance, execution, push, publication, or other gate.
K0-S source preparation/evidence import, K0-X native execution, K0-R result
acceptance, B0, development-kernel/BSP selection, B1, an H0 successor,
retained R8 progression, publication, and release remain separate blocked
gates.

## Closed PMR-105: private CHERI topic backup

Two human `--plan` attempts at `2026-09-29T01:11:12Z` and
`2026-09-29T01:11:22Z` stopped before tasking, component, GitHub, or remote
access because the prepared script incorrectly required the readable tasking
helper to be executable. The Project Manager corrected and revalidated that
local precondition; all push and confirmation gates remain open.

The corrected human `--plan` completed at `2026-09-29T01:31:02Z`. Ignored log
`scratch/owner-actions/pmr105-push-20260929T013100Z.log` verifies active
account `xjamesmorris`, private target
`agentic-os-research/cheri-riscv-notes`, `ADMIN` permission, shared lock,
clean exact topic, remote `9a4c5ef`, local `34a8b50`, three heads, zero tags,
and no remote write. Independent local inspection agrees. The responsible
human was unavailable for the exact authorize/defer question at that
checkpoint. The responsible human later stated exactly
`"authorize PMR-105 exact private fast-forward"`. This is a single-use
authorization for the exact verified account/repository/ref/tips only.

The human-run execute completed at `2026-09-29T06:30:54Z`. Ignored log
`scratch/owner-actions/pmr105-push-20260929T063042Z.log` records exact
private fast-forward `9a4c5ef -> 34a8b50`,
`other-refs-preserved=yes`, three heads, zero tags, and final
`behind=0 ahead=0 clean=yes`. Independent maintained inspection confirms the
clean local and `origin` topic refs at exact `34a8b50`. `PMD-20260929-002`
closes PMR-105, and the single-use authorization is consumed.

PMR-101 returned durably as `blocked` at handoff-only commit `c6606ff`.
Maintained validation passed; the recovery reservation is released; no remote
operation occurred; and the exact thirteen content paths remain dirty with
tracked-diff SHA-256
`6736270acf9ef1f908718679884d3e5b83699526debdafcbac9c33e48677422d`.
`PMD-20260926-005` closes PMR-101 as acknowledgement without approving D4.

The responsible human selected D4 `defer` for that fingerprint and separately
authorized exactly two `meta/status.md` proposal corrections. PMR-102 is
superseded. PMR-103 completed at handoff-only return `b203181`: both
authorized corrections are present, all thirteen paths remain unstaged,
maintained validation passed, no remote operation occurred, and the
reservation is released. The revised tracked-diff SHA-256 is
`8bfec6744d26ba96e3e6c8e6eb3611c9caa1d38f4d6cdabb2bdaccc2a47010ca`.

`PMD-20260927-003` closes PMR-103 as acknowledgement. The responsible human
later selected `approve_exact`; `PMD-20260927-004` binds that D4 authority
only to the exact revised fingerprint. PMR-104 completed: owner work
`41e4125` integrates exactly the thirteen approved paths, handoff-only return
`4deec95` records maintained validation, and the human-run wrapper exited 0
with clean post-status and released reservation.

`PMD-20260927-005` closes PMR-104 as acknowledgement. Class-3 PMR-106 carry
`34a8b50` refreshes only the handoff date and next action. PMR-105 then
privately backed up that complete topic range. The consumed exact
confirmation was:

```text
agentic-os-research/cheri-riscv-notes
origin/docs/reconcile-project-status: 9a4c5ef -> 34a8b50
```

That single-use PMR-105 fast-forward is complete and no longer authorized for
reuse. Force, tags, remote mutation, merge to `main`, Pages, publication,
visibility change, D5, redistribution, sibling writes, and every other push
remain excluded.

`PMD-20260928-001` selected the dedicated human-run mechanism;
`PMD-20260929-001` recorded authorization; and `PMD-20260929-002` records
verified completion. Do not rerun `outbox/pmr105-push.sh`.

## P3 PMR-107: OS-security pointer triage

The synchronized analysis-workbook added three public-source pointers from
`AWB-20260928-001`, now ledgered as `PML-0032..0034`: Sirius, the *Secure
Programming with Dispersed Compartments* thesis, and Deluminator. Read-only
search found no matching public-index entry in synchronized OS-security
`86645d4`.

This component is ask-first. Before any owner write, the responsible human
must approve starting the OS-security owner session. The exact prepared
request is run from the workspace root:

```sh
bash ./project-manager/scripts/owner-session.sh launch osr-claude PMR-107
```

The owner may record public metadata/lawful routes, report an existing
record, or decline each pointer. It must not access
`sources/restricted-microsoft/`, copy full text, decide redistribution,
publish, or turn pointer triage into an architecture or assurance gate.

## Project-wide tasking and SOT startup adoption

`PMD-20260915-008` requires every registered owner context to map
`check Project Manager tasking` to:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

The command must be run from the registered logical workspace entry. If it
cannot be found or fails validation, stop and ask the human to relaunch from
that entry. Never search session history, task/todo databases, background
agents, prior chat, or memory for a fallback PMR.

PMR-108 additionally requires the owner context to read current
`workspace://SOT.md` before resolving component paths or beginning work. The
generated view and dispatch packet carry its SHA-256; missing, symlinked, or
changed status fails closed until Project Manager regeneration.

If a Project Manager turn is still changing `outbox/component-requests.md`,
wait for its commit and regenerated views before starting an owner session.
For tracked symlinks, record `pwd` and `pwd -P`; if logical `PWD` is not
preserved, stop and use the `PM_TASKING_ROOT` / `PM_TASKING_WORKSPACE`
fallback documented by `PMD-20260915-008`.

The selected PMR-009/051/071 and PMR-058/072 batches are complete and
verified; do not rerun them. Future ordinary owner work uses the same
one-command launcher and preloaded packet; never ask the human to paste a
prompt.

The first PMR-064/117 launch exited with threat-modeler clean and unchanged at
`c4126b6`, no durable return, and a released writer lock. No transcript was
persisted. Current policy exposes a deterministic bootstrap conflict: the
ordinary packet requires the parent resolver before editing, while the
pre-PMR-064 maintainer may execute repository-local commands only. The exact
one-time launcher mode below relies on the launcher's already validated,
embedded tasking and does not execute that not-yet-authorized sibling command.
It is not usable for another component or request.

The first bootstrap retry also left threat-modeler unchanged and produced no
new packet, proving another failure occurred before packet finalization but
not identifying its exact check. The launcher now writes one sanitized
fixed-field state log for every syntactically valid attempt under ignored
`scratch/owner-sessions/preflight/`; it records only the current stage,
terminal result, and validated identifiers. It captures no command output or
Copilot transcript. After the next retry, the Project Manager reads that log
directly rather than asking the human to relay terminal output.

The next retry reached Copilot successfully; its preflight log records
`stage=complete`, `result=launching`, and `reason=none`. The owner then
stopped because it could not invoke a scope-review task runner and did not
find `cross-repo-collaboration`. The corrected `-05` packet was prepared but
not launched; do not count it as another failure or run it now.

The responsible human selected a resumed hidden-owner rollout instead.
`PMD-20261002-002` and P2 `PMR-120` stage only a maintenance-only
`threat-modeler-owner`. The former PMR-064/117 bootstrap is retired and fails
closed. Scope steering `resume-threat-owner-rollout-20261002-06` reviewed the
plan against source request blob `9c289ab...`; the Project Manager applied its
required changes and bound exact PMR-120 through applied request blob
`7508420...`, unchanged SOT SHA, and component HEAD `c4126b6`. The binding
was mechanically refreshed after PMR-119 closure and exact P3 blocker notes;
the PMR-120 row and component envelope did not change.

PMR-120 changes only the six paths named in its row. It adds no
`ask_user`, delegation, web, threat-modeling skill, package scaffold,
threat-material discovery, PMR-064/117 work, model/queue/outbox change, push,
or gate. The existing user-facing profiles stay unchanged beyond hidden-owner
registration. Static registration is not native discovery proof. Work `ca8fa3c` and return
`bbbc534` now install the candidate and the responsible human released the
session, but `PMD-20261003-001` records a blocking response-contract gap:
the delivered profile uses `COMPLETE/PARTIAL/BLOCKED` rather than the
established V1 state and field set. PMR-120 remains open.
`PMD-20261003-002` selects standard V1 and re-arms one exact correction
binding. Do not rerun the original packet, allocate the handshake, or
dispatch PMR-064/117 before the corrected return and release.
The re-armed correction binds review
`threat-owner-standard-v1-correction-20261003-09`, reviewed source request
blob `0d7e84201e160c94080055fec121ff2dbf5540a8`, applied request blob
`b6160d3130163ede106141c8cb9494222e16186d`, unchanged SOT SHA-256
`5ccaf1d8a7f4a11a5169595a7744d36b99d6641c6d99cc24f1215aeefe4c1a68`,
and threat-modeler baseline
`bbbc5349943c3a7d64ced24f19f90d6e0c50ea06`.

Corrected work `71bca3f` / return `e6aed9f` now completes PMR-120 and the
responsible human stated exactly `"above done"`. `PMD-20261003-003` records
the profile adopted but not native-handshaken or PM-invocable. Both
tasking-bootstrap bindings are consumed. No handshake is allocated, and
PMR-064/117 are parked P4 under the exact return-to-hypervisor priority.

The one-hundredth-turn fleet triage changed no owner boundary. PMR-066 and
PMR-118 still require human-started owner sessions because those components
have no adopted hidden owner. PMR-070/116 additionally retain OS-security's
specific ask-first convention; the broad fleet direction is not that consent.
PMR-107 remains an ask-first owner source decision and is not a class-2
Project Manager carry. Generic fleet agents cannot run any of these writes.

| Request | Priority | One-command owner invocation | Packet boundary |
| --- | --- | --- | --- |
| `PMR-064`, `PMR-117` | P4 | **Parked — do not launch.** | PMR-120 adoption is closed. Resume only after explicit later direction and a separately allocated/closed native no-write handshake. |
| `PMR-066` | P3 | `bash ./project-manager/scripts/owner-session.sh launch provenance-review PMR-066` | Packet preloaded for ordinary configuration maintenance. |
| `PMR-068`, `PMR-113` | P4 | `bash ./project-manager/scripts/owner-session.sh launch helium-te-poc PMR-068 PMR-113` | Parked; preserve frozen refs and gates. |
| `PMR-070`, `PMR-116` | P3 | `bash ./project-manager/scripts/owner-session.sh launch osr-claude PMR-070 PMR-116`; answer the component's ask-first gate before writing | Packet preloaded; never open `restricted-microsoft`. |
| `PMR-107` | P3 | `bash ./project-manager/scripts/owner-session.sh launch osr-claude PMR-107`, only after you approve the ask-first OS-security session (see "P3 PMR-107" above) | OS-security owner must decide the three public pointers under its own source/redistribution rules. Do not combine with PMR-070/116 or treat this as class-2 carry. |
| `PMR-118` | P3 | `bash ./project-manager/scripts/owner-session.sh launch security-reviewer PMR-118 PMR-123` | `PMR-118` is startup policy only, with no engagement, push, or gate; it shares this session with the `PMR-123` repin in the CRQ-004 section. Do not add `--agent`: the `security-reviewer` profile still pins `gpt-5.3-codex` until `PMR-123` lands. Under `PMD-20261006-001` its Codex-preservation clause no longer applies. |

Do not paste a follow-up phrase. Every ordinary generated packet includes exact
PM/request/SOT fingerprints, selected PMR text, local instruction checklist,
one-writer rule, validation/commit/return contract, and no-gate/no-push
boundary. Ordinary packets require the exact resolver. The consumed PMR-120
bootstrap compared the generated view read-only; request-note drift now makes
that old packet binding fail closed.

## Completed - do not rerun

`PMR-120` is closed at initial work/return `ca8fa3c` / `bbbc534` and
standard-V1 correction work/return `71bca3f` / `e6aed9f`. The focused owner
suite reports 148/0 and diff check passed; full package-reading suite and
index check are unknown. Clean local `main` is 0 behind / 4 ahead, all four
commits are local-only, and no push, model/package action, or gate occurred.
Both human bootstrap bindings are consumed; do not rerun either.

`PMR-119` is closed at Project Manager class-3 carry
`7f671548a18bc426133b5b2102fa83a70cb3f9bc`. It changes only
`meta/handoff.md`'s opening date and `Exact next action`, following PMR-106
precedent. No component command, owner session, push, corpus, D4/D5, merge,
Pages, publication, or gate change occurred. Do not launch the former
PMR-119 owner command.

`PMR-112` is closed from exact owner work `2313cbe0`, owner return
`55b568b4`, and released-session checkpoint `93819fd9`. The owner reports
SOT-first startup, current-path correction, bounded tasking-contract
validation, and no implementation or gate change. All three commits are
untagged; as of the last fetch they are contained in remote-tracking
`origin/beryllium/k3-b0-bringup` through `k3-b3-bringup`, which grants no
push, publication, or gate. Do not rerun its
launcher.

`PMR-098` and `PMR-100` are closed from exact canonical return `1f38e699`
and released-session checkpoint `4c6acbed`. The return keeps the
thirteen-commit H0/current-line range separate from the fourteen-commit KVM0
range, records bounded validation/ref/publication evidence, and performs no
new implementation, fetch, push, tag, remote change, publication, or gate.
As of the last fetch both return commits are contained in the same
remote-tracking k3 branches. Do not rerun their combined launcher.

`PMR-040` is closed at qualified selective incorporation work `38a69bd` and
HANDOFF-only return `d5d33a2`. The owner recorded source-aware
`REV-20260922-001`, incorporated only proposed immutable mutation-record and
cross-layer assurance refinements, corrected rollback wording, and deferred
the Helium parity plan. No target, comparator baseline, implementation,
approval, publication, backup, or formal-verification gate follows.
Backup-only PMR-092 later closes from synchronized private `60d5ceb`.

`PMR-051` and `PMR-071` are closed through final CHERI notes return
`6ac70af`; PMR-009 was untouched. `PMR-058` and `PMR-072` are closed through
corrected XRV return `07e86ab`; analysis-workbook carry `5a646df` mirrors the
three accepted pointer statuses. PMR-094 later closes from synchronized
private `60d5ceb`; PMR-093 is withdrawn and PMR-095 retains the separate
analysis-workbook backup range.

`PMR-114` is closed as acknowledgement of owner work
`8d1bc9db8ea1ab6a832c27dbec882f5a8b1ecefd` and handoff-only return
`7fb49f40a6399000199de96d97b84f98f378eace`. The owner reports changes only
to `.github/copilot-instructions.md`, `automation/validate-project-tasking.mjs`,
and `meta/handoff.md`; maintained tasking and corpus validation, 35/35
negative mutations, non-publishing wiki build, and diff checks passed.
At PMR-114 closure, maintained inspection confirmed the return as clean local
`docs/reconcile-project-status`, 0 behind / 2 ahead of last-fetched private
`origin` `34a8b50`, with no writer reservation. Later class-3 PMR-119 carry
`7f67154` is now the clean tip at 0 behind / 3 ahead. The PMR-114 work/return
and PMR-119 carry are not backed up remotely; no fetch, push, merge, or
publication occurred.
D4/D5, Pages, and all corpus/release gates are unchanged.

`PMR-115` is closed as acknowledgement of the single XRV owner work/return
commit `7361de4138ad733be46e8a72608a779d24ae488a`. The owner reports only
`.github/copilot-instructions.md` and `HANDOFF.md` changed, current SOT and
PM/request fingerprints matched, exact changed paths and startup wording were
reviewed, and `git diff --check` passed; no build, test, or lint toolchain is
configured. Maintained inspection confirms clean local `main`, exact parent
`5e7387a`, and 0 behind / 1 ahead of last-fetched private `origin/main`.
No fetch, push, remote, research, review-ID, source-intake, collaboration,
publication, or gate change occurred, and the owner writer lock is released.
PMR-053 and every other request remain unchanged.

`PMR-009` is now also closed at owner work `e95922f` / return `6cb15e3` after
separate explicit D4 approvals. Analysis-workbook carry `8da398d` mirrors
PML-0008/0011. PMR-096 is withdrawn and PMR-097 keeps the later analysis
carry backup separate; D5 licensing, redistribution, publication, Pages,
merge, and push gates remain open.

`PMR-067` and `PMR-083` are closed at their final owner return correction
`416b2e9`, following tasking implementation `9b726c1`, structured return
`32300c1`, section-boundary/Chromium remediation `b5bd8cc`, and fence-parser
hardening `364552c`. The responsible human's `"all ready"`, given in direct
response to the Project Manager's Beryllium owner-session release request,
releases that historical `active_session: self` lock. Do not treat this
closed range as the return for later `416b2e9..80345e1`; PMR-098 later
closed that distinct reconciliation at return `1f38e699` / checkpoint
`4c6acbed`.

The exact resolver startup mapping, fence-aware validation, and explicit
Chromium documentation gates passed. Full `make check` stops first on
unchanged R3 Node executable digest drift, not a PMR-067 semantic failure.
For Project Manager purposes R8-C remains plan-only and R8-H0 remains
committed but unaccepted under `PMD-20260925-001`; candidate `6e93461`
remains local, H1-H4 remain unauthorized, and K3 remains `NOT RUN`. No push
occurred in the closed PMR-067/083 session.

Analysis PMR-004 and PMR-050 are also complete. Hidden
`analysis-workbook-owner` added only `project-manager` at work `5684317` /
return `635719e`, then only `security-reviewer` at work `231cca4` / return
`692caeb`. It then completed exact PMR-055 coordination housekeeping at work
`70bea16` / return `6d5d03d`, followed by the HANDOFF-only PMR-059 refresh
at work `9d76048` / return `e6c8aad`. Final PMR-063 work `62bd071` / return
`8b5a301` activates the fail-closed startup resolver and expands the suite to
410 / 0. All returns record clean local state, no push, and no combined PMR.

## Deferred and non-blocking work

- **P3 PMR-085:** synchronized analysis-workbook `origin/main` at `3c9d2a3`
  contains the exact predecessor range through `ea72522`. Reconcile who
  reviewed and authorized the encompassing push before closure. No force,
  publication, analysis disposition, or handshake authority follows.
- **P3 PMR-088:** synchronized `3c9d2a3` contains PMR-086 work `efbfdb8` and
  durable return `858a73b`. After `PMR-085`'s push evidence is independently
  reconciled, review the exact range with
  `git -C ../analysis-workbook diff ea72522..858a73b -- tests/validate-agent.sh HANDOFF.md`
  from `project-manager/`.
  This request was not dispatched or combined with PMR-086; no queue change,
  analysis disposition, publication, or gate follows.
- **P4 PMR-089:** synchronized `3c9d2a3` contains the frozen twelve-commit
  closure range `858a73b..8b5a301`. Do not close it until `PMR-085` plus
  `PMR-088` push evidence is independently reconciled. The request covers only that
  exact six-request housekeeping range,
  beginning with HANDOFF-only commits `f7079fb` and `5e037b1`, followed by
  PMR-004 work `5684317` / return `635719e` and PMR-050 work `231cca4` /
  return `692caeb`, PMR-055 work `70bea16` / return `6d5d03d`, then PMR-059
  work `9d76048` / return `e6c8aad`, and PMR-063 work `62bd071` / return
  `8b5a301`. The range is frozen; the request remains undispatched and blocked
  by PMR-085/088 plus private access. No force, tag, analysis/source change,
  publication, or gate is included.
- **P3 PMR-090:** 2026-10-11 maintained inspection: active/default
  `beryllium/single-hart-runtime-r0` is 0/0 at `3bc3ef0` with last-fetched
  `origin`, and the return/checkpoint commits named below are remotely
  contained; candidates `6e93461` / `0d53120` still have no remote-tracking
  containment. Earlier, in the last recorded (104th-turn) state, active/default
  Beryllium was clean at documentation-only return `a8e137e`, behind 0 /
  ahead 6 of last-fetched private `origin/beryllium/single-hart-runtime-r0`
  `4141cf6`. Maintained refs inspection at 2026-10-06T18:16Z shows that
  local branch at `f213555`, behind 0 / ahead 22. As of the last fetch,
  local candidate `beryllium/r8-h0-pmr-080` at `6e93461` and local R8-C/H0
  branch tip `0d53120` are still on no remote-tracking branch and remain
  unbacked.
  The 2026-10-06 observation (clean `beryllium/k3-b3-bringup` at `afa4336`,
  0 / 1, with a responsible-human-reported active session) is under
  "Beryllium drift reconciliation and new planning" above. Canonical
  PMR-098/100 return `1f38e699` / checkpoint `4c6acbed` and PMR-112
  work/return/checkpoint `2313cbe0` / `55b568b4` / `93819fd9`, plus later
  PMR-077 return `a8e137e`, close the prior evidence, startup, and readiness
  dependencies. As of the last fetch, these six commits are remotely
  contained via remote-tracking `origin/beryllium/k3-b0-bringup` through
  `k3-b3-bringup`. They remain outside PMR-090's fixed scope, and that
  containment changes no PMR-090 candidate, ref, push, or publication
  decision. The owner
  reports authenticated current GitHub visibility `PRIVATE`; the Project
  Manager performed no network check. Keep PMR-090 open for exact review of
  its fixed active/candidate scope and a new separate human push/publication
  decision. Never push inactive `msft-downstream`; no observed or future push
  accepts H0, authorizes H1-H4/K3, or grants publication approval.
  The component handoff additionally states that local branch
  `beryllium/doc-repro-option-a-20260929` is unpushed and not integrated,
  that `archive/generated-docs-2026-09-30` points to `d4c5ff0`, and that
  K0-S target `c6570558` is contained by last-fetched Beryllium refs; source
  target `c1c7e254` is absent from Beryllium and remains owner-stated sibling
  evidence. These facts do not expand PMR-090's exact push scope or establish
  authority, readiness, acceptance, publication, or backup approval.
- **Closed PMR-091:** human-run maintained `outbox/pmr091-push.sh`
  fast-forwarded only private `for-review` from `1ab289c` to `f928aac`.
  Script evidence reports `other-refs-preserved=yes`, 23 heads / zero tags,
  and restored active account `xjamesmorris`; independent read-only inspection
  confirms clean local `for-review` synchronized 0/0 with
  `origin/for-review` at `f928aac`. No creation, force, remote change, tag, or
  other branch push occurred, and no review, acceptance, approval,
  publication, release, formal-verification, or hardware-validation status
  follows.
- **P4 PMR-076:** parked by `PMD-20260918-003`. If explicitly resumed later,
  locate the responsible human's `kcopilotd` project, then
  design a Project Manager-owned OSS alignment skill/agent that maintains
  revision-bound comparisons with upstream and peer projects across LLM
  policy, development workflow, licensing/redistribution, governance/release,
  automation/CI, and contribution practices. Preserve fact/inference/proposal/
  unknown labels; do not write peer repositories or infer human gates.
- **Closed PMR-075/092/094:** component `HANDOFF.md` at owner tip `60d5ceb`
  records a responsible-human-authorized private `origin/main` fast-forward
  containing all nine predecessor commits after `d618935` plus a separate
  current research-review change set. Maintained inspection confirms clean
  synchronized 0/0 `main`. The three exact backup ranges are therefore
  closed independently; the broader research review remains owner evidence
  and grants no Project Manager source disposition or publication gate.
- **Withdrawn PMR-093/096:** `PMD-20260926-003` removes the two backup rows
  from current CHERI resolution so no human row selection was needed. Their
  exact historical ranges remain evidence. PMR-101 returned blocked and
  PMR-102 is superseded. That later backup allocation is now complete:
  PMR-105 covers clean topic range `9a4c5ef..34a8b50`.
- **P4 PMR-095:** synchronized `3c9d2a3` contains analysis-workbook carry
  `5a646df` (`8b5a301..5a646df`); close only after predecessor push
  dispositions are reconciled.
- **P4 PMR-097:** synchronized `3c9d2a3` contains analysis-workbook carry
  `8da398d` (`5a646df..8da398d`); close only after PMR-095's disposition is
  reconciled.
- **Withdrawn PMR-073:** `PMD-20260918-003` records that the proven owner-worker path
  supplies the bounded need and no current request requires a separate
  Git-maintainer specialist.

- **Closed PMR-014/037/041/069:** synchronized formal-verification refresh
  `388690d` contains research `62cc207`, owner controls `9109345`, all routed
  pointer dispositions, current topology/remote wording, and the exact
  fail-closed tasking resolver. The owner reports 48 URL checks and no sibling
  write. Pointer removal or admission changes no licensing, verification,
  Beryllium, or publication gate.
- **P3 PMR-107:** after the responsible human satisfies OS-security's
  ask-first convention, triage only PMQ-031..033 under the public-source
  rules; never access restricted material.
- **P4 PMR-125:** Project Manager-owned `CRQ-003` todo to investigate RVV
  use in the Beryllium hypervisor. The 2026-10-10 Beryllium hold ended on
  2026-10-11; the todo stays parked until you want the investigation
  scheduled. Then tell the Project Manager, which selects the investigating
  owner and allocates distinct owner requests. Private workbook package
  `AWB-20261007-001` may be relevant input but is not adopted. No human step
  is due now.

## Push the completed coordination carries

The responsible human selected exact scope `"both"` for Project Manager
`165b15b -> origin/main` and parent `72a6c42 -> upstream/main`. Human-run
`scripts/owner-actions.sh --only push_pm` completed both normal
fast-forwards; `scratch/owner-actions/owner-actions-20260922T060342Z.log`
records exact `ls-remote` verification. Independent inspection reports both
clean branches synchronized 0/0. That prior authorization is consumed.

The responsible human's `"update project and push"` direction for the
CHERI/XRV consolidation is complete and consumed. Human-run
`scripts/owner-actions.sh --only push_pm` fast-forwarded Project Manager
`165b15b..74220dc` and parent `72a6c42..560a921`; helper live-tip checks and
independent inspection confirm both synchronized 0/0. It did not include
`cheri-riscv-notes`, `cheri-hypervisor-research`, PMR-075, any tag, force,
remote mutation, publication, or release.

PMR-091 is complete; its one authorized push has been consumed and grants no
later push authority. The opt-in `owner-actions.sh --helium-branches` path
belongs to historical PMR-018 and remains outside PMR-091. No default or
opt-in helper step and no parent, Project Manager, component, branch, tag, or
remote mutation is authorized.

**No further push is authorized; do not run again without a new exact
responsible-human confirmation:**

From `project-manager/`:

```sh
bash ./scripts/owner-actions.sh --plan
bash ./scripts/owner-actions.sh
```

The relevant local component commits are:

- `analysis-workbook` has local-only private branch
  `analysis/k3-a100-service-design-private` at `353c431` checked out
  (2026-10-10; no upstream; origin visibility is an open question); its
  local `main` is at `4cf44d0`, 0 behind / 2 ahead of
  last-fetched `origin/main` `3c9d2a3` (2026-10-06): local
  `d1f2caf` (CRQ-003) and `4cf44d0` (CRQ-004) are unpushed. The historical
  range contained by `origin/main` `3c9d2a3` includes Project Manager carry
  `c7cc0fa`, seven PMR-084
  owner commits through `ea72522`, and PMR-086 commits `efbfdb8` and
  `858a73b`, followed by PMR-038 HANDOFF-only commits `f7079fb` and
  `5e037b1`, then PMR-004 work `5684317` / return `635719e`, PMR-050 work
  `231cca4` / return `692caeb`, PMR-055 work `70bea16` / return `6d5d03d`,
  PMR-059 work `9d76048` / return `e6c8aad`, and PMR-063 work `62bd071` /
  return `8b5a301`. The first range remains exact backup request `PMR-085`;
  separate dependent `PMR-088` tracks only the two PMR-086 commits; PMR-089
  freezes the twelve-commit post-`858a73b` closure range at `8b5a301`;
  PMR-095 and PMR-097 separately track carries `5a646df` and `8da398d`;
- `beryllium-hypervisor/` was observed on 2026-10-06T16:03Z clean on
  `beryllium/k3-b3-bringup` at `afa4336`, behind 0 / ahead 1 of last-fetched
  `origin/beryllium/k3-b3-bringup` `6358ed2`, with a human session the
  responsible human reports active; `afa4336` is on no remote-tracking
  branch. Its last recorded (104th-turn) primary state was clean at
  documentation-only PMR-077 return `a8e137e`, behind 0 / ahead 6 of
  last-fetched private `origin` `4141cf6`; maintained refs inspection at
  2026-10-06T18:16Z shows local `beryllium/single-hart-runtime-r0` at
  `f213555`, behind 0 / ahead 22 of that upstream. PMR-112 work `2313cbe0`,
  return `55b568b4`, and checkpoint `93819fd9` adopt SOT-first startup.
  PMR-077 is closed as acknowledgement at `a8e137e`, which grants no
  successor or hardware authority. Canonical
  return `1f38e699` and checkpoint `4c6acbed` close PMR-098/100 as
  acknowledgements and change owner-stated `planning/HANDOFF.md`. As of the
  last fetch, which is not a live remote check, those six commits and
  `f213555` are contained in remote-tracking
  `origin/beryllium/k3-b0-bringup` through `k3-b3-bringup`; that grants no
  push, publication, or gate. No push path is authorized. Local candidate
  `beryllium/r8-h0-pmr-080` is `6e93461` and local branch
  `beryllium/r8-c-h0-pmr-081-v3` ends at `0d53120`, both on no
  remote-tracking branch and unbacked. The component handoff separately
  states local
  doc-repro branch `beryllium/doc-repro-option-a-20260929` is unpushed and
  not integrated, archive ref `archive/generated-docs-2026-09-30` points to
  `d4c5ff0`, and K0-S target `c6570558` is Beryllium-ref-contained. Source
  target `c1c7e254` is absent from Beryllium and remains owner-stated sibling
  containment evidence. PMR-090 retains unresolved publication/ref review.
  PMR-099 is
  closed at exact K0-A plan acceptance only. Generic helper delivery remains
  excluded; PMR-105's single-use topic fast-forward is complete and consumed;
- `helium-te-poc` clean attached `for-review` at PMR-026 durable return
  `f928aac` is synchronized 0/0 with `origin/for-review`; exact owner-only
  backup request `PMR-091` is closed from script and inspection evidence;
  `main`, `public`, tags, and every other branch were unchanged;
- `cheri-riscv-notes` is clean local `docs/reconcile-project-status` at
  PMR-119 class-3 carry `7f67154`, 0 behind / 3 ahead of last-fetched private
  `origin` `34a8b50`. PMR-114 work `8d1bc9d` / return `7fb49f4` and the
  PMR-119 carry are unpushed with no allocated backup request. Owner work
  `41e4125` integrates exactly the thirteen D4-approved paths; PMR-104,
  PMR-106, PMR-114, and PMR-119 are closed. PMR-093/096 are withdrawn;
  PMR-105 private topic backup is complete and its single-use authorization
  is consumed;
- `cheri-hypervisor-research` local `main` is at PMR-115 return `7361de4`,
  0 behind / 1 ahead of last-fetched private `origin/main` `5e7387a`; on
  2026-10-06 it is not clean, being dirty only with two untracked
  `review-inbox/*.pdf` files. Exact PMR-075/092/094 predecessor ranges are
  remotely contained and those backup requests are closed. The later
  startup-path change remains local and unpushed; inactive
  `legacy-backup/main` remains `706e708`;
- `formal-verification-research` clean `main` is synchronized 0/0 with
  last-fetched `origin/main` at `388690d`, which contains `c55065c` and
  `784be93` (`PMR-035`, `PMR-037`, `PML-0022`, `PML-0024`); no
  formal-verification commit is pending;
- `threat-modeler` clean `main` is at `e6aed9f`, 0 behind / 4 ahead of
  last-fetched `origin/main` `c4126b6`. Remote backup reaches only
  predecessor owner maintenance `c4126b6` (`PMR-028` closed; includes
  `5bf6a4b` and `f4eb272`); the four PMR-120 commits `ca8fa3c`, `bbbc534`,
  `71bca3f`, and `e6aed9f` are local-only and unpushed;
- `security-reviewer`: work `2bb4c98` and return `c2edac7` close
  PMR-109/110 locally and leave clean `main` two ahead of private
  `origin/main` `2e8d205`; PMR-111 separately tracks the unapproved
  `push_sr` fast-forward.

The current helper's `push_fvr` path expects a remote named `backup`, while
the restored formal-verification clone has only `origin`. It will not push
by default. `c55065c` and `784be93` are already contained in synchronized
`origin/main` `388690d`, so no formal-verification push is pending; any
later helper retargeting is a separate Project Manager change. Do not create
a duplicate remote implicitly.

The XRV encompassing private fast-forward is complete and consumed.
`push_xrv` is not due; do not repeat it without a new exact responsible-human
confirmation.

The helper prompts before every push, warns on a dirty worktree and skips it
automatically only under `--yes`, never forces, and does not publish. Report
its log path and result to the next Project Manager turn.

## Human gates unchanged

Beryllium is accepted through R7. R8-C plan target `f47ae60` is accepted as
plan text. The component records exact target `1999ee7` as accepted, but the
responsible human selected `defer` for Project Manager reconciliation;
`PMD-20260925-001` therefore keeps Project Manager R8-H0 state committed but
unaccepted. Exact KVM0 K0-A plan target `5227266` is responsible-human
accepted under `PMD-20260926-002`, satisfying K0-P only. PMR-100's canonical
return records the distinct K0-I exact-target and K0-S boundaries without
expanding their authority. K0-S preparation/status documentation is accepted
only at exact target
`c65705582c243dd908ff47d3189df07601167400`; current-package readiness,
K0-X, and K0-R remain blocked. KVM0 and K3 are `NOT RUN`; development kernel/BSP is
`UNDECIDED`. H1-H4 are not authorized. Helium is a review-and-test proof of
concept, not formally verified or hardware validated. No coordination action
grants acceptance, approval, risk acceptance, sign-off, licensing,
publication, or release.
