# Owner edits (data for the human-run helper)

Exact text for the owner-side edits that `../../scripts/owner-actions.sh
--apply-edits` applies, one open request at a time, after showing the diff and
receiving a `y` from the responsible human. The words live here, next to the
request table, so the script holds no request text and every edit can be
reviewed and cited by its request identifier.

- `<name>.old.txt` with `<name>.new.txt`: block mode; the old text must occur
  exactly once in the component file and is replaced by the new text.
- `<name>.anchor.txt` with `<name>.new.txt`: line mode; exactly one line of
  the component file contains the anchor and that whole line is replaced.
  Used where the current line holds a repository URL that is not recorded
  here.

The token `@DATE@` in a new-text file becomes the UTC date on which the
human applies the edit, so appended history rows carry their real date. The
file, component, and mode for each name are in the `edits` table of the
script. A file that no longer matches (already applied, or changed by the
owner) makes the script skip that request and point at `../OWNER-RUNBOOK.md`.
The set never includes `helium-te-poc/` or `beryllium-repo`. A set is removed,
together with its rows in the script's `edits` table, once the owner's commit
is observed. Applied and removed so far: `PMR-019` (analysis-workbook
`d003dec`), `PMR-002` (osr-claude `e275544`), and the `PMR-014` wording
(formal-verification-research `e5740de`), all on 2026-09-06. No set is
pending.
