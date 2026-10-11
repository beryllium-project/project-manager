# workbook split and republication path

- **Record ID:** `PMD-20261011-002`
- **Created:** 2026-10-11
- **Status:** recorded
- **Supersedes:** None
- **Superseded by:** None

## Scope

Answer the responsible human's question whether a GitHub repository can
hold a private branch while public. Record the chosen way to separate the
analysis-workbook's private work from a repository that may become public
again. Name the requests and gates that follow. This record touches Project
Manager artifacts only; no component is written.

Observed when recorded (2026-10-11, on `l1`):

- Clean `analysis-workbook` checkout on branch
  `analysis/k3-a100-service-design-private` at `353c431`, which has no
  upstream. Local `main` is at `4cf44d0`. The only remote is `origin`,
  `beryllium-project/analysis-workbook`. Its remote-tracking refs predate the
  `lx2` push.
- The responsible human's `lx2` output showed `main` and
  `analysis/k3-a100-service-design-private` on that `origin`, both up to date
  from `lx2`. The human then reported making the repository private.
- Every workbook session package records `Distribution: private`. On `main`,
  `AWB-20260913-001`, `AWB-20260914-001`, and `AWB-20260914-002` declare
  `Intended distribution: private`. `AWB-20260829-001`, `AWB-20260915-001`,
  and `AWB-20260928-001` declare `public-candidate`, which the workbook's
  instructions say is not publication approval. `AWB-20261007-001`, which
  intends `private`, exists only on the private branch.

## Inputs

- Responsible-human question, exactly: `"is it possible to have a private
  branch on a public repo?"`
- Responsible-human answers to four structured questions on 2026-10-11:
  - end state `split_republish` (move private branches to a new private
    repository, then reopen this one publicly);
  - handling of `main` `inventory_first` (the owner inventories package
    classifications on `main`, then the human decides publication at an
    exact commit);
  - checks `exposure_review` and `visibility_audit`, with the note
    `"don't worry about exposure, it's not super critical, and it is just
    for the workbook"`;
  - remote layout `helium_style`, with new private repository
    `beryllium-project/analysis-workbook-private`.
- GitHub Docs, read 2026-10-11:
  [Setting repository visibility](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility),
  [Forks](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/what-happens-to-forks-when-a-repository-is-deleted-or-changes-visibility),
  [Removing sensitive data from a repository](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository),
  [About repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/about-repositories),
  and
  [Viewing traffic to a repository](https://docs.github.com/en/repositories/viewing-activity-and-data-for-your-repository/viewing-traffic-to-a-repository).
- `PMD-20260915-001` dispositions 2 and 8: every successor starts private, any
  later public visibility requires a separate decision, and no repository is
  approved for public release.
- `PMD-20260914-004`: the D0 inventory records the workbook as a private
  origin with private analysis and no publication approved.
- `../analysis-workbook/.github/copilot-instructions.md` on the checked-out
  branch: session packages default to `private`, and `internal` or
  `public-candidate` needs an explicit user request plus a structured
  human-recorded promotion.
- `component://helium-te-poc`: a private `origin` plus a separate `public`
  remote, the existing project precedent.
- `outbox/pmr105-push.sh` and `outbox/pmr091-inventory.sh`: the human-run
  script conventions reused here.

## Disposition

1. **Answer.** No. GitHub sets visibility per repository: every branch, tag,
   and commit in a public repository is readable by anyone. Repositories in
   a fork network share Git data. Branch protection and rulesets restrict
   writes, not reads. A deleted branch's commits can stay reachable by SHA in
   GitHub's cached views, and GitHub Support removes them only for data it
   judges sensitive. Making a public repository private erases its stars
   and watchers, and any public forks stay public in a separate network that
   no longer appears in the repository's fork list. Keeping private branches
   while publishing therefore needs two repositories.
2. **Finding.** `beryllium-project/analysis-workbook` was public for an
   unknown period without the decision `PMD-20260915-001` requires. Its
   private branch was pushed to it while public, and its `main` carries
   packages whose recorded distribution is `private`. The responsible human
   made it private on 2026-10-11. The human treats the exposure as not
   critical and limited to the workbook. The Project Manager records that
   as the human's assessment, not as a risk acceptance.
3. **Layout** (`helium_style`). The new private
   `beryllium-project/analysis-workbook-private` becomes the workbook's
   `origin` and receives both existing branches, `main` and
   `analysis/k3-a100-service-design-private`; the split refuses to run if
   any other branch or any tag exists. The existing
   `beryllium-project/analysis-workbook` becomes remote `public`, holds
   `main` only, and keeps its push URL disabled until a recorded publication
   decision. `scripts/owner-actions.sh --only push_awb`, which pushes `main`
   to `origin`, therefore stays a private backup. The noncanonical `lx2`
   copy gets its push URL disabled before the split executes.
4. **Requests.**
   - `PMR-128` (`project-manager`, human-run, read-only): a visibility audit
     of every registered identity and non-inactive remote, plus the
     workbook's exposure facts, through `outbox/pmr128-visibility-audit.sh`.
     It is informational and non-blocking.
   - `PMR-129` (`analysis-workbook`, human-run): the split, through
     `outbox/pmr129-workbook-split.sh`. `--plan` is read-only. `--execute`
     runs only after the Project Manager records a same-turn
     responsible-human confirmation. If its log shows a local branch behind
     its new upstream, the human fast-forwards it; the owner does not.
   - `PMR-130` (`analysis-workbook`, owner session, after `PMR-129`): the
     two-repository rule in the workbook's own documents, a
     publication-readiness inventory of `main` at one exact commit, and
     placement of `PMQ-034..036`, committed locally without a push. It runs
     together with `PMR-124` and `PMR-126`.
5. **Publication gate.** Reopening `beryllium-project/analysis-workbook` is
   a separate responsible-human publication decision, made after the
   `PMR-130` inventory and naming an exact commit. That decision must state
   whether the human accepts that the moved branch's commits, and any
   history it excludes, may stay reachable by SHA in this repository. A new
   clean public repository would avoid that. The Project Manager will record
   the decision and allocate a distinct request to push the approved commit
   to `public` and change visibility.

## What this record does not decide

This record is coordination evidence. It does not grant acceptance, approval,
sign-off, licensing, publication, release, formal verification, or hardware
validation. The Project Manager runs no `gh` command, push, remote change,
visibility change, history rewrite, or GitHub Support request. It promotes
no session package and approves no public visibility for any repository.
Its finding that the workbook was public establishes no fault and no
exposure scope; the audit may refine both. Open responsible-human gates:
the `PMR-129` execution confirmation, the publication decision for `main`
at an exact commit including any acceptance of residual SHA reachability,
and the push-evidence reconciliation of `PMR-085/088/089/095/097`.

## Follow-up

- From `project-manager/`, the responsible human runs the read-only audit
  and the read-only split preflight, then reports both printed log paths:

  ```sh
  bash ./outbox/pmr128-visibility-audit.sh --run
  bash ./outbox/pmr129-workbook-split.sh --plan
  ```

## Provenance

- Written by the `project-manager` agent from the responsible-human question
  and answers, the GitHub Docs pages read on 2026-10-11, and read-only
  inspection of Project Manager and workbook files.
