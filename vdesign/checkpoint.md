# Checkpoint

Increments 1–6 are DONE; their outcomes and verification are recorded in
[the plan](plan.md#increments). Increments 1 and 2 were published in
[v0.9.0](../CHANGELOG.md#v090--2026-11-04), 3–5 in
[v0.10.0](../CHANGELOG.md#v0100--2026-11-06). Increment 6, branching
([ADR 0005](../docs/adr/0005-branching.md)), is unreleased under `## Unreleased` in the
changelog. Increments 7–9, delegated work ([ADR 0006](../docs/adr/0006-delegated-work.md)),
are ACCEPTED.

## Next Steps

- Build increment 7, roles, on `inc/7-roles`.
- Decide the [principle-defaults candidate](proposals/principle-defaults.md); the
  committed references stay authoritative until then, and an accepted change needs an ADR.
- Select a host project for the pending real-project pilot and follow its
  [validation criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
- Validate pi on a live install; no release has been run there.
