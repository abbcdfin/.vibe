---
name: architectural-principles
description: Apply the vibe architectural standards when writing, refactoring, reviewing, or designing ANY code — single source of truth, auto-propagation, data-driven engines, buildability, scale seams, minimal mechanism, and resisting entropy. Use whenever making implementation or structural decisions.
---

# Architectural Principles

Apply the vibe architectural standards to all code and structural decisions. The
**complete, authoritative standard** — with the concrete actions and self-check
questions for each principle — lives in `reference.md` alongside this file. Read it
and apply it.

The seven standards, in brief:

1. **One Fact, One Place** — never duplicate data, logic, or config.
2. **Auto Propagation** — downstream updates flow automatically from the source.
3. **Construct Engine** — build generic, data-driven processors, not hardcoded flows.
4. **Building is Part of Architecture** — ship the build/deploy path with the code.
5. **Design for Scale** — keep handlers stateless; don't build in bottlenecks.
6. **Minimal Mechanism** — simplest tool for the job; fight over-engineering (YAGNI).
7. **Resist Entropy** — strict typing, clean layering, leave code cleaner than found.

**Resolving tensions (esp. #6 vs #5):** keep the *implementation* simple (build
only for today's problem) while keeping the *structure* flexible (preserve clean
seams so scaling later is an extension, not a rewrite). When in doubt, read the
"Resolving Tensions" section of the full document.
