# Principles of Agentic Application Development

This document outlines the foundational principles, design patterns, and architectural guidelines for building robust, autonomous AI agent systems. 

## 1. Architectural Foundation & Philosophy
* **Generality Before Specialization (Graceful Degradation):** Start with a generic reasoning core supported by highly modular scaffolding. Decouple domain context from the operational logic (Prompt-as-Data). Only degrade into specialized, hardcoded architectures when operational constraints (e.g., strict determinism, ultra-low latency, or context window overload) demand it.
* **Separation of Reasoning and Execution:** The Large Language Model (LLM) serves as the "cognitive engine" responsible for reasoning, planning, and proposing actions. The "harness" (the surrounding code infrastructure) is strictly responsible for executing those actions, managing state, and enforcing safety. The model should never directly execute code or access the filesystem without going through the harness.
* **The Agentic Loop:** Core systems should utilize a foundational "while-true" state loop: perceive the environment, update internal context, reason/plan, propose tool use, execute via harness, and repeat until the objective is met.

## 2. Core Workflow Patterns
Do not rely on a single monolithic prompt for complex tasks. Decompose workflows using standard routing and execution patterns:
* **Prompt Chaining:** Break down sequential, deterministic problems into discrete, linear steps where the output of one operation logically informs the next.
* **Routing:** Implement dynamic decision-making mechanisms. Use an initial classification step to assess user intent and route the execution flow to specialized tools, sub-agents, or processes.
* **Parallelization:** Whenever tasks are independent (e.g., gathering context from multiple APIs or generating distinct variations), execute them concurrently to minimize system latency.
* **Prioritization:** Empower agents to autonomously rank tasks based on urgency, dependencies, and resource constraints.

## 3. Tool Use & Boundary Management
* **Strict Tool Definition:** Equip the model with well-defined tools (functions, APIs) to interact with external environments. Tools are the *only* bridge between internal reasoning and external action.
* **Context as a Scarce Resource:** Implement progressive context management (e.g., multi-layered compaction pipelines). Only inject the precise data, API schemas, or business rules needed for the immediate task to prevent hallucination and context overload.

## 4. Cognitive Architecture & Resilience
* **Planning:** Before executing complex tasks, agents must generate structured, multi-step plans. 
* **Reflection & Self-Correction:** Implement "Generator-Critic" patterns (Self-Refine). An agent's initial output should rarely be the final output. Introduce a secondary evaluation step (either by the same model or a specialized critic agent) to verify factual accuracy, adherence to constraints, and logical soundness before returning results to the user.
* **Graceful Recovery:** The harness must handle tool failures, parsing errors, or API timeouts gracefully by returning the error state to the LLM, allowing the agent to reason about the failure and attempt alternative paths.

## 5. Multi-Agent Orchestration
For multifaceted goals, utilize Multi-Agent Systems (MAS) rather than relying on a single generalist:
* **CWD Model (Coordinator, Worker, Delegator):** Structure multi-agent ecosystems around clear roles. A *Coordinator* parses intent and manages timelines, *Delegators* route specific sub-tasks, and specialized *Workers* execute narrow objectives.
* **Contract-Adhering Agents:** Transition from loosely prompted agents to "contractors." Define strict input/output schemas, expected outcomes, and validation criteria that the agent must fulfill before concluding its run.

## 6. Safety, Governance, and Observability
* **Deny-First Safety Posture:** Implement layered, defense-in-depth safety mechanisms within the execution harness. Default to denying unrecognized or destructive actions. Unknown actions should trigger human escalation.
* **Human-in-the-Loop (HITL):** For high-stakes operations (e.g., executing structural database changes or deploying code), implement breakpoints where the agent must pause and request explicit human approval.
* **Observability & Evaluation:** Maintain append-only session storage. Track agent "trajectories" (the exact sequence of thoughts, tool calls, and observations) to evaluate efficiency, debug failures, and monitor token/resource usage.

***

**Usage Instruction for Coding Agents:** *When instructed to build or refactor an agentic application, rely on these principles to determine where logic should reside (LLM vs. Harness), how tasks should be decomposed, and how safety and context should be managed.*
