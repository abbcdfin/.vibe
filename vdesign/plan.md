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

## Candidates

- Validate increment planning in a real project — host project to be selected;
  [pilot criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
