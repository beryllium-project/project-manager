# D0 transition inventory

- **Record ID:** `PMD-20260914-004`
- **Created:** 2026-09-14
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Complete the bounded D0 inventory requested by `PMR-047` before any
organization rename, active-repository rehome, remote or symlink change,
quarantine move, tasking pilot, or publication action. This inventory covers
the parent coordination repository, all eleven registered component
repositories, and the Microsoft-origin repositories named in current
coordination evidence. No additional repository name was supplied by the
responsible human.

The inventory separates locally observed Git state from GitHub account and
service metadata that requires an authenticated owner check. `unknown` is a
result, not an inference. Private remote URLs are intentionally not reproduced.

Observed revisions on 2026-09-14:

| Repository | Revision | Branch / worktree | Backup observation |
| --- | --- | --- | --- |
| Parent coordination | `79fa3bc` | clean `main` | `upstream/main`, 0 behind / 5 ahead |
| `project-manager` | `174f113` | clean `main` | `origin/main`, 0 behind / 6 ahead |
| `helium-te-poc` | `1ab289c` | clean detached HEAD | matching `for-review` / `origin/for-review`; other refs are not gate evidence |
| `formal-verification-research` | `784be93` | clean `main` | `origin/main`, 0 behind / 2 ahead |
| `osr-claude` | `f2edd17` | clean `main` | `origin/main`, 1 behind / 0 ahead |
| `provenance-review` | `9bfbab3` | clean `main` | `origin/main`, 0 behind / 0 ahead |
| `analysis-workbook` | `b93722b` | clean `main` | `origin/main`, 0 behind / 7 ahead |
| `threat-modeler` | `f4eb272` | clean `main` | `origin/main`, 0 behind / 2 ahead |
| `security-reviewer` | `c13c36e` | clean `main` | `origin/main`, 0 behind / 1 ahead |
| `beryllium-repo` | `65f6d89` | clean `beryllium/single-hart-runtime-r0` | tracked upstream, 0 behind / 0 ahead as of last fetch; live reachability unknown |
| `cheri-riscv-notes-repo` | `6553092` | dirty `docs/reconcile-project-status`, 21 changed entries | no topic-branch upstream; `main` / `origin/main` 0/0 as of last fetch; live reachability unknown |
| `xrv-research-repo` | `d618935` | clean `main` | `backup/main`, 0 behind / 1 ahead; old `origin/main` is stale |

## Inputs

- `../SOT.md` and `../COMPONENTS.md` at parent `79fa3bc`: canonical
  topology, integration form, observed revisions, backup state, and approved
  future identities.
- `HANDOFF.md`, `AGENT-ROSTER.md`, and `components/*.md` at Project Manager
  `174f113`: repository ownership, active-session signals, remote/visibility
  statements, publicability gates, and component-local handoff paths.
- `records/decisions/PMD-20260914-003-approve-federated-research-topology.md`
  at Project Manager `174f113`: approved target namespace and repository
  identities, legacy-reference policy, quarantine rule, and D0 fields.
- `scripts/inspect-components.sh status`, `components`, `symlinks`, `refs`,
  and `registry-check`, observed 2026-09-14T23:06Z: local worktree, branch,
  revision, tracking, tag, and symlink state without network access.
- `../cheri-riscv-notes-repo/meta/handoff.md`, uncommitted worktree copy
  above `6553092`: owner-reported internal visibility, Wiki and issue state,
  pending Actions workflow, unresolved licensing/public-mirror gate, and
  active topic work. Hosted-service facts remain unverified under `PMR-049`.
- `../xrv-research-repo/HANDOFF.md` at `d618935`: reachable private backup,
  stale old origin, and owner-controlled before-push protocol.
- `../osr-claude/HANDOFF.md` at local `f2edd17` and owner correction
  `e275544`: private personal-account origin and the restricted-resource
  quarantine. The restricted subtree was not opened.
- `../formal-verification-research/HANDOFF.md` at `784be93`: stale
  Microsoft-namespace remote wording, reconciled against the restored
  checkout evidence already recorded by `PMR-037`.
