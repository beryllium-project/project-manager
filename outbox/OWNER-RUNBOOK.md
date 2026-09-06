# Owner runbook: open items by priority

**Maintained by:** the `project-manager` agent, refreshed every coordination
turn from `component-requests.md` (the request table is the source of the
`Priority` column) and `../HANDOFF.md` "Blockers and open human gates".
**Last refreshed:** 2026-09-06 (fifth coordination turn).

Every step below is the responsible human's or the component owner's action.
The Project Manager agent never runs `scripts/owner-actions.sh`, never pushes,
and never writes inside `helium-te-poc/` or `beryllium-repo`; it records what
you did from your statement, the script's log in `scratch/owner-actions/`
(ignored by Git), and the observed component state.

Priorities: `P1` act now (data-loss exposure, or blocks other work); `P2`
next (unblocks coordination or another decision); `P3` housekeeping, when next
working in that component; `P4` waits on an external input, another machine,
or a gate that is not actionable now.

## Quick path: one script run covers most of it

```sh
cd /home/jmorris/src/l1/src/beryllium-project/project-manager
bash ./scripts/owner-actions.sh --plan --apply-edits --files-search   # read-only preview, diffs included
bash ./scripts/owner-actions.sh --apply-edits --files-search          # y/N per edit, commit, and push
```

That run: applies and commits `PMR-019` (P2), `PMR-002` (P3), and the wording
half of `PMR-014` (P3) after showing each diff and, for the transfer queue,
running the workbook's own validator; searches for the lost retained PM
artifacts (P2) and offers to remove the broken parent `files` link if nothing
is found; pushes analysis-workbook, osr-claude, formal-verification-research
(`backup`), this repository, and the parent; fetches; prints the restart
snapshot and this list by priority. Then start Copilot CLI here, select
`/agent project-manager`, and say what the run did (or point it at the log).

Not covered by the script, in priority order: `PMR-013` (P1, one-time remote
decision, commands below), `PMR-003` (P2, `beryllium-repo`, pasted command
below), `PMR-020` (P2, credentials), the pointer half of `PMR-014` (P3),
`PMR-004` (P3), `PMR-009` (P4).

## P1

### PMR-013: xrv-research-repo `7314e2f` exists only on this workstation

`main` is 1 commit ahead of `origin/main`, and `origin` is in the unreachable
`jamorris_microsoft` namespace, so the nine `REV-20260904-001..009` records
have no off-machine copy. Decide a reachable private remote. Recommended: a
second remote named `backup` in the `beryllium-project` organization, `origin`
untouched (the same pattern the script used for formal-verification-research).

```sh
cd /home/jmorris/src/l1/src/beryllium-project/xrv-research-repo
gh repo create beryllium-project/xrv-research --private
git remote add backup https://github.com/beryllium-project/xrv-research.git
git push -u backup main
git ls-remote backup refs/heads/main        # expect 7314e2f...
```

From then on `scripts/owner-actions.sh` pushes `main -> backup` for this
component on every run (target `push_xrv`, remote `backup`). Alternative: keep
`origin` and authenticate the EMU account on this workstation, which the
registry records as not possible from here. Closure: the next turn observes
`backup/main` at `7314e2f` in the read-only `refs` listing and closes
`PMR-013`; if you choose differently, say so and the request is updated.

## P2

### PMR-019: analysis-workbook mirrors `HET-001` to `recorded`

Automated by `--apply-edits`: three exact table edits in
`outbox/helium-transfer-queue.md` (status-history rows `routed` and
`recorded` citing `PMD-20260905-002` at Project Manager commit `94888ea` and
`PMR-016`; queue-summary status `recorded`, input state unchanged at
`unaccepted`; `ACTIVITY-002`), validated with the component's
`scripts/validate-helium-transfer-queue.sh --baseline <current file>` before
you are asked, then committed as `docs: mirror HET-001 to recorded (PMR-019)`
and pushed by `push_awb`. The exact text is `owner-edits/PMR-019-*.new.txt`,
based on the rows in
`../records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md`
"Exact mirror rows for PMR-019" with three differences: the appended rows are
dated the day you apply them (the script replaces `@DATE@`), the locators name
the Project Manager commit `94888ea` that introduced the record, and
`ACTIVITY-002` says the rows are based on that record.

