# Generated component tasking views

`outbox/component-requests.md` remains the only authoritative outbound request
surface. Files beside this README are ignored, local generated projections for
component startup discovery; never edit or commit them.

After each Project Manager commit:

```sh
cd project-manager
bash ./scripts/project-tasking.sh generate
bash ./scripts/project-tasking.sh check
```

From a registered direct checkout or tracked workspace symlink entry, preserve
the logical workspace path when locating the Project Manager:

```sh
bash "${PWD%/*}/project-manager/scripts/project-tasking.sh" resolve .
```

In every component owner context, `check Project Manager tasking` and obvious
case/singular/plural variants mean: run that exact command. A user-invocable
agent with an execution allowlist permits this one read-only sibling command
for startup discovery. If the command path is absent or validation fails,
stop and tell the human to relaunch from the registered logical workspace
entry. Never search session history, task/todo databases, background agents,
prior chat, or memory for a fallback PMR (`PMD-20260915-008`).

From the workspace root, the equivalent explicit form is:

```sh
bash ./project-manager/scripts/project-tasking.sh resolve <component>
```

After the Project Manager has separately established that one directly
assigned open request is already authorized and ready, it may emit one exact
owner-worker packet:

```sh
bash ./project-manager/scripts/project-tasking.sh dispatch <component> <PMR-NNN>
```

`dispatch` is PM-only. It accepts a canonical component name, not a path;
requires the PMR to be directly assigned to that component, open, unresolved,
and structurally valid; reads the row from the committed request-table object;
and binds the packet to the current Project Manager commit and request blob.
It writes and launches nothing. Cross-named rows remain discovery only.
Missing, duplicated, closed, wrong-component, dirty, or stale input fails
without a partial packet.

An `open` row is not automatically dispatch-ready. Priority is not
authorization. Before invoking an owner worker, the Project Manager must
separately verify recorded authority and prerequisites, the adopted owner
profile, expected component branch/HEAD, clean worktree, and absence of
another writer. The packet grants no human gate, implementation authority, or
permission beyond the recorded request.

If a tracked symlink entry has been physically resolved before command
execution, the human may supply `PM_TASKING_ROOT` and
`PM_TASKING_WORKSPACE`, or relaunch from the logical workspace entry. Owners
record `pwd` and `pwd -P` while adopting the contract. If a Project Manager
turn is in progress and views are stale, component owners wait for the PM
commit and regeneration; only the Project Manager may read its dirty
authoritative request table directly.

The resolver identifies the physical repository behind either integration
form. It prints open requests assigned to the component plus requests that
explicitly cross-name it in the Request or Note field, only when the generated view
names the current Project Manager commit, matches the committed
`outbox/component-requests.md` blob, and that request table has no staged or
unstaged change. Missing, unreachable, or stale tasking fails closed.
Each row includes `Assigned to`, so a cross-named coordination row cannot be
mistaken for work owned by the current component.

The view and dispatch packet are discovery/selection only. Owner results
return durably through the component-owned handoff protocol in
`PMD-20260914-002`; a live PM-invoked worker uses
`templates/owner-agent-response.md`. Neither grants a human gate.

When a resolved request consumes, incorporates, qualifies, or applies sibling
research or analysis, the human also tells the destination owner:

```text
Load and follow the `cross-repo-collaboration` skill before using sibling
research or analysis.
```

Under `PMD-20260917-001`, the destination owner reads the source `COLLAB.md`
when present, completes and validates destination work first, and records
completed use only within the ledger's explicit guest budget. A missing or
read-only ledger grants no source write; return completed-use evidence through
the source owner and Project Manager instead. Pointer triage alone triggers
this only when it becomes substantive destination use.
