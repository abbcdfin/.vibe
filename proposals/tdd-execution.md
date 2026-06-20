# Proposal: Test-Driven Execution Mode

> **Status: CANDIDATE — not adopted.** This is a proposal awaiting validation, not an
> active framework rule. Do **not** treat it as doctrine. It must be run manually on at
> least one real task and pass a Decision Check Point before it graduates into the
> framework (e.g. a `workflows/` file referenced by `vibe.md`).

## Motivation

A failing test is an **executable, objective contract**. For agentic work this solves the
two hardest problems at once:

1. **Verifiable completion** — green tests are a success signal, not a vibe. This
   operationalizes the existing `vibe.md` directive that *each phase should be verifiable
   so it can be properly completed*.
2. **Context hygiene for subagents** — the test contract is a compressed, unambiguous
   handoff. A fresh implementation subagent needs the contract, not the exploratory mess
   that produced it.

## Scope: when to use it (and when not)

Test-first is a **phase-scoped tool**, not a universal default. Forcing it everywhere
conflicts with **Minimal Mechanism (#6)**.

* **Use it** for implementation work with a *knowable contract*: business logic, pure
  functions, APIs, data transforms, parsers — anything with a definable input/output.
* **Do not use it** for exploratory or non-deterministic work where the interface is not
  yet known: research/spikes, prompt tuning, data exploration, visual UI, infra, ML
  quality. Verify these differently (snapshots, smoke tests, human eval). Do not write a
  failing test for an interface you are still discovering.

## Workflow

| Phase | Who | Context State | Tooling / Output |
|-------|-----|---------------|------------------|
| 1. Architecture & Design | You + main agent | Collaborative, exploratory | Scratchpad in `vdesign/`; optional MCP forks for second opinions |
| 2. Contract & Test Definition | You + main agent | Focus on interface/tests | Write the **failing** tests; drop inline `// TODO` stubs. Locked contract lands in `docs/` |
| 3. Implementation Execution | Fresh isolated subagent | Pristine, single-task | Reads the TODO + tests, writes code, runs tests to green, exits |
| 4. Verification | You | System-wide view | Static-analysis scripts + human review |

Naming note: phase 1's scratchpad maps onto **`vdesign/`** (volatile) and the locked
contract onto **`docs/`** (stable outcome). Do not introduce a separate `DESIGN.md` — that
reintroduces the "one fact, many places" problem.

## Guardrails (non-negotiable for autonomous runs)

1. **Tests are frozen for the implementation subagent.** The phase-3 subagent may write
   code, run tests, and read results — it **must not modify the test files**. If the
   laborer can edit the test to make it pass, the entire verifiability guarantee
   collapses. Enforce this in tooling (read-only test paths), not just by instruction.

2. **Phase 4 (human verification) is mandatory, not a rubber stamp.** Green tests prove
   the *presence* of intended behavior, not the *absence* of unintended behavior. Green
   does not equal correct system. A human + static analysis must close that gap.

## Known failure modes to watch during validation

* **The laborer games the test** — writes code that satisfies the literal assertion rather
  than solving the problem. (Guardrail 1 limits the worst case; phase 4 catches the rest.)
* **Garbage-in-garbage-out** — weak phase-2 tests yield green-but-wrong code. The real
  intellectual work moves to contract definition; it cannot be done lazily.
* **Brittle/over-mocked tests** — pass while the integrated system is broken.

## Graduation criteria

Promote out of `proposals/` only after:

* It has been run manually on at least one real task.
* Guardrail 1 (frozen tests) is actually enforceable in the harness, not just documented.
* The contract-definition step proved strong enough to produce correct code, not just
  green code.