Still the maintainer's afterwards: the component's `HANDOFF.md` says in
several sentences that `HET-001` is `new`; the script prints those lines.
Refresh them in the maintainer's words, for example with the component's
agent:

```text
cd /home/jmorris/src/l1/src/beryllium-project/analysis-workbook   # then: /agent analysis-workbook
Refresh HANDOFF.md so it reflects that HET-001 is now `recorded` (input state
still `unaccepted`) per outbox/helium-transfer-queue.md status history, citing
workspace://project-manager/records/decisions/PMD-20260905-002-het-001-owner-triage-recorded.md;
run bash ./tests/validate-agent.sh and commit.
```

If you prefer the agent to do the whole mirror instead of `--apply-edits`,
give it the same record path and the section name; the transition table allows
`new` to `recorded` directly, and the maintainer decides whether the Project
Manager-owned record meets its `recorded` definition or whether to stop at
`routed`. Closure: the next turn reads the queue file at the new commit and
closes `PMR-019`; `PML-0017` stays `routed` with the observed status noted.

### PMR-003: beryllium-repo `planning/HANDOFF.md` names a former path and calls H0 uncommitted

Carry-ineligible for the Project Manager and deliberately outside
`--apply-edits`; paste the following yourself. It replaces exactly six
occurrences and stops with an error if the file differs from what was read at
`65f6d89`. The path is computed from the workspace symlink, so no absolute
path is copied here.

