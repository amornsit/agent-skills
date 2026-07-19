---
name: implement
description: "Build a piece of work from a spec or a set of tickets, test-first, and commit it."
disable-model-invocation: true
---

# Implement

Implement the work described by the user in the spec or tickets.

The spec normally comes from [`to-spec`](../to-spec/SKILL.md) and the tickets from
[`to-tickets`](../to-tickets/SKILL.md). If the user passes a reference rather than the work itself
— a ticket number, a path, an issue URL — fetch it from the configured tracker and read it in full
before starting. If no tracker has been configured, default to the local-markdown tracker: tickets
live one per file at `.scratch/<feature-slug>/issues/NN-<slug>.md`. `/setup-skills` changes which
tracker is the target; it is not a prerequisite for this skill.

Use [`tdd`](../tdd/SKILL.md) where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use [`code-spec-review`](../code-spec-review/SKILL.md) to review the work.

Commit your work to the current branch.

---

*Adapted from Matt Pocock's "implement" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Reproduced with the slash-command mentions of `tdd` and `code-spec-review` turned into cross-skill links
into this repo; local extension: a ticket-fetch paragraph naming `to-spec` and `to-tickets` as the
upstream sources and guaranteeing the local-markdown tracker fallback, which upstream leaves
implicit. See [NOTICE.md](../../NOTICE.md).*
