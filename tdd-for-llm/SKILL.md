---
name: tdd-for-llm
description: >-
  Test-driven development discipline for an LLM coding agent, adapted from Kent
  Beck's "Test-Driven Development: By Example". Use when writing or changing code
  test-first — whenever the user asks for TDD, test-driven development, or
  "red/green/refactor", when starting a new feature/function/module and tests
  should drive it, or when fixing a reported bug (write the failing test first).
  Enforces the red→green→refactor loop, one failing test at a time, the smallest
  change to green (Fake It / Triangulate / Obvious Implementation), and
  refactoring only under a green bar. Also covers refactoring code with weak or
  missing test coverage — write characterization tests to pin behavior before
  changing structure. Skip for pure config, docs, or one-off throwaway scripts
  with no behavior to pin down.
---

# TDD for LLM

Kent Beck's TDD, translated into a discipline an LLM coding agent can follow in a
tool loop. An agent's failure mode is the opposite of a human's: you can generate
a lot of plausible code fast, but plausible ≠ working. TDD closes that gap — you
never claim code works until a test you watched fail now passes.

**Two rules govern everything (Beck's "da roolz"):**

1. Write a failing test before you write the production code that makes it pass.
2. Remove duplication — between test and code, and within the code — but only when the bar is green.

## The core loop: red → green → refactor

Run this loop, one test at a time. **Actually run the tests each step — never assume.**

1. **RED** — Add exactly one test for the next small increment. Run it. Watch it fail, and read the failure. A test that passes immediately, or fails for the wrong reason (compile error when you expected an assertion failure), is telling you something — stop and understand it before moving on.
2. **GREEN** — Make it pass with the *smallest* change you can, even an ugly one. Getting to green fast matters more than getting it right; you clean up next. Run the full test suite — green bar.
3. **REFACTOR** — Now, and only now, remove duplication and improve the design. Run the suite after each change. Any red → undo the last step, don't debug forward. (If the code you're changing may be untested, see "Refactoring existing code" first — a green bar doesn't protect code it doesn't exercise.)

Keep the loop to minutes. If a step drags, your step was too big — see Child Test below. The discipline is: **never more than one change away from a green bar** (the mountaineer's "three points of contact" rule).

## Refactoring existing code

"Refactor" = change structure without changing behavior — so you need tests that pin the current behavior of the code you're touching. A green bar is the precondition, with one caveat pure TDD never has to state:

**A green bar only protects the code the tests actually exercise.** A suite can be green because a function is correct, *or* because nothing tests it — those look identical from the bar. So the question before refactoring is never "is the suite green?" but **"is *this seam* covered?"**

1. **Limit scope.** Touch only what needs to change; leave untested code you're not changing alone.
2. **Check local coverage** of each unit you'll change — read the tests, or run the suite under coverage and look at those specific functions.
3. **Branch per seam:**
   - *Covered* → refactor in small steps, run the suite after each; any red → undo the last step, don't debug forward.
   - *Not covered but testable* → write a **characterization test** pinning its current behavior first (see `references/legacy-coverage.md`), then refactor.
   - *Not covered and hard to test* (dependencies block the harness — DB, network, globals, singletons, framework types) → use the **`working-with-legacy-code`** skill to break dependencies and get it under test, then come back to the loop.
4. **Don't chase whole-codebase coverage.** Pin only the seams you're changing.

## Before you start: the Test List

Do not dive into code. First write a **Test List** — a checklist of every test you expect to need:

- One example test for each operation you know you must implement.
- The degenerate/null case for each new operation (empty input, zero, missing item).
- Any refactorings you anticipate.

Keep it as a running checklist (a scratch file, or a TodoWrite list). As implementation reveals new cases, **add them to the list rather than chasing them now** (Another Test). Pick the next test with **One Step Test**: the one that will *teach you something* and that you're *confident you can make pass quickly*. When unsure where an operation even belongs, pick a **Starter Test** — a variant that does almost nothing — just to answer "where does this code live?"

## Getting to green: pick a gear

Three ways to make a red test pass — shift gears by confidence (`references/patterns.md` has fuller treatment):

- **Obvious Implementation** (top gear) — You know the real code and it's small. Just type it. If you start getting surprised by red bars, downshift.
- **Fake It** — Return a hard-coded constant that makes the test pass. Then, in refactor, drive the constant toward a real expression by removing the duplication between the test's expected value and the code.
- **Triangulate** (lowest gear) — When you don't see the right abstraction, add a *second* example. Two concrete cases force the general solution. Use only when genuinely unsure — it's the slowest.

Default to Fake It / Obvious; reach for Triangulate when the design won't reveal itself.

## Bug fixes

When a defect is reported, the first thing you write is the **smallest failing test that reproduces it** (Regression Test). Watch it fail, fix, watch it pass. Then ask: what would have made me write this test originally? — and add that class of case to your Test List habits.

## Writing good tests

- **Test First / Assert First** — Start the test from the assertion (the answer you want), then work backward to the setup that produces it. It clarifies naming, placement, and the interface before you commit to an implementation.
- **Isolated Tests** — Each test runs independently and in any order; one broken test = one problem. If tests must share expensive setup, that's a signal to split the objects, not to couple the tests.
- **Evident / Test Data** — Put the expected value and its derivation right in the test so a reader sees *why* it's correct (`100 / 2 * (1 - 0.015)`, not a magic `49.25`). Use the simplest data that still forces the design; never reuse one constant to mean two things.
- **Test only what you wrote** — conditionals, loops, operations, polymorphism *you* authored. Don't test the language or third-party libraries unless you distrust them (then write a **Learning Test** that documents the behavior you rely on).

## When you get stuck

- **Child Test** — A test turned out too big (needs several changes to pass)? Delete/park it, write a smaller test for one broken piece, get it green, then reintroduce the bigger one.
- **Do Over** — Lost, code's a tangle, list of "shoulds" piling up? Throw away the working-copy code and start the increment again from the tests. Often faster than untangling.
- **Break** — Tired or spinning? Stop. Fatigue erodes the judgment needed to notice you're tired. Return with the failing test as your bookmark.

## How much to test

"Write tests until fear turns to boredom." Tests are a means to confident code, not an end. If knowledge of the implementation already makes you confident, you may skip that test. Watch the tests themselves as a design smell detector: long setup, setup duplication, slow suites, or tests that break at a distance all mean the *design* needs work, not the tests.

## Reference

`references/patterns.md` — the full pattern catalog (red-bar, green-bar, testing, and refactoring patterns) distilled from Part III of the book, for when you need the detailed form of a pattern named above.

---

*Adapted from Kent Beck, "Test-Driven Development: By Example" (Addison-Wesley, 2002), Part III — Patterns for Test-Driven Development.*