- `../helium-te-poc/HANDOFF.md` at `1ab289c`: stale no-remotes statement,
  public-release gate, and local-history restriction, reconciled only as an
  inventory discrepancy under `PMR-026`.
- `../provenance-review/HANDOFF.md` at `9bfbab3`: owner-recorded private
  `beryllium-project/provenance-review` origin and private, not-approved-for-
  release state.

## Disposition

### Repository transition map

| Repository | Current active remote / namespace | Approved target | Visibility | Authorship context | Third-party license / redistribution | Publicability class | Quarantine boundary |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Parent coordination | `upstream` in `beryllium-project`; legacy `origin` is in a Microsoft-named personal namespace | `unknown`; movement of Be workflow repositories is undecided | private | `unknown` | `unknown` | private coordination | no repository-specific quarantine identified |
| `project-manager` | `origin` in `beryllium-project` | `unknown`; movement is undecided | `unknown` | `unknown` | `unknown` | coordination records only; no publication approved | no repository-specific quarantine identified |
| `helium-te-poc` | `origin` plus a `public` tracking ref; exact namespaces intentionally not recorded here | `unknown` | `unknown` | employer context is present in copyright notices; complete authorship status `unknown` | maintained source identifies GPL-3.0-only; complete third-party redistribution review `unknown` | possible public artifact only after its blocked publication gate | frozen local history must not be published; exact quarantine mechanism `unknown` |
| `formal-verification-research` | reachable `origin` in `beryllium-project`; old handoff still names a Microsoft personal namespace | `unknown` / deferred | private backup recorded | `unknown` | bibliography includes paywalled and metadata-only sources; complete repository review `unknown` | private research; future namespace and publication state undecided | downloaded PDFs stay out of Git; no separate quarantine target identified |
| `osr-claude` | private personal-account `origin` | private `agentic-os-research/os-security-research` | private | mixed archive context; exact classification `unknown` | restricted licensed material is not approved for redistribution | private canonical history; not public-safe | `sources/restricted-microsoft/` moves only under a human-approved plan to a separate human-only private repository; owner, slug, method, and history policy `unknown` |
| `provenance-review` | owner-recorded private `beryllium-project/provenance-review` origin | `unknown`; placement undecided | owner-recorded private | `unknown` | `unknown` | private, not approved for release | no repository-specific quarantine identified |
| `analysis-workbook` | private `origin`; namespace not established by sanitized local evidence | `unknown`; placement undecided | private | `unknown` | per-source sensitivity and redistribution metadata; repository-wide state `unknown` | private analysis; no publication approved | no repository-specific quarantine identified |
| `threat-modeler` | private `beryllium-project/threat-modeler` | `unknown`; placement undecided | private | `unknown` | package/source-specific; repository-wide state `unknown` | private threat models; no publication or risk acceptance | no repository-specific quarantine identified |
| `security-reviewer` | private `beryllium-project/security-reviewer` | `unknown`; placement undecided | private | Helium-derived contract is attributed in `AUTHORS.md`; complete status `unknown` | GPL-3.0-only license file recorded; complete third-party review `unknown` | private reviews; no publication or approval | review evidence follows package sensitivity; no separate quarantine target identified |
| `beryllium-repo` | private Microsoft namespace through `origin` | private `agentic-os-research/beryllium`, slug pending final confirmation | private | employer-origin context; exact authorship classification `unknown` | owner handoff identifies GPL-3.0-only; complete third-party review `unknown` | private implementation; no publication or release approved | keep private; no separate quarantine repository identified |
| `cheri-riscv-notes-repo` | internal `gim-home/cheri-riscv-notes` through `origin` | `agentic-os-research/cheri-riscv-notes` | internal | `unknown` | unresolved D5 licensing and public-mirror checklist | first Pages/publication candidate only after licensing, authorship, integrity, and mirror gates | no repository-specific quarantine identified; unapproved corpus material remains non-public |
| `xrv-research-repo` | reachable private `beryllium-project/xrv-research` backup; old Microsoft-origin `origin` remains stale | private `agentic-os-research/cheri-hypervisor-research` | private | `unknown` | pointer/provenance rules recorded; complete repository review `unknown` | private research; no publication approved | no repository-specific quarantine identified |

