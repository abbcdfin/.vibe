# Vibe Project Initializer — Procedure

Use the directory the user identified, otherwise the current directory. Ask only if
the target or a conflicting edit is unresolved. Create missing artifacts; preserve
existing content. If `vdesign/env.md` exists, apply the framework changelog's v0.8.0
Upgrade instructions instead of creating a second environment file.

## Mode: `single` (default)

Create:

- `vdesign/plan.md`, using the seed below.
- `vdesign/checkpoint.md`, with a `Next Steps` section.
- `vdesign/constraints.md` and `vdesign/dev_env.md`, as project-specific stubs.
- `vdesign/utils/.gitkeep`, for throwaway scripts.
- `docs/product_specification.md` and `docs/architecture_design.md`, as design stubs.
- `README.md`, only if absent, with a vision and quick start.

Create `docs/design/`, `docs/adr/` and `vdesign/proposals/` only when writing their
first document — not during initial scaffolding. Do not create `.vibe/`;
the framework is installed as a plugin.

Set up branching and the pre-push hook in the target repository: create `dev` from
`main` when absent, and copy `pre-push` from this skill's directory (alongside
`SKILL.md` and `reference.md`) into `.git/hooks/pre-push` as an executable only when
none exists, reporting and leaving any existing hook alone. If there is no `.git/`, no
commit yet, or no `main` branch, report that the branching rules expect `main` and skip
creating `dev` and installing the hook without running `git init`, committing, or
renaming a branch.

Seed `plan.md` with:

```markdown
# Plan

<!-- Optional: IPD: <phase> (DCP <date>, <decision reference>). -->

## Increments

## Candidates
```

The governance Lifecycle owns numbering, "done when", proposal handling and completion.
Once an increment enters BUILDING, create `vdesign/active_plan.md` with:

```markdown
# Increment <number> — <outcome>

Done when: [increment <number> in the plan](plan.md#increments).

- [ ] <task>
```

Add slice headings only when integration points help organize the work.

## Mode: `hub` (EXPERIMENTAL)

Scaffold the single-mode structure, but put the roadmap at root `plan.md` instead of
`vdesign/plan.md`. The board remains `vdesign/active_plan.md`; its "done when" link
points to `../plan.md`. Also create:

- `vdesign/workspace.md`:

  ```yaml
  mode: hub
  hub: .
  spokes: []
  ```

- `docs/contracts/README.md`, stating that shared schemas and API contracts are defined
  here and consumed by spokes.

Use supplied spoke paths; ask for missing ones. Paths in repository manifests are
relative to the repository root.

## Mode: `spoke` (EXPERIMENTAL)

Scaffold single mode and add `vdesign/workspace.md`:

```yaml
mode: spoke
hub: ../architecture/
```

Use the supplied hub path; confirm it if unresolved. Explain that context sync reads
the hub's global plan and contracts before the spoke's local planning files.

## After scaffolding

Summarize what was created, read the applicable plan and checkpoint, then continue the
user's authorized task. Wait if no further work was requested.
