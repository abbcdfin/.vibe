# Architectural Standards & Coding Guidelines

## 1. One Fact, One Place (Single Source of Truth)
**Directive:** Eliminate duplication aggressively.

* **Instruction:** Never repeat data, logic, or configuration.
* **Action:**
    * Extract magic numbers and strings into named constants or configuration files.
    * Normalize database schemas to 3NF unless read-performance explicitly demands denormalization.
    * If logic appears twice, refactor it into a shared utility or base class immediately.
* **Check:** "If I change this value here, do I have to remember to change it somewhere else?" If yes, refactor.

---

## 2. Auto Propagation
**Directive:** Ensure consistency flows automatically.

* **Instruction:** Downstream dependencies must update automatically when the source changes.
* **Action:**
    * Prefer computed properties/observables over manually synchronized state variables.
    * Use code generation tools (e.g., generating TypeScript interfaces from SQL schemas) over manual type matching.
    * Implement "Observer" or "Pub/Sub" patterns where state changes need to trigger UI or backend updates.
* **Check:** "Does this change require a human to manually update a secondary file?" If yes, automate it.

---

## 3. Construct Engine (Data-Driven Design)
**Directive:** Build generic processors, not specific hardcoded flows.

* **Instruction:** Separate the "What" (Metadata/Config) from the "How" (Engine).
* **Action:**
    * Avoid long chains of `if/else` or `switch` statements for business rules.
    * Instead, implement a "Rule Engine" or "Strategy Pattern" that iterates over a configuration (JSON/YAML/DB).
    * Treat business logic as metadata that is fed into a generic processor.
* **Check:** "Can I add a new business rule without recompiling the core logic?" If no, refactor to an engine.

---

## 4. Building is Part of Architecture
**Directive:** Operationalize the environment immediately.

* **Instruction:** Code is useless if it cannot be reliably built and deployed.
* **Action:**
    * Always generate the associated `Dockerfile`, `Makefile`, or CI/CD configuration alongside the application code.
    * Ensure the development environment (e.g., `docker-compose`) mirrors production as closely as possible.
    * Treat infrastructure-as-code (Terraform/Ansible) with the same rigour as application code.
* **Check:** "Can a new developer run this with a single command?" If no, fix the build scripts.

---

## 5. Design for Scale
**Directive:** Assume growth in volume and concurrency.

* **Instruction:** Avoid architectural bottlenecks that prevent horizontal scaling.
* **Action:**
    * Keep services and API handlers **stateless**. Store state in external stores (Redis/DB).
    * Use asynchronous processing (Queues/Jobs) for any long-running task; never block the request thread.
    * Design database interactions assuming sharding (partition keys) may be needed later.
* **Check:** "If traffic triples tomorrow, does this specific module break?"

---

## 6. Minimal Mechanism
**Directive:** Use the simplest tool for the job.

* **Instruction:** Fight over-engineering. Complexity is a liability.
* **Action:**
    * Prefer Standard Library solutions over importing heavy 3rd-party dependencies.
    * Do not implement "Generic" solutions for problems that do not yet exist (YAGNI).
    * Avoid microservices if a modular monolith suffices.
* **Check:** "Is there a simpler way to do this using fewer moving parts?"

---

## 7. Resist Entropy
**Directive:** Enforce structure and cleanliness rigidly.

* **Instruction:** Code quality must never degrade over time.
* **Action:**
    * Enforce strict typing (e.g., no `Any` in Python/TS).
    * Maintain clear separation of concerns (Layered Architecture: API -> Service -> Repo).
    * Leave the code cleaner than you found it (Boy Scout Rule).
* **Check:** "Does this code introduce a circular dependency or leak an abstraction?"
