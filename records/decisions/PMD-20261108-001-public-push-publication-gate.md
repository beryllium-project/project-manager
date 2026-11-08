# Public-push publication gate and P0 non-public identifier remediation

- **Record ID:** `PMD-20261108-001`
- **Created:** 2026-11-08
- **Status:** recorded
- **Supersedes:** `PMD-20260906-001` in part (the request priority scale
  of its disposition 5 gains `P0` above `P1`) and `PMD-20260916-003` in part
  (P0 rows are listed first and individually in every todo table); the rest
  of both records stands
- **Superseded by:** None

## Scope

This record answers three coordination questions: how the project keeps a
non-public model identifier, and any later denylisted term, out of every
public remote; how the exposure found on 2026-11-08 is remediated; and how
the request table expresses stop-the-line work. It covers every push to a
public remote from any repository under the Beryllium workspace roots or
with a remote in the `beryllium-project` or `agentic-os-research`
organisations. Pushes to private remotes are outside it, at the responsible
human's direction.

It changes Project Manager scripts, tests, `.gitignore`, instructions,
agent profiles, skill, interface, roster, README, `REHYDRATE.md`, cards,
requests, ledger, handoff, and runbook; adds the user-level skill source
`user-assets/skills/beryllium-publication-gate/SKILL.md`; and adds the
Project Manager-owned parent-root directory `../.publication-gate/` (the
private denylist and private incident notes), with parent `README.md`,
`.github/copilot-instructions.md`, and `COMPONENTS.md` updates. It writes no
component repository and no user-level configuration.

Observed with `scripts/inspect-components.sh` at 2026-11-08T02:28Z: parent
`9c6d167` (only the unregistered `beryllium-cheri/` untracked); Project
Manager `a874b19`, 0/0 with public `origin/main`; `security-reviewer` clean
at a new `main` that a push the Project Manager did not observe had made
0/0 with its public `origin` (exact commits in the private note below);
`beryllium-hypervisor` clean `main` at `c7be2498`, 0/0; `analysis-workbook`
clean `research/AWB-20261105-003-venue-landscape` at `624ce26`, 0/0;
`threat-modeler` clean `aba3350`, 0/6; `provenance-review` `9bfbab3`;
`helium-te-poc` `f928aac`; `formal-verification-research` `388690d` and
`osr-claude` `a6cd0de`, each dirty with owner files; `communications`
`1f66802`; CHERI notes `888f658`; XRV `7361de4`, dirty.

## Inputs

- The responsible human's request of 2026-11-08 (UTC; the evening of
  2026-11-07 at UTC-8), quoted here only in its term-free parts: a
  project-wide check for one non-public model identifier and any details
  about it, done without writing to any repository; `"make a P0 task to
  remediate, across the project"`; reuse of the security-reviewer scrubbing
  work; and `"develop a project-wide SOP and skills/prompts for each repo to
  invoke as publication gating, for all public pushes. private repo pushes
  are not covered by this."`
- The responsible human's structured answers in that turn:
  `scan_with_live_refs` (one read-only history scan of every repository and
  clone, with anonymous live checks of the public remotes),
  `public_bound_only` (remediate public-bound paths; internal records may
  keep exact names under their own repository rules; no private-history
  rewrite), and `global_scoped_hook` (a global Git pre-push dispatcher scoped
  to the Beryllium roots, chaining existing repository hooks, plus an
  `owner-actions.sh` gate and a skill).
- The responsible human's approval (2026-11-08T02:23Z): `"all other model
  names are ok. A3 is ok. confirm p0 hold. approve implementation"`. Only
  the one identifier is non-public; the denylist lives in the private parent
  repository; the P0 hold is confirmed; implementation is approved. Pushes
  still need a same-turn confirmation.
- The read-only scan (2026-11-08T01:48Z): 1,695 unique commits across 39
  repositories and clones, working trees, commit messages, identities, ref
  names, and tag text; all six public remotes were then clean. Findings lay
  in one local, unpushed security-reviewer commit and in Beryllium internal
  release records, some of them in paths that the public snapshot copies.
- Live anonymous `ls-remote` at 02:28Z and 03:30Z, the same credential-free
  probe that `scan_with_live_refs` authorized at 01:48Z: the public
  security-reviewer `main` had moved to include that commit. At 04:14Z the
  gate's own `audit --remote origin` found the same seven findings in the
  live public view (paths and lines only in the private note).
- `component://security-reviewer` publication-safe provenance work, reused
  here: a non-public model identifier is recorded as `unlisted` with a
  `/package/model_id` qualification that explains the redaction without
  reproducing the identifier, a publication-checklist line, and fail-closed
  validation with mutation tests. Its check embedded the identifier in a
  reversible encoding, which this record rejects.
