# Proposal: Progress Units

> **Status: CANDIDATE — not adopted.** Graduation target: the spine's Lifecycle (names
> the board's contents, adds the stage line and "done when"), `agents/product-owner.md`
> (IPD stages), and the `plan.md` / `active_plan.md` seeds in `skills/init/reference.md`.

The spine names the phase but not what goes on the `active_plan.md` board, so projects
fill the gap with step, item, task, epic and feature, each meaning something slightly
different.

## The model

Not one hierarchy. Three terms are nested units of work; the rest sit on other axes —
product maturity, scope, delivery — and each has one home.

| Term | What it is | Home |
|---|---|---|
| **Stage** | Where the product is in its life (IPD, Concept → Lifecycle Management); one at a time, advanced by a DCP | one line atop `plan.md` |
| **Phase** | The unit of commitment: numbered on ACCEPTED, one BUILDING at a time | `plan.md` |
| **Slice** | The unit of delivery inside the BUILDING phase: first the thin end-to-end path, then one widening each; every slice ends runnable | `active_plan.md` |
| **Task** | The unit of execution inside a slice: one commit-sized checkbox | `active_plan.md` |
| **Feature** | Scope, not progress: a capability the product has | `docs/product_specification.md` |
| **Release** | An event: a published bundle of DONE phases | `CHANGELOG.md` |

Dropped as synonyms: **epic** (a feature, or a parent phase), **step** and **item** (a
task), **milestone** (a phase reaching DONE, or a release), **story** (a slice),
**sprint** (a time-box the agent does not have).

## Rules

1. **One level per file.** `plan.md` never lists slices or tasks; `active_plan.md` never
   lists another phase.
2. **Only phases carry lifecycle states.** Slices and tasks exist only inside an accepted
   phase, so checkboxes suffice.
3. **A phase is accepted with a "done when".** It bounds the widening: a loud failure
   inside it becomes a slice, one outside it a candidate.
4. **Sub-phases group; only a leaf phase is BUILDING.**
5. **Feature progress is read, not tracked.** A phase names the features it delivers;
   nothing else records their progress.
6. **DONE collapses the board.** Delete the slices and tasks; the summary in `plan.md`
   names the features delivered and the release that carried them.

Existing plans convert at their next phase; DONE history is not rewritten.

## Shape

```markdown
# Plan
Stage: Development (DCP 2026-10-01, docs/adr/0003)

## Phases
- [x] 1. Ingest — delivers *CSV import*. Outcome: … Released in v0.2.0.
- [/] 2. Validation — delivers *row checks*. Board: active_plan.md
- [ ] 3. Dashboard
  - [ ] 3.1 Query layer

## Candidates
- Offline sync — needs a spike: can a sync finish under 2 s on 3G?
- Excel import — REJECTED 2026-10-12: users export CSV anyway.
```

```markdown
# Phase 2 — Validation
Done when: every row is accepted or rejected with a reason.

## Slice 1 — thin path: one rule, end to end  [x]
- [x] Rule engine with one rule
## Slice 2 — widen: malformed dates (failed loudly in slice 1)  [/]
- [/] Date parser
## Loud failures, not yet sliced
- NotImplementedError: multi-sheet files (src/validate.py:88)
```

## Framework changes on graduation

- `agents/product-owner.md`: "IPD Lifecycle Phases" become **stages**, freeing "phase"
  for `plan.md`.
- Spine: the checkpoint trigger "critical milestone" becomes "a phase reaching DONE, or a
  release".

## Validation

One phase of a real project run from ACCEPTED to the DONE collapse in this shape. It
passes if no other term was needed, nothing was stated in two files, and "done when"
stopped the widening.

## Open questions

1. **DCP names two gates** — the spine's accepts a phase, IPD's advances a stage. One
   name scoped by what it gates, or a separate name (e.g. *acceptance*) for the phase gate?
2. **Stage for non-products** — a library or this framework has no Launch. Is the stage
   line optional?
