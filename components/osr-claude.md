# osr-claude

- **Workspace entry:** `../osr-claude/` (ignored direct checkout)
- **Ownership:** agent-owned research archive (Claude research agent); ask the
  user before any modification. Carry-eligible in principle under the standing
  carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`, but the Project Manager asks the user first per
  this convention and never touches `sources/restricted-microsoft/`
- **Agent:** reusable Claude skill `.claude/skills/os-security-research`
- **Local instructions to read first:** `CLAUDE.md`, `HANDOFF.md`
- **Observed state:** clean local `main` synchronized with `origin/main` at
  `e275544`. The responsible human completed the fast-forward and sanitized
  state/refs verify the exact result; `PMR-027` is closed

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

The approved target identity is
`agentic-os-research/os-security-research` (`PMD-20260914-003`, `PMR-044`).
The bounded local D0 inventory is recorded in `PMD-20260914-004`;
the guided owner inventory is closed by `PMD-20260915-001` / `PMR-049`.
The organization rename is complete (`PMD-20260915-003`) and local checkout
reconciliation `PMR-027` is closed at synchronized `e275544`; `PMR-044` is
now P1 and owner-actionable under
`PMD-20260916-002`.
The separate private quarantine target is the responsible human's personal
`os-security-restricted-sources` repository with clean new history and manual
human transfer.
The active private successor uses a clean snapshot whose reachable history
excludes `sources/restricted-microsoft/`; the complete old private repository
remains an inactive historical reference. After verification the successor
becomes `origin`, while the old home remains under an explicit inactive
remote name. No symlink changes. Each repository creation, remote change,
push, and restricted-file transfer remains an explicit same-turn human gate.
The active owner workflow is to become tool-neutral and Copilot-capable after
D0. The old
repository remains an inactive reference. Its current history stays private;
quarantined licensed resources move only through a responsible-human-approved
plan into a separate private repository visible only to the responsible
human. The Project Manager never opens or copies the restricted subtree.
`PMR-070` asks the Claude owner context to implement the exact tasking
resolver mapping and no-fallback rule; ask the responsible human before that
OS-security write.
