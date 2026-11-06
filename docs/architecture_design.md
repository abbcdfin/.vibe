# Architecture Design

How vibe is built. Choices made between weighed alternatives are in the
[decision records](adr/); a choice without one carries its rationale here.

## One source, thin adapters

The framework is Markdown written once — the governance spine `vibe.md`, `skills/`,
`agents/` and `modes/` — and each host tool gets an adapter that delivers the same files.
Adding a tool means writing its adapter and nothing else.

| Host | Delivers the spine by | Adapter |
|------|-----------------------|---------|
| Claude Code | `SessionStart` hook, stdout | `hooks/hooks.json` → `hooks/inject-governance.sh` |
| OpenAI Codex CLI | plugin-bundled `SessionStart` hook, JSON `additionalContext` | `.codex-plugin/hooks.json` → `hooks/inject-governance-codex.sh` |
| Antigravity CLI | `PreInvocation` hook on every turn, JSON `injectSteps` | `hooks.json` → `hooks/inject-governance-agy.sh` |
| pi | `before_agent_start` extension, `systemPrompt` | `pi/vibe.ts` |

Skills and agents are shared verbatim by the hosts that support them.

- **The spine is a hook, not a skill.** Governance must be always on; skills load on
  demand, so a skill spine would silently fail to fire.
- **Each fact lives once.** A principle's full text is its skill's `reference.md`, behind a
  thin `SKILL.md`; a role is its `agents/*.md` file; the initializer's procedure is
  `skills/init/reference.md`. Adapters read these files and copy nothing.
- **Codex bundles its hook.** Codex runs a plugin's hook after a one-time trust review (its
  `plugin_hooks` feature reads `removed` because it graduated to standard). A
  hand-registered hook in `~/.codex/config.toml` is the fallback for anyone who declines;
  it runs the same script under a different schema — top-level events rather than events
  nested under `hooks:`.

## Mode harness

`hooks/lib-mode.sh` finds the workspace manifest — `workspace.md` at a workspace root, or
a repository's `vdesign/workspace.md` — and the shell adapters append the matching
`modes/<mode>.md` after the spine
([ADR 0001](adr/0001-mode-specific-rules-via-injection.md)). A single repository has no
manifest and gets the spine alone. The modes exist to validate the hub-and-spoke
candidate and are not adopted doctrine; pi does not run the harness.

The workspace is the session's working directory, except on Antigravity, which runs hooks
from the plugin root and passes the workspace as `workspacePaths`. Without one, the hook
injects the spine alone rather than read the plugin's own directory.

## Repository layout

The repository is the plugin and its own marketplace: `.claude-plugin/` for Claude Code,
`.codex-plugin/` and `.agents/plugins/` for Codex, the root `plugin.json` and `hooks.json`
for Antigravity, and the `package.json` `"pi"` field for pi. It follows its own
governance, so `vdesign/` and `docs/` ship with the plugin; no adapter reads them, and no
shipped file names them by path ([constraints](../vdesign/constraints.md)).
