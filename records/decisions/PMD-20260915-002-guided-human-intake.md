# Guided human intake

- **Record ID:** `PMD-20260915-002`
- **Created:** 2026-09-15
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Record the responsible human's interaction preference for future Project
Manager sessions. This applies to coordination questions, owner inventories,
gate inputs, and choices that require human judgment. It changes the
human-facing intake method, not component ownership or any gate.

Recorded with Project Manager at `12e4424` and parent at `8b7a017`.

## Inputs

- Responsible-human statement on 2026-09-14 local time: "for future sessions,
  utilize this interactive approach where appropriate, it is much better. i
  am not a parsing engine."
- The immediately preceding guided `PMR-049` intake: one short structured
  question at a time produced complete owner answers without requiring a
  hand-authored inventory table.

## Disposition

1. When human input is required and the answer can be decomposed, the Project
   Manager uses `ask_user` to ask one short, plain-language question at a
   time.
2. Each question presents a recommended default where one is safe, while
   preserving an explicit exception or defer option.
3. The Project Manager carries prior answers forward and does not ask the
   human to restate, parse, or manually transform information already
   available in Project Manager records.
4. Large templates, multi-repository matrices, and machine-shaped response
   blocks are prepared by the Project Manager, not assigned to the human.
5. The human receives one specific next decision or action. Additional
   questions follow only after that answer.
6. If the human is unavailable, the Project Manager preserves the partial
   intake and reports the next unanswered plain-language question rather than
   inventing an answer.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
risk acceptance, sign-off, licensing, redistribution, publication, release,
formal verification, or hardware validation. It does not weaken required
human confirmation or allow the Project Manager to answer a human-owned
decision. It changes presentation, not authority.

## Follow-up

- Apply this interaction rule to every future Project Manager intake where
  sequential prompting is appropriate.

## Provenance

- Written by the `project-manager` agent from the responsible human's explicit
  interaction preference.
