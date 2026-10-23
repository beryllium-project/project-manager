# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-10-23
**Workspace root:** parent of `project-manager/`; exact current root is
recorded in `../COMPONENTS.md`

The Project Manager does not execute this file's commands, run component
validation, or modify carry-ineligible components. It pushes only the
Project Manager and parent coordination repositories, and only on an exact
same-turn responsible-human confirmation; it pushes no component.
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
`scripts/beryllium-governance.sh` does not yet follow this preference: it
writes no log, so its `check` and `install` results reach the Project
Manager only through your report, which the Project Manager records as
unverified responsible-human evidence, unless a logging wrapper runs it.
On 2026-10-23 you ran it through the ignored wrapper
`scratch/lx2-setup.sh`, whose log the Project Manager read.

## P1 CHERI-RISC-V notes history check (no PMR)

Why: on `lx2`, `../agentic-os-research/cheri-riscv-notes` is a `main`-only
checkout at `888f658` (files dated 2026-10-21, handoff dated 2026-10-20)
that contains none of the recorded commits, and the 128th-turn audit found,
from its Git metadata, that it is the same registered repository:
`origin` is `agentic-os-research/cheri-riscv-notes`, `ORIG_HEAD` is the
recorded `main` `6553092`, `FETCH_HEAD` is the recorded backup tip
`34a8b50` of that remote's `docs/reconcile-project-status`, and
`packed-refs` holds only `main` and `origin/main` at `888f658`. Its earlier
history was replaced and pruned, and when it last fetched or pushed, the
remote's `main` was `888f658`. File and Git-metadata times (UTC) place the
replacement on 2026-10-21 between 06:25:09Z, when your DASICS workbook
session recorded CHERI notes still at `7f67154`, and 08:06:13Z, when
`packed-refs` was written (`ORIG_HEAD` 07:39:13Z, working tree 08:05:56Z;
no fetch since 2026-09-29), that is, between 02:25 and 04:06 at UTC-4. The
Project Manager infers no cause. If the
remote was rewritten, its backups of the earlier history (`34a8b50` and
`archive/gim-wiki` at `cd7dc81`) may be gone. The three never-pushed
commits (`PMR-114` work `8d1bc9d` and return `7fb49f4`, and Project Manager
carry `7f67154`) were last known in the `l1` copy; if `lx2` is a copy of
`l1` (inferred), `l1` may show the same replacement. You answered
`unresolved` and keep the `l1` copy untouched (`PMD-20261023-001`).

1. Run this read-only check. It lists the remote's branches and tags, the
   repository's GitHub visibility and last push time, and the `gh` account
   used, writes `scratch/cheri-notes-remote-check-<UTC>.log` for the
   Project Manager to read, and runs no write, fetch, or push:

   ```sh
   bash /home/jmorris/src/beryllium-project/project-manager/scratch/cheri-notes-remote-check.sh
   ```

2. Tell the Project Manager whether you, or a session at your direction,
   replaced that history on purpose, so that it can record a named
   decision:
   - if it was intended and the new history is canonical, decide separately
     whether the three `l1` commits are still wanted;
   - if it was not intended, keep the `l1` copy untouched and decide how to
     recover, which is your action under the component's own rules. Pushing
     the `l1` branch to the private `origin` would meet a remote `main` with
     different history.

Default until then: keep the `l1` copy untouched, start no CHERI notes
owner session on `lx2`, and expect no Project Manager carry there. The
Project Manager never fetches, clones, copies, or recovers a repository.

## P2 Beryllium S3 MVP plan review (no PMR)

Beryllium's instructions at `882868b9` propose the S3 MVP plan,
`planning/mvp-plan.md`, for your review at exact commit `06c35f48` on local
branch `beryllium/s3-mvp-plan`, with the packet
`planning/mvp-plan-review-summary.md`; it is not accepted. It defines MVP
1.0 as milestones M0-M4, with decisions D1-D13 and open questions Q1-Q8;
its acceptance would authorize writing M0's bounded plan only. The same
instructions record S1, the project review, the S2 plan, and security model
v1 as accepted, component-side. Start a new Beryllium session; one started
before the 2026-10-23T05:38:54Z `lx2` install must be restarted, because
the hook denied its sub-agent launches whatever arguments were passed. Then
run `/model` to confirm `claude-opus-5.5` / `max` / `long_context`:

