# Agile Method Principles

The **method** layer of the vibe framework: how work is sequenced, built, and verified
once its structure is settled. `architectural-principles` governs how the system is
arranged; this governs how it comes to exist. Both always apply; neither replaces the other.

## Part 1 — The twelve principles behind the Agile Manifesto

Quoted verbatim from <https://agilemanifesto.org/principles.html>. These are the
commitments; Part 2 is how this framework discharges them.

1. Our highest priority is to satisfy the customer through early and continuous delivery
   of valuable software.
2. Welcome changing requirements, even late in development. Agile processes harness change
   for the customer's competitive advantage.
3. Deliver working software frequently, from a couple of weeks to a couple of months, with
   a preference to the shorter timescale.
4. Business people and developers must work together daily throughout the project.
5. Build projects around motivated individuals. Give them the environment and support they
   need, and trust them to get the job done.
6. The most efficient and effective method of conveying information to and within a
   development team is face-to-face conversation.
7. Working software is the primary measure of progress.
8. Agile processes promote sustainable development. The sponsors, developers, and users
   should be able to maintain a constant pace indefinitely.
9. Continuous attention to technical excellence and good design enhances agility.
10. Simplicity—the art of maximizing the amount of work not done—is essential.
11. The best architectures, requirements, and designs emerge from self-organizing teams.
12. At regular intervals, the team reflects on how to become more effective, then tunes and
    adjusts its behavior accordingly.

### Where each already lives in this framework

Most are discharged by machinery that exists. Read this map before adding anything new —
the gap is usually smaller than it looks.

| Principle | Discharged by |
|---|---|
| 1, 3, 7 — early, frequent, working software is the measure | **Build thin, then widen** (below); the Lifecycle's one-phase-at-a-time rule |
| 2 — welcome late change | The Lifecycle's holding pen: an unnumbered DRAFT costs nothing to reorder, and a phase number is withheld until a verdict |
| 4 — business and developers together daily | `product-owner` and `software-expert` as two roles with a declared seam, and Decision making rules 2–3 (ask with options rather than assume) |
| 9 — technical excellence | `architectural-principles` #7 Resist Entropy |
| 10 — maximize work not done | `architectural-principles` #6 Minimal Mechanism, YAGNI |
| 12 — reflect and adjust | DONE collapses a phase into an outcome summary; a rejected DRAFT is recorded with its reason |
| 5, 6, 8, 11 — team, pace, conversation, self-organization | **Not framework concerns.** They govern how humans organize, not how an agent works. Do not simulate them |

Principle 6 deserves a note in an agent context: the nearest honest equivalent is asking
the user directly instead of inferring — Decision making rule 2. It is not a licence to
substitute a long document for a short question.

## Part 2 — Method rules

### Build thin, then widen

Inside a phase, make the narrowest end-to-end path work before making any part of it
complete. Then widen, one case at a time.

- **An unhandled case must fail loudly.** Raise — `NotImplementedError`, an assertion, a
  default branch that errors. Never return a plausible default, never a catch-all that
  swallows, never coerce a bad value into a valid-looking one.
- **The loud failures are the backlog.** This is the engine, not a style preference:
  without them, "widen next" has no driver and coverage grows by guesswork. A faked case
  is a missing case you can no longer see.
- **Validate at the edge, assert inside.** Graceful handling belongs where untrusted input
  enters — user input, network, a tool result. Inside your own code an invariant violation
  is a bug, not a case to absorb. (This is why it does not contradict `agentic-principles`
  §4 Graceful Recovery: a harness reporting a tool failure *is* edge handling.)
- **Check:** "Does this branch exist because I designed for the case, or because I didn't?"

### Thin and end-to-end over thick and partial

Where a phase has the choice, the first increment runs the narrowest path through *every*
layer; later phases thicken it. Completing one component at a time defers all integration
risk to the end, where it costs most.

This pairs with "Simple Now, Flexible Later" (`architectural-principles`): the slice is
the simple implementation, and clean seams are what let later phases thicken it by
extension rather than rewrite.

### Three things called "a prototype"

"Prototype" says something was built early. It does not say whether it survives — the
property every rule here turns on. A **spike** is a time-boxed build that answers one
technical question and is then discarded (the XP sense).

| | **Spike** | **Thin slice** | **Demo** |
|---|---|---|---|
| Purpose | Answer one technical question | Deliver the first increment | Elicit what to build |
| Lifespan | Throwaway by definition | Kept and grown | Throwaway |
| Output | A finding | Running software | Requirements |
| Place in development | Before a phase is accepted | How a BUILDING phase proceeds | Before any DRAFT exists |
| Owner | `software-expert` | `software-expert` | `product-owner` (IPD Concept) |
| Home | `vdesign/utils/` | the production tree | — |

A spike allowed to survive becomes a thin slice that never passed a gate. A thin slice
mistaken for a spike gets abandoned with the work half-done.

### Throwaway probes

When a DRAFT can only be judged by building something, build the smallest thing that
answers the question:

- **Declare the question first,** with a stop condition. "Explore the API" is not a
  question; "can we hold a frame under 16 ms on this device" is.
- **It lives in `vdesign/utils/`**, exempt from the architectural standards — which is
  exactly why it must not survive.
- **Its output is a finding,** recorded with the DRAFT. The code is not the deliverable.
- **No silent promotion.** To keep the code, accept a phase whose scope includes bringing
  it to standard. Promotion requires the gate, never inertia.
- **Fail loudly while probing.** A probe that stubs its hard cases with plausible values
  answers nothing — the faked case is usually the one that decides the verdict.

### When not to

- **When the answer is derivable.** Decision making rule 1 first: consult `docs/`,
  `constraints.md`, the README. A probe is for an unknown, not for unread context.
- **As a substitute for a decision.** If the blocker is an unmade choice, make it or ask.
  Building something is not a way to avoid deciding.
- **Thin-slicing, when there are no layers to slice through** or a phase is genuinely one
  component deep.
- **Fail-loud at a trust boundary.** See "validate at the edge" above.
