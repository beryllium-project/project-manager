#!/usr/bin/env bash
# Beryllium publication-gate Git hook dispatcher (PMD-20261108-001).
#
# Installed by the human-run scripts/publication-gate-setup.sh as
# bin/hook-dispatch under ${XDG_CONFIG_HOME:-~/.config}/beryllium/
# publication-gate/, with hooks/<name> symbolic links to it for every chained
# hook name. A global includeIf points core.hooksPath at that hooks directory
# only for repositories under the Beryllium workspace roots or with a remote in
# the beryllium-project or agentic-os-research organisations.
#
# pre-push runs the publication gate first and refuses the push when the gate
# fails; every hook then chains to the repository's own hook in
# $(git rev-parse --git-common-dir)/hooks, so hooks that core.hooksPath would
# otherwise disable keep running. There is no bypass variable; a push made with
# --no-verify skips every hook and is prohibited for public remotes by the
# Beryllium publication-gate SOP.

set -u

name=${0##*/}
self=$(readlink -f -- "$0" 2>/dev/null) || self=$0
bin_dir=${self%/*}
hooks_dir=$(cd -- "${0%/*}" 2>/dev/null && pwd -P) || hooks_dir=

repo_hook=
common=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) ||
    common=
if [[ -n $common && -f $common/hooks/$name && -x $common/hooks/$name ]]; then
    repo_hook_dir=$(cd -- "$common/hooks" && pwd -P) || repo_hook_dir=
    if [[ -n $repo_hook_dir && $repo_hook_dir != "$hooks_dir" ]]; then
        repo_hook=$common/hooks/$name
    fi
fi

if [[ $name == pre-push ]]; then
    input=$(mktemp "${TMPDIR:-/tmp}/publication-gate-pre-push.XXXXXX") || {
        printf 'publication-gate: cannot buffer pre-push input; refusing\n' >&2
        exit 1
    }
    trap 'rm -f -- "$input"' EXIT
    cat >"$input"
    /usr/bin/env python3 -I -B "$bin_dir/publication-gate" pre-push "$@" \
        <"$input" || exit $?
    if [[ -n $repo_hook ]]; then
        "$repo_hook" "$@" <"$input"
        exit $?
    fi
    exit 0
fi

if [[ -n $repo_hook ]]; then
    exec "$repo_hook" "$@"
fi
exit 0
