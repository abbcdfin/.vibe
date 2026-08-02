<!-- DRAFT — CANDIDATE, not adopted. Injected by the mode-aware hook harness to
     validate proposals/hub-and-spoke-mode.md. Not framework doctrine. -->

# Workspace Mode: HUB (candidate)

You are working inside the **hub** repository — the single source of truth for
cross-cutting concerns.

- Own the cross-stack roadmap (`plan.md`), global constraints, and the shared
  contracts/schemas in `docs/contracts/` (the seams between components).
- **Define cross-boundary data structures HERE, once.** Spokes consume them; they must
  never re-invent them locally.
- **Context sync order:** read the hub `plan.md` + `docs/contracts/`; consult a spoke's
  local `vdesign/` only when coordinating that spoke.
- The authoritative spoke list is the `spokes:` field in `vdesign/workspace.md`.
