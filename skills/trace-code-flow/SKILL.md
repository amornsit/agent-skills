---
name: trace-code-flow
description: Explain how a named folder, package, feature, or other area of a repository works. Trace its important execution paths as self-contained file-and-symbol boxes connected by labeled arrows. Use when the user asks how code works; do not use to design, change, or review code.
---

# Trace Code Flow

Turn a requested code area into a **flow map**: an evidence-backed diagram of the important code path.
The user should be able to follow what happens without opening every file themselves.

This skill explains existing code only. Do not change files, propose a redesign, or review quality
unless the user separately asks.

## Establish the scope

Use the folder, package, feature name, endpoint, command, or symbol the user supplied. Read
applicable repository guidance before exploring it.

If the request names a broad area, find the public entry point or most important behavior within that
area. If several plausible starting points would produce materially different maps, ask one concise
question rather than choosing silently.

## Trace the flow

Start at the entry point, then follow the actual execution path through the code. Include essential
callers when they explain how the area is reached, and include branches only when they change the
behavior, produce a side effect, or answer an obvious "what happens next?" question.

- Follow verified calls, method dispatch, route registration, rendering, event publication and
  handling, reads, writes, or construction.
- Label every arrow with the relationship it represents: `calls`, `constructs`, `reads from`,
  `writes to`, `publishes`, `handles`, `renders`, or similarly precise language.
- Use exact repository-relative file paths and exact function, method, class, or exported-symbol
  names.
- Do not draw an arrow merely because one file imports another. For types, configuration, or data
  with no runtime entry point, show verified consumer relationships and label them accordingly.
- When a call leaves the repository, identify the external package or service plainly. Do not imply
  that its code was inspected locally.
- If a relationship cannot be confirmed, say so below the diagram rather than inventing an arrow.

Keep the map readable. Omit incidental helpers; split independent flows into separate diagrams when
one diagram would become hard to follow.

## Output

Lead with a text diagram. Each box represents one real code unit and contains its role in the flow,
file path, symbol, and what it does. Use a code fence so the boxes and arrows stay aligned.

```text
┌─────────────────────────────────────────────────────────────┐
│ <role in this flow>                                          │
│ File: <repository-relative path or external package>         │
│ Symbol: <function | Class.method | exported symbol>          │
│ Does: <concise, evidence-backed explanation>                 │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ <actual relationship>
                              ▼
┌─────────────────────────────────────────────────────────────┐
│ <next role in this flow>                                     │
│ File: <repository-relative path or external package>         │
│ Symbol: <function | Class.method | exported symbol>          │
│ Does: <concise, evidence-backed explanation>                 │
└─────────────────────────────────────────────────────────────┘
```

Use a short `Scope:` line only when the request could be interpreted more than one way. After the
diagram, add concise `Not traced:` or `Unresolved:` notes only when they help the user understand a
boundary of the map.
