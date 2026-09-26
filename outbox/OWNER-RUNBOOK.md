# Owner runbook: current open items

**Maintained by:** `project-manager`
**Last refreshed:** 2026-09-25
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

## Human-run script output

Responsible-human preference, stated exactly on 2026-09-21: `"next time,
script should log the output and you retrieve it"`. Future human-run scripts
must write timestamped output under a Project Manager-owned ignored
`scratch/` path, print the exact log path, and leave retrieval to the Project
Manager instead of asking the human to paste command output. If logging cannot
be made reliable, stop and explain that exception before asking for output.

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

The ordinary Beryllium PMR-067/083 owner session completed and released its
historical lock at `416b2e9`; both requests remain closed. A later
thirteen-commit owner series now ends at synchronized `80345e1` and requires
its own canonical return under `PMR-098`; this does not reopen the completed
process-expansion workstream. All six exact analysis-workbook
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
| Blocked | P4 | `PMR-052` | Wait for the cap-talk archive owners' response; only then may OS-security identify and inspect, or precisely bound as inaccessible, the public continuation from the `2016-04-01` start bound. |
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

Maintained inspection later on 2026-09-25 observes dirty active/default
`beryllium/single-hart-runtime-r0` at `1795400`, behind 0 / ahead 6 of
last-fetched `origin` `80345e1`. Eight modified paths are all under
`tests/kvm0/`. The component handoff now includes later K0-A planning and
acceptance material. `PMD-20260926-002` records exact human-accepted K0-A
target `5227266` and closes plan-only PMR-099, satisfying K0-P only. No
canonical return names open earlier-series `PMR-098` or
later-series/current-session `PMR-100`. This dirty state is a coordination
lock: do not run a new Beryllium owner launcher or infer KVM0 implementation,
execution, backup, publication, or any assurance gate.

The unreconciled range `416b2e9..80345e1` still records the component-side
exact H0/R8-C acceptance claim for `1999ee7`, the
`helium/* -> historical_he/*` private-origin namespace rename, KVM0/B0/B1
planning input, repository rehoming, and identity policy. `PMR-098` still
requires one canonical account of that range, the observed origin advance,
visibility, refs, validation, active-session state, and publication boundary.

The responsible human selected `defer` when asked whether the Project Manager
should confirm, reject, or defer the component acceptance claim.
`PMD-20260925-001` therefore keeps the Project Manager boundary unchanged:
Beryllium is accepted through R7; R8-H0 is committed but not accepted;
H1-H4 are unauthorized; K3 remains `NOT RUN`.

**P2 `PMR-098` and `PMR-100` are both blocked by the existing dirty owner
session.** The existing owner must first return a clean durable checkpoint
that names the two exact reconciliation scopes. Only after Project Manager
verification may a new owner command be generated. K0-I tooling, K0-S source
preparation/evidence import, K0-X native execution, K0-R result acceptance,
B0, development-kernel/BSP selection, B1, an H0 successor, retained R8
progression, publication, and release remain separate blocked gates.

## P1 current CHERI-RISC-V notes owner lock

Maintained inspection observes unchanged HEAD `6cb15e3` with thirteen
modified research/status paths. `meta/handoff.md` still contains only the
already-verified PMR-009 return. The responsible human classified this state
as `unfinished`.

Do not rerun PMR-009 and do not start PMR-093 or PMR-096. Resume only the
existing owner session. It must validate its actual scope, commit it or return
a precise blocked result, refresh `meta/handoff.md` with a structured owner
return, release its reservation, and leave the checkout clean. After that
owner action, verify from the Project Manager repository with:

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/inspect-components.sh state cheri-riscv-notes
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

The selected PMR-009/051/071 and PMR-058/072 batches are complete and
verified; do not rerun them. Future ordinary owner work uses the same
one-command launcher and preloaded packet; never ask the human to paste a
prompt.

