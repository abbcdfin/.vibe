# ADR 0001: Mode-specific rules via dependent injection, not merged into `vibe.md`

- **Status:** Accepted
- **Date:** 2026-08-01
- **Deciders:** Jian Zhang
- **Related:** [`proposals/hub-and-spoke-mode.md`](../../proposals/hub-and-spoke-mode.md)

## Context

The vibe plugin supports (or will support) multiple workspace modes — `single`,
`hub`, and `spoke` — declared per project in `vdesign/workspace.md`. The always-on
governance spine (`vibe.md`) is injected into every session by the `SessionStart`
hook.

The question: once the hub-and-spoke pattern is validated, **where should the
mode-specific operational rules live?**

- **Option A — Merge into `vibe.md`.** One document containing single + hub + spoke
  rules, with in-prose conditionals ("if hub… / if spoke…").
- **Option B — Mode-dependent injection.** Keep `vibe.md` mode-agnostic; put
  mode-specific rules in separate modules the hook loads conditionally based on the
  `workspace.md` manifest.

## Decision

**Adopt Option B.** Keep one mode-agnostic `vibe.md` spine. Mode-specific
operational rules live in `modes/*.md` (e.g. `modes/hub.md`, `modes/spoke.md`) and
are appended to the injected governance **only when that mode is active**, as
determined by reading `vdesign/workspace.md` at `SessionStart`. `vibe.md` gains only
a small, always-true **mode-agnostic pointer** (a project may be single/hub/spoke;
mode is declared in `workspace.md`; multi-repo modes load additional rules).

End-state structure:

```
vibe.md            base spine + tiny "Workspace Modes" pointer (always injected)
modes/workspace.md adopted; injected when launched at a workspace-root map (mode: workspace)
modes/hub.md       adopted; injected only when mode: hub
modes/spoke.md     adopted; injected only when mode: spoke
(single = base spine only)
```

The manifest is read from the launch cwd — the root `workspace.md` map, or a repo's
`vdesign/workspace.md`. See `proposals/hub-and-spoke-mode.md` for the workspace-root
(coordinator) model.

Consequently, the graduation target for the hub-and-spoke proposal is **`modes/`,
not `vibe.md`** — graduating means moving from `proposals/` (candidate) to `modes/`
(adopted doctrine the injection engine loads), plus adding the one-line pointer to
the spine.

This also **resolves the "read vs. hook-inject" open question** in
`proposals/hub-and-spoke-mode.md` in favor of **hook-injection**: mode awareness is
delivered as always-on governance, not left to a discretionary read.

## Rationale

- **Context as a scarce resource** (agentic principle #3). Most sessions are
  single-repo; merging would make every one of them carry — and reason around —
  multi-repo rules it never uses. Injection shows each session only the rules that
  apply, keeping single-repo sessions lean.
- **Construct Engine / data-driven** (architectural principle #3). The injection
  mechanism is a generic engine (read manifest → load matching module). Merging
  collapses that into a prose `if/else` the model re-evaluates every turn.
- **One Fact, One Place** (#1) is **not** violated. #1 forbids *duplicating* a fact,
  not physical separation. Each rule still lives exactly once — in the spine or in
  one mode module.
- **Clean seams / extension-not-rewrite** (#7 + the tension-resolution rule). A
  future mode is a new module the engine picks up, not surgery on a monolith.

## Consequences

- **Positive:** lean single-repo sessions; a data-driven, extensible mode engine;
  a small stable spine; new modes added by extension.
- **Cost:** the `SessionStart` hook must read `vdesign/workspace.md` and select the
  module (a small, one-time conditional) — accepted as appropriate mechanism, not
  over-engineering, since the hook must read the manifest for mode awareness anyway.
- **Follow-up:** when hub-and-spoke graduates, create `modes/hub.md` and
  `modes/spoke.md`, add the mode-agnostic pointer to `vibe.md`, and implement the
  `workspace.md`-driven append in `hooks/inject-governance.sh`.
