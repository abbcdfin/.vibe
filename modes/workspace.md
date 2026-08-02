<!-- DRAFT — CANDIDATE, not adopted. Injected by the mode-aware hook harness to
     validate proposals/hub-and-spoke-mode.md. Not framework doctrine. -->

# Workspace Mode: WORKSPACE / COORDINATOR (candidate)

You are launched at the **workspace root** — a plain folder that coordinates several
repositories. You can see and edit all of them in this one session.

- This root holds only a map (`workspace.md`) naming the hub via its `hub:` field. It is
  NOT a repository and stores nothing substantive.
- Read the hub's manifest (`<hub>/vdesign/workspace.md`) for the authoritative topology
  (the spoke list), and read the hub's `docs/contracts/` + cross-cutting `plan.md` first.
- Drive cross-cutting changes across repos in this one session; contracts change in the
  hub first, then propagate to the spokes.
- **Git is per-repo:** commit changes in each repository separately. Never assume a
  single top-level commit covers multiple repos.
