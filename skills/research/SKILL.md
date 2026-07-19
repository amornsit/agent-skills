---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic, library, or API researched, or the reading legwork delegated so they can keep working.
---

# Research

Delegate the research to a **sub-agent** working in the background, so you keep making progress while it reads. Hand it the question, then carry on with the current task and pick up its file when it lands.

The sub-agent's job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings to a single Markdown file, citing each claim's source.
3. Save it where the repo already keeps such notes; match the existing convention, and if there is none, put it somewhere sensible and say where.

---

*Adapted from Matt Pocock's "research" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Description collapsed to one trigger per branch, and the delegation step reworded from one harness's
"background agent" to a portable sub-agent instruction. See [NOTICE.md](../../NOTICE.md).*
