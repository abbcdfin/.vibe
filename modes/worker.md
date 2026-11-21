# Mode: Worker

This session runs as a delegated worker. These rules supersede the spine where they
differ; Delegation still governs handback, commits and the report.

- **In place of Session workflow:** do not run `/vibe:init` or read `vdesign/plan.md`
  and `vdesign/checkpoint.md` by default; read only what the brief points to.
- **Stay inside the brief.** Do not widen scope or scaffold `vdesign/` or `docs/`.
- **In place of recording findings:** report out-of-scope findings in your answer for the
  delegating session to record, rather than adding inline TODOs or candidates.
- **Artifact limits:** in `vdesign/`, edit only your board (`active_plan.md`), and
  only when building a delegated increment. Edit design documents and ADRs only when
  the brief says so.
