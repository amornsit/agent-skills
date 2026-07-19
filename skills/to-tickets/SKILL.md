---
name: to-tickets
description: Break a plan, spec, or the current conversation into tracer-bullet tickets, each sized to one context window and declaring the tickets that block it. Use when work is too big for a single session and needs slicing into an ordered set of independently verifiable pieces.
---

# To Tickets

Break a plan, spec, or conversation into **tickets** — tracer-bullet vertical slices, each declaring
the tickets that **block** it.

## 1. Gather context

Work from what is already in the conversation. If the user passes a reference — a spec path, a file,
a URL — read it in full first.

If you have not already explored the codebase, do so now. Ticket titles should use the vocabulary the
project actually uses. Look for opportunities to prefactor: *make the change easy, then make the easy
change.*

## 2. Draft vertical slices

<vertical-slice-rules>

- Each slice cuts a narrow but COMPLETE path through every layer (schema, API, UI, tests) — vertical,
  NOT a horizontal slice of one layer
- A completed slice is demoable or verifiable on its own
- Each slice is sized to fit in a single fresh context window
- Any prefactoring is its own ticket, and goes first

</vertical-slice-rules>

Give each ticket its **blocking edges** — the other tickets that must complete before it can start. A
ticket with no blockers can start immediately. Add an edge only where one ticket genuinely gates
another: a spurious edge shrinks the frontier and serializes work that could have run in any order.

### Wide refactors are the exception

A **wide refactor** is one mechanical change — rename a column, retype a shared symbol — whose
**blast radius** fans across the whole codebase, so a single edit breaks thousands of call sites at
once and no vertical slice can land green. Don't force it into a tracer bullet. Sequence it as
**expand–contract**:

1. **Expand** — add the new form beside the old so nothing breaks.
2. **Migrate** — move call sites over in batches sized by blast radius (per package, per directory),
   each batch its own ticket blocked by the expand. CI stays green batch to batch because the old
   form still exists.
3. **Contract** — delete the old form once no caller remains, in a ticket blocked by every migrate
   batch.

When even the batches can't stay green alone, keep the sequence but let them share an integration
branch that all block a final integrate-and-verify ticket — green is promised only there.

## 3. Quiz the user

Present the breakdown as a numbered list before writing anything. For each ticket show:

- **Title** — short and descriptive
- **Blocked by** — which tickets (if any) must complete first
- **What it delivers** — the end-to-end behaviour this ticket makes work

Then ask:

- Does the granularity feel right — too coarse, too fine?
- Are the blocking edges correct — does each ticket only depend on what genuinely gates it?
- Should any tickets be merged or split further?

Iterate until the user approves. Do not write files before they do.

## 4. Write the tickets

Write one file per ticket — never a single combined file — under
`.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numbered from `01` in dependency order (blockers
first).

Before writing, look under `.scratch/` for a directory that already belongs to this feature — a spec
from [to-spec](../to-spec/SKILL.md), or tickets from an earlier run. Write into it if you find one;
only create a new directory when nothing is there. A second directory naming the same feature
differently strands both halves, and nothing downstream will look for the one you didn't write to.

<ticket-template>

```markdown
# NN — Ticket title

**What to build:** the end-to-end behaviour this ticket makes work, from the user's perspective —
not a layer-by-layer implementation list.

**Blocked by:** the numbers/titles of the tickets that gate this one, or "None — can start
immediately".

- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2
```

</ticket-template>

Avoid specific file paths and code snippets — they go stale fast. The exception is a snippet that
encodes a decision more precisely than prose can (a state machine, a reducer, a schema, a type
shape). Inline it, trimmed to the decision-rich parts.

## 5. Hand off

Work the **frontier** — any ticket whose blockers are all done — one ticket at a time, clearing
context between tickets. That is what the one-context-window sizing rule buys, and it only works if
the tickets are on disk rather than in the conversation you are about to clear.

---

*Adapted from Matt Pocock's "to-tickets" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Stripped to local markdown output: the original's configurable issue tracker, triage label
vocabulary, and `/setup-matt-pocock-skills` and `/implement` couplings are removed. See
[NOTICE.md](../NOTICE.md).*
