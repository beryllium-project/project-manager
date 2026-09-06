# osr-claude

- **Workspace entry:** `../osr-claude/` (ignored direct checkout)
- **Ownership:** agent-owned research archive (Claude research agent); ask the
  user before any modification. Carry-eligible in principle under the standing
  carry authority `../records/decisions/PMD-20260904-003-standing-carry-authority.md`, but the Project Manager asks the user first per
  this convention and never touches `sources/restricted-microsoft/`
- **Agent:** reusable Claude skill `.claude/skills/os-security-research`
- **Local instructions to read first:** `CLAUDE.md`, `HANDOFF.md`
- **Observed state:** see `../../COMPONENTS.md`

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

Removal of stale handoff statements (the HTTPS-remote and pending `mktemp`
bug lines superseded by the SSH remote and the fix; `PMR-002`, P3 since
2026-09-06: the owner applies the exact two-line replacement in
`../outbox/owner-edits/PMR-002-*` through the human-run
`../scripts/owner-actions.sh --apply-edits`, which asks first, as this
component's convention requires, and then pushes `main` in its `push_osr`
step);
registration of routed sources under the owner's rules; backup decisions (the
remote is a personal account rather than the organization).
