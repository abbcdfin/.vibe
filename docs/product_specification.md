# Product Specification

Vibe provides shared engineering governance, roles and principles across coding tools,
installed once per host rather than copied into every project.

The shipped text is the product; its authoritative sources are:

- **Governance** — [`vibe.md`](../vibe.md): artifacts, delegation, the increment
  lifecycle and its branches ([ADR 0005](adr/0005-branching.md)), milestones and goals
  ([ADR 0007](adr/0007-milestones.md)), session workflow and decisions.
- **Roles** — [`agents/`](../agents/): product-owner for what and why, architect for
  design and increment planning, implementer for building to the brief, tester for
  verification ([ADR 0006](adr/0006-delegated-work.md)); adopted on the main thread or
  delegated, a delegated session running in worker mode.
- **Principles** — each skill's `reference.md`: architectural structure, Agile method
  and agentic-system design. **Pending (increment 11,
  [ADR 0008](adr/0008-release-rules.md)):** release rules in the Agile reference.
- **Initializer** — [`skills/init/reference.md`](../skills/init/reference.md): project
  planning files and design stubs, preserving existing content; the `dev` branch and the
  pre-push hook.
- **Modes** — [`modes/`](../modes/): worker mode for delegated sessions; workspace modes
  and hub/spoke initialization are candidates for multi-repository work.

See the [README](../README.md) for supported hosts and installation, and the
[changelog](../CHANGELOG.md) for releases and upgrade steps.
