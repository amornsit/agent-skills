---
name: ticket-commit
description: Commit the current work against an open ticket, referencing it from the message, appending a working note to its thread, and closing it when the work is done.
disable-model-invocation: true
---

# Ticket Commit

Commit what's in the working tree **against a ticket**: the message references it, a working note
appends to its thread, and when the work is finished the same run closes it.

Use this repeatedly through a piece of work. One ticket collects many commits; the ticket thread —
not the commit log — becomes the place the reasoning lives.

The issue tracker should have been provided to you. If no tracker has been configured, default to the
local-markdown tracker: tickets are files at `.scratch/<feature-slug>/issues/<NN>-<slug>.md`.
`/setup-skills` changes the target; it is not a gate you must pass before starting.

## Why the reference matters

A commit that names its ticket is findable from the code six months later — and
[`code-spec-review`](../code-spec-review/SKILL.md) depends on it literally, finding the originating
ticket by reading issue references out of commit messages. A commit without one leaves its Spec axis
with nothing to review against.

The trade the reference buys: **the commit message stays short, because the ticket carries the
context.** A one-line summary plus a reference beats a paragraph nobody will find again.

## Process

### 1. Identify the ticket

In order, stopping at the first that works:

1. An argument — a path, a number, or `#123`.
2. The ticket named by the most recent commit on this branch, which is usually still the one in play.
3. The branch name, if it encodes a ticket number or slug.
4. Otherwise list the open tickets and ask. Don't guess between two plausible ones.

**Read it in full before committing**, including its comments — you're about to append to a
conversation, and repeating a decision already recorded there is worse than adding nothing.

If the ticket is already closed, stop and ask. Committing against a closed ticket usually means the
work belongs to a new one, and filing that is [`/file-ticket`](../file-ticket/SKILL.md).

### 2. Check what's about to be committed

Run `git status` and read the diff — both staged and unstaged. Two things to establish:

- **Does all of it belong to this ticket?** If the tree also holds unrelated changes, say so and let
  the user decide what to stage. Don't sweep them in silently: an unrelated change buried under
  another ticket's reference is invisible to anyone reading either thread later.
- **Is the change complete?** A commit should bundle the implementation with the **tests that show it
  works** and the **documentation that describes it**. If tests or docs are missing and the change
  warrants them, say so before committing rather than after — splitting them across commits means
  the tree is broken at a commit that claims to work.

Never use `git add -A` to decide the scope for the user. Stage deliberately, or commit what they
already staged.

### 3. Commit, referencing the ticket

A one-line summary, then the reference. Keep the body to what a reader needs *at the code* — the
reasoning goes in the ticket thread, not here.

- **Local markdown (the default)** → reference the ticket path:
  `Refs: .scratch/<feature-slug>/issues/<NN>-<slug>.md`
- **A hosted tracker** → use its reference syntax (`Refs #123`), and its **closing** keyword
  (`Closes #123`) only on the commit that finishes the work — see step 5.

Write the summary in the imperative, describing the change rather than the ticket: the ticket
already says what was wanted, and the commit says what was done about it.

### 4. Append a working note to the ticket

Append an entry to the ticket's thread — under the `## Comments` heading on local markdown, or as a
comment on a hosted tracker. This is the point of the whole skill: the ticket becomes a **working
notebook**, and a thread with a dozen honest notes is worth more than a perfect final summary.

<working-note-template>

```markdown
### <short commit SHA> — <what this commit did>

What changed, in a sentence or two, and **why** — the reasoning that isn't visible in the diff.

- **Decided:** what you chose, and what you chose it over.
- **Didn't work:** approaches tried and abandoned, with the reason. These are worth more than the
  successes — they're what stops the next person retrying them.
- **Links:** documentation, prior art, a related ticket or discussion.
- **Still open:** what's not done yet, so the next session starts where this one stopped.
```

</working-note-template>

Write the parts that apply and drop the rest — an empty heading is worse than no heading. Skip the
note entirely for a genuinely trivial commit (a typo, a lint fix); a thread padded with "fixed
formatting" is a thread people stop reading.

**Don't restate the diff.** The diff is already in git and reads better there. Record what git can't:
what you considered, what you rejected, and what you're unsure about.

### 5. Close it when the work is done

Only when the ticket's acceptance criteria are actually met. Check them — if the ticket carries a
checklist, tick the boxes as part of this step, and if any remain unticked, **don't close it**: say
which and commit as normal. A ticket closed with work outstanding is worse than one left open,
because nobody looks at it again.

**A ticket filed by [`/file-ticket`](../file-ticket/SKILL.md) usually has no criteria at all** — it
records a request, not a contract, and nothing in this pipeline writes one. That's the common case,
not the exception, so don't read an empty checklist as "nothing left to satisfy."

When there are none, **write them before closing**, in this order:

1. Propose what *done* means for this ticket — two to four concrete, checkable statements, drawn
   from the request and from what the work actually turned out to involve. "The export button
   downloads a CSV of the current filter" — not "export works."
2. Show them to the user and get agreement. They may well say the scope moved, which is exactly the
   conversation worth having *before* the ticket closes rather than after.
3. Append them to the ticket, then verify them the same way you would criteria that had been there
   all along.

This is not ceremony. Criteria written at the end still do the two jobs that matter: they force the
question "is this actually finished?" to be answered out loud, and they leave a closed ticket that
says what shipped rather than only what was once wanted. Writing them earlier is better — if the
scope is clear before you start, propose them on the **first** `ticket-commit` against the ticket
instead of the last.

If the work sprawled beyond the original request, don't stretch the criteria to cover it. Close this
ticket on what it asked for and file the rest with `/file-ticket`.

Closing means, in this order:

1. The commit uses the tracker's closing keyword (`Closes #123`), or on local markdown the `Status:`
   line near the top of the file becomes `closed`.
2. A **capstone comment** appends to the thread: what shipped, a link to the updated documentation,
   and a demo or the command that exercises it if there is one. This is the comment that pays off
   every note above it — someone arriving at a closed ticket should learn what the feature *is*,
   not have to reconstruct it from twelve commit notes.
3. Run the project's full test suite first, if you haven't this session. Closing a ticket on a red
   tree is the one mistake this skill can make that git won't let you take back cheaply.

If the work is *not* done, say what's left and stop. The ticket stays open and you run this skill
again on the next commit.

## What this is not

- It doesn't decide **what** to build — that's the ticket's job, and
  [`/file-ticket`](../file-ticket/SKILL.md) files one. It does pin down what **done** means when the
  ticket never said (step 5), because something has to before a ticket can honestly close.
- It doesn't review the work. Reach for [`/code-spec-review`](../code-spec-review/SKILL.md) before
  closing anything substantial; it will find the ticket through the very references this skill wrote.
- It doesn't push, open a PR, or release. Committing is where it stops.

---

*Original to this repo — not derived from
[mattpocock/skills](https://github.com/mattpocock/skills). The workflow follows Simon Willison's
["The Perfect Commit"](https://simonwillison.net/2022/Oct/29/the-perfect-commit/) — implementation,
tests, and documentation bundled into one commit that links an issue thread, with the thread carrying
the context the commit message no longer has to. The tracker conventions it writes to arrived here
via the ported skills. See [NOTICE.md](../../NOTICE.md).*
