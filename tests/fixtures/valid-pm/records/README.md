# Project Manager records

Durable, cross-component coordination records owned by the Project Manager.

| Directory | Contents | Identifier |
| --- | --- | --- |
| `assurance/` | Assurance-transfer records that summarize exact evidence boundaries carried between components | File name; each file states its component, revisions, and claim limits |
| `decisions/` | Project Manager dispositions and coordination decisions | `PMD-YYYYMMDD-NNN-<slug>.md`, allocated by `scripts/new-record.sh` using UTC |

Rules:

- A record is coordination evidence. It never grants acceptance, approval,
  sign-off, licensing, publication, release, formal verification, or hardware
  validation; those remain responsible-human gates recorded by the humans who
  hold them.
- Never renumber or reuse an allocated identifier. A correction adds a
  superseding record and marks the earlier record `superseded`.
- Every record names the exact component revisions it depends on and carries a
  provenance section naming where its content came from.
- Records cite component material by workspace-relative path
  (`../<component>/...`) or `component://<name>/...` locator, never by absolute
  workstation path.