### GitHub and old-reference surface

| Repository | Old names / paths / API references | Wiki | Tags / releases | Issues / discussions | Pages | Actions | Packages / webhooks / integrations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Parent coordination | legacy Microsoft-named `origin`; current root path is canonical | `unknown` | no local tags observed; releases `unknown` | `unknown` | `unknown` | `.github/` exists; enabled/run state `unknown` | `unknown` |
| `project-manager` | no old repository name recorded | `unknown` | no local tags observed; releases `unknown` | `unknown` | `unknown` | agent configuration exists; hosted Actions state `unknown` | `unknown` |
| `helium-te-poc` | stale handoff says no remotes; old local paths are noncanonical | `unknown` | local tag `v0.6.0`; release state not inferred | `unknown` | publication gate blocked | workflow/service state `unknown` | `unknown` |
| `formal-verification-research` | handoff names old Microsoft personal namespace and stale remote role | `unknown` | no local tags observed; releases `unknown` | `unknown` | `unknown` | `unknown` | `unknown` |
| `osr-claude` | current `osr-claude` identity becomes inactive after migration | `unknown` | no local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | large-push transport note exists; other integrations `unknown` |
| `provenance-review` | no old identity recorded | `unknown` | no local tags observed; releases `unknown` | `unknown` | publication gate open | `unknown` | `unknown` |
| `analysis-workbook` | no old identity recorded | `unknown` | no local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | `unknown` |
| `threat-modeler` | no old identity recorded | `unknown` | no local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | `unknown` |
| `security-reviewer` | no old identity recorded | `unknown` | no local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | `unknown` |
| `beryllium-repo` | current Microsoft repository remains the active canonical symlink target until separately directed; after migration it remains an inactive reference | `unknown` | four local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | `unknown` |
| `cheri-riscv-notes-repo` | `gim-home` home becomes inactive; current symlink target remains until separately directed | owner reports checked-in `wiki/` is authoritative for generated GitHub Wiki; unverified | no local tags observed; releases `unknown` | owner reported issues `#2` and `#3` open and no prior pull requests on 2026-09-11; unverified; discussions `unknown` | candidate only; blocked | uncommitted topic work adds a workflow; owner reports no remote run; unverified | packages / webhooks / integrations `unknown` |
| `xrv-research-repo` | `xrv-research` and old Microsoft-origin namespace become historical; symlink remains unchanged | `unknown` | no local tags observed; releases `unknown` | `unknown` | no publication approved | `unknown` | `unknown` |

### D0 result

`PMR-047` is complete as a reproducible inventory of the registered set.
There is no evidence of an additional human-named Microsoft-origin repository
outside the registered set and parent coordination repository. Authenticated
GitHub service metadata, complete authorship and licensing adjudication, exact
remote targets for repositories marked `unknown`, and confirmation of the
complete Microsoft-origin set remain owner inputs. They are separated into
`PMR-049`; until it closes, no rename, rehome, remote, symlink, visibility,
quarantine, Pages, or publication operation proceeds.

All visibility and hosted-service statements in this record are local or
owner-recorded evidence, not authenticated verification; `PMR-049` verifies
them before use in a transition decision.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, redistribution, publication, release, formal
verification, hardware validation, organization-name availability, repository
creation, remote change, history transfer, symlink retarget, quarantine
movement, or visibility change. It does not establish that a repository is
public-safe. It does not infer remote reachability beyond last-fetched refs,
and it does not inspect any restricted content.

Beryllium remains accepted through R7. R8-H0 is a committed candidate and is
not accepted; H1-H4 are not authorized; K3 hardware is `NOT RUN`. Helium
remains a review-and-test proof of concept and is not formally verified or
hardware validated. Selected Helium C properties are machine-checked by CBMC
only within their stated source, property, and tool boundary.

## Follow-up

- The responsible human completes `PMR-049` from authenticated owner views,
  supplies any omitted Microsoft-origin repository names, and records exact
  answers for the `unknown` fields before approving an organization rename or
  any repository transition.

## Provenance

- Written by the `project-manager` agent from the inputs above. No network
  operation, component write, restricted-content read, remote change, or
  publication action was performed.
