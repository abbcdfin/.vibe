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

`hooks/lib-mode.sh` selects root `workspace.md` before `vdesign/workspace.md`. Shell
adapters append the matching draft `modes/<mode>.md` after the spine
([ADR 0001](adr/0001-mode-specific-rules-via-injection.md)). Without a manifest, only
the spine is injected. These modes remain candidates under validation; pi does not
run the harness.

Claude Code and Codex use the session working directory. Antigravity runs hooks from
the plugin directory and selects the workspace from its payload; absent a workspace,
it injects the spine alone.

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
