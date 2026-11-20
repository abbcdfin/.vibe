# ADR 0005: `main` holds releases, `dev` integrates, one branch per increment

- **Status:** Accepted
- **Date:** 2026-11-20
- **Decider:** Jian Zhang

## Context

Hosts install from a repository's default branch, so work pushed there reaches consumers
under an already released version, and one version names several commits. Branch rules
were split between a release-rules candidate and the delegated-work candidate, and
delegated increments need a branch for workers to commit to. A convention that varies
by project would need a question at initialization.

## Decision

- `main`, the default branch, moves only to a tagged release, by fast-forward from
  `dev`; a pre-push hook refuses anything else. `dev` integrates done increments and
  always works; planning outside one increment's work is committed there directly.
- Each increment builds on `inc/<n>-<slug>`, branched from `dev` after it is marked
  BUILDING. At DONE, `dev` is merged into it and "done when" verified there; the branch
  then merges into `dev` with `--no-ff` and is deleted.
- `main`, `dev` and tags are never rewritten.
- A patch that must ship without unreleased work branches from the release tag.
- Initialization creates `dev` when absent and copies vibe's pre-push hook into
  `.git/hooks/` when the clone has none.

## Alternatives rejected

- **Name the integration branch per project in `dev_env.md`.** Initialization would ask
  every time, for a choice nearly every project makes the same way.
- **Integrate on `main` and install from a `release` branch.** Hosts install from the
  default branch, so every consumer would have to name the branch, or the repository
  would need a default branch other than `main`.
- **Squash, or rebase and fast-forward.** Squashing loses the task commits; a linear
  history loses the increment's boundary. `--no-ff` keeps both and reverts as one commit.
- **A tracked hook through `core.hooksPath`.** It disables a clone's other hooks, and
  tools such as pre-commit refuse to install while it is set.

## Consequences

- Existing projects create `dev`, move work to it and install the hook; the release
  that ships increment 6 carries the steps.
- The hook is local and `--no-verify` skips it; server-side protection of `main` against
  force-push and deletion complements it where available.
