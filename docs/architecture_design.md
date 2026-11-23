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
on demand. Role and skill discovery differs by host: Claude Code loads `agents/`
namespaced as `vibe:<role>` and `skills/`; Antigravity CLI loads `agents/` unprefixed
and `skills/`; OpenAI Codex CLI loads `skills/` and hooks from
`.codex-plugin/plugin.json` but not plugin `agents/`, so a launching tool supplies a
role itself; the pi extension loads only the spine.

The JSON shell adapters use `jq`, falling back to `python3`. Codex can register the
same script through either a bundled plugin hook or a standalone config hook; their
configuration schemas differ, as shown in the [installation instructions](../README.md#install-openai-codex-cli).

## Mode harness

`hooks/lib-mode.sh` selects the module the shell adapters append after the spine
([ADR 0001](adr/0001-mode-specific-rules-via-injection.md)). `VIBE_MODE=worker`, set by
a launching tool, selects `modes/worker.md` ([ADR 0006](adr/0006-delegated-work.md))
before any manifest; any other value is ignored with a warning on stderr. Otherwise root
`workspace.md`, then `vdesign/workspace.md`, selects a candidate `modes/<mode>.md`;
without a manifest, only the spine is injected. pi delivers the spine alone.

Claude Code and Codex read manifests from the session working directory. Antigravity
runs hooks from the plugin directory and reads manifests only from its payload's
workspace; without one it injects the spine alone, plus the worker module in worker
mode.

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

Verification runs each check once, where the work is done; later verifiers review the
reported evidence and the diff ([Agile reference](../skills/agile-principles/reference.md#verifying)).
Rerunning a check another role ran on the same commit costs tokens and repeats its
blind spots, while asking whether the evidence proves the claim catches logic gaps and
missing cases. Tasks and slices run only covering checks, while one full-suite run per
increment at DONE (after merging `dev` and before merging into `dev`) tests the exact
integrated code that reaches `dev` without repeating full runs at each task or milestone.
Which checks cover a change and what constitutes the full suite are left to the running
role's judgment because projects differ too much to prescribe commands. The rule refines
[ADR 0006](adr/0006-delegated-work.md)'s "delegating session verifies results" and is
easy to reverse, so it needs no ADR.
