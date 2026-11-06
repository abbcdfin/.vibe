# ADR 0003: Document kinds and the proposal lifecycle

- **Status:** Accepted
- **Date:** 2026-11-06
- **Decider:** Jian Zhang

## Context

The spine recorded a decision by "updating a design document or adding an ADR", with no
test for which. Until v0.9.0, an accepted candidate also had to record its rationale in
`docs/`; v0.9.0 dropped that clause, and nothing said what became of a proposal once
accepted. A candidate could live in `plan.md` *or* in a proposal file, so a session
syncing from `plan.md` could miss a proposal. This repository kept its proposals at its
root, outside `vdesign/`, and turned an adopted one into a pointer stub.

## Decision

- `docs/` holds two kinds of document. **Design documents** are living: they describe the
  system as currently designed. **Decision records** are dated, live in `docs/adr/`, and
  are superseded rather than rewritten.
- Write an ADR when alternatives were weighed and the choice is hard to reverse; otherwise
  a sentence of rationale goes in the design document the decision shapes.
- Every candidate has a line in `plan.md`. A proposal is the longer argument that line
  links to, in `vdesign/proposals/`.
- At acceptance, a proposal's decision and rationale go to `docs/`. The proposal remains
  working material while its increment is built, and is deleted at DONE, once the design
  documents describe the result. A rejected proposal keeps its file, with the verdict.
- This repository follows the same rules.

## Alternatives rejected

- **An ADR for every accepted increment.** Most increments choose between no alternatives;
  their records would restate the plan.
- **Design documents only.** They describe the present, so rejected alternatives drop out
  and get proposed again.
- **A candidate in `plan.md` or a proposal file.** Sessions sync from `plan.md`; a
  proposal it does not list is invisible.
- **Delete a proposal at acceptance.** The build still needs its argument; DONE is where
  tactical material collapses.
- **Keep this repository's proposals public at its root.** The framework's own repository
  would remain the one project that ignores its rules.

## Consequences

- DONE includes bringing the design documents in line with the result.
- Files the plugin ships are read inside users' projects, where a relative path such as
  `vdesign/proposals/…` resolves to the user's own `vdesign/`. They name this
  repository's proposals without a path; [constraints](../../vdesign/constraints.md)
  records the rule.
