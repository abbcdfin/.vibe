# Vibe Operating Governance

These rules govern this session.

## Roles

Adopt the matching role from the framework's `agents/`: `product-owner` owns **what
and why**; `architect` owns design and increment planning; `implementer` builds to the
brief; `tester` verifies against "done when".

Apply `architectural-principles` to code and structure, `agile-principles` to
sequencing, verification and releasing, and `agentic-principles` to agentic systems.

## Delegation

- **When.** Delegate leaf tasks with an explicit contract; keep exploratory,
  cross-cutting or under-specified work.
- **Brief.** State the task, "done when", seams to reuse (utilities, layer, conventions)
  and why constraints hold; specify first if it will not brief concisely.
- **Board.** On a delegated increment build, the implementer drafts and commits
  `active_plan.md`, stops for review, then builds by the approved board and raises any
  change first.
- **Handback.** Commit all work on the increment's branch before handing back. Report
  each contract item's commit and evidence (command and result), then what was not run
  and out-of-scope findings.
- **Ownership.** The delegating session creates and merges the branch, verifies results
  itself by reviewing reported evidence and the diff, rerunning only on an exception and
  only the checks covering what changed or is in doubt (completion claims are not
  evidence; `agile-principles` lists the exceptions), and owns `plan.md`, the checkpoint
  and decisions.

## Output discipline

In messages, documents and code:

- Model the system before changing it; reuse its names and propagate conceptual changes.
- State outcomes and evidence; name the file, value or trade-off that matters.
- Cut preamble, request restatement and narration of upcoming steps.
- Earn length by content, not effort; keep each fact in one place and cut repetition
  and sentences that add no information.

## Where things live

Place artifacts by volatility: `vdesign/` holds active process, `docs/` durable
outcomes, `README.md` the vision, summary and quick start, and `CHANGELOG.md` what each
release changed for consumers.

- **Design documents** describe the current design and change with it:
  `docs/product_specification.md` (features, workflows, rationale) and
  `docs/architecture_design.md` (structure, mechanisms). A feature, component or
  subsystem that needs more gets `docs/design/<topic>.md`, linked from the global
  document it refines. Mark accepted, unbuilt parts **pending** with their
  increment; remove the mark at DONE.
- **Decision records** (`docs/adr/NNNN-<slug>.md`) preserve context, choice, rejected
  alternatives and consequences. Write one when alternatives were weighed and reversal
  is hard; otherwise record rationale in the design document. Supersede with a later
  ADR; upkeep may change only status, supersession links and references, never the
  original decision or reasoning.

Keep filenames descriptive and `docs/` otherwise flat; add directories and an index
past roughly five files.

| `vdesign/` | Purpose |
|---|---|
| `plan.md` | Increments, outcomes and unnumbered candidates |
| `proposals/` | Arguments too long for a candidate line |
| `active_plan.md` | Tasks and optional slices for the BUILDING increment |
| `checkpoint.md` | Handoff context; always include "Next Steps" |
| `constraints.md` | Project-specific technical and business limits |
| `dev_env.md` | Development setup, toolchains, local paths and local overrides |
| `utils/` | Throwaway scripts and probes |

Update the checkpoint only on instruction, starting a goal, an increment or milestone
reaching DONE, or a release. Default to `uv` for Python unless `dev_env.md` overrides
it. Put runtime configuration in the architecture design or constraints; local overrides
reference that source.

## Lifecycle

An **increment** is a bounded, verifiable product change defining an outcome; design,
development and validation are activities used as needed.

Increments advance DRAFT → ACCEPTED → BUILDING → DONE without skipping states. `main`
moves only to a tagged release by fast-forward from `dev`, which always works; commit
non-increment planning (candidates, proposals, checkpoint) straight to `dev`, and never
rewrite `main`, `dev` or tags (rebase only unshared commits).

- **DRAFT** — list unnumbered under `## Candidates` in `plan.md`; link a proposal in
  `vdesign/proposals/` if it needs a longer argument.
- **ACCEPTED `[ ]`** — `product-owner` prepares acceptance; the user decides. Only then
  number the increment in `plan.md` with its **"done when"** (inline or linked in
  `docs/`) and delivered features. Accepting a milestone accepts and numbers its listed
  increments; adding one later widens scope. Record proposal decisions in `docs/`,
  keeping the proposal until DONE. IPD Decision Check Points stay separate gates.
- **BUILDING `[/]`** — one increment at a time: mark BUILDING on `dev`, branch
  `inc/<n>-<slug>`, and carry the board, work and DONE record there, committing each
  task as checked off. `active_plan.md` links "done when" without copying it (when
  delegated, see Delegation), using commit-sized task checkboxes naming how each is
  verified and optional **slice** headings for integration points. Software slices
  leave the product working and integrated; other work ends with a verifiable
  deliverable.
- **DONE `[x]`** — merge `dev` into the increment branch, verify "done when" there,
  reconcile design documents and record outcome and verification in `plan.md`. Repoint
  surviving proposal links to the design document, ADR or Git revision, delete the board
  and that increment's proposal, merge into `dev` with `--no-ff` and delete the branch.
  Checked tasks alone do not establish completion; DONE does not wait for release.
- **REJECTED** — keep the candidate and any proposal; record verdict and reason on the
  candidate line and atop the proposal, and delete any increment branch.

Group increments under headings, never nest them. An optional **milestone** heading has
no checkbox and its own "done when"; once its increments are DONE, verify it end to end
on `dev` and record `Outcome` and `Verified` under the heading. A **goal** runs accepted
milestones in order — each DONE before the next begins — with the goal and active
milestone in `checkpoint.md`; running toward a goal changes no gate (stop wherever
governance asks the user). Tasks use plain checkboxes; infer feature progress from
delivered increments.

**Build thin, then widen.** For software, make the narrowest end-to-end path work first.
Unhandled cases fail loudly and drive widening within "done when".

**Scope and findings.** Widening scope requires renewed acceptance. Record out-of-scope
findings immediately (scoped inline TODO for code, unnumbered candidate for a
workstream). Resolve or record all open findings before deleting the board; deferral
never satisfies "done when".

## Session workflow

Read `vdesign/plan.md` and `vdesign/checkpoint.md` before acting; run `/vibe:init` if
`vdesign/` is absent. Follow the user's instructions; wait if none have been given.

## Decision making

1. **Consult first.** Check `docs/`, `vdesign/constraints.md`, `plan.md` and `README.md`;
   proceed if derivable.
2. **Ask before assuming.** Ask on unresolved, hard-to-reverse choices (architecture,
   data models, UX flows, technology, unclear artifact placement); do not re-ask
   answered questions.
3. **Offer options.** Give concrete choices and trade-offs.
4. **Record the decision.** Write choice and rationale in the design document or ADR
   before proceeding.
