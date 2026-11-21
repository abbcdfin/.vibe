# Checkpoint

Increments 1–10 are DONE; their outcomes and verification are recorded in
[the plan](plan.md#increments). Increments 1 and 2 were published in
[v0.9.0](../CHANGELOG.md#v090--2026-11-04), 3–5 in
[v0.10.0](../CHANGELOG.md#v0100--2026-11-06). Increments 6–9 are unreleased under
`## Unreleased` in the changelog: branching ([ADR 0005](../docs/adr/0005-branching.md)),
then roles, delegation rules and worker mode
([ADR 0006](../docs/adr/0006-delegated-work.md)). Increment 10, milestones
([ADR 0007](../docs/adr/0007-milestones.md)), is unreleased too.

## Next Steps

- Build increment 11, release rules, on `inc/11-release-rules`.
- Then release increments 6–11 as v0.11.0 under those rules: check the notes against an
  upgrade from 0.10.0, tag `dev`, fast-forward `main` to the tag, and push with the
  user's approval.
- The mission pilot candidate waits for mctl to reference roles by name and set
  `VIBE_MODE=worker`.
- Decide the [principle-defaults candidate](proposals/principle-defaults.md); the
  committed references stay authoritative until then, and an accepted change needs an ADR.
- Select a host project for the pending real-project pilot and follow its
  [validation criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
- Validate pi on a live install; no release has been run there.
