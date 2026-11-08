# Security-reviewer temporary private containment, and gate handling of contained repositories

- **Record ID:** `PMD-20261108-002`
- **Created:** 2026-11-08
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

This record answers two coordination questions raised by the responsible
human's containment decision for the P0 remediation of the published
security-reviewer history (`PMR-138`, `PMD-20261108-001`): in what order the
repair, the force push, the GitHub Support request, and the two visibility
changes happen, and how the publication gate treats a recorded public
repository that cannot be read anonymously while it is contained. It touches
`beryllium-project/security-reviewer` (no Project Manager write or remote
action), the Project Manager's `scripts/publication-gate.py` and
`tests/validate-agent.sh`, and Project Manager coordination records. It
clarifies, without superseding, `PMD-20261108-001` disposition 1, which
already defines a recorded public repository as public.

Observed with `scripts/inspect-components.sh` at 2026-11-08T06:48Z: Project
Manager `8a40adc`, one ahead of its public `origin` (push held under P0);
parent `525f721`, one ahead of its private `upstream`; `security-reviewer`
clean `main` at the published tip, 0/0 with its public `origin` (exact
commit only in private parent records); every other component unchanged since the
132nd turn. The gate's anonymous probe at 06:48Z still read the repository
as public. No publication-gate install log and no owner-session packet
existed.

## Inputs

- The responsible human's statement at 2026-11-08T06:43Z (22:43 on
  2026-11-07 at UTC-8), quoted exactly: `"there are no forks, we will make
  private for repair then public again"`. The fork count is human-reported;
  the Project Manager has no fork query within its execution boundary.
- `PMD-20261108-001`: disposition 1 (a remote is public when it is a
  recorded public repository or anonymous `git ls-remote` succeeds),
  disposition 4 (a visibility change to public needs `audit --all-refs`
  after a full fetch), disposition 9 (hold), and disposition 11 (private
  note).
- The private note `../.publication-gate/P0-20261108-001.md`, remediation
  steps 1 to 8.
- GitHub's documentation "Removing sensitive data from a repository", read
  on 2026-11-08: after a rewrite and force push, the old commits may still
  be reachable directly by their SHA-1 hashes in cached views on GitHub;
  GitHub Support, given the repository, the number of affected pull
  requests, and the first changed commit, runs a server-side garbage
  collection and removes cached views; and Support assists only where it
  judges that the risk cannot be mitigated by rotating credentials.
- A sandbox comparison on 2026-11-08 with a synthetic term: the gate
  committed at `8a40adc` refused (exit 2) both a clean push and an
  entry-carrying push to a public remote it could not read anonymously,
  because it classified that remote's visibility as unknown. Once installed,
  it would have refused the force push of the repaired history to the
  contained repository, leaving only a hook bypass, which
  `PMD-20261108-001` prohibits.

## Disposition

1. **Containment decided.** The responsible human decided to make
   `beryllium-project/security-reviewer` private for the repair and public
   again afterwards. Both visibility changes are the responsible human's
   commands; the Project Manager runs neither, because its execution
   boundary includes no `gh` command and no component remote change. The
   hold of `PMD-20261108-001` disposition 9 is unchanged.
2. **Order.** Make the repository private; install the gate, or reinstall it
   if it was installed before this correction, so that its pre-push hook
   scans the objects the force push adds (the step that verifies the whole
   repaired history is the `audit` below); run the `PMR-138` owner session,
   which edits files;
   the responsible human rewrites the published commits, runs the gate's
   `audit` of local branches and tags, and force-pushes with lease while the
   repository is private; the responsible human sends the GitHub Support
   request; then the responsible human makes the repository public again,
   after the checks of disposition 3.
3. **When to make it public again.** Project Manager recommendation; the
   timing is the responsible human's decision: only after GitHub Support
   confirms the server-side garbage collection and cached-view removal, and
   after the gate's `audit --all-refs` passes following a full fetch. Made
   public earlier, the repository lets anyone who already holds a replaced
   commit's ID open that commit on GitHub until the collection runs. If
   Support declines because the data is not a credential, the responsible
   human chooses between making the repository public anyway, keeping it
   private, and replacing the GitHub repository with a newly created one
   that holds only the repaired history (a further remote decision); the
   Project Manager records that choice.
4. **Gate correction.** `scripts/publication-gate.py` now follows
   `PMD-20261108-001` disposition 1. A recorded public repository, or one
   treated as public through `BERYLLIUM_PUBLICATION_GATE_TREAT_AS_PUBLIC`,
   that cannot be read anonymously (for example, while private for
   containment, or during a network failure) is scanned as public. Only the
   objects reachable from the remote's own values of the pushed refs, which
   Git supplies to `pre-push`, are excluded; `check`, which has no such
   values, scans the pushed refs' whole history. `audit --remote` refuses
   such a repository (exit 2) and directs the user to `audit --all-refs`
   after a full fetch. A remote that is neither recorded nor treated as
   public keeps the earlier rule: an authentication failure means private,
   and any other failure refuses. Two of the three new regression tests in
   `tests/validate-agent.sh` fail on the earlier behavior; the third guards
   the `audit --remote` refusal. An installed gate
   older than this correction fails `publication-gate-setup.sh check` by
   SHA-256 and is refreshed by running `install` again.
5. **Closing `PMR-138`.** After the responsible human reports the force
   push and runs `git fetch --prune --tags origin` in the component, the
   Project Manager runs the gate's `audit --all-refs` of the local
   security-reviewer clone, whose remote-tracking `main` moves with the
   push. When it passes, `PMR-138` closes, whether the repository is then
   private or public, and `PMR-118` and `PMR-123` are verified against the
   replacement commits. After the return to public, the Project Manager
   confirms the live view with `audit --remote origin`; a finding there
   reopens the matter as a new P0 request.

## What this record does not decide

This record is coordination evidence. It grants no acceptance, approval,
review approval, risk acceptance, sign-off, licensing, redistribution,
publication, release, formal verification, hardware validation,
implementation authority, component write authority, push, force push,
remote change, visibility change, repository deletion or creation, or tag
authority. It does not send the GitHub Support request: the private note
holds a draft, and sending it is the responsible human's action. Passing
the gate is not publication approval. Beryllium is accepted through R7;
R8-H0 is a committed candidate and is not accepted; H1-H4 are not
authorized; K3 hardware is `NOT RUN` in Project Manager records. Helium
remains a review-and-test proof of concept and is not formally verified or
hardware validated.

## Follow-up

- The responsible human makes the repository private, installs or
  reinstalls the gate, and starts the owner session, from the workspace
  root:

  ```sh
  gh repo edit beryllium-project/security-reviewer --visibility private --accept-visibility-change-consequences
  bash ./project-manager/scripts/publication-gate-setup.sh install
  bash ./project-manager/scripts/owner-session.sh launch security-reviewer PMR-138 PMR-141
  ```

- The Project Manager confirms containment with the gate's
  `classify https://github.com/beryllium-project/security-reviewer.git`,
  whose detail then reports that the repository is not readable
  anonymously, and verifies `PMR-138` as disposition 5 describes.

## Provenance

- Written by the `project-manager` agent on `claude-opus-5.5` from the
  inputs above, maintained inspection, the gate's anonymous probe, a
  sandbox gate comparison with a synthetic term, and GitHub's public
  documentation. No component repository, GitHub setting, or user-level
  configuration was modified.
