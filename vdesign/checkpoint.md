# Checkpoint

Increments 1–4 are DONE; their outcomes and verification are recorded in
[the plan](plan.md#increments). Increments 1 and 2 were published in
[v0.9.0](../CHANGELOG.md#v090--2026-11-04). Increment 3 ([ADR 0003](../docs/adr/0003-document-kinds-and-proposal-lifecycle.md))
and increment 4's consistency cleanup are unreleased, along with the README's
Antigravity update steps. The next release is minor, v0.10.0.

## Next Steps

- Decide the [principle-defaults candidate](proposals/principle-defaults.md); the
  committed references stay authoritative until then, and an accepted change needs ADR 0004.
- Release v0.10.0 when the user asks, by the candidate
  [release rules](proposals/release-rules.md); the GitLab mirror also lacks v0.9.0.
- Select a host project for the pending real-project pilot and follow its
  [validation criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
- Confirm v0.9.0 on the real installs once they are updated.
