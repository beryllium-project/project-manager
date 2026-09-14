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

The resolver identifies the physical repository behind either integration
form. It prints open requests assigned to the component plus requests that
explicitly cross-name it in the Request or Note field, only when the generated view
names the current Project Manager commit, matches the committed
`outbox/component-requests.md` blob, and that request table has no staged or
unstaged change. Missing, unreachable, or stale tasking fails closed.

The view is discovery only. Owner results return through the component-owned
handoff protocol in `PMD-20260914-002`; no view grants a human gate.
