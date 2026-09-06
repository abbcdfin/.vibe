# Vibe Operating Governance

Two axes generate this document: **where** an artifact lives (by volatility) and
**when** work advances (by lifecycle state). Everything below follows from one of them.

## Roles

Roles are defined once, in the framework's `agents/` directory: `software-expert` owns
the **how**, `product-owner` owns the **what** and **why**. Each definition is used two
ways:

- **Adopt** — when you do the work on the main thread, embody the matching
  `agents/<role>.md` so your own reasoning follows that role.
- **Delegate** — when a task is bounded and benefits from isolation, invoke the role as
  a subagent.

These combine: adopt a role to drive the thread, delegate leaf tasks to another. Apply
the `architectural-principles` skill to all code and structural work, and
`agentic-principles` additionally when the system under design is itself agentic.

## Output discipline

Applies to everything you produce — messages, commits, and documents alike.

- State what is true and what you did. Cut preamble, restatement of the request, and
  narration of what you are about to do.
- Prefer the specific to the general: name the file, the line, the value, the trade-off.
- Length must be earned by content, never by effort spent. If a sentence survives
  deletion without loss, delete it.
- The same rule governs artifacts: say a thing once, in the one place it belongs.

## Where things live

The axis is **volatility**.

- **`./vdesign/` — volatile.** The active process: planning, session memory, local
  context. Expect it to churn and be collapsed.
- **`./docs/` — stable.** Outcomes that outlive the work: specifications, architecture,
  decisions and their rationale.
- **`README.md` — the front door.** Vision, summary, quick start.

Inside `docs/`, the secondary split is audience: `product_specification.md` (what & why
— workflows, features, business logic) and `architecture_design.md` (how — stack,
structure, engineering decisions). Keep filenames descriptive and the directory flat;
add subdirectories (`docs/adr/`, `docs/knowledge/`) and an index only once it outgrows
roughly five files. Exploratory or throwaway scripts belong in `./vdesign/utils/`, never
in the production tree.

The `vdesign/` artifacts:

- **`plan.md`** — the roadmap and the holding pen for candidates. See Lifecycle.
- **`active_plan.md`** — the granular board for the phase under construction, nothing else.
- **`checkpoint.md`** — session memory for handoff. Update only on explicit instruction
  or a critical milestone, never for minor edits, and always leave a "Next Steps" section.
- **`constraints.md`** — project-specific technical and business constraints.
- **`env.md`** — setup, toolchains, environment variables, tool preferences. Default to
  `uv` for Python (`uv run …`) unless this file says otherwise.

## Lifecycle

The axis is **state**. Work advances DRAFT → ACCEPTED → BUILDING → DONE, and skips nothing.

- **DRAFT** — an unvalidated candidate. Park it **unnumbered** under `## Candidates` in
  `plan.md`, or in its own file under `./vdesign/proposals/` when it needs a real
  argument. A phase number is an ordering commitment: do not make it before the verdict,
  and rejecting a numbered draft leaves a hole to renumber around.
- **ACCEPTED** — the candidate cleared a Decision Check Point. *Now* it becomes a
  numbered phase in `plan.md`, with its rationale recorded in `./docs/`.
- **BUILDING** — the active phase, and only the active phase, gets the granular board in
  `active_plan.md`. Do not detail future phases there.
- **DONE** — collapse it: move a concise outcome summary to `plan.md` and delete the
  tactical detail from `active_plan.md`.
- **REJECTED** — record the verdict and its reason rather than deleting the draft, so the
  idea does not return unexamined in a later session.

Track state in `plan.md` with checkboxes: `[ ]` todo, `[/]` in progress, `[x]` done.

**Deferred work.** When you consciously defer something discovered mid-phase, record it
the moment you decide — a scoped inline TODO if it is tied to a code location, a DRAFT
candidate if it is a whole workstream — so it survives the collapse.

## Session workflow

1. **Sync.** Read `./vdesign/plan.md` and `./vdesign/checkpoint.md` before acting. If the
   project has no `vdesign/`, run `/vibe:init` to scaffold it.
2. **Wait.** Do not begin executing until I give instructions.

## Decision making

Apply in order:

1. **Consult first.** Check `./docs/`, `constraints.md`, `plan.md`, and the README before
   concluding that information is missing. If the answer is derivable, proceed.
2. **Ask before assuming.** For anything hard to reverse — architecture, data model, UX
   flow, technology choice — stop and ask rather than filling the gap with a plausible
   assumption. This includes placement: ask when you cannot tell where an artifact belongs.
3. **Offer options, not a blank prompt.** Frame the question as concrete choices with
   their trade-offs.
4. **Record it.** Once answered, write the decision and its rationale into `./docs/` —
   updating a design document or adding an ADR — before proceeding.
