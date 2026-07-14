# Getting untested code under test (before refactoring)

Loaded from `SKILL.md` → "Refactoring existing code" when a seam you need to change
turns out **not** to be covered. TDD assumes every line was born from a failing
test; real code often wasn't. Before you can safely change structure, you have to
manufacture the safety net that pure TDD gets for free.

The tool for this is the **characterization test**: a test that pins what the code
*does now*, not what it *should* do.

## Why not just refactor carefully?

Because "careful" isn't feedback. Without a test, a behavior change during
refactoring is invisible until something breaks in production. A green bar over
code you *didn't* exercise is not protection (see the false-green trap in
`SKILL.md`). Manufacture real coverage over the seam first, then you're back in
the ordinary red/green/refactor loop.

## Characterization Test — the technique

**Goal:** lock in current behavior so any change that alters it turns the bar red.

1. **Find a seam.** A seam is a place where you can call the unit in isolation and
   observe its output without editing it. If the unit is tangled into a database,
   clock, network, or global, break just *enough* dependency to invoke it — inject
   the collaborator, extract an interface, or subclass-and-override the one method
   (a Crash Test Dummy / Mock Object; see `patterns.md`). Break the minimum needed
   to get a value out — this is not the refactor yet.
2. **Write an assertion you expect to be wrong.** You often don't know the exact
   output. Assert something deliberately incorrect:

   ```java
   assertEquals("TODO", format(order));
   ```

3. **Run it, and let the failure tell you the truth.** The test framework reports
   the *actual* value:

   ```text
   expected "TODO" but was "INV-2024-0042 · $19.99"
   ```

4. **Lock that actual value in.** Replace your placeholder with what the code really
   produced:

   ```java
   assertEquals("INV-2024-0042 · $19.99", format(order));
   ```

   Green. You've now pinned real behavior without having understood every line.
5. **Repeat** for the branches, edge cases, and error paths of that unit until you're
   confident a structural change can't slip past unnoticed — "until fear turns to
   boredom," scoped to *this seam only*.

## Pin behavior, even when it looks buggy

A characterization test records what the code **does**, not what it **should do**.
If step 3 reveals output that looks wrong, **still lock in the actual value** — that
frozen behavior is your baseline. Record the suspected bug separately (a note, a
`TODO`, an item on the Test List). Do **not** "fix" it inside the refactor:
changing behavior *is* the thing refactoring must not do, and you can't tell a
deliberate fix from an accidental regression if you do both at once. Fix it after,
as its own red→green cycle, where the failing test states the intended behavior.

## Then hand back to the loop

Once the seam is pinned green, you're in the covered case: refactor in small steps,
run the suite after each, undo on red. The characterization tests are scaffolding —
some you'll keep as real regression tests, others you may delete once better tests
(written against intended behavior) replace them.

## Scope discipline

Do **not** try to cover the whole file or codebase before refactoring — that's
months of work with no shipped value. Pin only the seams you're about to change;
leave the rest alone.

---

*This technique is treated at book length in Michael Feathers, "Working Effectively
with Legacy Code" (Prentice Hall, 2004) — characterization tests, seams, and
dependency-breaking. If "get untested code under test" becomes a task you invoke on
its own, that book is the source for a dedicated companion skill; this file is the
minimal on-ramp needed by the TDD loop.*
