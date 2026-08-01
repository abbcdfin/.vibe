# Vibe

An installable **vibe coding framework** for Claude Code (and, later, Antigravity CLI).
Install it once and every project gets the same always-on engineering governance,
selectable role identities, architectural & agentic principles, and a one-command
project initializer — with nothing to copy into individual repositories.

## What's in the plugin

| Component | Path | Loading |
|-----------|------|---------|
| **Governance spine** | `vibe.md` | **Always-on** — injected every session by a `SessionStart` hook (`hooks/`) |
| **Role identities** | `agents/` (`software-expert`, `product-owner`) | Adopted by the main thread *or* delegated as subagents; each agent file is the single canonical role definition |
| **Architectural principles** | `skills/architectural-principles/` | On-demand skill; full text in its `reference.md` |
| **Agentic principles** | `skills/agentic-principles/` | On-demand skill; full text in its `reference.md` |
| **Project initializer** | `commands/init.md` → `/vibe:init` | Slash command |
| **Candidate patterns** | `proposals/` | Not adopted — awaiting validation |

## Install (Claude Code)

This repository is both the plugin (at its root) and a single-plugin marketplace
(`.claude-plugin/marketplace.json`). Pick one path:

**A. Try it now, this session only** (no install):

```bash
claude --plugin-dir /path/to/vibe
```

**B. Install persistently from the git remote** (recommended — updates via `git pull`
+ `/plugin marketplace update`):

```
/plugin marketplace add abbcdfin/.vibe
/plugin install vibe@vibe-marketplace
/reload-plugins
```

Or add the local clone instead of the remote:

```
/plugin marketplace add /path/to/vibe
/plugin install vibe@vibe-marketplace
/reload-plugins
```

**Verify:** start Claude Code in any repo — the vibe rules should be present in
context, and `/vibe:init` should be available. Check the `/plugin` **Errors** tab if
not.

### Guaranteed always-on (recommended fallback)

The `SessionStart` hook injects `vibe.md` via stdout, which is the documented path.
Some Claude Code versions have had bugs dropping plugin-hook context. If you ever
find the governance isn't loading, add a user-level import as a belt-and-braces
guarantee — edit `~/.claude/CLAUDE.md` and add:

```
These are your operating rules for all coding work:
@/absolute/path/to/vibe/vibe.md
```

This is rock-solid always-on (user memory is always loaded) and keeps a single
source of truth (`vibe.md`). Updating the framework is then just `git pull`.

## Initialize a project

```
/vibe:init            # single-repo (default)
/vibe:init single
/vibe:init hub        # EXPERIMENTAL — multi-repo hub (see proposals/)
/vibe:init spoke      # EXPERIMENTAL — multi-repo spoke (see proposals/)
```

- **single** — scaffolds `vdesign/` (plan, checkpoint, constraints, env, utils) and
  `docs/` in the current repo.
- **hub / spoke** — implement `proposals/hub-and-spoke-mode.md`, a CANDIDATE pattern
  that is **not yet adopted**. Use for validation only.

## Design notes

- **Single source of truth.** Each principle's full text lives once, in its skill's
  `reference.md` (the `SKILL.md` is a thin entry point). Each role's definition lives
  once, in its `agents/*.md` file. The hook injects `vibe.md`. Nothing is duplicated.
- **Why the spine is a hook, not a skill.** Governance must be *always-on*; skills
  load only on-demand. A skill spine would silently fail to fire. See the git
  history and `proposals/` for the reasoning.
- **Antigravity CLI.** The `SKILL.md` and `agents/` formats are portable; porting
  mainly means providing the equivalent manifest and a `PreInvocation` hook for the
  spine. Not yet done.

## Versioning

`v0.1.0` tags the pre-plugin, embedded-`.vibe/` framework. `v0.2.0` is the first
plugin form.
