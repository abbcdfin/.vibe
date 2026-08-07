import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

// Vibe always-on governance injector — pi coding-agent variant.
//
// pi has no plugin-hook system like Claude Code; instead an extension subscribes
// to the `before_agent_start` event and prepends the single-source vibe.md spine
// to the system prompt. This is the SAME vibe.md every other adapter reads
// (Claude SessionStart, Antigravity PreInvocation, Codex SessionStart) — one
// source of truth, N thin adapters.
//
// BEST-EFFORT: built from pi's published extension docs, not yet validated on a
// live pi install (pi was not installed when this was written). If pi's API has
// drifted, the two things to check are: (1) the event name `before_agent_start`
// and (2) that its handler returns `{ systemPrompt }`. See README (Install — pi).
//
// NOTE: the candidate mode-aware injection (modes/*.md) that the bash hooks add
// is not ported here — it is an unadopted validation harness. pi gets the spine.

const HERE = dirname(fileURLToPath(import.meta.url));
const SPINE = join(HERE, "..", "vibe.md");

const PREAMBLE = `# Vibe Framework — Active Operating Governance
The vibe framework is installed. The rules below are ALWAYS in effect for this session. Follow them.

---
`;

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", async (event) => {
    let spine: string;
    try {
      spine = readFileSync(SPINE, "utf8");
    } catch {
      return {}; // spine missing — inject nothing rather than break startup
    }
    const governance = `${PREAMBLE}${spine}`;
    return { systemPrompt: `${event.systemPrompt}\n\n---\n\n${governance}` };
  });
}
