# Proposal: Delegated Work

> **Status: CANDIDATE — not adopted.** The current roles and spine remain authoritative.

## Motivation

- In mctl's increment 14 acceptance, a delegated Codex worker received the full
  governance and scaffolded `docs/` and `vdesign/` beyond its task. The spine assumes
  every session is a top-level session.
- mctl's prompts restate governance: completion claims are not evidence, ask the user
  about decisions, what a developer or reviewer does, when to delegate. Each of those
  facts has two homes.
- Design and planning, implementation and testing need distinct roles;
  `software-expert` covers all three.

## Proposal

1. **Roles.** `product-owner` is unchanged: what and why, acceptance. `software-expert`
   is replaced by:
   - `architect` — design documents, ADRs and increment planning; no production code.
   - `implementer` — builds to the brief and commits.
   - `tester` — verifies against "done when" with evidence; reports defects, does not
     fix them.

   Role names are vibe's interface: tools such as mctl reference them by name. Renaming
   or removing one is a breaking change with an **Upgrade** line.
2. **Delegation rules**, in the spine. The delegating session briefs a bounded task,
   verifies the result itself — a worker's claim of completion is not evidence — and
   keeps ownership of the plan, checkpoint and decisions. For a non-trivial task the
   brief may require **plan first**: the worker returns a detailed plan — steps, files,
   risks and how it will verify — and stops; the delegating session approves or
   corrects it; the worker implements only the approved plan and raises any deviation
   before making it. The plan travels in the answer; an increment-sized brief may ask
   for it as the board.
3. **Worker mode.** `modes/worker.md`, appended when the launching tool sets
   `VIBE_MODE=worker`; `hooks/lib-mode.sh` reads the variable before any manifest. A
   worker skips the session workflow and initialization, stays within its brief, edits
   `vdesign/`, design documents and ADRs only when the brief says so, and reports
   out-of-scope findings in its answer for the delegating session to record.

## Boundary with tools

vibe states responsibilities and rules. A tool such as mctl chooses who plays a role
(backend, model, permissions), enforces limits, and documents only its own tools and
protocol. The [curated-subagents candidate](curated-subagents.md) covers how to write
the brief.

## Validation

One mctl mission with an architect supervisor and implementer and tester workers.
Workers stay within their briefs and create no planning files; the supervisor records
their findings; the tester reports without fixing.

## Open questions

1. How a worker adopts its role on each host: Claude Code has `--agent vibe:<role>`;
   Codex has no agent definitions, so the launching tool may put the role file in the
   task text.
2. Whether the supervisor defaults to `architect`.
