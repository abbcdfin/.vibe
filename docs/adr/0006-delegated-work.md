# ADR 0006: Delegated work — roles, delegation rules and worker mode

- **Status:** Accepted
- **Date:** 2026-11-20
- **Decider:** Jian Zhang

## Context

The spine assumes every session is a top-level session: in mctl's increment 14
acceptance, a delegated worker received the full governance and scaffolded `docs/` and
`vdesign/` beyond its task. mctl's prompts restate governance, so those facts have two
homes. `software-expert` designs, builds and tests, checking its work from the angle
that produced it.

## Decision

- **Roles.** `architect` (design documents, ADRs, increment planning), `implementer`
  (builds to the brief and commits) and `tester` (verifies with evidence, reports
  defects without fixing them) replace `software-expert`; `product-owner` is unchanged.
  Role names are vibe's interface; renaming one is a breaking change.
- **Delegation rules** in the spine: when to delegate, what a brief carries, and that the
  delegating session verifies results and owns `plan.md`, the checkpoint and decisions.
  The implementer drafts the increment's board and stops for review before building;
  workers commit on the increment's branch ([ADR 0005](0005-branching.md)) before handing
  back.
- **Worker mode.** A launching tool sets `VIBE_MODE=worker`; the hooks then append
  `modes/worker.md`, which replaces the session workflow with staying inside the brief.
- **Boundary.** vibe states responsibilities and rules. A launching tool such as mctl
  chooses who plays a role, enforces limits and documents only its own tools, and adds a
  role to the host's default instructions rather than replacing them.

Increments 7–9 deliver these in order.

## Alternatives rejected

- **Merge vibe into mctl.** vibe also governs plain sessions on hosts mctl does not
  launch; the boundary above keeps one home per fact.
- **mctl injects vibe instead of host plugins.** Plain sessions would lose governance,
  and mctl would carry a second copy.
- **Keep `software-expert` and add modes to it.** One role still checks its own work.
- **Apply roles with `--agent`.** On Claude Code and Antigravity it replaces the host's
  default prompt.
- **The delegating session drafts the board.** Drafting it is the implementer's detailed
  design, and reviewing it catches a misread brief before code exists.

## Consequences

- Projects and tools that name `software-expert` must rename it; the release that ships
  increment 7 carries the step.
- mctl removes the governance its prompts restate and references roles by name.
- Validation in a real mctl mission waits for mctl's changes and follows increment 9 as
  a pilot.