- `component://beryllium-hypervisor` internal release tooling: a
  forbidden-term category that no rule may keep, applied to every blob and
  commit message (design reused; its embedded literal rejected); and
  `mvp/tools/snapshot.sh`, which copies everything except four excluded
  paths into the public snapshot and has no term check.
- `PMD-20261012-001` and `PMD-20261012-002`: the public repositories. The
  Beryllium owner record `component://beryllium-hypervisor/planning/HANDOFF.md`
  at `c7be2498` adds that, since 2026-10-31, the canonical checkout's
  `origin` is the private `beryllium-project/beryllium-hypervisor-internal`
  and `beryllium-project/beryllium-hypervisor` is the public review snapshot,
  changed only by the responsible human's own pushes; the authorized 01:48Z
  probe read that snapshot anonymously. The scan also covered every local ref
  of the snapshot clone `beryllium-hypervisor-rc3/`, including its superseded
  snapshot branch, with no finding, and the identifier first entered any
  Beryllium history in a commit dated 2026-11-06, after the last snapshot
  push of 2026-11-05.
- `PMD-20260904-003`: component scripts, tests, and agent instructions lie
  outside the three carry classes, so component changes are owner requests.
- `PMD-20260906-001` (disposition 5, the request priority scale) and
  `PMD-20260916-003` (the todo-table rules).

## Disposition

1. **Gate scope.** Every push to a public remote from a repository under
   the Beryllium workspace roots or with a remote in the
   `beryllium-project` or `agentic-os-research` organisations passes the
   publication gate first. A remote is public when it is a recorded public
   repository or anonymous `git ls-remote` succeeds with every credential
   source disabled; when visibility cannot be determined, the push is
   refused. Private and local remotes pass unscanned.
2. **Private denylist.** The canonical denylist is
   `../.publication-gate/denylist` in the private parent coordination
   repository, pushed only to its private `upstream`. The human-run
   installer copies it to `~/.config/beryllium/publication-gate/denylist`
   with mode 0600. No entry is ever written into a public artifact in any
   form or encoding; Project Manager records refer to entries by number only
   and describe them only in the private note. The responsible human
   confirmed that every other model name in the public repositories is
   public.
3. **Tooling.** `scripts/publication-gate.py` holds no entry. It derives
   case-insensitive, separator-tolerant, reversed, ROT13, escaped (octal,
   hex, Unicode, percent, HTML entity), character-code, hex-byte, and base64
   variants in memory, and scans file contents, file names, commit messages,
   identities, tag text, and ref names. Its modes are `pre-push`, `check`,
   `audit` (named refs, local branches and tags, or `--all-refs`),
   `audit --remote` (what a public remote serves now: every live ref name it
   lists anonymously and everything reachable from those tips, refused when
   a live tip is absent locally), `scan-tree`, `scan-worktree`,
   `validate-denylist`, `classify`, and `self-test`. A finding blocks with no allowlist, and output never
   prints matched text, an entry, or a carrying name. An opt-in
   `--advisory` pass counts credentials, home paths, private addresses,
   session identifiers, and the Codasip name without blocking.
4. **Enforcement.** The human-run `scripts/publication-gate-setup.sh`
   installs the gate, the hook dispatcher `scripts/publication-gate-hook.sh`,
   the user-level skill `beryllium-publication-gate`, and the denylist, and
   adds global `includeIf` entries (`gitdir:` for each workspace root and
   `hasconfig:remote.*.url:` for the two organisations) that point
   `core.hooksPath` at the dispatcher. The dispatcher runs the gate at
   `pre-push` and chains every listed hook to the repository's own hook; its
   `check` fails if a scoped repository overrides `core.hooksPath` or relies
   on a hook it does not chain. Every push step of `owner-actions.sh` runs the
   gate's `check` first and refuses on failure. `git push --no-verify` and
   any other hook bypass are prohibited for public remotes. A visibility
   change to public, a new public repository, or a first push to an empty
   public remote requires `audit --all-refs` after fetching every ref about
   to become visible, tags included; `check` alone does not suffice there,
   because it passes a remote that is still private unscanned.
5. **Separate installer.** The plan assumed an extension of
   `scripts/beryllium-governance.sh`. The gate instead has its own installer,
   so that the governance transaction stays limited to Copilot hook files
   under `PMD-20261006-001` and its sandbox tests never touch Git global
   configuration. Both installers are human-run; the Project Manager never
   runs `install` or `uninstall` against real user configuration. Every
   run of the gate installer writes a timestamped log under the ignored
   `scratch/publication-gate-setup/` and prints its path, per the
   responsible human's 2026-09-21 logging preference.
