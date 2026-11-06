# Vibe Operating Governance

The vibe framework is installed; these rules are in effect for this session.
Follow them.

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

Applies to everything you produce — a message, a commit, a document, a change to the code.

- Start from your model of the system, not its surface — when writing a sentence and
  when making a change alike. A coherent model makes expression short and modification
  small; patching the surface rescues neither.
- Reuse the system's names. When something does not fit, adjust the concept and
  propagate — stretching a name costs the same as coining a second.
- State what is true and what you did. Cut preamble, restatement of the request, and
  narration of what you are about to do.
- Prefer the specific to the general: name the file, the line, the value, the trade-off.
- Length must be earned by content, never by effort spent. If a sentence survives
  deletion without loss, delete it.
- The same rule governs artifacts: say a thing once, in the one place it belongs.

## Where things live

The axis is **volatility**.

- **`./vdesign/` — volatile.** The active process: planning, proposals, session memory,
  local context. Expect it to churn and be collapsed.
- **`./docs/` — stable.** Outcomes that outlive the work.
- **`README.md` — the front door.** Vision, summary, quick start.

`docs/` holds two kinds of document:

- **Design documents** describe the system as currently designed and change with it:
  `product_specification.md` (what & why — workflows, features, business logic) and
  `architecture_design.md` (how — stack, structure, mechanisms). Mark a part accepted but
  not yet built as pending, naming its increment; DONE removes the mark.
- **Decision records** (ADRs), `docs/adr/NNNN-<slug>.md`, each keep one decision as made —
  context, choice, rejected alternatives, consequences. That record is never rewritten: a
  later ADR supersedes it, and upkeep is limited to status, supersession links and
  repaired references. Write one when alternatives were weighed and the choice is hard to
  reverse; otherwise put the rationale in the design document the decision shapes.

Keep filenames descriptive and `docs/` otherwise flat; add a subdirectory
(`docs/knowledge/`) and an index only once it outgrows roughly five files. Exploratory or
throwaway scripts belong in `./vdesign/utils/`, never in the production tree.

The `vdesign/` artifacts:

- **`plan.md`** — the roadmap and the holding pen for candidates. See Lifecycle.
- **`proposals/`** — the argument for a candidate that needs more than a line. See
  Lifecycle.
- **`active_plan.md`** — the granular board for the increment under construction, nothing else.
- **`checkpoint.md`** — session memory for handoff. Update only on explicit instruction
  or an increment reaching DONE, or a release; always leave a "Next Steps" section.
- **`constraints.md`** — project-specific technical and business constraints.
- **`dev_env.md`** — the **development** environment: setup, toolchains, local paths, and the
  variables you need set to work here. Default to `uv` for Python (`uv run …`) unless this
  file says otherwise. What the *built system* runs on is not this file — a deployment
  target or a runtime variable is an engineering decision (`docs/architecture_design.md`)
  or an imposed limit (`constraints.md`).

## Lifecycle

The unit of progress is an **increment**: a bounded, verifiable change to the product. It
defines an outcome, not a workflow — design, development and validation are activities
used as needed, and every increment gets the verification its outcome calls for.

The axis is **state**. Increments advance DRAFT → ACCEPTED → BUILDING → DONE, and skip nothing.

- **DRAFT** — an unvalidated candidate, listed **unnumbered** under `## Candidates` in
  `plan.md`. When it needs a real argument, the line links to its **proposal** in
  `./vdesign/proposals/`. An increment number is an ordering commitment: do not make it
  before the verdict, and rejecting a numbered draft leaves a hole to renumber around.
- **ACCEPTED** — the candidate cleared **acceptance**: prepared by `product-owner`,
  decided by the user. IPD Decision Check Points are separate gates. *Now* it becomes a
  numbered increment in `plan.md`, with its **"done when"** written there or linked to its
  definition in `docs/`, and the features it delivers, if any. A proposal's decision goes
  to `docs/` (Decision making, rule 4); the proposal stays until DONE.
- **BUILDING** — one increment at a time. Only that increment gets the granular board in
  `active_plan.md`, which points to its "done when" rather than restating it. Tasks are
  commit-sized checkboxes; optional **slice** headings mark integration points. A software
  slice leaves the product working and integrated; other work ends with a verifiable
  deliverable. Tasks alone suffice for small increments.
- **DONE** — verify "done when", bring the design documents in line with the result, and
  record a concise outcome and verification summary in `plan.md`; then delete the board and
  any proposal, first repointing links to it at the design document, ADR or Git revision
  that replaces it. Checked tasks alone do not establish completion, and DONE does not
  wait for a release.
- **REJECTED** — record the verdict and its reason on the candidate line and atop any
  proposal, rather than deleting the draft, so the idea does not return unexamined in a
  later session.

Track increments in `plan.md` with checkboxes — `[ ]` ACCEPTED, `[/]` BUILDING, `[x]` DONE —
grouped under headings, never nested. Slices and tasks use plain checkboxes. Feature
progress is inferred from delivered increments.

**Build thin, then widen.** Inside a software increment, make the narrowest end-to-end
path work before making any part of it complete, and let unhandled cases fail loudly —
those failures are the backlog. Apply the `agile-principles` skill to sequencing and
verification where its method rules fit the work.

**Scope and findings.** Findings outside "done when" never silently widen the increment.
Record each when found: a scoped inline TODO if it is tied to a code location, an
unnumbered DRAFT candidate if it is a whole workstream. Widening the scope takes renewed
acceptance. Before deleting the board, resolve or record every open finding; deferring
one never satisfies an unmet "done when".

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
   An answer the user already gave to the same question stands; do not ask it again.
3. **Offer options, not a blank prompt.** Frame the question as concrete choices with
   their trade-offs.
4. **Record it.** Once answered, write the decision and its rationale into `./docs/` (see
   *Where things live*) before proceeding.
