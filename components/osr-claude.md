# osr-claude

- **Workspace entry:** `../osr-claude/` (ignored direct checkout)
- **Ownership:** agent-owned research archive; ask the
  user before any modification. Carry-eligible in principle under the standing
  carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`, but the Project Manager asks the user first per
  this convention and never touches `sources/restricted-microsoft/`
- **Agent:** reusable Copilot skill
  `.github/skills/os-security-research/`
- **Local instructions to read first:** `.github/copilot-instructions.md`,
  `HANDOFF.md`
- **Observed state:** clean `main` at `49fbfd6`, synchronized with private
  active `origin/main`; clean root snapshot `58f8023` contains the reviewed
  non-restricted tree, while inactive `legacy-personal/main` preserves old
  private history at `e275544`. `PMR-044` and `PMR-027` are closed

## Role

Operating-system security research archive: surveys on MAC labels on
capabilities and on RISC-V Supervisor Domains / SmMTT, preserved primary
sources, grep-friendly text extractions, acquisition manifests, generated
standalone HTML, and a reusable research skill.

## Boundaries and conventions

- Markdown is the maintained source; matching standalone HTML is generated with
  `tools/md-to-html.sh`. Never hand-edit generated HTML.
- Keep tracked references repository-relative; the repository is used on
  multiple machines.
- Fetched papers get descriptive names with `.txt` extractions beside PDFs;
  each source batch is recorded in `sources/README.md` or the collection's
  `MANIFEST.md`.
- `sources/restricted-microsoft/` is quarantined licensed material. Never copy
  it into parent artifacts, other components, or any public distribution. The
  Project Manager and its auditor never open it.
- Flag files above GitHub's 100 MB limit instead of committing them.

## Commands (run by the human or the component's owner, from `../osr-claude/`)

```sh
tools/md-to-html.sh --check   # verify registered Markdown/HTML pairs
tools/md-to-html.sh           # regenerate registered HTML
```

## What the Project Manager may request

Removal of stale handoff statements (`PMR-002`, closed 2026-09-06: the owner
applied the exact two-line replacement the Project Manager had recorded,
through the human-run `../scripts/owner-actions.sh --apply-edits`, whose y/N
prompt was this component's ask-first convention, committing `e275544` and
pushing it to the personal-account `origin`; `HANDOFF.md` "Infrastructure
facts" now states the SSH remote and the applied `mktemp` fix);
registration of routed sources under the owner's rules; backup decisions (the
remote is a personal account rather than the organization).

The active private identity is
`agentic-os-research/os-security-research` (`PMD-20260914-003`, `PMR-044`,
closed at owner return `49fbfd6`).
The bounded local D0 inventory is recorded in `PMD-20260914-004`;
the guided owner inventory is closed by `PMD-20260915-001` / `PMR-049`.
The organization rename is complete (`PMD-20260915-003`) and local checkout
reconciliation `PMR-027` is closed at `e275544`.
The separate private quarantine target is the responsible human's personal
`os-security-restricted-sources` repository with clean new history and manual
human transfer.
The verified private successor uses root snapshot `58f8023`, whose reachable history
excludes `sources/restricted-microsoft/`; the complete old private repository
remains an inactive historical reference at `legacy-personal/main`. The
successor is `origin`; no symlink changed. The active owner workflow is
tool-neutral and Copilot-capable. The old repository stays private;
quarantined licensed resources move only through a responsible-human-approved
plan into a separate private repository visible only to the responsible
human. The Project Manager never opens or copies the restricted subtree.
The quarantine exists empty with clean history; no restricted file was copied
during `PMR-044`. `PMR-070` asks the owner context to implement the exact tasking
resolver mapping and no-fallback rule; ask the responsible human before that
OS-security write. `PMR-052` is blocked while the responsible human waits for
the cap-talk archive owners' response.
