#!/usr/bin/env bash
# Human-run PMR-108 global maintenance reservation. `hold` takes a
# non-blocking exclusive lock that owner-session.sh and owner-recovery.sh
# launches share, so the reservation cannot start while either launcher is
# running and neither launcher can start while it is held. It then replaces
# itself with the given command (normally the Project Manager rollout
# session), which keeps the lock until it and every process inheriting the
# descriptor exit. It does not block owner-actions.sh, hidden owner workers,
# or non-instrumented sessions, and grants no gate or write authority.

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  maintenance-reservation.sh hold -- <command> [<argument>...]

hold    take the global maintenance reservation, export
        PM_MAINTENANCE_RESERVATION=held, and run the command while holding it;
        exit 1 when an owner-session/owner-recovery launch or another holder
        has the lock, otherwise exit with the command's status
EOF
}

die() {
    printf 'maintenance-reservation: ERROR: %s\n' "$*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) ||
    die "cannot resolve script directory"
repository_root=$(CDPATH= cd -- "$script_dir/.." && pwd -P) ||
    die "cannot resolve repository root"
scratch_root=${PM_OWNER_SESSION_SCRATCH:-$repository_root/scratch/owner-sessions}
global_lock=$scratch_root/global/maintenance.lock

(($# >= 3)) && [[ $1 == hold && $2 == -- ]] || {
    usage
    exit 2
}
shift 2

command -v flock >/dev/null 2>&1 || die "flock is required"
[[ ! -L $scratch_root/global ]] || die "the global lock directory is a symbolic link"
mkdir -p -- "$scratch_root/global"
[[ ! -L $global_lock ]] || die "the global lock is a symbolic link"
[[ ! -e $global_lock || -f $global_lock ]] || die "the global lock is not a regular file"
exec {lock_fd}>>"$global_lock"
flock -n -x "$lock_fd" ||
    die "the global maintenance reservation is busy: an owner launch or another holder has it"
export PM_MAINTENANCE_RESERVATION=held
printf 'maintenance-reservation: held since %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >&2
exec "$@"
