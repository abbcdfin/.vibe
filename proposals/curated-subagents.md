# Proposal: Curated-Context Subagents

> **Status: CANDIDATE — not adopted.** This is a proposal awaiting validation, not an
> active framework rule. Do **not** treat it as doctrine. It must be run manually on at
> least one real task and pass a Decision Check Point before it graduates into the
> framework (e.g. a `workflows/` file referenced by `vibe.md`).

## Motivation

Delegate a bounded task to a **fresh subagent that holds only a curated briefing** for
that one task — it does the work, returns a result, and exits. The benefit is context
hygiene: a cold agent carrying just the contract outperforms a veteran agent dragging the
whole exploratory history.

This is the more general principle underneath the [test-driven execution
proposal](./tdd-execution.md) — a test contract is simply one way to make the handoff
*verifiable*. Curated-context execution is the deeper idea; TDD is one instance of it.

## Why it works

1. **Context rot is real.** LLMs degrade with long, noisy context — attention dilutes,
   middle content is lost, early dead-ends bias later steps. Removing accumulated *noise*
   often beats keeping accumulated *context*.
2. **Determinism & blast radius.** Minimal fixed input → more predictable output; a
   subagent that goes wrong damages only its leaf task.
3. **A forcing function for good design.** If the task can't be described concisely enough
   to hand to a cold agent, it isn't well-specified yet. The compression *is* the design
   discipline.

## The core rule: curated, not starved

The hard part does not disappear — it moves to the **handoff**, and that is where this
pattern fails if done naively. This is why the pattern is *curated*-context, not merely
*isolated*: isolation is the easy half; curation is the half that determines whether it
works.

* A cold agent **does not know your seams.** It cannot see that a shared utility already
  exists, what the layer conventions are, or *why* a constraint holds. Left truly minimal,
  it reinvents, duplicates, and violates **One Fact, One Place (#1)** — isolation then
  *manufactures* the very entropy the principles fight. Pure isolation is just amnesia.
* **Cold-start tax.** It re-reads and re-derives what the main agent already understood.
  For small tasks this overhead can exceed the task itself — net-negative.
* **No cross-cutting judgment.** It cannot make good system-level tradeoffs because it
  cannot see the system.

**Operative rule:** the value of a curated subagent is bounded by the quality of the
briefing. A good briefing carries the task **plus pointers to the relevant existing
seams** — the utilities it should reuse, the layer it works in, the conventions, and the
*why* behind constraints. Concise means *curated and sufficient*, never blindly minimal.

## Scope: when to use it (and when not)

* **Use it** for bounded *leaf* tasks with an explicit contract (e.g. TDD phase 3
  implementation).
* **Do not use it** for exploratory, cross-cutting, or under-specified work — there the
  context you would have to supply approaches "everything," and isolation buys nothing
  while costing the cold-start tax and loss of system-level judgment.

## Fit with the framework

The machinery to produce briefings already exists: `vdesign/` (checkpoint + JIT plan) is
the curated state, and the contract is the spec. A curated subagent is a natural
*consumer* of structure already built — a discipline for packaging what `vdesign/` holds,
not a new subsystem.

## Known failure modes to watch during validation

* **Convention drift** — the subagent ignores existing utilities/patterns it could not see
  and duplicates them. (Primary risk; mitigated only by a briefing that names the seams.)
* **Over-delegation** — using it for tasks too small or too cross-cutting to justify the
  handoff overhead.
* **Lossy handoff** — the briefing omits the *why*, so the agent makes locally-correct but
  globally-wrong choices.

## Graduation criteria

Promote out of `proposals/` only after:

* It has been run manually on at least one real task.
* A repeatable **briefing template** exists that reliably carries the relevant seams (not
  just the task), demonstrably avoiding convention drift.
* The overhead of packaging the briefing is shown to pay for itself on the target task
  size.
