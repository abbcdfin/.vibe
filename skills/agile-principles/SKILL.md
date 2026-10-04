---
name: agile-principles
description: Apply when sequencing, building, or verifying work — deciding what to build first, how much of it, how a phase proceeds, whether to prototype, or how to grow a partial implementation. Covers the twelve Agile Manifesto principles and this framework's method rules: build thin then widen, fail loudly on unhandled cases, thin-and-end-to-end over thick-and-partial, and the spike/slice/demo distinction. Applies alongside architectural-principles, which governs structure rather than method.
---

# Agile Method Principles

The **method** layer: how work is sequenced, built, and verified, once its structure is
settled. `architectural-principles` governs how the system is arranged; this governs how
it comes to exist.

The **complete, authoritative text** lives in `reference.md` alongside this file — the
twelve Agile Manifesto principles, a map of where each is already discharged by existing
framework machinery, and the method rules. Read it and apply it.

The core loop:

1. **Build thin, then widen.** Make the narrowest end-to-end path work before making any
   part of it complete.
2. **Fail loudly on the unhandled case.** Raise; never return a plausible default. The
   loud failures *are* the backlog that says what to widen next — this is the engine of
   the loop, not a style preference.
3. **Validate at the edge, assert inside.** Graceful handling belongs where untrusted
   input enters, not within your own code.
4. **Thin and end-to-end beats thick and partial.** Completing one component at a time
   defers integration risk to where it costs most.

And the distinction that keeps step 1 honest: a **spike** is throwaway by definition, a
**thin slice** is kept and grown, a **demo** elicits requirements. Confusing the first two
is how prototype code reaches production without passing a gate.

Key rule of thumb: if you cannot see what to build next, you have not failed loudly enough.
