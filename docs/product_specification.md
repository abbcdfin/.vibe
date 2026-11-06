# Product Specification

Vibe gives every coding agent a person uses the same engineering governance, roles and
principles, installed once per tool instead of copied into each repository.

The product is its shipped text, and each part is specified where it ships:

- **Governance** — [`vibe.md`](../vibe.md), always on: where project artifacts live, the
  increment lifecycle, the session workflow and decision making.
- **Roles** — [`agents/`](../agents/): `product-owner` owns the what and why,
  `software-expert` the how. The main thread adopts a role or delegates to it.
- **Principles** — the architectural, agentic and Agile skills, each in its
  `skills/<name>/reference.md`, loaded on demand.
- **Initializer** — `/vibe:init`, by [`skills/init/reference.md`](../skills/init/reference.md):
  scaffolds `vdesign/` and `docs/` for a single repository.
- **Workspace modes** — [`modes/`](../modes/) and `/vibe:init hub|spoke`: rules for
  multi-repository projects. A candidate under validation, not adopted.

Supported tools and installation are in the [README](../README.md); changes by version,
with upgrade steps, in the [changelog](../CHANGELOG.md).
