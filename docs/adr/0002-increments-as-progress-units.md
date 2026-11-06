# ADR 0002: Increments as the unit of progress

- **Status:** Accepted
- **Date:** 2026-11-04
- **Decider:** Jian Zhang
- **Related:** Progress Units proposal, drafted in `25cb943` and revised in `85b20c0`

## Context

The roadmap calls bounded commitments "phases", while IPD and development workflows
also use that word. Each commitment can extend the existing product through whatever
activities it needs; it is not itself a design, development or validation phase.
The working board also lacks names for its contents and a persistent completion boundary.

## Decision

Adopt the revised Progress Units proposal at the user's request. The planning unit is
an **increment**, with optional slices and tasks on its working board. The canonical
rules live in [the governance Lifecycle](../../vibe.md#lifecycle); the
[Agile guidance](../../skills/agile-principles/reference.md#part-2--method-rules)
describes how software slices grow, and the
[initializer](../../skills/init/reference.md#mode-single-default) supplies the seeds.

Keep IPD Lifecycle Phases and workflow phases under their existing names. Increment
acceptance is distinct from an IPD Decision Check Point. Do not introduce a separate
development-cycle entity or require every increment to follow the same activities.

"Done when" stays with the increment or in a referenced stable specification.
New findings do not silently expand accepted scope; changing it requires renewed user
acceptance. Completion is verified independently of publication.

## Rationale

- One planning term covers feature, quality, infrastructure and documentation work.
- A persistent "done when" bounds widening and survives working-board deletion.
- Optional decomposition keeps small increments small.
- Separating completion from publication allows DONE work to await a release.

## Adoption and migration

Update the spine, Agile skill, initializer, product-owner guidance and dependent
proposals together. Existing projects switch terminology at their next increment;
completed history stays as written. This behavioral change belongs in the next minor
release. Adoption in this checkout does not publish that release.

## Validation still pending

The documentation and adapter checks for this adoption do not establish that the model
has passed its proposed real-project pilot. Choose a host project that keeps `vdesign/`
and run one increment from acceptance through DONE. Verify that:

- an out-of-scope finding becomes a candidate or scoped TODO;
- a fresh session can resume from the plan, board and checkpoint;
- completion includes evidence and remains DONE while awaiting release.

Track this follow-up as an unnumbered candidate until a project is selected. Do not
claim a fresh-session trial from same-session document checks.
