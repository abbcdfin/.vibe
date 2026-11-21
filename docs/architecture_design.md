# Architecture Design

The framework has one source for each instruction and thin adapters for each host.
Historical choices are recorded in [ADRs](adr/).

## One source, thin adapters

| Host | Event and output | Adapter |
|---|---|---|
| Claude Code | `SessionStart`; stdout | `hooks/hooks.json` → `hooks/inject-governance.sh` |
| OpenAI Codex CLI | `SessionStart`; JSON `hookSpecificOutput.additionalContext` | `.codex-plugin/hooks.json` → `hooks/inject-governance-codex.sh` |
| Antigravity CLI | `PreInvocation`; JSON `injectSteps[].ephemeralMessage` | `hooks.json` → `hooks/inject-governance-agy.sh` |
| pi | `before_agent_start`; returned `systemPrompt` | `pi/vibe.ts` |

Every adapter reads `vibe.md`. Governance is loaded by the adapter because skills are
on demand. Hosts expose roles and skills through their supported discovery mechanisms;
the pi extension itself loads only the spine.

The JSON shell adapters use `jq`, falling back to `python3`. Codex can register the
same script through either a bundled plugin hook or a standalone config hook; their
configuration schemas differ, as shown in the [installation instructions](../README.md#install-openai-codex-cli).

## Mode harness

`hooks/lib-mode.sh` selects a mode module appended after the spine by the shell
adapters ([ADR 0001](adr/0001-mode-specific-rules-via-injection.md)). `VIBE_MODE=worker`
(adopted, [ADR 0006](adr/0006-delegated-work.md)), set by a launching tool, selects
`modes/worker.md` before any workspace manifest is checked. When `VIBE_MODE` is unset
or empty, detection falls through to root `workspace.md`, then `vdesign/workspace.md`,
appending the matching candidate `modes/<mode>.md` (or the spine alone if none exists);
any other `VIBE_MODE` value emits one warning on stderr and falls back to that same
manifest path without failing the hook.

Claude Code and Codex read manifests from the session working directory. Antigravity
runs hooks from the plugin directory and reads manifests only from `workspacePaths` in
its payload; `VIBE_MODE=worker` still applies without a workspace (and suppresses the
missing-workspace warning), whereas without it a missing workspace injects the spine
alone. The pi extension delivers only the spine: neither worker mode nor the candidate
workspace-mode harness applies there.

## Repository layout

The repository is the plugin and its marketplace. `.claude-plugin/` serves Claude Code;
`.codex-plugin/` and `.agents/plugins/` serve Codex; root `plugin.json` and `hooks.json`
serve Antigravity; `package.json` declares the pi extension.

Repository planning and design documents also ship with the checkout, but adapters
do not load them. Shipped instructions must not confuse these with the user's project
documents ([constraints](../vdesign/constraints.md)).

## Guidance ownership

The spine owns artifacts, lifecycle and decisions. Roles own responsibilities; skill
entry points route to authoritative references. The README owns installation steps;
this document owns adapter mechanisms.
