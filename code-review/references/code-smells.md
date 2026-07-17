# Code smells — the baseline

A fixed set of smells from Martin Fowler's *Refactoring* (ch. 3), used by the Standards axis of the
[code-review](../SKILL.md) skill. It applies even when a repo documents no standards of its own.

Three rules bind this list:

- **The repo overrides.** A documented repo standard always wins. Where it endorses something this
  baseline would flag, suppress the smell.
- **Always a judgement call.** Each smell is a labelled heuristic ("possible Feature Envy"), never a
  hard violation.
- **Skip what tooling enforces.** If a linter or formatter already catches it, it is not a review
  finding.

Each smell reads *what it is* → *how to fix*. Match them against the diff, not against the whole
codebase — a smell that predates the change is not this review's finding.

## The smells

- **Mysterious Name** — a function, variable, or type whose name doesn't reveal what it does or holds.
  → Rename it; if no honest name comes, the design's murky.
- **Duplicated Code** — the same logic shape appears in more than one hunk or file in the change.
  → Extract the shared shape, call it from both.
- **Feature Envy** — a method that reaches into another object's data more than its own.
  → Move the method onto the data it envies.
- **Data Clumps** — the same few fields or params keep travelling together (a type wanting to be
  born). → Bundle them into one type, pass that.
- **Primitive Obsession** — a primitive or string standing in for a domain concept that deserves its
  own type. → Give the concept its own small type.
- **Repeated Switches** — the same `switch`/`if`-cascade on the same type recurs across the change.
  → Replace with polymorphism, or one map both sites share.
- **Shotgun Surgery** — one logical change forces scattered edits across many files in the diff.
  → Gather what changes together into one module.
- **Divergent Change** — one file or module is edited for several unrelated reasons.
  → Split so each module changes for one reason.
- **Speculative Generality** — abstraction, parameters, or hooks added for needs the spec doesn't
  have. → Delete it; inline back until a real need shows.
- **Message Chains** — long `a.b().c().d()` navigation the caller shouldn't depend on.
  → Hide the walk behind one method on the first object.
- **Middle Man** — a class or function that mostly just delegates onward.
  → Cut it, call the real target direct.
- **Refused Bequest** — a subclass or implementer that ignores or overrides most of what it inherits.
  → Drop the inheritance, use composition.

## Shotgun Surgery vs Divergent Change

They're easy to confuse, and the difference is the direction of the fan-out:

- **Shotgun Surgery** — one change, many modules. You wanted to do one thing and had to touch eight
  files.
- **Divergent Change** — one module, many reasons. One file keeps getting edited for unrelated
  purposes.

The first wants gathering; the second wants splitting.

---

*Source: the smell baseline in Matt Pocock's `code-review` skill (github.com/mattpocock/skills) —
MIT © Matt Pocock — reproduced with the wording of each smell intact, reformatted as a reference file
and extended with the Shotgun Surgery / Divergent Change contrast. The smells themselves are from
Martin Fowler's* Refactoring *(ch. 3), which remains the property of its author and publisher. See
[NOTICE.md](../../NOTICE.md).*
