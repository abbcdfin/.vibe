# Proposal: Delegated Work

> **Status: CANDIDATE — not adopted.** The current roles and spine remain authoritative.

## Motivation

- In mctl's increment 14 acceptance, a delegated Codex worker received the full
  governance and scaffolded `docs/` and `vdesign/` beyond its task. The spine assumes
  every session is a top-level session.
- mctl's prompts restate governance: completion claims are not evidence, ask the user
  about decisions, what a developer or reviewer does, when to delegate. Each of those
  facts has two homes.
- `software-expert` designs, builds and tests, so it checks its work from the angle that
  produced it. Distinct roles check each other: the architect reviews the implementer's
  board against the design, the tester verifies work it did not build, and the product
  owner accepts against the why.

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
   keeps ownership of `plan.md`, the checkpoint and decisions.
3. **The implementer owns the board.** When an increment's build is delegated, the
   implementer drafts `vdesign/active_plan.md` — slices and commit-sized tasks, each
   with how it will be verified — and stops. The delegating session approves or
   corrects the board; the implementer then builds by it, checking off tasks, and
   raises any change to the plan before making it. Drafting the board is the
   implementer's detailed design; reviewing it catches a misread brief before code
   exists.
4. **Workers commit before handing back**, on the increment's
   [branch](branching.md); uncommitted work is not handed back. The delegating session
   creates the branch and merges it at DONE.
5. **Worker mode.** `modes/worker.md`, appended when the launching tool sets
   `VIBE_MODE=worker`; `hooks/lib-mode.sh` reads the variable before any manifest. A
   worker skips the session workflow and initialization, stays within its brief, and
   reports out-of-scope findings in its answer for the delegating session to record.
   In `vdesign/` it edits only its board; design documents and ADRs only when the brief
   says so.

## Boundary with tools

vibe states responsibilities and rules. A tool such as mctl chooses who plays a role
(backend, model, permissions), enforces limits, and documents only its own tools and
protocol. The [curated-subagents candidate](curated-subagents.md) covers how to write
the brief.

**Applying a role to a launched session** (tested 2026-11-20 on Claude Code 2.1.328,
Codex 0.153.2 and Antigravity 1.5.11; the recipe belongs to the launching tool). Add
the role to the host's default instructions; never replace them. `--agent` on Claude
Code and Antigravity replaces the default prompt, and Antigravity's agent format has
no field to keep it. The tool writes the role body, header stripped and prefixed "In
this session you act as the following role.", to `.mctl/<instance>/AGENTS.md` in the
working directory, so each worktree carries its own roles, excluded through Git's
`info/exclude`, and passes it as:

- Claude Code: `--append-system-prompt-file .mctl/<instance>/AGENTS.md`.
- Codex: `-c developer_instructions="<its text>"`.
- Antigravity: `--add-dir .mctl/<instance>`; an added folder's `AGENTS.md` is an
  always-on rule, injected into the default prompt.

Each session kept vibe's hook and took the role; Claude Code and Antigravity kept their
default prompts, and Codex adds a developer message beside base instructions it would
not quote. An unframed role file reads as a subagent definition.

## Validation

One mctl mission on an increment branch, with an architect supervisor and implementer
and tester workers.
Workers stay within their briefs and create no planning files; the supervisor records
their findings; the tester reports without fixing. Record what the board review and the
tester caught that the implementer did not.

## Open questions

1. Whether the supervisor defaults to `architect`.
