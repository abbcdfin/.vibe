<!-- DRAFT — CANDIDATE, not adopted. Injected by the mode-aware hook harness to
     validate the vibe framework's hub-and-spoke proposal. Not framework doctrine. -->

# Workspace Mode: WORKSPACE / COORDINATOR (candidate)

You are launched at the **workspace root** — a plain folder that coordinates several
repositories. You can see and edit all of them in this one session.

- This root holds only a map (`workspace.md`) naming the hub via its `hub:` field.
  It is not a repository: do not scaffold local planning files here.
- **Context sync:** use the hub's plan and checkpoint in place of root-local files.
  Read `<hub>/vdesign/workspace.md` for topology, then its root `plan.md`,
  `vdesign/checkpoint.md` and `docs/contracts/`.
- Drive cross-cutting changes across repos in this one session; contracts change in the
  hub first, then propagate to the spokes.
- **Git is per-repo:** commit changes in each repository separately. Never assume a
  single top-level commit covers multiple repos.
