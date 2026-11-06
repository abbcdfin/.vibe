# Vibe Project Initializer — Procedure

The single source of truth for initializing a directory as a **vibe** project. The
`init` skill (`skills/init/SKILL.md`) — plugin-namespaced to `/vibe:init` on Claude
Code, Codex, and Antigravity — executes this procedure. The caller supplies one
input — the workspace **mode** (`single` | `hub` | `spoke`), defaulting to `single`.

First, confirm the target directory with the user if it is not empty or if any
`vdesign/` or `docs/` already exists — do not overwrite existing artifacts; merge
or ask. If a `vdesign/env.md` exists from before the rename, migrate it by the v0.8.0
**Upgrade** step in the framework's `CHANGELOG.md` rather than creating a second file.

## Mode: `single` (default)

Scaffold a standard single-repository vibe project. Create only what's missing:

- `vdesign/plan.md` — roadmap. Use the seed below: an empty increment list and a
  holding pen for unnumbered DRAFT candidates. Add the optional IPD context only where
  the project uses it; do not invent a phase or decision reference.
- `vdesign/checkpoint.md` — volatile session memory. Seed with a "Next Steps" section.
- `vdesign/constraints.md` — project-specific technical/business constraints (stub).
- `vdesign/dev_env.md` — the *development* environment: setup, toolchains, local paths, the
  variables you need set to work here (stub). Not the built system's runtime environment —
  that is architecture or a constraint.
- `vdesign/utils/.gitkeep` — home for exploratory/supportive scripts.
- `docs/` — create the directory; add the design documents
  `docs/product_specification.md` (what & why) and `docs/architecture_design.md` (how) as
  brief stubs. Create `docs/adr/` with the first decision record, and
  `vdesign/proposals/` with the first proposal — not before.
- `README.md` — create only if absent (high-level vision / quick start stub).

Seed `plan.md` with:

```markdown
# Plan

<!-- Optional: IPD: <phase> (DCP <date>, <decision reference>). -->

## Increments

## Candidates
```

When an increment is accepted, add a numbered checkbox under `## Increments` with its
outcome and "done when", or a reference to its definition in `docs/`. Group increments
under headings if needed; do not nest them. Lifecycle rules live in `vibe.md`.

Create `vdesign/active_plan.md` only when an increment enters BUILDING. Its seed is:

```markdown
# Increment <number> — <outcome>

Done when: [increment <number> in the plan](plan.md#increments).

- [ ] <task>
```

Tasks alone suffice for small increments. Add optional slice headings when integration
points help organize the work. Point to the increment's "done when" rather than copying
it onto the board, and remove the board when the increment reaches DONE.

Do NOT create a `.vibe/` directory or add it to `.gitignore` — the framework is
installed as a plugin, not embedded in the repo.

## Mode: `hub` (EXPERIMENTAL — candidate proposal)

> This mode implements the vibe framework's hub-and-spoke proposal, which is a
> CANDIDATE and not yet adopted. Tell the user it is experimental before scaffolding.

Run this in the workspace root / architecture ("hub") repo. Scaffold:

- `vdesign/workspace.md` — the topology manifest. Seed with:
  ```yaml
  mode: hub
  hub: .            # this repo is the single source of truth
  spokes: []        # add each component repo path, e.g. [firmware/, mobile/, cloud/]
  ```
- `plan.md` (repo root) — the cross-cutting, cross-stack roadmap; use the increment
  layout above.
- `docs/contracts/` — the shared seams (schemas / API contracts). Add a README
  explaining that cross-boundary data structures are defined here FIRST, then
  consumed by spokes (never re-invented locally).
- `vdesign/` (constraints.md, checkpoint.md) scoped to global/cross-cutting concerns.

Ask the user for the spoke repository paths and populate `spokes:` accordingly.

## Mode: `spoke` (EXPERIMENTAL — candidate proposal)

Run this inside a component repo. Scaffold a normal single-repo vibe project
(as in `single` mode) PLUS a pointer back to the hub:

- `vdesign/workspace.md` — seed with:
  ```yaml
  mode: spoke
  hub: ../architecture/   # relative path to the hub repo (confirm with user)
  ```

Explain to the user that during context-sync in this repo, the hub's global plan
and `docs/contracts/` are consulted FIRST, then this spoke's local `vdesign/`.

## After scaffolding (all modes)

Summarize what was created, then follow the vibe workflow: read the plan and
checkpoint, and wait for the user's instructions before executing.
