<!-- DRAFT — CANDIDATE, not adopted. Injected by the mode-aware hook harness to
     validate proposals/hub-and-spoke-mode.md. Not framework doctrine. -->

# Workspace Mode: SPOKE (candidate)

You are working inside a **spoke** repository of a multi-repository workspace.

- This repo is a normal single-repo vibe project for its own component/slice.
- The **hub** holds the authoritative cross-cutting plan and the shared contracts
  (`docs/contracts/`). Its location is the `hub:` field in this repo's
  `vdesign/workspace.md`.
- **Context sync order:** read the hub's global plan + `docs/contracts/` FIRST, then
  this spoke's local `vdesign/`.
- **Schemas-first:** never define or redefine a cross-boundary data structure locally.
  If a shared type is missing or must change, change it in the hub's `docs/contracts/`
  first, then consume it here.
- Keep component-specific work in this repo; do not author cross-cutting decisions here.
