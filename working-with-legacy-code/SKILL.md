---
name: working-with-legacy-code
description: >-
  Getting untested, hard-to-test code safely under test so it can be changed —
  adapted from Michael Feathers' "Working Effectively with Legacy Code". Use when
  the code you must change has NO tests or poor coverage, when you "can't get this
  class/method into a test harness", when dependencies (DB, network, globals,
  singletons, framework classes) block testing, or when asked to characterize,
  pin, or break dependencies in existing code. Teaches the Legacy Code Change
  Algorithm, characterization tests, seams, and dependency-breaking techniques —
  then HANDS OFF to the tdd skill for the actual change. Do NOT use for
  greenfield code or code already under test — go straight to tdd for
  those.
---

# Working with Legacy Code

Michael Feathers' definition: **legacy code is code without tests.** Not old code —
*untested* code. You can't safely change what you can't test, and this code resists
testing. This skill's one job: **get the code under test safely, with the smallest
possible edits**, so that a real change can then be made test-first.

It stops where it succeeds. Once the code is pinned by tests, you're no longer in
legacy territory — **hand off to `tdd`** for the change itself (red → green →
refactor). This skill covers steps 1–4 below; `tdd` owns step 5.

An LLM agent's temptation here is the dangerous one: read the tangled code and
rewrite it directly. Don't. Untested edits to legacy code are exactly how
regressions ship. Pin behavior first, break dependencies *conservatively*, then
change under a green bar.

## The Legacy Code Dilemma

> When we change code, we should have tests. To put tests in place, we often have to
> change code.

That's the trap. The way out is to make the *smallest, safest* edits needed to get
tests in place — using **seams** (below) so you often change almost nothing — accept
that these edits may look slightly ugly, then let the tests make the real change
safe. "Suspend your sense of aesthetics a bit"; the scar heals once the area is
covered.

## The Legacy Code Change Algorithm

When you must change legacy code, follow these five steps:

1. **Identify change points** — where does the behavior actually need to change?
2. **Find test points** — where can you sense the effects of that change? (Sometimes
   the class itself is untestable but a class that *uses* it is easier — test at a
   higher level.)
3. **Break dependencies** — remove what blocks you from instantiating the object or
   running the method under test. Do this *conservatively* (see Seams + the
   `references/dependency-breaking-techniques.md` catalog).
4. **Write tests** — **characterization tests** that pin current behavior (below).
5. **Make changes and refactor** — **→ switch to `tdd`.** With the code now
   under test, add the change test-first and refactor under a green bar.

The goal every session: make the functional change *and* leave the area under test.
Tested regions grow like islands rising out of the ocean until you can work in
continents of covered code.

## Characterization Tests — the heart of this skill

A characterization test documents **what the code actually does**, not what it
*should* do. You are not hunting bugs; you are installing a tripwire that fires when
a future edit changes behavior. Feathers' algorithm:

1. Put the piece of code in a test harness.
2. Write an assertion you **know will fail** (e.g. `assertEquals("fred", ...)`).
3. **Let the failure tell you the actual behavior** (`expected <fred> but was <>`).
4. Change the test to expect what the code really produced (`assertEquals("", ...)`).
5. Repeat.

**Pin behavior even when it looks like a bug.** The expected value is whatever the
code *does today* — that's the baseline. If something looks wrong, keep the test but
mark it suspicious and check the impact of fixing it separately; do **not** "fix" it
while pinning (that changes behavior, defeating the net). Fix it afterward as its own
`tdd` cycle where the failing test states intended behavior.

**Where to stop** (coverage is infinite otherwise): these aren't black-box tests —
*read the code you're characterizing*. Get curious, write cases until you understand
it, then look at the specific change you intend and add tests until you're confident
they'll **sense any problem that change could cause**. If you can't reach that
confidence, change the code a different way, or in a smaller piece.

**Method Use Rule:** before you call a method in legacy code, check whether it has
tests. If not, write them first.

## Seams — change behavior without editing in place

> A **seam** is a place where you can alter behavior without editing in that place.
> Its **enabling point** is where you choose which behavior takes effect.

Seams are how you get tests in with minimal edits. Three types:

- **Object seam** *(preferred in OO languages)* — a call you can vary by passing a
  different object or subclassing and overriding the method. Enabling point: where the
  object is created / the argument list. Techniques: Subclass and Override Method,
  Extract Interface, Parameterize Constructor.
- **Link seam** — swap what the build links against (a stub library vs the real one).
  Enabling point: the makefile / build config. Useful when dependencies are pervasive.
- **Preprocessing seam** *(C/C++)* — redefine a symbol via macro/`#include` under a
  `TESTING` define. Enabling point: the preprocessor. Last resort — hard to maintain.

Prefer object seams; reserve link/preprocessing seams for when dependencies are
pervasive and nothing cleaner exists.

## Breaking dependencies — conservatively

The two ways testing gets blocked: **can't instantiate the object**, or **can't run
the method** in a harness. Break the offending dependency with the least invasive
technique that works — introduce an interface, subclass-and-override, parameterize a
constructor, etc. Because you're often doing this *without* tests yet, work in tiny,
mechanical, compiler-checked steps. Full catalog with when-to-use:
`references/dependency-breaking-techniques.md`.

## When you can't get it under test yet: Sprout & Wrap

Sometimes the surrounding code is too tangled to characterize right now, but you still
have to add behavior. Add the new behavior as **tested new code** and touch the old
code minimally:

- **Sprout Method / Sprout Class** — write the new logic in a *new*, fully tested
  method or class, and call it from the old code (one line of edit to the untested
  method).
- **Wrap Method / Wrap Class** — rename the old method and create a new one that calls
  the old plus your new behavior (or a decorator class), so the addition is testable
  without untangling the original.

These don't cover the old code — they stop it from getting worse while you add value,
and give you a tested beachhead to expand from.

## Boundary — this skill vs `tdd`

- **Code has no / poor tests, or resists testing** → **this skill.** Get it under test.
- **Code is greenfield, or already under test** → **`tdd` directly.**
- **Mid-task handoff:** the moment the seam you're changing is pinned green, switch to
  `tdd` for the change. They chain; they don't compete.

## Reference

`references/dependency-breaking-techniques.md` — the catalog of ~24 named
dependency-breaking techniques (Ch. 25), each as *when to use → what it does*, for
when a specific dependency blocks the harness.

---

*Adapted from Michael Feathers, "Working Effectively with Legacy Code" (Prentice Hall,
2004) — the Legacy Code Change Algorithm, the Seam Model, Characterization Tests, and
the Dependency-Breaking Techniques catalog.*
