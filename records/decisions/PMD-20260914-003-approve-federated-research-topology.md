# approve federated research topology

- **Record ID:** `PMD-20260914-003`
- **Created:** 2026-09-14
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's decisions on the target organization,
repository identities, topic ownership, task-discovery model, publication
pilot, Beryllium rehome, and restricted-resource boundary for the federated
research topology reviewed with Claude Fable 5.1. This record changes no
current repository name, remote, visibility, symlink, content location, or
publication state.

Observed registered revisions when recorded: Project Manager `c7a40b9`;
parent `bcdc88f`; `cheri-riscv-notes-repo` dirty at `6553092`;
`osr-claude` clean at `f2edd17`, one behind `origin/main`;
`xrv-research-repo` clean at `d618935`, one ahead of `backup/main`;
`formal-verification-research` clean at `784be93`, two ahead;
`analysis-workbook` clean at `b93722b`, seven ahead; `beryllium-repo` clean
at `65f6d89`; `threat-modeler` clean at `f4eb272`; `security-reviewer`
clean at `c13c36e`; `provenance-review` clean at `9bfbab3`; and
`helium-te-poc` clean at detached `1ab289c`.

## Inputs

- The responsible human on 2026-09-14 approved planning decisions 1, 2, 3,
  5, 6, 7, and 8 from the reviewed consolidation plan.
- The responsible human selected the existing GitHub organization
  `Agentic-OS-Development` as the target namespace and directed that it be
  renamed to `agentic-os-research`.
- The responsible human additionally directed that `beryllium-repo` and
  other Microsoft-origin repositories identified during inventory be
  rehoused on GitHub, and that quarantined resources live in a separate
  private repository visible only to the responsible human.
- The responsible human clarified that all active work will move out of the
  Microsoft repositories. Those repositories remain available as historical
  references but are no longer active development or research homes.
- `components/cheri-riscv-notes-repo.md`: the repository owns the canonical
  CHERI/CHERI-RISC-V corpus, wiki, BibTeX inventory, and SoK, with licensing
  and public-mirror gates still open.
- `components/osr-claude.md`: the repository is a large private OS-security
  archive with a restricted licensed subtree that the Project Manager never
  opens or copies.
- Project Manager reading of `components/xrv-research-repo.md`: the
  repository now has a stable
  CHERI-first hypervisor/capability-virtualization scope and owner-controlled
  review and collaboration protocols; the old experimental/unknown name is
  obsolete.
- Project Manager reading of `components/formal-verification-research.md`:
  generic verified-systems
  research and a bounded Beryllium-specific workstream currently coexist
  without requiring an immediate split.
- `records/decisions/PMD-20260914-002-owner-return-pull-protocol.md`: the
  existing pull-based return model remains the basis for component tasking;
  the approved target adds generated PM-side tasking views rather than
  duplicated component task state.
- GitHub Docs, "Renaming an organization", checked 2026-09-14: repository
  links generally redirect, but the old organization profile and API name do
  not; the old organization name becomes reusable, and remote URLs should be
  updated.
- GitHub Docs, "Transferring a repository", checked 2026-09-14: repository
  and Git transport redirects are provided, but Pages URLs are not
  redirected and reuse of the old location can destroy redirects.
- An unauthenticated check on 2026-09-14 confirmed the existing organization
  page and found no public repositories. The target organization URL did not
  resolve; GitHub's authenticated rename form remains authoritative for name
  availability.

## Disposition

The responsible human approves the following target state:

Approved-plan mapping: plan decision 1 -> disposition 2; 2 -> 3; 3 -> 4 and
5; 5 -> 6; 6 -> 7; 7 -> 9; 8 -> 2 and 12. Plan decision 4 (which namespace)
is resolved by disposition 1. The subsequently added Beryllium/Microsoft
rehome directions are dispositions 10 and 11.

1. **Organization.** Rename GitHub organization
   `Agentic-OS-Development` to `agentic-os-research`. This is the approved
   target namespace for the independent research layer, the Beryllium
   implementation repository, and active successors to Microsoft-origin
   project repositories. Whether the existing Be-specific workflow
   repositories already under `beryllium-project` also move is not yet
   decided.
2. **CHERI-RISC-V SoK.** Keep the repository slug
   `cheri-riscv-notes`; brand `sok/` as the **CHERI-RISC-V SoK**. Its corpus,
   wiki, reference inventory, and SoK remain canonical and Beryllium consumes
   pinned revisions as an external reference. It is the first
   publication/Pages pilot candidate after its license, authorship,
   integrity, and public-mirror gates close; publication itself remains a
   separate human gate.