```sh
cd /home/jmorris/src/l1/src/beryllium-project/beryllium-repo
git status --short --branch                     # expect a clean beryllium/single-hart-runtime-r0
python3 - <<'PY'
import pathlib, re, subprocess
root = subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip()
p = pathlib.Path("planning/HANDOFF.md"); s = p.read_text(encoding="utf-8")
def rep(old, new, count):
    global s
    n = s.count(old); assert n == count, (old[:60], n)
    s = s.replace(old, new)
def resub(pattern, new, count):
    global s
    s, n = re.subn(pattern, new, s, flags=re.M); assert n == count, (pattern, n)
rep("its candidate is\nlocal-uncommitted, not reviewed, blocked by 81 H0 facts, and not accepted.",
    "its candidate is\ncommitted as `102f2b0`, not reviewed, blocked by 81 H0 facts, and not accepted.", 1)
rep("; it remains local-uncommitted,\n  not reviewed, blocked, and unaccepted.",
    "; it is committed as candidate\n  `102f2b0`, not reviewed, blocked, and unaccepted.", 2)
rep("Review the local-uncommitted,\n  not-reviewed candidate",
    "Review the committed (`102f2b0`),\n  not-reviewed candidate", 1)
# the former workstation path (under a former home directory) becomes this checkout's real path
home_dirs = "/" + "home/"
resub(r"^- Repository: `" + home_dirs + r"[^`]*/beryllium`$", "- Repository: `" + root + "`", 1)
resub(r"^cd " + home_dirs + r"\S*/beryllium$", "cd " + root, 1)
p.write_text(s, encoding="utf-8"); print("6 replacements applied")
PY
git diff -- planning/HANDOFF.md                 # review: no acceptance is inferred anywhere
git add planning/HANDOFF.md
git commit -m "planning: name the canonical workstation path and the committed H0 candidate 102f2b0 (PMR-003)" \
  -m "The handoff called the R8-H0 candidate local-uncommitted and named a former workstation path. It is committed as 102f2b0 on beryllium/single-hart-runtime-r0 and remains not reviewed, blocked by the 81 H0 facts, and not accepted; H1-H4 stay unauthorized and K3 NOT RUN. Requested by the Beryllium Project Manager (PMR-003)." \
  -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
git push origin beryllium/single-hart-runtime-r0    # optional; your decision as owner
```

`102f2b0` ("r8: add bounded H0 profile freeze") was confirmed to exist on
`beryllium/single-hart-runtime-r0` and on `origin` by the read-only
`scripts/inspect-components.sh refs beryllium-repo 102f2b0` on 2026-09-06.
Closure: the next turn observes the new HEAD and the wording and closes
`PMR-003`.

### PMR-020: cheri-riscv-notes-repo `origin` fetch fails with an authentication error

Two consecutive script runs (2026-09-05T19:05Z, 2026-09-06T08:39Z) could not
fetch `origin`, so its live backup state is `unknown`. The remote host and
organization are not recorded here; read them yourself:

```sh
cd /home/jmorris/src/l1/src/beryllium-project/cheri-riscv-notes-repo
git remote -v
gh auth status
git fetch origin            # reproduces the failure
```

Then one of: `gh auth login` (or `gh auth refresh`) for the account that can
see that organization; a credential helper for that host; or switching the
remote to SSH (`git remote set-url origin <ssh form of the same repository>`).
Re-run `bash ./scripts/owner-actions.sh --only fetch_snapshot` from
`project-manager/`; a clean fetch in the log closes `PMR-020`. If the remote
is simply not reachable from this workstation, say so and the registry records
that instead of `unknown`.

### Lost retained PM artifacts (not a request; `../HANDOFF.md` "Retained PM session artifacts")

Automated by `--files-search` (add `--files-root DIR` for every other place
worth searching, for example a mounted backup): a read-only `find` for the
seven recorded names, a SHA-256 check of any `be-k3-h0-collection.tgz` found
against the recorded `277d6168...`, then, only if nothing is found, a y/N
prompt to remove the broken parent `files` link. Also worth one check on any
other machine that ran Beryllium sessions in August 2026. Afterwards tell the
Project Manager one of: "record the loss" (it writes a decision record; the K3
archive appears to be the only unregenerable item, the rest is the Beryllium
owner's to regenerate from the checked launchers) or "found at <path>" (it
records the location and you retarget the link by hand).

## P3

### PMR-002: osr-claude handoff still says HTTPS remote and "mktemp fix pending"

Automated by `--apply-edits`, with two preconditions checked first (`origin`
is an SSH remote; `tools/md-to-html.sh` contains the `md-to-html.XXXXXX`
template). Two lines of `HANDOFF.md` "Infrastructure facts" are replaced by:

```text
- Remote: `origin` is the private `xjamesmorris/osr-claude` repository, reached over SSH since the ~52 MB sources batch (HTTPS died mid-transfer on the original ~800 MB push, so large pushes use SSH).
- `tools/md-to-html.sh --check` works: the earlier `mktemp` template bug (too few X's) is fixed with a `md-to-html.XXXXXX` template.
```

Commit `docs: refresh infrastructure facts (PMR-002)`, pushed by `push_osr`.
The component's convention is to ask before changing it; the y/N prompt is
that question, answered by its owner. Closure: observed at the new HEAD.

### PMR-014: formal-verification-research wording (automated) and five routed pointers (yours)

Wording half, automated by `--apply-edits`: the "parent Project Manager
agent" bullet in `.github/copilot-instructions.md` (`owner-edits/PMR-014-1`),
the first "Workspace relationship" paragraph in `README.md` (`PMR-014-2`, one
sentence appended), and the second paragraph's sentence "The parent Project
Manager agent may perform the narrowly defined ledger and handoff
housekeeping described there" (`PMR-014-3`) are replaced by text that
describes the standing carry authority carried into `COLLAB.md` at `ccb48f6`
(class 2 `sources/bibliography.md` pointers; class 3 wording in `COLLAB.md`
and `HANDOFF.md`) instead of the former housekeeping budget. Commit `docs:
align Project Manager wording with COLLAB.md (PMR-014)`, pushed by `push_fvr`
(`backup`). The request stays open for the pointer half below.

Pointer half, yours: `sources/bibliography.md` "Routed pointers awaiting owner
triage" holds five metadata-only pointers recorded on 2026-09-04 (`PMQ-007`
Petroni et al. Copilot coprocessor monitor, USENIX Security 2004; `PMQ-010`
NIST SP 800-193; `PMQ-012` OSLO measurement chain; `PMQ-014` IEC 61508-2:2010,
paywalled; `PMQ-015` SWATT, paywalled). For each, tell the Project Manager
`keep` (leave in that section), `move` (name the topic section), or `remove`;
it carries a removal as a class-2 write on your instruction and gives the
ledger row (`PML-0007`, `0010`, `0012`, `0014`, `0015`) a superseding
`rejected` note, or you edit the file yourself. Closure: wording observed at
the new HEAD and a disposition per pointer.

### PMR-004: `scripts/readonly-inspect.sh` registered lists (analysis-workbook, threat-modeler)

Owner-only scripts, so an exact edit, not a scripted one. In each file add one
line `    project-manager` to the `registered_components=(` array:

```sh
cd /home/jmorris/src/l1/src/beryllium-project/analysis-workbook
python3 - <<'PY'
import pathlib; p = pathlib.Path("scripts/readonly-inspect.sh"); s = p.read_text()
old = "registered_components=(\n    provenance-review\n"; assert s.count(old) == 1
p.write_text(s.replace(old, "registered_components=(\n    project-manager\n    provenance-review\n")); print("ok")
PY
bash -n scripts/readonly-inspect.sh && bash ./tests/validate-agent.sh
git add scripts/readonly-inspect.sh && git commit -m "scripts: register project-manager in readonly-inspect (PMR-004)" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"

cd /home/jmorris/src/l1/src/beryllium-project/threat-modeler
python3 - <<'PY'
import pathlib; p = pathlib.Path("scripts/readonly-inspect.sh"); s = p.read_text()
old = "registered_components=(\n    beryllium-repo\n"; assert s.count(old) == 1
p.write_text(s.replace(old, "registered_components=(\n    project-manager\n    beryllium-repo\n")); print("ok")
PY
bash -n scripts/readonly-inspect.sh && bash ./tests/validate-agent.sh
git add scripts/readonly-inspect.sh && git commit -m "scripts: register project-manager in readonly-inspect (PMR-004)" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

If a component's `readonly-inspect.sh` resolves entries by a fixed path
pattern, check that `project-manager` resolves as a direct checkout before
committing (run its `components` mode). The next script run pushes both
(`push_awb`, `push_tm`). Closure: observed at the new HEADs.

## P4

### PMR-009: two source pointers for cheri-riscv-notes-repo (reference database on another machine; gate D4)

The corpus is a SQLite `refs` table kept in a Copilot session on the Windows
machine named in the component's `meta/handoff.md`; `references/*.md` and
`references.bib` are generated exports that must not be hand-edited. In that
session, as two `inbox` rows (metadata only; both sources are public):

| Field | PMQ-008 | PMQ-011 |
| --- | --- | --- |
| title | Exploiting the DRAM rowhammer bug to gain kernel privileges | The Unpatchable Silicon: A Full Break of the Bitstream Encryption of Xilinx 7-Series FPGAs (Starbleed) |
| authors | Mark Seaborn; Thomas Dullien | Maik Ender; Amir Moradi; Christof Paar |
| year / type / venue | 2015 / blog / Google Project Zero | 2020 / paper / USENIX Security |
| url | the Project Zero post recorded in `../../analysis-workbook/outbox/pm-queue.md` row `PMQ-008` | the USENIX presentation page recorded in row `PMQ-011` |
| topic / riscv_relevance | security / 0 (counter-source; not CHERI) | hardware / 0 (counter-source; FPGA configuration interface) |
| summary | Beryllium analysis counter-source: PTE bit flips as a privilege-escalation path outside any capability model | Beryllium analysis counter-source: configuration-interface secrets recovered from the device itself |

Then your D4 decision (`included` or not), regenerate the exports, commit, and
tell the Project Manager `accepted`, `rejected`, or `deferred` per pointer;
ledger rows `PML-0008` and `PML-0011` are updated and the class-1 queue
edits are carried in `analysis-workbook/outbox/pm-queue.md`. Nothing is
needed from this workstation.

## Beryllium gates (recorded, not actionable now)

| Item | Priority | State |
| --- | --- | --- |
| Two H0 input selections (normative Fedora 44 H0 static OCI; proposed H1/H2 path inventory) | P3 | Yours alone; wait for the retained-artifacts decision above (their inputs) and the exact board/firmware facts; the Project Manager infers nothing |
| H0 acceptance, H1-H4 authorization, K3 execution | P4 | Open; `NOT RUN`; not actionable now |
| Helium Tier 7/8 gate content | - | Not a Project Manager gate; the component states its approved refs must remain frozen; backed up 2026-09-06 (`PMR-018` closed) |

Beryllium is accepted through R7; R8-H0 is a committed candidate and is not
accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium is a
review-and-test proof of concept, not formally verified or hardware validated.
