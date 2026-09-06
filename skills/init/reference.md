# Vibe Project Initializer — Procedure

The single source of truth for initializing a directory as a **vibe** project. The
`init` skill (`skills/init/SKILL.md`) — plugin-namespaced to `/vibe:init` on Claude
Code, Codex, and Antigravity — executes this procedure. The caller supplies one
input — the workspace **mode** (`single` | `hub` | `spoke`), defaulting to `single`.

First, confirm the target directory with the user if it is not empty or if any
`vdesign/` or `docs/` already exists — do not overwrite existing artifacts; merge
or ask.

## Mode: `single` (default)

Scaffold a standard single-repository vibe project. Create only what's missing:

- `vdesign/plan.md` — interactive design board & roadmap. Seed with a title and an
  empty checkbox list (`[ ]` Todo, `[/]` In Progress, `[x]` Done), plus an
  empty `## Candidates` section — the holding pen for unnumbered DRAFT ideas.
- `vdesign/checkpoint.md` — volatile session memory. Seed with a "Next Steps" section.
- `vdesign/constraints.md` — project-specific technical/business constraints (stub).
- `vdesign/env.md` — setup, toolchains, env vars (stub).
- `vdesign/utils/.gitkeep` — home for exploratory/supportive scripts.
- `docs/` — create the directory; add `docs/product_specification.md` (What & Why)
  and `docs/architecture_design.md` (How) as brief stubs.
- `README.md` — create only if absent (high-level vision / quick start stub).

Do NOT create a `.vibe/` directory or add it to `.gitignore` — the framework is
installed as a plugin, not embedded in the repo.

## Mode: `hub` (EXPERIMENTAL — candidate proposal)

> This mode implements `proposals/hub-and-spoke-mode.md`, which is a CANDIDATE and
> not yet adopted. Tell the user it is experimental before scaffolding.

Run this in the workspace root / architecture ("hub") repo. Scaffold:

- `vdesign/workspace.md` — the topology manifest. Seed with:
  ```yaml
  mode: hub
  hub: .            # this repo is the single source of truth
  spokes: []        # add each component repo path, e.g. [firmware/, mobile/, cloud/]
  ```
- `plan.md` (repo root) — the cross-cutting, cross-stack roadmap.
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
