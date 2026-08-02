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

## Install (Antigravity CLI)

The same repository also carries an Antigravity CLI plugin. The tool-specific files
sit alongside the Claude Code ones and read the **same** `vibe.md`:

| Concern | Claude Code | Antigravity CLI |
|---------|-------------|-----------------|
| Manifest | `.claude-plugin/plugin.json` | `plugin.json` (root) |
| Always-on hook | `hooks/hooks.json` → `SessionStart` (stdout) | `hooks.json` (root) → `PreInvocation` (JSON `additionalContext`) |
| Hook script | `hooks/inject-governance.sh` | `hooks/inject-governance-agy.sh` |
| Skills / Agents | `skills/`, `agents/` | `skills/`, `agents/` (shared, same format) |

Install locally (Antigravity documents local install only — no git/marketplace):

```
agy plugin install /path/to/vibe
agy plugin list          # confirm it's staged & enabled
```

Plugins stage at `~/.gemini/antigravity-cli/plugins/vibe/`.

> **Best-effort / verify on your install.** Antigravity support is built from its
> published docs (manifest, `skills/`, `agents/`, `rules/`, `hooks.json`) plus a
> secondary source for the hook format. Two things to check after installing:
> 1. **Hook path.** `hooks.json` invokes the script via `$HOME/.gemini/antigravity-cli/plugins/vibe/hooks/inject-governance-agy.sh`. Antigravity requires absolute paths; if `$HOME` doesn't expand, hard-code your absolute path there.
> 2. **`PreInvocation` re-injects** the spine each turn (Antigravity has no `SessionStart`). If that's too heavy, and Antigravity's `rules/` directory auto-loads, move the governance there as a lighter one-time load.
>
> Also: `/vibe:init` is a Claude Code `commands/` file; Antigravity's documented
> plugin dirs are `skills/`/`agents/`/`rules/`, so the initializer may need to be
> invoked as a skill there. Not yet ported.

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
- **Antigravity CLI.** Supported alongside Claude Code: `skills/` and `agents/` are
  shared verbatim; `plugin.json` (root) is the manifest and `hooks.json` (root) wires
  a `PreInvocation` hook that injects the same `vibe.md`. Best-effort pending a live
  test — see the install section's caveats.

## Versioning

`v0.1.0` tags the pre-plugin, embedded-`.vibe/` framework. `v0.2.0` is the first
plugin form.