| Request | Priority | One-command owner invocation | Packet boundary |
| --- | --- | --- | --- |
| `PMR-064` | P3 | `bash ./project-manager/scripts/owner-session.sh --agent threat-model-maintainer launch threat-modeler PMR-064` | Packet preloaded; do not resume the paused model. |
| `PMR-066` | P3 | `bash ./project-manager/scripts/owner-session.sh launch provenance-review PMR-066` | Packet preloaded for ordinary configuration maintenance. |
| `PMR-068` | P4 | `bash ./project-manager/scripts/owner-session.sh launch helium-te-poc PMR-068` | Packet preloaded; preserve frozen refs and gates. |
| `PMR-069` | P3 | `bash ./project-manager/scripts/owner-session.sh launch formal-verification-research PMR-069` | Packet preloaded; no research or bibliography disposition. |
| `PMR-070` | P3 | `bash ./project-manager/scripts/owner-session.sh launch osr-claude PMR-070`; answer the component's ask-first gate before writing | Packet preloaded; never open `restricted-microsoft`. |

Do not paste a follow-up phrase. The generated packet already includes the
exact resolver, PM/request fingerprints, selected PMR text, local instruction
checklist, one-writer rule, validation/commit/return contract, and no-gate /
no-push boundary.

## Completed - do not rerun

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
private `60d5ceb`; PMR-093 and PMR-095 retain their separate CHERI and
analysis-workbook backup ranges.

`PMR-009` is now also closed at owner work `e95922f` / return `6cb15e3` after
separate explicit D4 approvals. Analysis-workbook carry `8da398d` mirrors
PML-0008/0011. PMR-096 and PMR-097 keep the two later backup commits
separate; D5 licensing, redistribution, publication, Pages, merge, and push
gates remain open.

`PMR-067` and `PMR-083` are closed at their final owner return correction
`416b2e9`, following tasking implementation `9b726c1`, structured return
`32300c1`, section-boundary/Chromium remediation `b5bd8cc`, and fence-parser
hardening `364552c`. The responsible human's `"all ready"`, given in direct
response to the Project Manager's Beryllium owner-session release request,
releases that historical `active_session: self` lock. Do not treat this
closed range as the return for later `416b2e9..80345e1`; PMR-098 owns that
distinct reconciliation.

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
- **P4 PMR-089:** the twelve-commit closure range `858a73b..8b5a301` is
  frozen. Do not act until `PMR-085` plus `PMR-088` are independently
  resolved and private access is authorized. The request covers only that
  exact six-request housekeeping range,
  beginning with HANDOFF-only commits `f7079fb` and `5e037b1`, followed by
  PMR-004 work `5684317` / return `635719e` and PMR-050 work `231cca4` /
  return `692caeb`, PMR-055 work `70bea16` / return `6d5d03d`, then PMR-059
  work `9d76048` / return `e6c8aad`, and PMR-063 work `62bd071` / return
  `8b5a301`. The range is frozen; the request remains undispatched and blocked
  by PMR-085/088 plus private access. No force, tag, analysis/source change,
  publication, or gate is included.
- **P3 PMR-090:** active/default Beryllium is now observed at `80345e1`,
  synchronized 0/0 with last-fetched
  `origin/beryllium/single-hart-runtime-r0`, while local candidate
  `beryllium/r8-h0-pmr-080` at `6e93461` and local R8-C/H0 branch tip
  `0d53120` have no remote-tracking containment. This partially changes the
  old backup facts but supplies no Project Manager publication authorization
  and no canonical owner return for the update. Keep PMR-090 open behind
  PMR-098; review the exact refs and publication gate before any later
  decision. Never push inactive `msft-downstream`; no observed or future push
  accepts H0, authorizes H1-H4/K3, or grants publication approval.
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
- **P3 PMR-093:** blocked by the current unfinished dirty CHERI owner session.
  Once that session returns clean, review exactly `9a4c5ef..6ac70af` and
  decide whether to fast-forward only `docs/reconcile-project-status` to its
  private active origin. The five commits close PMR-051/071 and do not touch
  PMR-009, `references/`, `wiki/`, or `sok/`.
- **P3 PMR-096:** blocked by the unfinished owner session and PMR-093. After
  both clear, separately review `6ac70af..6cb15e3` and decide whether to back
  up PMR-009 work `e95922f` plus return `6cb15e3`.
  D5/publication/Pages remain separate.
- **P4 PMR-095:** after PMR-085/088/089, separately review and back up only
  analysis-workbook carry `5a646df` (`8b5a301..5a646df`).
- **P4 PMR-097:** after PMR-095, separately review and back up only
  analysis-workbook carry `8da398d` (`5a646df..8da398d`).