```sh
cd /home/jmorris/src/beryllium-project/beryllium-hypervisor && copilot
```

Decide under Beryllium's own review rules, as its packet sets out. The
branch is local-only, so backing it up needs your direction in that
session. The Project Manager writes nothing in Beryllium, and no Project
Manager gate follows from your component-side decision.

## P3 Beryllium stage reconciliation (no PMR)

Beryllium's committed instructions (at `882868b9`) record, component-side:
responsible-human acceptance of B0-B7; the 2026-10-08 drop of the KVM0
workstream and R8 stages H1-H4 (owner-recorded `r8=drop`; a new accepted
plan may recreate either); S1 authorized on 2026-10-16 and accepted at
`fd670dcd` on 2026-10-18; the project review `480dab72` and its revision
plan `07541c59` accepted; the S2 plan `5ce7827f` (2026-10-19) and security
model v1 `0e3eec8b` (2026-10-22) accepted; and S3 directed on 2026-10-22.
They also record that one session ran on `claude-fable-5.1` by your
choice, outside the single-model SOP `PMD-20261006-001`, and that on
2026-10-18 you directed `override pinning and use fable 5.1 for everything,
re-run the research agents, apply changes if any` for that session only,
with the governance hook's required model edited for that run and restored
afterwards. Project Manager records keep K3 hardware
`NOT RUN`, K0-X/K0-R blocked, H1-H4 not authorized, and R8-H0 a committed
candidate, not accepted, and they record none of these component-side
acceptances. This question is reconciled only from a named
responsible-human record: tell the Project Manager which component-side
acceptances, authorizations, drops, and SOP exceptions its records should
carry. No gate follows from this runbook.

## P3 Beryllium session-state worktrees (no PMR)

`PMR-127` repaired seven Beryllium linked-worktree registrations, which are
clean on `lx2`. The owner retained five more, unrepaired, unpruned, and
unlocked, registered under a former Copilot session-state directory under
`~/.copilot/session-state/`; the exact directory and the five admin ids are
in the Beryllium `planning/HANDOFF.md` section "PMR-127 owner-session
checkpoint". On `lx2` (2026-10-23 `quiescence`) their directories exist,
so Git does not report them prunable here, but `git status` fails in each
because its link names the former `lx2` root. The owner's worktree list
puts one of them, `source-first-corrected-validation`, at `66eaa7f7`,
which no branch contains. `quiescence` keeps failing on them.

Default: do nothing now, and keep `~/.copilot/session-state/` on `lx2`.
When you choose, have a Beryllium owner session do one of these:

1. reconnect them with one `git worktree repair <path>...` from the primary
   checkout, then inspect, commit, or keep what they hold (`66eaa7f7` can
   be kept on a branch);
2. lock them with `git worktree lock`; or
3. let them go once nothing in them is needed.

On `l1`, where their directories are absent, the owner reported that
default `git gc` could prune them from about 2026-12-28. Tell the Project
Manager your choice; it allocates an owner request if one is needed. The
Project Manager never repairs, locks, or prunes worktrees.

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
aligned, so no Beryllium SOP request is allocated; Beryllium's closed
`PMR-133` was separate tasking-contract housekeeping. Threat-modeler is
aligned too: `PMR-121` closed on 2026-10-13 (work `c156c0a0`, return
`aba33507`, both local).

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

