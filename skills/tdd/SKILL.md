---
name: tdd
description: Test-driven development. Use when the user wants to build a feature test-first, fix a bug whose cause is already understood, or wants integration tests written at the right seams.
---

# Test-Driven Development

TDD is the red → green loop. This skill is the reference that makes that loop produce tests worth keeping: what a good test is, where tests go, the anti-patterns, and the rules of the loop. Every section applies on every cycle — consult them before and during the loop, not after.

The loop starts from a behaviour you can already name. **If you're fixing a bug and don't yet know
its cause, start at [`diagnosing-bugs`](../diagnosing-bugs/SKILL.md)** — it builds a loop that goes
red on the actual bug and writes the regression test itself. Come here once the failing behaviour is
understood.

When exploring the codebase, read `CONTEXT.md` (if it exists) so test names and interface vocabulary match the project's domain language, and respect ADRs in the area you're touching.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification — "user can checkout with valid cart" tells you exactly what capability exists — and survives refactors because it doesn't care about internal structure.

Read [good-and-bad-tests.md](references/good-and-bad-tests.md) before writing the first test of a
cycle — it works the implementation-coupled and tautological anti-patterns below through good/bad
pairs. Read [mocking.md](references/mocking.md) as soon as a test reaches for a test double — it
decides what may be mocked and how to shape a boundary that is mockable.

## Seams — where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals. [`codebase-design`](../codebase-design/SKILL.md) owns this vocabulary — reach for it when the seam under test isn't obvious and the module's shape has to be decided first.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam. You can't test everything — agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

Ask: "What's the public interface, and which seams should we test?"

## Anti-patterns

- **Implementation-coupled** — mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
- **Tautological** — the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth — a known-good literal, a worked example, the spec.
- **Horizontal slicing** — writing all tests first, then all implementation. Bulk tests verify _imagined_ behavior: you test the _shape_ of things rather than user-facing behavior, the tests go insensitive to real changes, and you commit to test structure before understanding the implementation. Work in **vertical slices** instead — one test → one implementation → repeat, each test a **tracer bullet** that responds to what the last cycle taught you.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to the review stage (see [`code-spec-review`](../code-spec-review/SKILL.md)), not the red → green implementation cycle.

---

_Adapted from Matt Pocock's "tdd" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
`tests.md` and `mocking.md` moved to `references/` with the context pointers repointed and reworded
to say when each file should be loaded; the description collapsed its "red-green-refactor" synonym
into the test-first branch; links added to `codebase-design` (seam vocabulary) and `code-spec-review`,
which upstream named as bare prose. Locally extended: upstream's description advertised "fix a bug
test-first" while its body assumes the cause is already known, so the trigger is narrowed to that
case and the unknown-cause case routed to `diagnosing-bugs`.
See [NOTICE.md](../../NOTICE.md)._
