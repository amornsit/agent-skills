---
name: implement
description: Build the work described by a spec or a set of tickets — test-first where it counts, then reviewed. Use when the user says to implement, build, or work a ticket, spec, or an approved plan. Invoke explicitly; do not auto-trigger on every code request.
---

# Implement

Implement the work the user described — a spec, or a set of tickets from [to-tickets](../to-tickets/SKILL.md).

If the work is a set of tickets, build the **frontier** one ticket at a time — any ticket whose
blockers are all done — and clear context between tickets. Each ticket was sized to fit one fresh
context, so carrying the last one's context into the next only crowds it.

Drive the code test-first with [tdd](../tdd/SKILL.md) at the seams that carry real behaviour — a
parser, a reducer, a calculation, a state machine. Agree those seams before writing them, and don't
force it onto glue, wiring, or config that has no behaviour to pin.

Keep the feedback loop tight as you go: typecheck often, run the single test file you're working in
often, and run the full suite once at the end rather than after every change.

When the work is done, review it with [code-review](../code-review/SKILL.md) against the spec or
ticket that motivated it, and address what that surfaces.

Commit to the current branch.

---

*Adapted from Matt Pocock's "implement" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
The `/tdd` and `/code-review` references are repointed at the skills in this repo, ticket-frontier
handling is spelled out, and the Claude-specific no-auto-invoke frontmatter moves to `agents/`. See
[NOTICE.md](../NOTICE.md).*
