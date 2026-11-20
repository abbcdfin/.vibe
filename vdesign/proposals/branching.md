# Proposal: Branching

> **Status: CANDIDATE — not adopted.** Graduation target: rules 1–4 in the spine's
> Lifecycle; rule 5 beside the [release rules](release-rules.md) in their **Releasing**
> section.

## Motivation

- Branch rules were split between release rule 5 and the delegated-work candidate.
- Consumers install from the repository's default branch, so unreleased work pushed
  there reaches them under a released version.
- A fixed convention needs no question at initialization.

## Rules

1. **`main` holds releases; `dev` integrates.** `main`, the default branch, moves only to
   a tagged release, by fast-forward from `dev`; a pre-push hook refuses anything else.
   Done increments land on `dev`, which always works. Planning outside one increment's
   work (candidates, proposals, the checkpoint) is committed to `dev` directly.
2. **One branch per increment**, `inc/<n>-<slug>`. Mark the increment BUILDING on `dev`,
   then branch from it. The branch carries the board, the work and the DONE record;
   commit each task as it is checked off.
3. **Verify what will land.** At DONE, merge `dev` into the increment branch, verify
   "done when" there and record the outcome; then merge into `dev` with `--no-ff`, so the
   increment is one revertible commit, and delete the branch. A rejected or abandoned
   increment's branch is deleted; its verdict goes on the candidate.
4. **Never rewrite shared history.** No force-push or rebase of `main`, `dev` or tags;
   rebase only commits no one else has.
5. **Patches.** A fix that must ship without unreleased work goes on `fix/<slug>`,
   branched from the release tag. `main` fast-forwards to the patch's tag, which then
   merges into `dev`.

Initialization creates `dev` from `main` when it is absent, and copies vibe's pre-push
hook into `.git/hooks/` when the clone has none, reporting an existing one instead. The
hook lives in vibe, so it is versioned once rather than in each project; setting
`core.hooksPath` was rejected because it disables a clone's other hooks. The hook is
local and `--no-verify` skips it, so where the server allows, also protect `main`
against force-push and deletion; servers cannot check for a tag.

## Validation

One increment in this repository run under all five rules: its branch, the DONE merge
and a release that fast-forwards `main`.
