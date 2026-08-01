---
name: agentic-principles
description: Apply when designing or refactoring an agentic application — AI agents, LLM-driven workflows, tool-using systems, multi-agent orchestration, RAG, or anything where an LLM reasons and calls tools. Guides where logic resides (LLM vs. harness), workflow decomposition, tool/context management, resilience, and safety. Applies on top of architectural-principles.
---

# Agentic Application Development Principles

Use these when the system under design is **itself an agentic application** (not
for ordinary code — for that, use `architectural-principles`). They apply *on top
of* the architectural principles, never instead of them.

The **complete, authoritative guidance** lives in `reference.md` alongside this
file. Read it and apply it.

Core decisions it governs:

1. **Architectural foundation** — generality before specialization; separate
   reasoning (LLM) from execution (harness); the agentic loop.
2. **Workflow patterns** — prompt chaining, routing, parallelization, prioritization.
3. **Tool use & boundaries** — strict tool definitions; context as a scarce resource.
4. **Cognitive architecture** — planning, reflection/self-correction, graceful recovery.
5. **Multi-agent orchestration** — Coordinator/Worker/Delegator; contract-adhering agents.
6. **Safety & observability** — deny-first posture, human-in-the-loop, trajectory logging.

Key rule of thumb: logic that needs judgment goes to the LLM; logic that needs
determinism, state, or safety enforcement goes to the harness.
