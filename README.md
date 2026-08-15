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
| OpenAI Codex CLI | plugin-bundled `SessionStart` hook (JSON `additionalContext`) | `.codex-plugin/` + `hooks/inject-governance-codex.sh` | Tested (Codex 0.146.0) |
| Antigravity CLI | `PreInvocation` hook (JSON `injectSteps`/`ephemeralMessage`) | `hooks/inject-governance-agy.sh` | Tested (agy CLI) |
| pi | `before_agent_start` extension (`systemPrompt`) | `pi/vibe.ts` | Best-effort |

## What's in the plugin

| Component | Path | Loading |
|-----------|------|---------|
| **Governance spine** | `vibe.md` | **Always-on** — injected every session by a `SessionStart` hook (`hooks/`) |
| **Role identities** | `agents/` (`software-expert`, `product-owner`) | Adopted by the main thread *or* delegated as subagents; each agent file is the single canonical role definition |
| **Architectural principles** | `skills/architectural-principles/` | On-demand skill; full text in its `reference.md` |
| **Agentic principles** | `skills/agentic-principles/` | On-demand skill; full text in its `reference.md` |
| **Project initializer** | `commands/init.md` → `/vibe:init` (Claude); `skills/vibe-init/` (Antigravity, Codex) — shared `reference.md` | Slash command / skill |
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
/plugin install vibe@uc-labs
/reload-plugins
```

Or add the local clone instead of the remote:

```
/plugin marketplace add /path/to/vibe
/plugin install vibe@uc-labs
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
| Always-on hook | `hooks/hooks.json` → `SessionStart` (stdout) | `hooks.json` (root) → `PreInvocation` (JSON `injectSteps`/`ephemeralMessage`) |
| Hook script | `hooks/inject-governance.sh` | `hooks/inject-governance-agy.sh` |
| Skills / Agents | `skills/`, `agents/` | `skills/`, `agents/` (shared, same format) |

Install locally (Antigravity documents local install only — no git/marketplace):

```
agy plugin install /path/to/vibe
agy plugin list          # confirm it's staged & enabled
```

Plugins stage at `~/.gemini/antigravity-cli/plugins/vibe/`.

