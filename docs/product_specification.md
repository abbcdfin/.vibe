# Product Specification

Vibe provides shared engineering governance, roles and principles across coding tools,
installed once per host rather than copied into every project.

The shipped text is the product; its authoritative sources are:

- **Governance** — [`vibe.md`](../vibe.md): artifacts, the increment lifecycle and its
  branches ([ADR 0005](adr/0005-branching.md)), session workflow and decisions.
- **Roles** — [`agents/`](../agents/): product-owner for what and why, software-expert
  for engineering execution; adopted on the main thread or delegated. **Pending
  (increments 7–8, [ADR 0006](adr/0006-delegated-work.md)):** architect, implementer
  and tester replace software-expert, under delegation rules in the governance.
- **Principles** — each skill's `reference.md`: architectural structure, Agile method
  and agentic-system design.
- **Initializer** — [`skills/init/reference.md`](../skills/init/reference.md): project
  planning files and design stubs, preserving existing content; the `dev` branch and the
  pre-push hook.
- **Workspace modes** — [`modes/`](../modes/) and hub/spoke initialization: candidates
  for multi-repository work, not adopted doctrine.

See the [README](../README.md) for supported hosts and installation, and the
[changelog](../CHANGELOG.md) for releases and upgrade steps.
