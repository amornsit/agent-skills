---
name: to-spec
description: Turn the current conversation into a spec — problem, solution, user stories, and the implementation and testing decisions already settled — written to `.scratch/` as a single markdown file. Use when a discussion has converged and needs writing down before it is sliced into tickets or built. Invoke explicitly; do not auto-trigger on every design discussion.
---

# To Spec

Turn the current conversation into a **spec** — the document some teams call a PRD.

**Do not interview the user.** This skill synthesizes a decision that has already been made. The
discussion happened; your job is to write it down, not to reopen it. If you find yourself wanting to
ask what the feature should do, you have invoked this too early — say so and stop.

## 1. Gather context

Work from what is already in the conversation. If the user passes a reference — a plan, a file, a
URL — read it in full first.

If you have not already explored the codebase, do so now. The spec should use the vocabulary the
project actually uses, and should respect any architectural decisions already recorded in the area
you're touching — an ADR, a `CONVENTIONS.md`, a `CLAUDE.md`, or the prevailing pattern in
neighbouring code.

## 2. Sketch the seams

A **seam** is a place you can change behaviour without editing in that place — the point at which
this feature can be tested. Decide those before writing the spec, because they shape what the
Testing Decisions section can honestly promise.

<seam-rules>

- Prefer an existing seam to a new one
- Use the highest seam available — the one closest to the user-visible behaviour
- The fewer seams this feature adds across the codebase, the better; the ideal is none
- If a new seam is genuinely needed, propose it at the highest point you can

</seam-rules>

If the code you'd be testing through is untested or tangled enough that no seam is reachable,
that's a finding for the spec, not a detail to paper over — see
[working-with-legacy-code](../working-with-legacy-code/SKILL.md) for how the seam gets created, and
record the work as its own scope item.

Present the seams to the user and confirm they match expectations before writing. This is the only
checkpoint in the skill — everything else is synthesis of what they already told you.

## 3. Write the spec

Write to `.scratch/<feature-slug>/spec.md`, creating the directory if needed. By convention
[to-tickets](../to-tickets/SKILL.md) writes its `issues/` directory into that same folder, so a
feature's spec and its tickets end up together — tell the user the path you used, and pass it when
you invoke `to-tickets` rather than leaving it to guess the same slug.

<spec-template>

```markdown
# Feature title

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution to that problem, from the user's perspective.

## User Stories

A long, numbered list, each in the form:

1. As an <actor>, I want <capability>, so that <benefit>

Cover the whole feature — the ordinary path, the empty and error states, and what each actor can
see or do. A story the list omits is a decision nobody made.

## Implementation Decisions

What was settled about how this gets built: the modules built or modified and their interfaces,
schema changes, API contracts, architectural choices, and any technical clarification the user
gave during the discussion.

## Testing Decisions

The seams agreed in step 2, what will be tested through each, and the prior art in this codebase
that those tests should resemble. Tests here assert external behaviour, never implementation
detail.

## Out of Scope

What this spec deliberately does not cover — and, where it's a close call, why.

## Further Notes

Anything else worth carrying forward: open questions, assumptions, things to revisit.
```

</spec-template>

Avoid specific file paths and code snippets — they go stale fast. The exception is a snippet that
encodes a decision more precisely than prose can (a state machine, a reducer, a schema, a type
shape). Inline it, trimmed to the decision-rich parts.

Write only what was decided. A spec that invents requirements to fill a section is worse than a
spec with a short section — if the discussion never settled something, it belongs under Further
Notes as an open question, not under Implementation Decisions as a fact.

## 4. Hand off

The spec is the input to [to-tickets](../to-tickets/SKILL.md) when the work is too big for one
context window, or straight to [implement](../implement/SKILL.md) when it isn't.

---

*Adapted from Matt Pocock's "to-spec" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Stripped to local markdown output: the original's issue tracker, `ready-for-agent` triage label, and
`/setup-matt-pocock-skills` coupling are removed in favour of a `.scratch/` file shared with
`to-tickets`. Seam guidance is pulled into its own step and pointed at this repo's legacy-code
skill, and the Claude-specific no-auto-invoke frontmatter moves to `agents/`. See
[NOTICE.md](../NOTICE.md).*