- **Withdrawn PMR-073:** `PMD-20260918-003` records that the proven owner-worker path
  supplies the bounded need and no current request requires a separate
  Git-maintainer specialist.

- **P3 PMR-014:** the formal-verification owner triages the five original routed
  bibliography pointers.
- **P3 PMR-041:** the same owner triages the later `PMQ-021` and `PMQ-023`
  pointers at `c55065c` and `784be93`.
- **P3 PMR-037:** in `formal-verification-research`, refresh the owner-maintained
  handoff to state that the restored clone tracks the reachable
  `beryllium-project` repository as `origin`. The bibliography-format half
  was carried at `784be93`.

## External Beryllium dependency

**P4 `PMR-077`:** K3 COM260 (normalized from the responsible human's
externally unverified `Com260` term) bring-up is in progress in a separate
environment/project. The component now states that a board is available and
that read-only inventory/troubleshooting occurred on 2026-09-24. Those
statements are not the requested readiness return, retained Beryllium
evidence, K3 execution, or hardware validation. Wait for the responsible
human's minimal readiness return before any Beryllium hardware bring-up. Do
not access or import that project through this request, and return no serial
numbers, credentials, keys, tokens, private URLs, or restricted content. Its
completion does not accept H0 or authorize H1-H4.

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

```sh
cd /home/jmorris/src/beryllium-project/project-manager
bash ./scripts/owner-actions.sh --plan
bash ./scripts/owner-actions.sh
```

The relevant local component commits are:

- `analysis-workbook` clean `main` `8da398d` is twenty-four ahead of last-fetched
  `origin/main` `1ef1ac6`: Project Manager carry `c7cc0fa`, seven PMR-084
  owner commits through `ea72522`, and PMR-086 commits `efbfdb8` and
  `858a73b`, followed by PMR-038 HANDOFF-only commits `f7079fb` and
  `5e037b1`, then PMR-004 work `5684317` / return `635719e`, PMR-050 work
  `231cca4` / return `692caeb`, PMR-055 work `70bea16` / return `6d5d03d`,
  PMR-059 work `9d76048` / return `e6c8aad`, and PMR-063 work `62bd071` /
  return `8b5a301`. The first range remains exact backup request `PMR-085`;
  separate dependent `PMR-088` tracks only the two PMR-086 commits; PMR-089
  freezes the twelve-commit post-`858a73b` closure range at `8b5a301`;
  PMR-095 and PMR-097 separately track carries `5a646df` and `8da398d`;
- `beryllium-hypervisor/` is dirty at active/default `1795400`, behind 0 /
  ahead 6 of last-fetched `origin` `80345e1`; no push path is safe while the
  current owner session remains active. Local candidate
  `beryllium/r8-h0-pmr-080` is `6e93461` and local branch
  `beryllium/r8-c-h0-pmr-081-v3` ends at `0d53120`, both without
  remote-tracking containment. PMR-098 and PMR-100 request distinct canonical
  returns; PMR-090 retains unresolved publication/ref review. PMR-099 is
  closed at exact K0-A plan acceptance only. Generic helper delivery remains
  excluded and no push is authorized;
- `helium-te-poc` clean attached `for-review` at PMR-026 durable return
  `f928aac` is synchronized 0/0 with `origin/for-review`; exact owner-only
  backup request `PMR-091` is closed from script and inspection evidence;
  `main`, `public`, tags, and every other branch were unchanged;
- `cheri-riscv-notes` is dirty at topic HEAD `6cb15e3`, seven ahead of
  last-fetched active origin `9a4c5ef`, with thirteen unfinished modified
  paths. PMR-093/096 remain blocked and no push path is safe;
- `cheri-hypervisor-research` is clean and synchronized 0/0 at private
  `origin/main` `60d5ceb`. Exact PMR-075/092/094 predecessor ranges are
  remotely contained and those backup requests are closed. The later
  research-review change set is separate owner evidence; inactive
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
accepted under `PMD-20260926-002`, satisfying K0-P only. K0-I, K0-S, K0-X,
and K0-R remain blocked; KVM0 and K3 are `NOT RUN`; development kernel/BSP is
`UNDECIDED`. H1-H4 are not authorized. Helium is a review-and-test proof of
concept, not formally verified or hardware validated. No coordination action
grants acceptance, approval, risk acceptance, sign-off, licensing,
publication, or release.
