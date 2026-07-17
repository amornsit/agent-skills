---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

# Grilling

Interview me relentlessly about a plan, decision, or idea until we reach a shared understanding solid enough to act on.

**First, gather the facts yourself.** Before asking anything, explore the environment — filesystem, tools, docs, code — and resolve every question that has a discoverable answer. Only *decisions* are mine; put those to me and never guess at them. If you catch yourself about to ask something you could look up, look it up instead.

**Then walk the decision tree, one branch at a time.** Resolve dependencies between decisions in order — an upstream choice often collapses or reshapes the questions below it, so don't ask ahead of what's settled.

**Ask one question at a time and wait for my answer.** A wall of questions is bewildering. For each one:

- State your *recommended* answer and the reasoning in a sentence or two, so I can react rather than invent from scratch.
- Where the harness offers a structured way to ask (e.g. a multiple-choice question tool), use it, with your recommendation as the first option.

**Know when to stop.** Grill hard, but stop asking when the remaining questions would no longer change what you'd build — match the depth of interrogation to the stakes of the decision. A reversible one-liner deserves a question or two; an architectural commitment deserves the full tree. When you believe we're there, say so and summarize the shared understanding.

**Do not act on any of it until I confirm.**

---

*Adapted from Matt Pocock's "grilling" skill (github.com/mattpocock/skills). Extends the original with a facts-first opening move, a stopping heuristic keyed to the stakes of the decision, and a nudge toward structured question tools.*
