# Index of information required for vibe design

## System Role
Roles are defined in the `./.vibe/identities` directory. You should pick the proper role based on each individual task.

## Specification
The specification of this project is in the project root `README.md`. (Note: Ensure this file exists or point to the relevant documentation).

## Vibe Design (Project Specific)
While `.vibe/` contains generic framework rules, all project-specific design artifacts MUST be placed in the `./vdesign/` directory at the project root. This ensures that different design agents can collaborate using a shared, project-local context.

### Plan (`./vdesign/plan.md`)
Use `plan.md` as the interactive design board and high-level roadmap.
- **Status Tracking:** Use Markdown checkboxes: `[ ]` (Todo), `[/]` (In Progress), `[x]` (Done).
- **Just-In-Time (JIT) Planning:** For the active phase, create a granular plan in `./vdesign/active_plan.md`. Do not detail future phases in the JIT plan.
- **Summarize and Collapse:** Once a phase is finished, move a concise summary of the outcome to `plan.md` and delete/archive the tactical details from `active_plan.md`.

### Checkpoint (`./vdesign/checkpoint.md`)
Used strictly for volatile short-term memory and session handoffs.
- **Efficiency:** DO NOT update for minor edits.
- **Triggers:** Update only on "Explicit Instruction" or "Critical Milestones" (resolving high-friction blockers).
- **Handoff:** Always include a "Next Steps" section for the next agent or session.

### Knowledge (`./vdesign/knowledge/` or `./vdesign/knowledge.md`)
Store design-critical information here:
- **Stable Knowledge:** Architectural decisions, hardware/domain quirks.
- **Negative Knowledge:** Document what *failed* or was rejected and why, to prevent regression or wasted effort.
- **Corrections:** Update when a previous assumption is proven wrong.
- **Indexing:** If using a directory, maintain `./vdesign/knowledge/index.md`.

### Constraints (`./vdesign/constraints.md`)
Project-specific technical or business constraints.

### Work Environment (`./vdesign/env.md`)
Project-specific setup, toolchains, or environment variables.

## Work Flow
1. **Initialize:** On first entry, read `.vibe/vibe.md` to understand the rules.
2. **Context Sync:** Read `./vdesign/plan.md` and `./vdesign/checkpoint.md` to understand the current state.
3. **Wait:** Please wait for my instructions before starting execution.

### Decision Making

When executing a task, you will encounter decisions. Apply the following rules in order:

1. **Consult existing artifacts first.** Check `./vdesign/knowledge/`, `./vdesign/constraints.md`, `./vdesign/plan.md`, and the README before concluding that information is missing. If the answer is derivable from existing context, proceed without asking.

2. **Ask before assuming.** If the information needed to make a decision is not available in the existing artifacts — especially for decisions that are hard to reverse (architecture choices, data model shape, UX flow, technology selection) — **stop and ask the user directly**. Do not fill the gap with a plausible-sounding assumption. State clearly what the decision is, why it matters, and what the options are.

3. **Present options, not open questions.** When asking, frame the question with concrete options and their trade-offs rather than asking "what do you want?" An informed choice is faster than a blank prompt.

4. **Document the decision.** Once the user has answered, record the decision and its rationale in `./vdesign/knowledge/` before proceeding. This prevents the same question from arising in a future session.
