# ADR 0007: Milestones group increments under an accepted outcome

- **Status:** Accepted
- **Date:** 2026-11-21
- **Decider:** Jian Zhang

## Context

A long task spans several increments, each accepted on its own, so a session running
toward a goal stops at every one. Increments that each pass do not show that together
they deliver the larger outcome. [ADR 0002](0002-increments-as-progress-units.md)
excludes a separate development-cycle entity.

## Decision

- A **milestone** is a heading in `plan.md`'s Increments with its own "done when". Its
  increments are listed under it, not nested; increments outside any milestone remain
  allowed. It groups outcomes and is not a development cycle, so ADR 0002's exclusion
  stands.
- Accepting a milestone accepts its listed increments, each numbered with its "done
  when". Adding an increment to it widens scope and needs renewed acceptance.
- A milestone is DONE when its increments are DONE and its own "done when" is verified
  end to end.
- A **goal** names one or more accepted milestones, in order; each is DONE before the
  next begins. The checkpoint names the goal's milestones and the one in progress.
- Running toward a goal changes no gate: an unattended run stops wherever the
  governance would ask the user.

## Alternatives rejected

- **Accept increments one by one and run a goal across them.** The run stops at each
  acceptance, and nothing checks the whole.
- **Nest increments under a milestone entry.** The plan groups under headings and never
  nests; a heading keeps each increment's status where it is.
- **One milestone per goal.** A user may want several built in one run; ordering them
  keeps a failed check from being built on.
- **A milestone as a release.** A release bundles DONE work as a separate event;
  tying them would make DONE wait for publication.

## Consequences

- Plans without milestones are unchanged; the initializer's seed shows the heading.
- Validation in a real project joins the pending real-project pilot.
