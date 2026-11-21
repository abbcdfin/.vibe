# Vibe Operating Governance

These rules govern this session: where artifacts live, how increments advance, and
how decisions are made.

## Roles

Adopt the matching role from the framework's `agents/`: `product-owner` owns the
**what and why**; `architect` owns design and increment planning, `implementer` builds
to the brief, and `tester` verifies against "done when".

Apply `architectural-principles` to code and structural work, `agile-principles` to
sequencing and verification, and `agentic-principles` when designing agentic systems.

## Delegation

- **When.** Delegate leaf tasks with an explicit contract; keep exploratory,
  cross-cutting or under-specified work.
- **Brief.** Give the task, "done when", seams to reuse (utilities, layer, conventions)
  and why constraints hold; if it will not brief concisely, specify it first.
- **Board.** On a delegated build, the implementer drafts and commits `active_plan.md`,
  stops for review, then builds by the approved board and raises any change first.
- **Handback.** Commit all work on the increment's branch before handing back. Report
  each contract item's commit and evidence (command and result), then what was not run
  and out-of-scope findings.
- **Ownership.** The delegating session creates and merges the branch, verifies results
  itself (completion claims are not evidence), and owns `plan.md`, the checkpoint and
  decisions.

## Output discipline

For messages, documents and code:

- Model the system before changing it. Reuse its names; propagate conceptual changes.
- State the outcome and evidence. Name the file, value or trade-off that matters.
- Cut preamble, restatement of the request, and narration of what you are about to do.
- Length must be earned by content, never by effort spent.
- Keep each fact in one place. Remove repetition and sentences that add no information.

## Where things live

Place artifacts by volatility: `vdesign/` holds active process, `docs/` durable
outcomes, and `README.md` the vision, summary and quick start.

- **Design documents** describe the current design and change with it. Two global ones
  sit at the root of `docs/`: `product_specification.md` covers features, workflows and
  business rationale; `architecture_design.md` covers structure and mechanisms. A
  feature, component or subsystem that needs more gets `docs/design/<topic>.md`, linked
  from the global document it refines. Mark accepted but unbuilt parts **pending**,
  naming their increment; remove the mark at DONE.
- **Decision records**, `docs/adr/NNNN-<slug>.md`, preserve a decision's context, choice,
  rejected alternatives and consequences. Write an ADR when alternatives were weighed
  and the choice is hard to reverse; otherwise put the rationale in the design document.
  Supersede decisions with a later ADR. Upkeep may change only status, supersession links
  and references, never the original decision or reasoning.

Keep filenames descriptive and `docs/` otherwise flat; add directories and an index
when it outgrows roughly five files. Put throwaway scripts in `vdesign/utils/`.

Inside `vdesign/`:

| Artifact | Purpose |
|---|---|
| `plan.md` | Increments, outcomes and unnumbered candidates |
| `proposals/` | Arguments too long for a candidate line |
| `active_plan.md` | Tasks and optional slices for the BUILDING increment |
| `checkpoint.md` | Handoff context; always include "Next Steps" |
| `constraints.md` | Project-specific technical and business limits |
| `dev_env.md` | Development setup, toolchains, local paths and environment overrides |

Update the checkpoint only on instruction, an increment or milestone reaching DONE, or
a release.
Default to `uv` for Python unless `dev_env.md` says otherwise. Runtime configuration
belongs in the architecture design or constraints; local overrides reference that source.

## Lifecycle

An **increment** is a bounded, verifiable product change. It defines an outcome;
design, development and validation are activities used as needed.

Increments advance DRAFT → ACCEPTED → BUILDING → DONE, without skipping states.
`main` moves only to a tagged release by fast-forward from `dev`, which always works;
commit non-increment planning (candidates, proposals, the checkpoint) straight to `dev`,
and never rewrite `main`, `dev` or tags (rebase only unshared commits).

- **DRAFT** — list the candidate unnumbered under `## Candidates` in `plan.md`; link to
  a proposal in `vdesign/proposals/` when it needs a longer argument.
- **ACCEPTED `[ ]`** — `product-owner` prepares acceptance; the user decides. Only now
  number the increment in `plan.md`, with its **"done when"** written there or linked
  to `docs/`, and any features it delivers. Accepting a milestone accepts and numbers its
  listed increments; adding one later widens scope. Record a proposal's decision in
  `docs/`; retain the proposal until DONE. IPD Decision Check Points remain separate gates.
- **BUILDING `[/]`** — one increment at a time: mark it BUILDING on `dev`, branch
  `inc/<n>-<slug>`, and carry the board, work and DONE record there, committing each task
  as you check it off. Its `active_plan.md` points to "done when" without copying it
  (when delegated, see Delegation). Use commit-sized task checkboxes, each naming how it
  will be verified; add optional **slice** headings for integration points. Software
  slices leave the product working and integrated; other work ends with a verifiable
  deliverable.
- **DONE `[x]`** — merge `dev` into the increment branch, verify "done when" there,
  reconcile design documents with the result, and record the outcome and verification in
  `plan.md`. Repoint surviving proposal links to the design document, ADR or Git
  revision, delete the board and that increment's proposal, then merge into `dev` with
  `--no-ff` and delete the branch. Checked tasks alone do not establish completion; DONE
  does not wait for release.
- **REJECTED** — keep the candidate and any proposal; record the verdict and reason on
  the candidate line and atop the proposal, and delete any increment branch.

Group increments under headings, never nest them. An optional **milestone** heading
carries no checkbox and has its own "done when"; once its increments are DONE, verify
it end to end on `dev` and record `Outcome` and `Verified` lines under the heading. A
**goal** names accepted milestones in order — each DONE before the next begins — with
the goal and active milestone noted in `checkpoint.md`; running toward a goal changes
no gate (stop wherever governance would ask the user). Slices and tasks use plain
checkboxes. Infer feature progress from delivered increments.

**Build thin, then widen.** For software, make the narrowest end-to-end path work first.
Unhandled cases fail loudly and drive widening within "done when".

**Scope and findings.** Widening scope requires renewed acceptance. Record out-of-scope
findings when found: a scoped inline TODO for a code location, an unnumbered candidate
for a whole workstream. Resolve or record every open finding before deleting the board;
deferral never satisfies an unmet "done when".

## Session workflow

Read `vdesign/plan.md` and `vdesign/checkpoint.md` before acting; run `/vibe:init` if
`vdesign/` is absent. Follow the user's instructions; wait if none have been given.

## Decision making

1. **Consult first.** Check `docs/`, `vdesign/constraints.md`, the plan and README. Proceed
   when the answer is derivable.
2. **Ask before assuming.** Ask about unresolved choices that are hard to reverse:
   architecture, data models, UX flows, technology, or unclear artifact placement.
   An answer already given to the same question stands; do not ask again.
3. **Offer options.** Give concrete choices and their trade-offs.
4. **Record the decision.** Put the choice and rationale in the appropriate design
   document or ADR before proceeding.