> **Verified against Antigravity's hook contract.** The `PreInvocation` wiring
> follows the authoritative hooks reference (`agy-customizations/docs/hooks.md`):
> `PreInvocation` uses the **flat** handler-list structure (no `matcher`/`hooks`
> wrapper — that's only for `PreToolUse`/`PostToolUse`), and the command returns
> `{"injectSteps":[{"ephemeralMessage":"<spine>"}]}` on stdout. Two things worth
> knowing:
> 1. **No absolute path needed.** Antigravity runs the hook with cwd set to the
>    directory containing `hooks.json` (the plugin root), so `hooks.json` calls the
>    script by the relative path `./hooks/inject-governance-agy.sh` — robust to any
>    install location. The user's project isn't cwd; it arrives as `workspacePaths`
>    on stdin, which the mode harness reads (falling back to `$PWD`).
> 2. **`PreInvocation` re-injects** the spine each turn (Antigravity has no `SessionStart`). If that's too heavy, and Antigravity's `rules/` directory auto-loads, move the governance there as a lighter one-time load.
>
> The initializer **is** ported: Antigravity's documented plugin dirs are
> `skills/`/`agents/`/`rules/` (no `commands/`), and skills auto-convert to slash
> commands, so `/vibe:init` is available here as the `vibe-init` skill — see
> [Initialize a project](#initialize-a-project).

## Install (OpenAI Codex CLI)

Tested against Codex **0.146.0**, end-to-end (plugin install → `SessionStart` hook
fires → `vibe.md` injected). Codex delivers the full framework — skills **and** the
always-on spine — from a single plugin, like Claude Code and Antigravity.

**A. Plugin via marketplace (recommended).** The repo is its own Codex marketplace
(`.agents/plugins/marketplace.json`) and plugin (`.codex-plugin/plugin.json`, which
exposes `skills/` and bundles a `SessionStart` hook → `.codex-plugin/hooks.json` →
`hooks/inject-governance-codex.sh`).

```bash
codex plugin marketplace add /path/to/vibe   # or:  codex plugin marketplace add abbcdfin/.vibe
codex plugin add vibe@uc-labs
```

> **One-time trust review.** Installing a plugin does **not** auto-trust its hooks —
> Codex skips a bundled hook until you review and trust it (by hash). On first
> interactive `codex` you'll be prompted to trust the vibe `SessionStart` hook;
> approve it once and it fires every session thereafter. (For CI/automation,
> `codex exec --dangerously-bypass-hook-trust` runs enabled hooks without the
> prompt.) This trust step is the only difference from the Claude Code experience.

The hook reads the same `vibe.md` as every other adapter and reuses the candidate
mode harness (`hooks/lib-mode.sh`): single-repo injects the spine only; a workspace
with a `mode:` manifest also appends the matching `modes/*.md`.

**B. Standalone config hook (fallback).** If you'd rather register the hook yourself
than trust a bundled one — or want it independent of the plugin system — add it to
`~/.codex/config.toml` by hand (absolute path to your clone):

```toml
[[hooks.SessionStart]]
[[hooks.SessionStart.hooks]]
type = "command"
command = '/path/to/vibe/hooks/inject-governance-codex.sh'
timeout = 30
```

Note the standalone `config.toml` schema keys events at the top level
(`[[hooks.SessionStart]]`), which differs from the plugin `hooks.json` schema (events
nested under `hooks:`) — the same `inject-governance-codex.sh` script, different wiring.

**C. AGENTS.md (belt-and-braces).** Codex always loads `~/.codex/AGENTS.md` (no
`@import`, unlike CLAUDE.md). For a hook-independent guarantee, symlink it to the
single source: `ln -s /path/to/vibe/vibe.md ~/.codex/AGENTS.md`.

## Install (pi)

> **Best-effort — not yet validated on a live pi install.** Built from pi's
> published extension docs. pi loads extensions from `~/.pi/agent/extensions/`
> (global) and `.pi/extensions/` (project), and supports git/npm packages via
> `settings.json`. The adapter (`pi/vibe.ts`) subscribes to `before_agent_start`
> and prepends the same `vibe.md` spine to the system prompt.

Install from git (declared via this repo's `package.json` `"pi"` field):

```json
// ~/.pi/agent/settings.json
{ "packages": ["git:github.com/abbcdfin/.vibe@v0.4.0"] }
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

The initializer works on every tool, driven by one **mode** argument (`single` |
`hub` | `spoke`, default `single`). How you invoke it differs because only Claude
Code has a `commands/` slash-command loader — Antigravity and Codex expose the same
logic as the `vibe-init` **skill** instead:

| Tool | Invocation | Argument passing |
|------|-----------|------------------|
| Claude Code | `/vibe:init hub` (`commands/init.md`) | positional `$1` |
| Antigravity CLI | `/vibe-init hub`, or just ask ("bootstrap a hub workspace here") | skill reads the mode word from your message |
| OpenAI Codex CLI | `vibe-init` skill, or just ask | skill reads the mode word from your message |

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

> **Skills have no positional `$1`.** The `vibe-init` skill (`skills/vibe-init/`)
> reads the mode word (`single`/`hub`/`spoke`) out of your invocation text and
> defaults to `single`. Both the Claude command and the skill are thin wrappers over
> one shared procedure (`skills/vibe-init/reference.md`) — one source, three tools.

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
- **Codex ships as a plugin (bundled hook), with a standalone fallback.** Plugin-
  bundled `SessionStart` hooks *do* fire in Codex 0.146.0 (tested); the `plugin_hooks`
  feature reading `removed` means the flag graduated to standard, not that the
  capability was pulled. Bundled hooks require a one-time trust review, so a
  hand-registered standalone `config.toml` hook is documented as the fallback for
  anyone who prefers not to trust a bundled hook. Both paths run the same
  `inject-governance-codex.sh` but use different hook schemas (plugin nests events
  under `hooks:`; standalone keys them at top level).

## Versioning

`v0.1.0` tags the pre-plugin, embedded-`.vibe/` framework. `v0.2.0` is the first
plugin form (Claude Code + Antigravity CLI). `v0.3.0` adds OpenAI Codex CLI and pi
adapters. `v0.4.0` ports the `/vibe:init` initializer to a cross-tool `vibe-init`
skill (Antigravity CLI + Codex, since neither loads Claude's `commands/`). `v0.4.1`
fixes the Antigravity `PreInvocation` hook (flat schema, `injectSteps`/
`ephemeralMessage` output contract, install-location-independent relative path) —
verified firing live on the `agy` CLI.
