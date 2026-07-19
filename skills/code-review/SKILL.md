---
name: code-review
description: Review the changes since a fixed point along two axes — Standards (does the code follow this repo's conventions and avoid known smells?) and Spec (does it do what was actually asked?). Reviews each axis independently and reports them side by side without merging. Use when reviewing a branch, a PR, work in progress, or when asked to "review since X".
---

# Code Review

Review the diff between `HEAD` and a fixed point along two axes:

- **Standards** — does the code follow this repo's conventions, and is it free of known smells?
- **Spec** — does the code faithfully implement the thing that asked for it?

## Why two axes

A change can pass one and fail the other:

- Code that follows every convention but implements the wrong thing → **Standards pass, Spec fail.**
- Code that does exactly what was asked but breaks the project's conventions → **Spec pass,
  Standards fail.**

They are reported separately so one cannot mask the other. That separation is the whole point of this
skill — respect it in step 5.

## 1. Pin the diff

The fixed point is whatever the user named — a commit SHA, a branch, a tag, `main`, `HEAD~5`. If they
didn't name one, ask; don't assume.

Resolve it and confirm there is something to review **before** starting either axis — a bad ref or an
empty diff should fail here, not halfway through a review:

```sh
git rev-parse <fixed-point>          # does the ref exist?
git diff <fixed-point>...HEAD        # three-dot — compare against the merge-base
git log <fixed-point>..HEAD --oneline
```

## 2. Find the spec

Take the first of these that yields something, and say which one you used:

1. A path or reference the user passed as an argument.
2. Issue references in the commit messages (`#123`, `Closes #45`) — fetch the issue if the environment
   can reach it.
3. A ticket or spec file matching the branch or feature — `.scratch/<feature>/issues/*.md` (see
   [to-tickets](../to-tickets/SKILL.md)), or a spec under `docs/` or `specs/`.
4. Ask the user where it is.

**If there is no spec, skip the Spec axis** and say so in the report. Don't substitute your own
reconstruction of the intent — a review against an imagined spec confirms whatever the diff already
does, which is worse than no review. The Standards axis still runs.

## 3. Find the standards

Read whatever this repo documents about how its code should be written — `CODING_STANDARDS.md`,
`CONTRIBUTING.md`, `CLAUDE.md` / `AGENTS.md`, or a conventions doc under `docs/`.

On top of whatever the repo documents, this axis always carries the smell baseline in
[references/code-smells.md](references/code-smells.md) — a fixed set of Fowler smells that applies
even when a repo documents nothing. Read it before reviewing. Three rules bind it:

- **The repo overrides.** A documented repo standard always wins. Where it endorses something the
  baseline would flag, suppress the smell.
- **Always a judgement call.** Each smell is a labelled heuristic ("possible Feature Envy"), never a
  hard violation. A breach of a *documented* standard can be hard; a baseline smell cannot.
- **Skip what tooling enforces.** If a linter or formatter already catches it, it is not a review
  finding.

## 4. Review each axis independently

Run the two axes in isolation from each other — in separate contexts where the harness offers them.
Neither axis should see the other's findings while forming its own: a Standards finding shouldn't
soften into "but it does what the ticket asked", and a Spec finding shouldn't get excused because the
code is tidy.

**Read the diff and the spec as evidence — not your memory of either.** If you wrote this code earlier
in the session, that memory is a liability: it carries the intent you meant rather than the behaviour
you shipped, and it will talk you out of findings. Reread both from disk.

**Standards axis** — for each finding, cite the source: either the documented rule (file plus the
rule) or the named smell plus the hunk it appears in. Distinguish documented breaches from baseline
judgement calls.

**Spec axis** — look for exactly three things, quoting the spec line for each:

- **Missing or partial** — a requirement the spec asked for that the diff doesn't deliver, or delivers
  only halfway.
- **Scope creep** — behaviour in the diff the spec never asked for. Judge it honestly: a test, a type,
  or an error path that the asked-for behaviour genuinely requires is not creep. A new capability, an
  abstraction with no caller, or a config knob nobody requested is.
- **Implemented but wrong** — a requirement the diff appears to satisfy, where the implementation
  doesn't actually do what the spec describes. These are the ones a checklist read passes over.

A Spec finding that can't cite the spec isn't a Spec finding — it's a Standards finding, or an
opinion. **And the spec can be the thing that's wrong:** if the diff knowingly departs from it for a
good reason, report it as a spec needing an update rather than a defect in the code, and say which you
think it is.

## 5. Report

Present the two axes under `## Standards` and `## Spec` headings. **Do not merge or rerank findings
across axes** — that reranking is exactly what the separation exists to prevent.

Close with one line: how many findings per axis, and the worst issue *within each axis*. Don't pick a
single winner across the two. If an axis found nothing, say so plainly — a review that always finds
something is not reviewing.

---

*Adapted from Matt Pocock's "code-review" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
The original's `/setup-matt-pocock-skills` issue-tracker coupling and Claude-specific sub-agent
orchestration are removed; the smell baseline moves to `references/`. Adds the fresh-context
rationale, the no-spec fallback, and the honest-creep and wrong-spec carve-outs. See
[NOTICE.md](../NOTICE.md).*
