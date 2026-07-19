---
name: to-spec
description: Synthesize the current conversation into a spec and publish it to the project issue tracker — no interview, just what has already been decided.
disable-model-invocation: true
---

# To Spec

This skill takes the current conversation context and codebase understanding and produces a spec (you may know this document as a PRD). Do NOT interview the user — just synthesize what you already know.

The issue tracker and triage label vocabulary should have been provided to you. If no tracker has been configured, default to the local-markdown tracker; run `/setup-skills` to point the skill somewhere else.

## Process

1. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the spec, and respect any ADRs in the area you're touching.

2. Sketch out the seams at which you're going to test the feature. Existing seams should be preferred to new ones. Use the highest seam possible. If new seams are needed, propose them at the highest point you can. The fewer seams across the codebase, the better - the ideal number is one.

   Check with the user that these seams match their expectations.

3. Write the spec using the template below, then publish it to the project issue tracker. If no tracker has been configured, default to the local-markdown tracker: write the spec to `.scratch/<feature-slug>/spec.md`, creating the directory if it does not exist.

   Apply the `ready-for-agent` triage label - no need for additional triage. On the local-markdown tracker that label is a `Status: ready-for-agent` line near the top of the file.

<spec-template>

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories. Each user story should be in the format of:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

This list of user stories should be extremely extensive and cover all aspects of the feature.

## Implementation Decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it within the relevant decision and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Out of Scope

A description of the things that are out of scope for this spec.

## Further Notes

Any further notes about the feature.

</spec-template>

## Next

Break the published spec into tickets with [`to-tickets`](../to-tickets/SKILL.md), then work the
frontier one ticket at a time with [`implement`](../implement/SKILL.md), clearing context between
tickets.

---

*Adapted from Matt Pocock's "to-spec" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Tracker references renamed to `/setup-skills`, the "run setup if not" gate removed in favour of
degrading to the local-markdown default (`.scratch/<feature-slug>/spec.md`) at the point the spec is
published, plus a local "Next" section handing off to `to-tickets` and `implement`. See
[NOTICE.md](../../NOTICE.md).*