6. **Project Manager use.** The Project Manager may run the gate's
   read-only modes (`check`, `audit` including `audit --remote`,
   `scan-tree`, `scan-worktree`, `validate-denylist`, `classify`,
   `self-test`) against this repository, the parent, and registered component
   repositories, and, to verify publication-bound work, against the Beryllium
   publication clones under the workspace root (such as
   `beryllium-hypervisor-rc3/` and the clean release repository); these
   modes write nothing. Live remote state is read only through the gate's
   anonymous probe (`classify`, `check`, `audit --remote`), never by a
   separate `git ls-remote`; the 02:28Z and 03:30Z re-checks of this turn used
   the same credential-free probe as the authorized 01:48Z scan.
   `scripts/validate-pm.sh` scans this repository's working tree with the
   parent denylist and refuses a denylist-like file here. Before its own
   public push, the Project Manager runs `check` against `origin`.
7. **Wording.** A non-public model is `unlisted` in public text, with
   nothing else said about it: no vendor, base model, family, version,
   suffix, size, date, relationship to another model, or comparison. Model
   provenance in public-bound files reuses the
   security-reviewer qualification convention.
8. **Priority `P0`.** `P0` is stop-the-line: an active or imminent
   disclosure or data loss. P0 rows are listed first and individually in
   every todo table and runbook. `validate-pm.sh` and `project-tasking.sh`
   accept `P0` through `P4`.
9. **Hold (confirmed).** No public push of security-reviewer except the
   remediation's force push; no public Beryllium snapshot refresh, merge of
   the internal release branch into `main`, or release publication until
   `PMR-139` closes; and no public Project Manager push until the
   security-reviewer rewrite lands, because these records describe the
   incident. Every other public push passes the gate; until the gate is
   installed on the current workstation, `owner-actions.sh` refuses every
   public push step because the gate fails closed without its denylist.
10. **Requests.** P0 `PMR-138` (security-reviewer: remediate the published
    history), `PMR-139` (beryllium-hypervisor: make public-bound paths and
    tools entry-free and fail closed), and `PMR-140` (project-manager:
    install, verify, and lift the hold). Gate adoption, which adds the
    trigger phrase `check publication gate` and the gate command to each
    component's instructions, is `PMR-141` through `PMR-150`. `PMR-111` is
    superseded by the observed push and `PMR-138`. The `PMR-118` and
    `PMR-123` returns are observed, but closure waits for the rewrite that
    replaces their commit.
11. **Private note.** Exact commits, paths, lines, timeline, and the
    responsible-human remediation commands are only in the private
    `../.publication-gate/P0-20261108-001.md`.
12. **Launcher readiness.** The Project Manager `.gitignore` ignores the
    Copilot CLI local settings `.github/copilot/settings.json`, its lock,
    and `settings.local.json`, which `PMD-20261025-001` keeps untracked, so
    that the human-run `owner-session.sh` sees a clean Project Manager
    checkout for the P0 owner sessions. Their content stays unverified local
    state.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance,
approval, review approval, risk acceptance, sign-off, licensing,
redistribution, publication, release, formal verification, hardware
validation, implementation authority, component write authority, push,
force push, remote change, visibility change, or tag authority. Passing the
gate is not publication approval. It does not decide whether to make a
repository private for containment, whether to force-push, or whether and
how to contact GitHub Support; those are the responsible human's decisions.
It does not change any Beryllium internal record that stays out of every
public path, rewrite any private history, or install anything. It is not a
security review. Beryllium is accepted through R7; R8-H0 is a committed
candidate and is not accepted; H1-H4 are not authorized; K3 hardware is
`NOT RUN` in Project Manager records. Helium remains a review-and-test proof
of concept and is not formally verified or hardware validated.

## Follow-up

- The responsible human decides containment and runs the remediation steps
  in the private note, starting with the security-reviewer owner session
  for `PMR-138`.
- The responsible human installs and checks the gate on `l1`, from the
  current workspace root recorded in `../COMPONENTS.md`:

  ```sh
  bash ./project-manager/scripts/publication-gate-setup.sh install
  ```

- The Project Manager verifies `PMR-138` with the gate's
  `audit --remote origin` once the force push lands (or, while the
  repository is private for containment, `audit --all-refs` after a full
  fetch before it returns to public), verifies `PMR-139` with `audit` of
  every public-bound Beryllium ref and `audit --remote origin` of the
  snapshot clone, closes `PMR-140`, and lifts the hold.

## Provenance

- Written by the `project-manager` agent on `claude-opus-5.5` from the
  inputs above, maintained inspection, and read-only gate runs against the
  repositories. No component repository or user-level configuration was
  modified.
