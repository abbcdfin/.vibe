---
name: init
description: Initialize the current directory as a vibe project — scaffold vdesign/ (plan, checkpoint, constraints, env) and docs/ stubs. Takes one architecture-mode argument — single (default), hub, or spoke — for multi-repository workspaces. Use whenever the user asks to initialize, scaffold, bootstrap, or set up a vibe project or workspace.
---

# Vibe Project Initializer

Initialize the current directory as a vibe project. This skill is plugin-namespaced,
so it is invoked as `/vibe:init` on Claude Code, Codex, and Antigravity. It takes one
input — the workspace **mode** — which you read from the user's invocation (skills
have no positional `$1`, so the mode arrives as plain text in the request).

## Determine the mode (the argument)

Read the mode from what the user typed:

- Look for the word **`single`**, **`hub`**, or **`spoke`** anywhere in the
  invocation — e.g. `/vibe:init hub`, "initialize a spoke here", "bootstrap this as a
  hub workspace", or a bare "set up vibe" (→ `single`).
- If none of those words is present, default to **`single`**.

## Execute

Read `reference.md` alongside this file and follow the procedure for the resolved
mode exactly. It is the single source of truth for the scaffolding steps — do not
re-derive them here.

`hub` and `spoke` are EXPERIMENTAL candidate patterns (`proposals/hub-and-spoke-mode.md`,
not yet adopted); tell the user so before scaffolding them.