**Direct carry for PMR-122** (formerly "Direct carry for PMR-121 and
PMR-122"). The ordinary `owner-session.sh`
packet requires the owner to run the parent tasking resolver before editing.
Provenance-review limits trusted execution to its own scripts and read-only
inspection until `PMR-066` lands. The Project Manager therefore uses the
existing human-carry path for this request, as closed `PMR-121` did for the
threat-modeler while parked `PMR-064` keeps its resolver unadmitted: start
an ordinary session directly in the component with the one-line request
below. The owner reads its request row with read-only file tools and runs no
parent or sibling command. This neither adopts tasking startup nor un-parks
`PMR-064` or `PMR-066`.
This direct ordinary session is a recorded exception, under
`PMD-20261006-001`, to the rule that the human receives one exact launcher
command instead of prompt text. It takes neither the per-component writer
lock nor the PMR-108 global reservation, and it writes no preflight log.
Before starting it, confirm that the component is clean and that
no other Copilot session, `owner-session.sh`, `owner-recovery.sh`, or
`maintenance-reservation.sh` run is active for that component. If the owner
reports any mismatch, it stops.

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
`HANDOFF.md`, and does not push. `PMR-111` stays separate. Start the
session after the 2026-10-23T05:38:54Z `lx2` install; restart an older one,
because the hook denied its task launches whatever arguments were passed.
Passing `claude-opus-5.5` / `max` / `long_context` explicitly to a
`security-evidence`, `security-research`, or `security-finding-review`
task launch remains harmless.

## Completed user-level governance installs (no PMR)

On `lx2`, after the relocation (`PMD-20261023-001`), you ran the ignored
human-run wrapper `scratch/lx2-setup.sh`, which follows `REHYDRATE.md`
section 4. Its log, `scratch/lx2-setup-20261023T053854Z.log`, which the
Project Manager read, records host `lx2` at 2026-10-23T05:38:54Z, the
`cross-repo-collaboration` skill at the expected SHA-256
`da583f99b0685afce6fdd641f26aca79839bf15ee6a94e138b87e8d701dc79f9`,
`install` post-install checks passing, the retired scope agent and skill
already absent, and `check` passing every line, with exit 0. The retired
assets were present at the 127th turn's read-only listing and were removed
before the logged run by a step the Project Manager did not observe. A
read-only listing shows the hook configuration naming the current root.
`check` does not inspect `/subagents`, and whether another Copilot session
was running during the install is unrecorded. This replaces the stale
2026-10-01 `lx2` install described below. The Project Manager ran neither
mode against real user configuration. Nothing here changes a component,
PMR, acceptance, review approval, risk acceptance, publication, release, or
assurance gate.

On `l1`, the 116th turn recommended this sequence: run
`/config model claude-opus-5.5`, confirm the `/subagents` defaults are
`claude-opus-5.5`, then, with no other Copilot session working, run:

```sh
cd /home/jmorris/src/beryllium-project
bash ./project-manager/scripts/beryllium-governance.sh check
bash ./project-manager/scripts/beryllium-governance.sh install && bash ./project-manager/scripts/beryllium-governance.sh check
```

At 2026-10-13T00:30Z (2026-10-12 local) the responsible human replied
exactly `"done above"`. This is responsible-human evidence only. The
Project Manager did not run these commands against real user
configuration, see their output, or independently verify the installed
files. The Project Manager session that recommended them was idle, awaiting
that reply, and had started before the install, so it has no hook loaded;
its task launches keep passing `claude-opus-5.5` / `max` / `long_context`
explicitly. New Copilot sessions started after the install load the hook
configuration, matcher, and environment (`PMD-20260930-003`). Agent and
skill reread behavior in already-running sessions remains unknown. If the
final `check` did not pass every line, tell the Project Manager; rerunning
the read-only `check` above is always safe. `REHYDRATE.md` section 4 stays
the full per-workstation procedure. The report changes no component, PMR,
acceptance, review approval, risk acceptance, publication, release, or
assurance gate.

Earlier, on 2026-10-01, the responsible human stated exactly `"there is no other
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
`l1` (`PMD-20261010-001`); after the 2026-10-23 relocation that install
was stale, and the logged install above replaced it.
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

### P3 worktree inventory and namespacing follow-up

On 2026-10-12 `PMR-127` repaired, at the current root path, the five registered flat
`worktrees/be-*` placements and the two registrations under the checkout's
`build/restore-pinned-validation-environment/scratch-diagnosis/`;
`be-doc-repro-review-7cf4-20260930` is absent. The flat placements do not
yet follow `worktrees/<repository>/<purpose-or-branch>`. The owner also
observed, untouched, six unregistered `worktrees/beryllium-hypervisor-*`
directories whose `.git` files name Git admin directories that no longer
exist, so `git worktree repair` cannot reattach them, and an empty
`worktrees/beryllium-hypervisor/`. A later Beryllium owner inventory
decides any `git worktree move` and the unregistered directories'
disposition, after fresh tasking, worktree, and one-writer checks; nothing
is deleted before the owner confirms that no unique content remains. The
Project Manager never moves, removes, repairs, prunes, or judges these
worktrees obsolete. The five retained session-state registrations are the
separate choice in "P3 Beryllium session-state worktrees (no PMR)" above.

## Completed PMR-108: global startup status and quiescence gate

`../SOT.md` is the existing global topology/status anchor. It now records the
2026-10-23 relocation to the Fedora laptop `lx2`, the canonical root
`~/src/beryllium-project`, the noncanonical former `l1` copy, and the
unresolved CHERI-RISC-V notes checkout (`PMD-20261023-001`).

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

## P3 PMR-111: security-reviewer backup (publishes)

PMR-109 and PMR-110 are closed as acknowledgements of owner work
`2bb4c989bbe9b57f870e6f653ed3732e742b11f9` and HANDOFF-only return
`c2edac70afdfe5b0bb90e237487cd168fb91e900`. The responsible human replied
exactly `"done"` after being directed to review the return and exit the
existing security-reviewer owner session, releasing only that component's
session/reservation. The two commits remain local and unpushed; no engagement
ran.

PMR-111 is a separate backup-only request. Before any push, require a new
exact same-turn responsible-human confirmation, clean idle `main` at
`c2edac70`, and live public `origin/main` still at
`2e8d2054840af35ba6d64a00546ee99806a88dfb`. Then the responsible human may
run the maintained helper from the workspace root:

```sh
bash ./project-manager/scripts/owner-actions.sh --only push_sr
```

The Project Manager never runs this command. The human retrieves the
timestamped helper log from `project-manager/scratch/owner-actions/`; closure
requires exact remote containment and final clean branch state.
`beryllium-project/security-reviewer` stays public by your choice
(`PMD-20261012-002`), so this push publishes the two commits, and the
confirmation must say so. No force, tag, remote mutation, engagement,
review approval, risk acceptance, release, or other gate is combined.

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
gates in Project Manager records. The component's 2026-10-08 instructions,
read at `69bf8f8a`, record component-side B0-B7 acceptance and the
responsible human's drop of KVM0 and R8 H1-H4; Project Manager records are
not reconciled to them (open responsible-human question).

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

`PMR-090` is closed (2026-10-16). In a Beryllium owner session you
directed `"for pmr-090, retire those commits"` and answered
`candidate_6e93461=retire-keep`, so candidate `6e93461` was never pushed
and its local branch `beryllium/r8-h0-pmr-080` stays; the request's active
history through `416b2e9` was already in `origin`. The session also, on
your form answers `accepted_r8_branch=backup` and `fast_forward=ff-push`,
which lie outside `PMR-090`, fast-forwarded the development branch to
return `56e36ae1` and pushed it, `beryllium/k3-b7-bringup`, and
`beryllium/r8-c-h0-pmr-081-v3` (tip `0d53120`, which the owner identifies
as the component-side H0/R8-C acceptance record) to the private `origin`.
The Project Manager verified the work `65df753a`, the return, and those
remote-tracking refs with maintained `refs`; no separate live check ran.
Do not rerun it; any later Beryllium push needs new direction.

`PMR-121` is closed (2026-10-13). The direct threat-modeler session
repinned all six profiles to `claude-opus-5.5` in work `c156c0a0` and
returned at `aba33507`. Both commits are local; `threat-modeler` is public,
so pushing them would publish and needs your separate confirmation. Do not
rerun its command.

The Beryllium backup push (no PMR) is complete (2026-10-13). Under your
exact `"push the beryllium backup"`, you pushed `beryllium/k3-b7-bringup`
(`563cca1..f6fc6c7`) and `beryllium/single-hart-runtime-r0`
(`3bc3ef0..80ef261`) to Beryllium's private `origin` as fast-forwards.
Maintained remote-tracking refs reflect both; no separate live check ran.
Candidates `6e93461` / `0d53120` and the B4-B7 worker branches stayed
local, and no tag was pushed (`--no-follow-tags`). Do not rerun it; any later push
needs a new confirmation.

`PMR-134` and `PMR-132` are closed (2026-10-13), run in parallel as fleet
lanes under your exact `"proceed with these in fleet mode. fast-foward."`.
The Beryllium owner session fast-forwarded development branch
`beryllium/single-hart-runtime-r0` from `3bc3ef04` to `80ef261e` with one
guarded compare-and-swap ref update, owner-reported. It made no checkout,
merge, rebase, worktree change, or push. It recorded the move in work
`e42c6c6a` and returned at `f6fc6c7e` on `beryllium/k3-b7-bringup`. The
development branch now holds B6, the step-3 re-baseline, B7, `PMR-127`,
and `PMR-133`; your same-day backup push put it on `origin`. The
workbook branch is backed up: `5db4f2c` is 0/0 with its private `origin`.
The Project Manager verified both with maintained `refs`. Do not rerun
either.

`PMR-133` is closed (2026-10-12). The Beryllium owner session committed
work `f0e24f1f`, which makes `## Project Manager tasking` the first
level-two section of `.github/copilot-instructions.md` again on
`beryllium/k3-b7-bringup` and lets `docs/check-links.mjs` accept one dated
`## Current direction` section after it, and returned at `80ef261e`. The
Project Manager verified both commits with maintained `refs` and read the
changed layout and validator; the owner reports `--tasking-contract`
passing. Both commits are in `origin` since your 2026-10-13 backup push. Do not rerun its launcher.

`PMR-130`, `PMR-124`, and `PMR-126` are closed. The workbook owner session
committed PMR-124 work `a301348` (CRQ-004 `routed`), PMR-126 work `f0b8b35`
(CRQ-003 `routed`), and PMR-130 work `c9d1971`, and returned at `5db4f2c`.
PMR-130 adds the two-repository rule to the workbook's instructions,
interface, README, and handoff; a hosting-only note in `AWB-20261007-001`;
and inventory `publication-readiness/main-4cf44d0.md`. The inventory finds
`main` at `4cf44d0` not publication-ready as-is. The Project Manager
verified the commits with maintained `refs` and read the changed rows. The
owner reports 414 / 0 agent tests and passing session, queue, and workbook
checks. Routing PMQ-034..036 to XRV became `PMR-131`, and backing up the four
local commits became `PMR-132`.

`PMR-129` is closed. `--execute`
(`scratch/owner-actions/pmr129-workbook-split-20261012T074846Z.log`)
created private `beryllium-project/analysis-workbook-private` and pushed
`main` `4cf44d0` and the private branch `353c431` to it. It deleted the
private branch from `beryllium-project/analysis-workbook` and made that
repository remote `public`, with its push URL disabled. Maintained
inspection confirms both branches track `origin` at 0 behind / 0 ahead.
You reported disabling pushes from the noncanonical `lx2` copy first. Do
not rerun it; with `PMR-129` closed, its preflight now fails closed.

`PMR-128` is closed (`PMD-20261012-002`). The audit
(`scratch/owner-actions/pmr128-visibility-audit-20261012T052523Z.log`) found
8 repositories private as expected and 5 public: the Project Manager
(`PMD-20261012-001`), and `threat-modeler`, `security-reviewer`,
`provenance-review`, and Helium's public remote `helium-te-poc`, which you
chose to keep public. One unresolved identity is the unused personal-fork
parent remote. The workbook is private, with two unprotected heads and no
tags, pull requests, or listed forks. It had 17 clones by 12 unique cloners
and no views from 2026-09-27 to 2026-10-10; 2026-10-11 is outside that
window. Re-run the audit at any time; its `MISMATCH` lines for those five
repositories are expected.

The coordination backup is complete through Project Manager `e5b18ae` and
parent `1ca8869`. Under your exact `"push"` (2026-10-13), the 118th turn
pushed Project Manager `918efe7..3873777` (publishing it) and parent
`b7ba4a4..29dcf66` as fast-forwards; on 2026-10-13 the 119th turn verified
with live `ls-remote` that each remote holds only `main` at those tips,
0 behind / 0 ahead, and that confirmation is consumed. Your 123rd-turn
`"push all"` (2026-10-13) lapsed unused: the parent remote refused the
then-active `gh` account, so nothing was pushed. Under your exact
`"push all"` (2026-10-14), the 124th turn pushed Project Manager
`3873777..e5b18ae` (publishing it) and parent `29dcf66..1ca8869` as
fast-forwards, through the repo-local credential helper you added on `l1`
(`HANDOFF.md`, "Remote access"); on 2026-10-16 the 125th turn verified with
live `ls-remote` that each remote holds only `main` at those tips, with no
tag, 0 behind / 0 ahead, and that confirmation is consumed. Under your
exact `"push all"` (2026-10-16T23:37Z), the 126th turn pushes Project
Manager `main` from `e5b18ae` through its record commit (publishing it)
and parent `main` from `1ca8869` through its registry commit as
fast-forwards; the next turn records verification, and later commits
stay local until a new same-turn confirmation. Under your exact `push_both`, the
114th turn pushed Project Manager `98a916c..918efe7` and parent
`b4cb8e4..b7ba4a4` as fast-forwards; on 2026-10-12 the 115th turn verified
with live `ls-remote` that each remote holds only `main` at those tips,
0 behind / 0 ahead, and that confirmation is consumed. The 111th turn pushed Project Manager
`43e7e82..98a916c` and parent `ff4f598..b4cb8e4`, and the 112th turn
verified both 0 behind / 0 ahead. The 110th turn found
`beryllium-project/project-manager` publicly readable, held its push
(`PMD-20261011-003`), and pushed the non-public parent `4f96358..ff4f598`,
verified 0 behind / 0 ahead. You then directed exactly `"just finish the
backup publicly"`. `PMD-20261012-001` records that as your decision to
publish the Project Manager commits after `43e7e82` through `2b39df0`, plus
its record commit, and as the push
confirmation for the 111th turn's Project Manager and parent fast-forwards,
which it consumed. The repository stays public; every later push to it publishes
and needs a new confirmation.

`PMR-120` is closed at initial work/return `ca8fa3c` / `bbbc534` and
standard-V1 correction work/return `71bca3f` / `e6aed9f`. The focused owner
suite reports 148/0 and diff check passed; full package-reading suite and
index check are unknown. At closure, clean local `main` was 0 behind / 4
ahead, all four commits were local-only, and no push, model/package action,
or gate occurred; closed `PMR-121` later added two more local commits.
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

- **P4 workbook DASICS branch and PMQ-037..048 (no PMR):** your
  direct-human DASICS session `AWB-20261021-001` is on local-only branch
  `analysis/dasics-cheri-fallback-private` (`c0d5fb7`, tip `10c777a`), with
  no backup. Its handoff leaves the disposition to you: keep it local, or
  back it up to the private `origin`, never to `public`. Its twelve
  pointers PMQ-037..048 are ledgered `pending` (PML-0038..0049); routing
  waits for that disposition and, for the eleven CHERI notes rows, for that
  checkout's resolution. Not needed for development. For a private backup,
  the first command must print a
  `beryllium-project/analysis-workbook-private` URL; stop if it prints
  anything else, and tell the Project Manager the result:

  ```sh
  git -C /home/jmorris/src/beryllium-project/analysis-workbook remote get-url --push origin
  git -C /home/jmorris/src/beryllium-project/analysis-workbook push origin analysis/dasics-cheri-fallback-private
  ```

- **Workbook publication decision (no PMR):** both workbook repositories
  are private, so nothing is exposed and nothing is urgent. The `PMR-130`
  inventory (`../analysis-workbook/publication-readiness/main-4cf44d0.md`
  at `c9d1971`) finds `main` at `4cf44d0` not publication-ready as-is: all
  six packages are `private`, three only `public-candidate` without
  promotion, and generated navigation and coordination records expose
  private-session state. When you want to decide, choose one of three:
  keep both repositories private (the recommended default, which needs no
  action); have the owner prepare a clean publication line; or publish an
  exact commit, naming what you accept. The Project Manager then records
  the decision.
- **P4 PMR-131:** in a human-started XRV owner session, the owner decides
  under its review-log rules whether to record PMQ-034..036 as pointer-only
  entries, and reports each as recorded, already represented, or declined.
  This is research intake, not needed for development:

  ```sh
  cd /home/jmorris/src/beryllium-project/project-manager
  bash ./scripts/owner-session.sh launch cheri-hypervisor-research PMR-131
  ```

  The launcher refuses while XRV has its two untracked `review-inbox/`
  PDFs, because it counts untracked files as dirty. Have the XRV owner
  handle them under its own rules first.
- **P3 PMR-085:** analysis-workbook `main` (synchronized at `3c9d2a3`,
  now `4cf44d0` on both the private `origin` and `public`) contains the exact predecessor range through `ea72522`. Reconcile who
  reviewed and authorized the encompassing push before closure. No force,
  publication, analysis disposition, or handshake authority follows.
- **P3 PMR-088:** `main` (`3c9d2a3`, now `4cf44d0` on both the private `origin` and `public`) contains PMR-086 work `efbfdb8` and
  durable return `858a73b`. After `PMR-085`'s push evidence is independently
  reconciled, review the exact range with
  `git -C ../analysis-workbook diff ea72522..858a73b -- tests/validate-agent.sh HANDOFF.md`
  from `project-manager/`.
  This request was not dispatched or combined with PMR-086; no queue change,
  analysis disposition, publication, or gate follows.
- **P4 PMR-089:** `main` (`3c9d2a3`, now `4cf44d0` on both the private `origin` and `public`) contains the frozen twelve-commit
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
- **P4 PMR-095:** `main` (`3c9d2a3`, now `4cf44d0` on both the private `origin` and `public`) contains analysis-workbook carry
  `5a646df` (`8b5a301..5a646df`); close only after predecessor push
  dispositions are reconciled.
- **P4 PMR-097:** `main` (`3c9d2a3`, now `4cf44d0` on both the private `origin` and `public`) contains analysis-workbook carry
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
belongs to historical PMR-018 and remains outside PMR-091. PMR-091
authorizes no default or opt-in helper step and no parent, Project Manager,
component, branch, tag, or remote mutation.

**No further helper push is authorized; do not run again without a new exact
responsible-human confirmation.** The coordination backup is complete and
verified through Project Manager `e3c8e10` and parent `6639e86`: the 126th
turn pushed them under your exact `"push all"` (2026-10-16T23:37Z), and
live `ls-remote` on 2026-10-23 shows each remote holding only `main` at
those commits, with no tag. Later commits, including the 127th and 128th
turns', stay local until a new same-turn confirmation. `beryllium-project/project-manager` stays public by your
decision, so any later `push_pm` publishes the Project Manager commits it
pushes. `threat-modeler` and `security-reviewer` also stay public
(`PMD-20261012-002`), so `push_tm` and `push_sr` publish too.

From `project-manager/`, add `--skip push_pm,push_tm,push_sr` unless you
intend to publish new commits to those public repositories:

```sh
bash ./scripts/owner-actions.sh --plan --skip push_pm,push_tm,push_sr
bash ./scripts/owner-actions.sh --skip push_pm,push_tm,push_sr
```

The relevant local component commits are:

- `analysis-workbook` has local-only private branch
  `analysis/dasics-cheri-fallback-private` checked out on `lx2` at
  `10c777a` over `c0d5fb7`, with no backup (see "Deferred and non-blocking
  work"). Private branch `analysis/k3-a100-service-design-private` is at
  owner return `5db4f2c`, 0 behind / 0 ahead of private `origin`
  `beryllium-project/analysis-workbook-private` since the human-run
  `PMR-132` backup (closed 2026-10-13). Local `main` at `4cf44d0`, including
  `d1f2caf` (CRQ-003) and `4cf44d0` (CRQ-004), is synchronized with the
  private `origin/main` since the 2026-10-12 `PMR-129` split. The historical
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
- `beryllium-hypervisor/` is clean on local branch `beryllium/s3-mvp-plan`
  at `882868b` (2026-10-23T03:15Z on `lx2`), over S3 proposal `06c35f4`;
  both are local-only with no upstream, and backing them up needs your
  direction in a Beryllium session. The development branch is at `0096de3`,
  0 behind / 0 ahead of last-fetched `origin`, which the owner records as
  pushed on your instructions of 2026-10-18 and 2026-10-22. On 2026-10-16
  it was clean on `beryllium/s1-synthesis` at `2256101` and earlier on
  `beryllium/k3-b7-bringup` at
  `PMR-090` return `56e36ae` over work `65df753` (2026-10-16). The
  `PMR-090` owner session pushed both to private `origin`, with the
  development branch then (2026-10-16) at the same commit and 0 behind / 0
  ahead, on your form answer `fast_forward=ff-push`. Before that, `PMR-134` return
  `f6fc6c7` over work `e42c6c6` (2026-10-13), `PMR-133` return `80ef261` /
  work `f0e24f1`, and `PMR-127` return `69bf8f8` / work `da65b80` reached
  private `origin` under your exact `"push the beryllium backup"`
  (2026-10-13). History: on 2026-10-06T16:03Z it was observed clean on
  `beryllium/k3-b3-bringup` at `afa4336`, behind 0 / ahead 1 of last-fetched
  `origin/beryllium/k3-b3-bringup` `6358ed2`, with a human session the
  responsible human then reported active; `afa4336` was then on no
  remote-tracking branch and is now contained. Its last recorded (104th-turn) primary state was clean at
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
  push, publication, or gate. No push path is authorized. Retired candidate
  `beryllium/r8-h0-pmr-080` at `6e93461` stays local and unpushed by your
  decision (closed `PMR-090`), and `beryllium/r8-c-h0-pmr-081-v3` at
  `0d53120` is in private `origin` since the 2026-10-16 backup. The
  component handoff separately
  states local
  doc-repro branch `beryllium/doc-repro-option-a-20260929` is unpushed and
  not integrated, archive ref `archive/generated-docs-2026-09-30` points to
  `d4c5ff0`, and K0-S target `c6570558` is Beryllium-ref-contained. Source
  target `c1c7e254` is absent from Beryllium and remains owner-stated sibling
  containment evidence. PMR-090 is closed (2026-10-16).
  PMR-099 is
  closed at exact K0-A plan acceptance only. Generic helper delivery remains
  excluded; PMR-105's single-use topic fast-forward is complete and consumed;
- `helium-te-poc` clean attached `for-review` at PMR-026 durable return
  `f928aac` is synchronized 0/0 with `origin/for-review`; exact owner-only
  backup request `PMR-091` is closed from script and inspection evidence;
  `main`, `public`, tags, and every other branch were unchanged;
- `cheri-riscv-notes` is unresolved on `lx2` (see "P1 CHERI-RISC-V notes
  history check"). Last recorded on `l1`: clean local
  `docs/reconcile-project-status` at PMR-119 class-3 carry `7f67154`, 0
  behind / 3 ahead of last-fetched private `origin` `34a8b50`. PMR-114 work
  `8d1bc9d` / return `7fb49f4` and the PMR-119 carry are unpushed, last
  known in the untouched `l1` copy (whether it still holds them is
  unknown), with no allocated backup request. Owner work
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
- `threat-modeler` clean `main` is at `PMR-121` return `aba3350`, 0 behind
  / 6 ahead of last-fetched public `origin/main` `c4126b6`. Remote backup
  reaches only predecessor owner maintenance `c4126b6` (`PMR-028` closed;
  includes `5bf6a4b` and `f4eb272`); the four PMR-120 commits `ca8fa3c`,
  `bbbc534`, `71bca3f`, and `e6aed9f` and the two PMR-121 commits `c156c0a`
  and `aba3350` are local-only and unpushed;
- `security-reviewer`: work `2bb4c98` and return `c2edac7` close
  PMR-109/110 locally and leave clean `main` two ahead of public
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
automatically only under `--yes`, never forces, and changes no visibility.
It does not check visibility, though, so a push to a public repository
publishes. `beryllium-project/project-manager`, `threat-modeler`, and
`security-reviewer` stay public by your decisions (`PMD-20261012-001`,
`PMD-20261012-002`), so keep `--skip push_pm,push_tm,push_sr` unless you
intend to publish new commits there. Report its log path and result to the
next Project Manager turn.

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
