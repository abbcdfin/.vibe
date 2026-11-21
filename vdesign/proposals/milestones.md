# Proposal: Milestones

> **Status: ACCEPTED** as increment 10 in [ADR 0007](../../docs/adr/0007-milestones.md);
> deleted when it is DONE. Graduation target: the spine's Lifecycle and the
> initializer's `plan.md` seed.

## Motivation

- A long task spans several increments, but each increment needs its own acceptance, so
  a lead running toward a goal (a host's `/goal`, or a supervisor's mission) stops at
  every one.
- Increments that each pass do not show that together they deliver the larger outcome.

## Proposal

1. **A milestone groups increments under an outcome.** It is a heading in `plan.md`'s
   Increments with its own "done when"; increments under it are not nested. Increments
   outside any milestone remain allowed. It is not a development cycle, so ADR 0002's
   exclusion stands.

   ```markdown
   ### M1 — <outcome>

   Done when: <end-to-end check>.

   - [ ] 6. <increment> — done when: …
   - [ ] 7. <increment> — done when: …
   ```

2. **Accepting a milestone accepts its increments.** One user decision numbers each
   listed increment with its "done when". Adding an increment to an accepted milestone
   is widening scope and needs renewed acceptance; a finding becomes a candidate.
3. **A milestone is DONE when its increments are DONE and its own "done when" is
   verified** end to end. Record its outcome and verification under its heading.
4. **A goal names one or more accepted milestones, in order.** Each is verified DONE
   before the next begins, so a failed check stops the run before later work builds on
   it. The checkpoint names the goal's milestones and the one in progress, so a resumed
   session continues them.
5. **Running toward a goal changes no gate.** An unattended run stops and reports
   wherever the spine would ask the user: a hard-to-reverse choice, widening scope, or a
   "done when" that cannot be met.

Unchanged: one increment at a time, each on its own
[branch](../../docs/adr/0005-branching.md); a release is a separate event; IPD Decision
Check Points remain separate gates.

## Validation

One milestone of at least two increments run under a goal in a real project. Record
each stop and whether a gate caused it, and whether the end-to-end check caught
anything the increments' checks did not.
