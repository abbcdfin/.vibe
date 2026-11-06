# Vibe

Engineering governance, roles and design principles for coding agents. Install once
per tool; projects share the framework without copying it into their repositories.

| Host | Validation |
|---|---|
| Claude Code | Tested |
| OpenAI Codex CLI | Tested with 0.146.0 |
| Antigravity CLI | Tested; staging path checked with 1.4.4 |
| pi | Not tested on a live install |

## Components

| Component | Source |
|---|---|
| Always-on governance | `vibe.md`, loaded by the host adapter |
| Product and engineering roles | `agents/` |
| Architectural, agentic and Agile principles | `skills/`, loaded on demand |
| Project initializer | `skills/init/`, invoked as `/vibe:init` |

After updating, apply any **Upgrade** steps since your installed version in the
[changelog](CHANGELOG.md). Verify that governance is present in a new session and
that skills are available where the host supports them.

## Install (Claude Code)

Try the local clone for one session:

```bash
claude --plugin-dir /path/to/vibe
```

For persistent installation, run inside Claude Code:

```text
/plugin marketplace add abbcdfin/.vibe
/plugin install vibe@uc-labs
/reload-plugins
```

For a local marketplace, use `/path/to/vibe` instead of `abbcdfin/.vibe`.

To update, pull a local clone first, then run these shell commands and restart Claude Code:

```bash
claude plugin marketplace update uc-labs
claude plugin update vibe@uc-labs
```

If governance is missing, check the `/plugin` Errors tab. As a hook-independent
alternative, put this import in `~/.claude/CLAUDE.md`:

```text
These are your operating rules for all coding work:
@/absolute/path/to/vibe/vibe.md
```

## Install (Antigravity CLI)

```bash
agy plugin install /path/to/vibe
agy plugin list
```

Antigravity 1.4.4 stages the plugin at `~/.gemini/config/plugins/vibe/`. To update,
pull the clone and run `agy plugin install /path/to/vibe` again; the staged copy
does not follow the clone automatically.

## Install (OpenAI Codex CLI)

```bash
codex plugin marketplace add /path/to/vibe
codex plugin add vibe@uc-labs
```

Use `abbcdfin/.vibe` instead of the local path for a Git marketplace. Start interactive
Codex to review and trust the bundled hook; installing the plugin alone does not
grant hook trust.

To update, pull a local clone first. For a Git marketplace, refresh its snapshot,
then reinstall and restart Codex:

```bash
codex plugin marketplace upgrade uc-labs   # Git marketplace only
codex plugin add vibe@uc-labs
```

### Alternative setup

Use one governance-loading path. To register the hook yourself, add this to
`~/.codex/config.toml`, using the absolute clone path:

```toml
[[hooks.SessionStart]]
[[hooks.SessionStart.hooks]]
type = "command"
command = '/path/to/vibe/hooks/inject-governance-codex.sh'
timeout = 30
```

Alternatively, load the spine as user instructions through `~/.codex/AGENTS.md`:

```bash
ln -s /path/to/vibe/vibe.md ~/.codex/AGENTS.md
```

## Install (pi)

Add the package to `~/.pi/agent/settings.json`:

```json
{ "packages": ["git:github.com/abbcdfin/.vibe@v0.9.0"] }
```

Or install the extension from a local clone:

```bash
mkdir -p ~/.pi/agent/extensions
ln -s /path/to/vibe/pi/vibe.ts ~/.pi/agent/extensions/vibe.ts
```

Verify governance on your install. The extension loads the spine; it does not run
the experimental workspace-mode harness. A user-instruction fallback is:

```bash
ln -s /path/to/vibe/vibe.md ~/.pi/agent/AGENTS.md
```

## Initialize a project

On hosts with skill support, use `/vibe:init` or ask to initialize the project:

```text
/vibe:init            # single repository
/vibe:init hub        # experimental hub
/vibe:init spoke      # experimental component repository
```

Single mode creates planning files in `vdesign/` and design stubs in `docs/`.
Hub/spoke mode is a [candidate under validation](vdesign/proposals/hub-and-spoke-mode.md),
not adopted doctrine. The shell adapters recognize workspace manifests and append the
matching draft mode module; ordinary single-repository projects get the spine alone.

## Design

- [Product specification](docs/product_specification.md) — capabilities and scope.
- [Architecture design](docs/architecture_design.md) — shared sources and host adapters.
- [Decision records](docs/adr/) — choices and their rationale.
- [Plan](vdesign/plan.md) — increments, candidates and current work.