3. **CHERI hypervisor research.** After the D0 inventory and remote gates,
   establish a new active repository
   `agentic-os-research/cheri-hypervisor-research`. It remains independent
   and owns CHERI-first hypervisor/VMM/capability-virtualization synthesis,
   confidential-computing comparisons, `REV-*` provenance, and collaboration
   records.
4. **OS security research.** After D0, establish a new active repository
   `agentic-os-research/os-security-research` and migrate its owner workflow
   to tool-neutral Copilot instructions. Its current canonical history stays
   private because restricted and heterogeneous source material is already
   tracked.
5. **Quarantine.** Quarantined licensed resources must be housed in a
   distinct private repository visible only to the responsible human. The
   exact owner, slug, transfer method, and history policy are `unknown`
   pending the D0 licensing/authorship inventory. Moving current files does
   not by itself make the existing OS-security Git history public-safe.
6. **Formal verification.** Keep `formal-verification-research` independent
   and mixed for now. Mark the Beryllium workstream as project-specific and
   extract it only on a later publication or maintenance trigger.
7. **Be-specific evidence producers.** Keep `analysis-workbook`,
   `threat-modeler`, `security-reviewer`, and `provenance-review` separate.
   Consolidate contracts before considering repository merges; independence
   remains especially important for security review.
8. **Topic ownership.** CHERI-RISC-V SoK owns CHERI/RISC-V
   ISA/platform/toolchain/corpus facts; CHERI hypervisor research owns
   hypervisor/VMM/confidential-computing synthesis including the
   hypervisor-facing SmMTT workstream; OS security research owns
   capability-OS, MAC, reference-monitor lineage, and archives; formal
   verification research owns generic methods, tools, systems, and proof
   boundaries. Existing overlap remains in place with cross-citations until
   an owner deliberately supersedes it.
9. **Task discovery.** Approve the target UX where the human starts Copilot
   in a component and says "check Project Manager tasking." The authoritative
   state remains `outbox/component-requests.md`; future generated PM-side
   per-component tasking views provide discovery without copying mutable task
   state into component handoffs. Owner results continue through the
   component-owned return protocol.
10. **Beryllium implementation.** Rehouse the Beryllium implementation in a
    new private active repository under the approved organization. The
    recorded target slug is `agentic-os-research/beryllium`, pending final
    responsible-human confirmation before creation. Other Microsoft-origin repositories are
    inventoried and decided individually rather than moved as an unnamed
    batch.
11. **Legacy Microsoft homes.** Microsoft-hosted repositories remain
    read-only historical references. They are not renamed or transferred away
    by default, because the responsible human wants the old homes to remain
    available. For each repository, D0 selects a new private active repository
    under `agentic-os-research`, verifies the copied history and active branch,
    changes the active checkout to the new remote only through the owner, and
    labels the old remote/reference as inactive. No future active commit is
    intentionally pushed to the Microsoft home.
12. **Publication topology.** No umbrella portal is approved yet. Each
    publishable independent repository may own its eventual Pages site. A
    portal is reconsidered only after at least two public sites exist and
    aggregation has demonstrated value.
13. **No rename before D0.** Organization and repository renames, transfers,
    remotes, symlink changes, and publication wait for an inventory covering
    canonical remote, visibility, third-party license, authorship context,
    publicability class, Wiki, tags/releases, issues/discussions,
    packages/actions/Pages dependencies, old-name references, and
    active-session/worktree state.

14. **Formal-verification namespace.** The future active namespace for
    `formal-verification-research` is deliberately `unknown` pending D0. Its
    content model is approved to remain unchanged; its organization placement
    is not yet selected.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. It does not execute the organization rename, transfer or rename a
repository, create or change a remote, retarget a symlink, move or open
quarantined content, rewrite Git history, choose a quarantine repository
name, publish a site, select a license, or move the existing Be workflow
repositories. Every external operation remains a separate responsible-human
action after D0 review.

Because the Microsoft repositories must remain as references, this record
does not assume GitHub repository transfer is the migration mechanism. The
default target is a new private active repository with verified history,
while the old repository remains inactive; the owner chooses the exact
mechanism per repository after D0.

## Follow-up

- Complete and review the D0 inventory in the next Project Manager planning
  turn, then the organization owner may use GitHub organization settings:
  `Agentic-OS-Development` -> `Settings` -> `Danger zone` ->
  `Rename organization`, confirm `agentic-os-research`, and return the exact
  result before any repository transfer or remote update.

## Provenance

- Written by the `project-manager` agent from the responsible human's
  approvals and additional rehome/quarantine directions on 2026-09-14.
- The two-pass consolidation review used Claude Fable 5.1 and recommended the
  federated topology, D0 stop gates, tool-neutral names, independent SoK and
  hypervisor research, private OS-security canonical history, generated
  tasking discovery, and a CHERI-RISC-V SoK publication pilot.
