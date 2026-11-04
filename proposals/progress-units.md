# Proposal: Progress Units

> **Status: CANDIDATE — not adopted.** Graduation renames the spine's planning unit from
> phase to **increment** — a minor release. The files it touches are listed under
> "Changes on graduation".

The spine names the phase but not what goes on the `active_plan.md` board, so projects
fill the gap with step, item, task, epic and feature, each meaning something slightly
different.

## The model

Three nested units of work, at most. Scope and delivery sit on their own axes.

| Term | What it is | Home |
|---|---|---|
| **Increment** | The planning unit: a bounded, verifiable change to the product | `plan.md` |
| **Slice** | Optional: an integration point inside an increment | `active_plan.md` |
| **Task** | The unit of execution: one commit-sized checkbox | `active_plan.md` |
| **Feature** | Scope: a capability the product has, not a progress unit | `docs/product_specification.md` |
| **Release** | An event: publishes increments already DONE | `CHANGELOG.md` |

IPD keeps its own terms — "IPD Lifecycle Phases" and their Decision Check Points (DCPs).
IPD context is optional, a single line atop `plan.md` where it serves the project.
Dropped as synonyms: epic, step, item, milestone, story, sprint, development cycle.

## Rules

1. **The increment carries the lifecycle.** DRAFT → ACCEPTED → BUILDING → DONE; numbered
   at acceptance, one BUILDING at a time. **Acceptance** is the gate — prepared by
   `product-owner`, decided by the user. DCP is reserved for IPD gates.
2. **An increment defines an outcome, not a workflow.** It states what improves and when
   it is done. Design, building and validation are activities used as needed, not
   mandatory stages; a configuration or documentation change takes its own path. Every
   increment still gets the verification that fits it.
3. **"Done when" has a persistent home:** written with the increment in `plan.md`, or a
   reference to its definition in `docs/`. The board points to it and never restates it.
   DONE means the outcome is verified, not that every task is checked.
4. **Use board levels only when useful.** Tasks alone suffice for a small increment;
   slice headings mark the points where it integrates again. A software slice leaves the
   product working and integrated; other work ends with a verifiable deliverable. Group
   increments in `plan.md` under headings, never by nesting.
5. **Findings outside "done when" never widen the increment.** Each becomes a candidate
   or a scoped TODO, when found and in any case before the board is deleted.
6. **DONE collapses the board.** Verify "done when", leave an outcome and verification
   summary in `plan.md`, then delete the board.
7. **DONE does not wait for a release.** A release, when it happens, adds "Released in
   vX" to each increment it publishes.
8. **Feature progress is inferred.** An increment names the features it delivers, if any;
   quality, infrastructure and documentation increments need none.

## Shape

```markdown
# Plan
IPD: Development (DCP 2026-10-01, docs/adr/0003)

## Ingest
- [x] 1. CSV import — delivers *import*. Done when: a 10k-row file loads in under 5 s.
  Verified: tests/test_ingest.py, 3.1 s. Released in v0.2.0.
- [x] 2. CI gate — done when: main accepts only green builds.
  Verified: a failing PR was blocked.

## Validation
- [/] 3. Row checks — done when: every row is accepted or rejected with a reason.

## Candidates
- Multi-sheet files — found during 3, outside its "done when".
- Excel import — REJECTED 2026-10-12: users export CSV anyway.
```

Increment 2 is DONE and awaits a release. The board for increment 3:

```markdown
# Increment 3 — Row checks (done when: plan.md)

## Slice 1 — thin path: one rule, end to end  [x]
- [x] Rule engine with one rule
- [x] Rejection shown in the UI
## Slice 2 — widen: malformed dates (failed loudly in slice 1)  [/]
- [/] Date parser
```

## Changes on graduation

- **`vibe.md`** — "phase" becomes "increment" (lines 60, 76–81, 89–93); ACCEPTED means
  "cleared acceptance", not a DCP. The Lifecycle gains rules 3, 5 and 7, and the
  checkpoint trigger "critical milestone" becomes "an increment reaching DONE, or a
  release".
- **`skills/agile-principles/`** — "phase" becomes "increment" (`SKILL.md` description;
  `reference.md` 39, 40, 44, 55, 108, 119). Lines 72–73 and 77 are rewritten: an
  increment's first slice runs the narrowest path through every layer, later slices
  thicken it up to its "done when", and widening past that is a new increment. In the
  table, line 88's thin slice "makes the first working, end-to-end version of the
  increment", and line 91 reads "Before an increment is accepted" and "How a BUILDING
  increment proceeds".
- **`skills/init/reference.md`** — the `plan.md` seed gains an optional IPD line and an
  increment list beside `## Candidates`.
- **`agents/product-owner.md`** — a line saying that it prepares acceptance: the outcome
  and its "done when".
- **Proposals** — "phase" becomes "increment" in `release-rules.md`, `tdd-execution.md`
  and `curated-subagents.md`.
- **`CHANGELOG.md`** — Upgrade: existing plans switch at their next increment; DONE
  history stays as written.

## Validation

One real increment in a project that keeps `vdesign/`, run from acceptance to DONE. It
passes on three counts:

- **Clear scope** — "done when" decided every in-or-out call, and at least one finding
  outside it became a candidate or TODO without widening the increment.
- **Resumable work** — a fresh session resumes from `plan.md`, `active_plan.md` and
  `checkpoint.md` without asking what is in flight.
- **Verified outcome** — DONE is recorded with its evidence, and the increment stays DONE
  while it awaits a release.

## Open questions

1. Which project hosts the validation increment?
