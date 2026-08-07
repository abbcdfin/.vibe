# Vibe

An installable **vibe coding framework** for Claude Code, Antigravity CLI, OpenAI
Codex CLI, and pi. Install it once and every project gets the same always-on
engineering governance, selectable role identities, architectural & agentic
principles, and a one-command project initializer — with nothing to copy into
individual repositories.

The design is **one source, N thin adapters**: `vibe.md` + `skills/` + `agents/`
are written once, and each tool gets a small always-on injector that reads the
*same* `vibe.md`. Adding a tool is just writing that adapter.

| Tool | Always-on mechanism | Adapter | Confidence |
|------|---------------------|---------|------------|
| Claude Code | `SessionStart` hook (stdout) | `hooks/inject-governance.sh` | Tested |
| OpenAI Codex CLI | standalone `SessionStart` hook (JSON `additionalContext`) | `hooks/inject-governance-codex.sh` | Tested (Codex 0.146.0) |
| Antigravity CLI | `PreInvocation` hook (JSON `additionalContext`) | `hooks/inject-governance-agy.sh` | Best-effort |
| pi | `before_agent_start` extension (`systemPrompt`) | `pi/vibe.ts` | Best-effort |

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

## Install (OpenAI Codex CLI)

Tested against Codex **0.146.0**. Codex's standalone `hooks` feature is stable and
provides a `SessionStart` event (fires on startup/resume/clear/compact) whose
`hookSpecificOutput.additionalContext` is injected as developer context — the same
shape Claude Code uses. Note: Codex's `plugin_hooks` feature is **removed**, so the
hook cannot be bundled inside a plugin; register it **standalone** in your Codex
config, pointing at the script in this repo. Check your own install first:

```bash
codex features list | grep -E '^(hooks|plugin_hooks)'
# hooks         stable  true      <- required
# plugin_hooks  removed false     <- expected; that's why the hook is standalone
```

**Recommended — run the installer** (idempotent; writes a marker-delimited block
to `$CODEX_HOME/config.toml`, so re-runs update in place and `--uninstall` removes
it cleanly):

```bash
scripts/install-codex.sh              # register the SessionStart hook
scripts/install-codex.sh --fallback   # also symlink $CODEX_HOME/AGENTS.md -> vibe.md
scripts/install-codex.sh --dry-run    # preview without writing
scripts/install-codex.sh --uninstall  # remove the hook block (and managed symlink)
```

It resolves the absolute hook path for you, checks the `hooks` feature is enabled,
respects `$CODEX_HOME`, and verifies the hook emits valid JSON before finishing.

Or wire it by hand — add to `~/.codex/config.toml` (absolute path to your clone):

```toml
[[hooks.SessionStart]]
[[hooks.SessionStart.hooks]]
type = "command"
command = '/path/to/vibe/hooks/inject-governance-codex.sh'
timeout = 30
```

**Verify:** `codex` — the vibe rules should appear in context. The script reads the
same `vibe.md` as every other adapter and reuses the candidate mode harness
(`hooks/lib-mode.sh`), so single-repo injects the spine only and a workspace with a
`mode:` manifest also appends the matching `modes/*.md`.

**Fallback (belt-and-braces).** Codex also always loads `~/.codex/AGENTS.md`
(no `@import` support, unlike CLAUDE.md). For a hook-independent guarantee, symlink
it to the single source:

```bash
ln -s /path/to/vibe/vibe.md ~/.codex/AGENTS.md
```

## Install (pi)

> **Best-effort — not yet validated on a live pi install.** Built from pi's
> published extension docs. pi loads extensions from `~/.pi/agent/extensions/`
> (global) and `.pi/extensions/` (project), and supports git/npm packages via
> `settings.json`. The adapter (`pi/vibe.ts`) subscribes to `before_agent_start`
> and prepends the same `vibe.md` spine to the system prompt.

Install from git (declared via this repo's `package.json` `"pi"` field):

```json
// ~/.pi/agent/settings.json
{ "packages": ["git:github.com/abbcdfin/.vibe@v0.3.0"] }
```

Or drop it in globally without a package manager:

```bash
mkdir -p ~/.pi/agent/extensions
ln -s /path/to/vibe/pi/vibe.ts ~/.pi/agent/extensions/vibe.ts
```

**Verify on your install:** confirm pi's current API still uses the
`before_agent_start` event returning `{ systemPrompt }`; if it has drifted, adjust
`pi/vibe.ts` accordingly. The candidate `modes/*.md` harness is **not** ported to
pi — it gets the spine only. pi also reads `AGENTS.md` from `~/.pi/agent/`, so a
symlink there (`ln -s /path/to/vibe/vibe.md ~/.pi/agent/AGENTS.md`) is the
hook-independent fallback.

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

> **Candidate mode-aware harness.** The governance hooks read the workspace manifest in
> the launch cwd (root `workspace.md`, or a repo's `vdesign/workspace.md`) and append the
> matching **draft** module from `modes/` (`workspace.md` / `hub.md` / `spoke.md`). This
> exists to *validate* the hub-and-spoke proposal — `modes/*.md` are DRAFT, not adopted
> doctrine. Single-repo projects have no manifest, so nothing extra is injected.

## Design notes

- **Single source of truth.** Each principle's full text lives once, in its skill's
  `reference.md` (the `SKILL.md` is a thin entry point). Each role's definition lives
  once, in its `agents/*.md` file. The hook injects `vibe.md`. Nothing is duplicated.
- **Why the spine is a hook, not a skill.** Governance must be *always-on*; skills
  load only on-demand. A skill spine would silently fail to fire. See the git
  history and `proposals/` for the reasoning.
- **Four tools, one source.** Every adapter reads the *same* `vibe.md` and reuses the
  same candidate mode harness (`hooks/lib-mode.sh`) where it applies. The adapters
  differ only in how each tool takes always-on context: Claude Code and Codex use a
  `SessionStart` hook, Antigravity a `PreInvocation` hook, pi a `before_agent_start`
  extension. `skills/` and `agents/` are Markdown shared verbatim across the tools
  that support them. Codex and Claude are tested; Antigravity and pi are best-effort
  pending live tests — see each install section's caveats.
- **Why Codex's hook is standalone, not plugin-bundled.** Codex's `plugin_hooks`
  feature is removed, so hooks inside a plugin don't fire; the standalone `hooks`
  feature is stable. The hook is therefore registered in `~/.codex/config.toml`.

## Versioning

`v0.1.0` tags the pre-plugin, embedded-`.vibe/` framework. `v0.2.0` is the first
plugin form (Claude Code + Antigravity CLI). `v0.3.0` adds OpenAI Codex CLI and pi
adapters.
