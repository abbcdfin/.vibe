# Plan

Status: `[ ]` ACCEPTED, `[/]` BUILDING, `[x]` DONE.

## Increments

- [x] 1. Adopt increment progress units — accepted in
  [ADR 0002](../docs/adr/0002-increments-as-progress-units.md).
  Done when: the governance, Agile guidance, initializer and dependent proposals use
  the accepted increment model consistently; IPD and workflow phases retain their
  meanings; migration is documented; affected skills and delivered hook contexts pass
  validation.
  Outcome: adopted across the framework; the proposal now points to canonical guidance.
  Verified: both affected skill validators, all three shell adapter outputs, local
  Markdown links and anchors, and `git diff --check` pass. A review then trimmed the
  spine and restored "done when" where "acceptance criteria" had crept back. Released in
  v0.9.0.
- [x] 2. Antigravity hook never guesses the workspace — done when: a payload without
  `workspacePaths` gets the spine alone, with or without `jq`, and a named workspace still
  gets its mode module. Verified: five cases against a scratch plugin copy carrying a
  decoy `vdesign/workspace.md`. Released in v0.9.0.
- [x] 3. Document kinds and the proposal lifecycle — accepted in
  [ADR 0003](../docs/adr/0003-document-kinds-and-proposal-lifecycle.md).
  Done when: the spine defines design documents and decision records and takes a proposal
  from its candidate line to deletion at DONE; the initializer seeds agree; this repository
  follows both — candidates listed here with proposals in `vdesign/proposals/`, the adopted
  proposal removed, design documents describing the current system; no shipped file names
  this repository's `vdesign/` or `proposals/` by path; every adapter still injects
  `vibe.md` unchanged; local links resolve.
  Outcome: the spine separates living design documents from dated decision records and
  carries a proposal from its candidate line to deletion at DONE; the four candidate
  proposals moved here, the adopted one was removed, and the README's design notes became
  `docs/architecture_design.md`. Verified: the Claude Code, Codex and Antigravity hooks
  inject `vibe.md` byte for byte and a hub manifest still appends its module; `pi/vibe.ts`
  is unchanged and was not run. Both plugin validators, all local Markdown links
  and anchors, and `git diff --check` pass. A peer review then added link repair before a
  proposal's deletion, the limits of ADR upkeep and pending marks for unbuilt design.
  Unreleased.
- [x] 4. Framework consistency and concision — accepted by the user's cleanup request.
  Done when: governance, roles, skills, initialization and current design documents agree;
  redundant wording and document inconsistencies are removed while committed principle
  defaults, the increment lifecycle and candidate arguments are preserved; installation
  and migration steps remain usable; skill, plugin, link and adapter checks pass; the
  core guidance is shorter. Policy changes require a separate acceptance decision.
  Outcome: retained the consolidation and hub/spoke path fixes; restored committed
  architectural and agentic references verbatim, proposal arguments and failure lists,
  concision rules, rule-name indexes and lazy directory creation. Alternative defaults
  are a separate candidate, with deny-by-default retained. The spine is 817 words and
  the README 585, down from 1,264 and 1,589. No policy ADR was created.
  Verified: four skills, two role definitions, local links and anchors, 18 adapter cases
  with terminal newlines normalized, exact reference/draft preservation and whitespace
  checks. `claude plugin validate .` passes; Antigravity validation passes with its
  expected Claude-hook warning. Live pi validation was not run. Unreleased.

## Candidates

- Principle defaults — consider the policy alternatives identified during cleanup;
  committed references remain authoritative. [Proposal](proposals/principle-defaults.md).
- Curated-context subagents — delegate a bounded task to a fresh subagent holding only
  its briefing. [Proposal](proposals/curated-subagents.md).
- Hub-and-spoke mode — multi-repository workspaces; the `modes/` harness and
  `/vibe:init hub|spoke` exist to validate it. [Proposal](proposals/hub-and-spoke-mode.md).
- Release rules — release notes, upgrade checks and tags; validation run 1 was v0.8.1.
  [Proposal](proposals/release-rules.md).
- Test-driven execution — a failing test as the contract for agentic work.
  [Proposal](proposals/tdd-execution.md).
- Validate increment planning in a real project — host project to be selected;
  [pilot criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
