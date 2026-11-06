# Proposal: Principle Defaults

> **Status: CANDIDATE — not adopted.** The committed architectural and agentic
> references remain authoritative. The cleanup does not accept these policy changes.

## Motivation

Several committed defaults prescribe a mechanism whatever the need, and agents apply
them literally:

- **Buildability** says always generate a `Dockerfile`, `Makefile` or CI configuration;
  an agent following it adds packaging to a script or library that is never deployed.
- **Resist Entropy** says leave the code cleaner than you found it, while the spine's
  scope rule says findings outside "done when" never silently widen the increment. An
  agent obeying one breaks the other.
- **Construct Engine** asks whether a new business rule can be added without
  recompiling, and refactors to an engine if not; for two rules that contradicts
  **Minimal Mechanism**, which Resolving Tensions reconciles only by level.
- **Multi-Agent Orchestration** makes multiple agents the default for multifaceted
  goals, adding coordination cost where one agent would do.

The consistency audit rewrote these defaults. The rewrites change agent behavior, not
just wording, so they need their own decision rather than passing as editorial cleanup.

## Alternatives

1. Keep the committed defaults and their existing tension-resolution guidance.
2. Revise selected defaults individually, with explicit rationale and verification.
3. Adopt a broader revised set after evaluating its combined effects.

| Area | Committed default | Audit alternative to evaluate |
|---|---|---|
| Construct Engine | Generic, data-driven processors; refactor unsuitable branching | Use engines or strategies when observed variation justifies them |
| Duplication | Refactor repeated logic immediately | Distinguish repeated knowledge from similar-looking code |
| Buildability | Always generate build/deployment configuration | Package only what the deliverable requires |
| Scale | Stateless services, external state and anticipation of partitioning | Add scale mechanisms when requirements call for them |
| Code quality | Leave code cleaner than found | Avoid cleanup outside the task's scope |
| Agent coordination | Multiple agents for multifaceted goals | Add agents when isolation or independent work justifies them |
| Reflection | First output should rarely be final; evaluate again | Choose review intensity according to consequence |

The drafts also drop or soften: third-normal-form schemas, strict typing with no `Any`,
API → service → repository layering, infrastructure-as-code rigour, the
Coordinator/Worker/Delegator model, append-only session logs, the Resolving Tensions
checks, and the names Agentic Loop, Prompt-as-Data, Context as a Scarce Resource and
Contract-Adhering Agents, whose content survives condensed.

## Safety invariant

Retain the committed deny-first posture: deny unrecognized or destructive actions by
default and escalate unknown actions to a human. Least privilege is complementary.
The audit agentic draft below omitted this rule; that omission is a regression to
correct, not a proposed weakening of the safety policy.

## Validation and decision

Compare the alternatives on a small application, a service and an agentic workflow.
Look for unnecessary infrastructure, duplicated rules, missing build paths, scaling
constraints, delegation overhead and inadequate self-review. Include unknown-action
and destructive-action cases to verify the safety invariant.

