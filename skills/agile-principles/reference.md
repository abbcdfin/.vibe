# Agile Method Principles

This skill governs sequencing and verification. The governance Lifecycle owns increment
scope and completion; `architectural-principles` governs structure.

## Part 1 — The twelve principles behind the Agile Manifesto

Quoted verbatim from <https://agilemanifesto.org/principles.html>.

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

| Principles | Framework support |
|---|---|
| 1, 3, 7 — frequent delivery of working software | Integrated slices and verified increment outcomes |
| 2 — welcome change | Candidates and explicit acceptance of scope changes |
| 4 — business and developers together | Product-owner and software-expert responsibilities; direct user decisions |
| 9, 10 — quality and simplicity | Architectural principles: Resist Entropy and Minimal Mechanism |
| 12 — reflect and adjust | Outcome summaries, verification and recorded rejection reasons |
| 5, 6, 8, 11 — people and team organization | Human concerns; do not simulate them with agent ceremonies |

## Part 2 — Method rules

### Build thin, then widen

For a software increment spanning layers, make the narrowest path through every layer
work first. Widen through integrated slices within its "done when". Completing entire
components separately defers integration risk. Keep clean seams so later slices can
extend the working path.

Slice headings are optional. A single-component change, configuration update or
documentation increment uses the activities and verification its outcome needs.

- **Fail loudly on the unhandled case.** Raise an explicit error rather than invent a plausible
  default, silently coerce data or swallow a failure. Visible failures identify what
  needs widening; route findings by the governance Lifecycle's scope rules.
- **Validate at the edge, assert inside.** Handle untrusted input at user, network and
  tool boundaries. Internal invariant violations are bugs; do not disguise them as
  valid results. Reporting a tool failure to an LLM is edge handling, not suppression.

**Check:** Does this branch implement a supported case or conceal a missing one?

### Three things called "a prototype"

| | Spike | Thin slice | Demo |
|---|---|---|---|
| Purpose | Answer a technical question | Deliver a working path | Discover requirements |
| Lifespan | Throwaway | Kept and grown | Throwaway |
| Output | A finding | Integrated software | Requirements |
| Place in development | Before an increment is accepted | How a BUILDING increment proceeds | Before any DRAFT exists |
| Owner | software-expert | software-expert | product-owner |
| Home | `vdesign/utils/` | Production tree | Temporary working material |

A spike is time-boxed and informs acceptance; a thin slice implements an accepted increment.
Keeping a spike without acceptance bypasses the gate; discarding a thin slice abandons
the implementation.

### Throwaway probes

- State one question and a stop condition before building. Record the finding with
  the candidate; probe code is not the deliverable.
- Keep the probe in `vdesign/utils/`. Build only what answers the question, with explicit
  failures for unsupported cases. Probe code is exempt from the architectural standards;
  that exemption is why it must not survive without promotion.
- Keeping the code requires an accepted increment that brings it to production standard.
- Do not probe for an answer already in project documents or to avoid an unmade decision.
