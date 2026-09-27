# Dirty owner recovery specifications

These tracked specifications allow the responsible human to restart one exact
closed owner session whose component worktree must remain dirty. Ordinary
clean owner work uses `scripts/owner-session.sh`.

Each active `<PMR-NNN>.tsv` file is Project Manager-owned and records exactly one
component, directly assigned open request, branch, full HEAD, responsible-human
statement that the prior session is closed, and complete
`git status --porcelain=v1 --untracked-files=all` output, plus the SHA-256 of
the tracked full-index binary diff from HEAD. Untracked recovery states are
refused. The human-run
`scripts/owner-recovery.sh` refuses every mismatch, stale tasking view,
uncommitted specification, additional visible request, merge conflict, or
concurrent writer. It writes only ignored Project Manager scratch before
Copilot starts.

A specification may remain as historical evidence after its request closes,
but it is no longer launchable: the sole-visible-open-request and dispatch
checks fail closed. Any later request requires a newly committed
request-specific specification at the then-current
HEAD and fingerprint.

The terminal transcript is private, mode-restricted, ignored scratch and may
contain sensitive interactive output. Never quote credentials, private
locators, or other secrets from it into a durable record.

Recovery is coordination, not retroactive authority for dirty content. The
component owner must follow its own rules, return `blocked` when a required
gate is absent, validate and review every retained path, and record a durable
structured return. The launcher never pushes, changes a remote, cleans,
stashes, resets, stages, or commits component content.