The user selects which defaults, if any, to change. Record the decision and rejected
alternatives in an ADR if accepted; no ADR or numbered increment is created while
this remains a candidate. Any implementation must update references and their name
indexes together, and check the documents that cite principles by name or number:
[ADR 0001](../../docs/adr/0001-mode-specific-rules-via-injection.md) cites "Context as
a scarce resource (agentic principle #3)" and "Construct Engine (architectural
principle #3)"; the [hub-and-spoke proposal](hub-and-spoke-mode.md) cites
"Construct Engine #3".

## Preserved audit drafts

These are the exact working reference texts before restoration, retained for comparison.
They are draft alternatives, not instructions governing this project.

### Architectural draft

```markdown
# Architectural Standards & Coding Guidelines

## 1. One Fact, One Place (Single Source of Truth)

Give each fact, rule and configuration value one authoritative home. Reuse that source
instead of maintaining copies. Extract repeated knowledge; similar-looking code alone
does not justify an abstraction.

**Check:** Would changing this fact require remembering a second edit?

## 2. Auto Propagation

Derive downstream values from their source. Prefer computed values, schema generation
or appropriate notifications over manually synchronized state. Automate repeated
propagation where it reduces drift.

**Check:** Can consumers obtain the change from the source automatically?

## 3. Construct Engine (Data-Driven Design)

Separate variable rules from the mechanism that applies them. Use configuration, a
strategy or a shared processor when real variants justify it. Simple branches are
appropriate for simple rules; a rule engine must earn its complexity.

**Check:** Is the variability understood, and is this the simplest way to express it?

## 4. Building is Part of Architecture

Ship the commands and configuration needed to build, run and verify the deliverable.
Reuse the project's existing tooling. Add deployment packaging when deployment is part
of the outcome, and keep development representative of the target environment.

**Check:** Can another developer reproduce the build and verification?

## 5. Design for Scale

Identify state, concurrency and resource limits. Keep boundaries that allow capacity
to grow without replacing the design. Externalize shared state when processes must
coordinate; add queues, partitioning or other scale mechanisms when requirements call
for them.

**Check:** Which known growth constraint would force a rewrite?

## 6. Minimal Mechanism

Use the simplest mechanism that meets today's requirements. Prefer existing tools and
standard libraries. Add dependencies, abstractions or services for demonstrated needs,
not possible future ones.

**Check:** Can the same outcome be delivered with fewer moving parts?

## 7. Resist Entropy

Use precise types, explicit interfaces and clear dependency boundaries. Isolate dynamic
or untrusted data at the edges. Avoid circular dependencies and unrelated cleanup;
leave the changed area easier to understand and maintain.

**Check:** Does this change clarify ownership, or blur it?

## Resolving Tensions: Simple Now, Flexible Later

Keep the implementation small while preserving useful structural seams. Design for
known constraints without building unused infrastructure. These principles guide the
choice of mechanism; none mandates a particular stack or application shape.
```

### Agentic draft

```markdown
# Principles of Agentic Application Development

Apply these to systems that use LLM reasoning and tools, alongside the architectural
standards. Choose mechanisms for the task rather than assembling every pattern.

## 1. Architectural Foundation & Philosophy

Separate judgment from execution: the model reasons and proposes actions; the harness
executes tools, manages state and enforces permissions. Start with a general reasoning
loop and clear stop conditions. Specialize when latency, reliability or context limits
justify it; keep prompts separate from execution code.

## 2. Core Workflow Patterns

Decompose work where explicit boundaries improve reliability:

- Chain steps when one result is required by the next.
- Route work when requests need different capabilities.
- Parallelize independent work when shared resources and writes permit it.
- Prioritize by value, urgency and dependencies.

Do not add orchestration to a task one agent can handle clearly.

## 3. Tool Use & Boundary Management

Define tool inputs, outputs, failure states and allowed effects explicitly. Validate
untrusted results at the boundary. Give the model the tools and context relevant to
its current task; retrieve details as needed and preserve decisions when compacting.

## 4. Cognitive Architecture & Resilience

Plan complex work at the level needed to execute it. Verify consequential outputs
against requirements and evidence, using tests, review or a critic pass as appropriate.
Return tool and parsing failures to the model as actionable errors so it can recover
or stop; never substitute a plausible success.

## 5. Multi-Agent Orchestration

Use multiple agents when isolation or independent work offers a clear benefit. A
coordinator can assign bounded tasks and integrate results; add further routing roles
only when needed. Each delegated task needs sufficient context, owned resources,
allowed actions, an expected result and verification criteria.

## 6. Safety, Governance, and Observability

Grant tools only the permissions their tasks require. Enforce authorization and required
human checkpoints in the harness; prompts alone cannot enforce them. Record observable
actions, tool results, failures and resource use, with concise decision summaries, so
behavior can be evaluated and failures diagnosed.
```
