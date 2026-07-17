# TDD Pattern Catalog

Distilled from Kent Beck, *Test-Driven Development: By Example*, Part III. Each
pattern is stated as **question → answer**, then adapted for an LLM coding agent.
Load this when `SKILL.md` names a pattern and you need its detailed form.

---

## TDD strategy patterns (Ch. 25)

**Test (noun)** — *How do you test software?* Write an automated test — a procedure
that runs at the push of a button, not a manual poke-and-look. Automated tests
turn the stress spiral (more stress → less testing → more errors → more stress)
into its inverse: when you feel uncertain, you *run the tests* and the fear drains.
Don't bother running a brand-new test *before* the code exists just to prove it
fails, unless you're genuinely unsure it will.

**Isolated Test** — *How should tests affect one another?* Not at all. Order
independent, no shared mutable state. One broken test should mean exactly one
problem. Achieving isolation forces highly cohesive, loosely coupled objects —
the isolation *is* the design pressure.

**Test List** — *What do you test?* Before coding, list every test you expect:
one example per operation, the null/degenerate version of each new operation, and
anticipated refactorings. Don't implement them en masse — each unimplemented test
is a red bar you're staring at and inertia against refactoring. Add new cases to
the list as they surface; work them one at a time.

**Test First** — *When do you write tests?* Before the code under test. Not for
purity — because test-first is a design and scope-control tool. It's the only way
you'll actually write them; "after" never comes.

**Assert First** — *When do you write the assert?* First. Build the test backward
from the answer:

- Start a system from the stories you want to tell about the finished system.
- Start a feature from the tests that pass when it's done.
- Start a test from the asserts that pass when *it's* done.

Writing the assertion first separates "what is the right answer?" and "how do I
check it?" from all the other decisions, so you solve them one at a time.

**Test Data** — *What data?* Data that makes the test easy to read. Simplest values
that still drive the design (a 3-item list, not 10, if 3 forces the same decisions).
Never use one constant to mean two things — if the first argument is 2, make the
second 3, so a swapped-argument bug can't hide.

**Evident Data** — *How do you show intent?* Put expected *and* actual, and the
relationship between them, in the test. `assertEquals(100 / 2 * (1 - 0.015), result)`
beats `assertEquals(49.25, result)` — the reader sees the computation. Making the
relationship explicit also tells you what the code must compute.

---

## Red-bar patterns (Ch. 26) — when/where you write tests

**One Step Test** — *Which test next?* One that teaches you something **and** that
you're confident you can implement quickly. Not obvious (no learning), not
impossible (no traction) — the one that's "ah, this one I can do." Programs grow
from known to unknown this way, neither strictly top-down nor bottom-up.

**Starter Test** — *Which test first?* A variant of the operation that does almost
nothing — smallest possible input, output that's trivial to predict (often
output == input, or an empty collection). It answers only "where does this code
belong?" without dragging in "what are the real inputs/outputs?" A realistic first
test leaves you too long without feedback.

**Explanation Test** — *How do you spread TDD?* Ask for and give explanations in
terms of test cases ("so if I have X and Y, the answer is 76?"). Don't evangelize;
demonstrate.

**Learning Test** — *When do you test third-party code?* Before the first time you
use a new facility. Write a small test that checks the library behaves as you
expect. If it passes first try, your understanding was right. On version bumps,
run these first — if they break, the app will too.

**Another Test** — *How do you stay on topic?* When a tangential idea appears, add
a test to the list and return to what you were doing. Respect the idea; don't
chase it now.

**Regression Test** — *First move on a reported defect?* Write the smallest test
that fails because of it. Then it's a normal red→green. Afterward, reflect on how
you could have known to write that test originally.

**Break / Do Over** — *Tired or lost?* Take a break (fatigue hides itself); or
throw the code away and restart the increment from the tests. Both beat pushing
forward through mud.

---

## Testing patterns (Ch. 27) — detailed techniques

**Child Test** — *A test too big to get green?* Write a smaller test for one broken
part of it, get that green, then reintroduce the larger test. Protects the
red/green/refactor rhythm; ten minutes of red is a warning sign.

**Mock Object** — *Object depends on an expensive/slow/awkward resource (DB,
network, clock, filesystem)?* Substitute a fake that returns constants. Gains:
speed, reliability, and readability (the expected data is right there in the test).
Risk: the mock may diverge from the real thing — mitigate with a shared test suite
run against both. Mocks push you to reduce coupling and think about each object's
visibility.

**Self Shunt** — *How do you test that object A talks to object B correctly?* Have
A talk to the *test case itself* instead of B. The test implements the interface B
would, and records what it received. Tests read better because expected and actual
end up in one place.

**Log String** — *How do you test that calls happen in the right order?* Keep a
string, append to it as each call fires, assert on the final string
(`"setUp testMethod tearDown "`). Great for Observer/notification sequences. If
order doesn't matter, use a set instead.

**Crash Test Dummy** — *How do you test error paths that are hard to trigger (disk
full, connection dropped)?* Pass in a special object that throws the error instead
of doing the real work — override just the one method that should fail. Untested
error code doesn't work.

**Broken Test** — *How do you stop a solo session?* Leave the last test failing.
When you return, the red bar is a bookmark pointing straight at your next move (like
stopping a writing session mid-sentence).

**Clean Check-in** — *How do you stop a team session?* Leave *all* tests passing.
Others depend on a known-good baseline. Never comment out a test to make the suite
pass. (For an agent: don't commit or hand off with a red suite unless the human
explicitly wants the failing test committed as a spec.)

**Characterization Test** *(not from Beck — the on-ramp for untested code)* — *How
do you refactor code that has no test?* Pin what it **currently does** before you
change its structure. Find a seam to invoke the unit in isolation, assert a value
you expect to be wrong, run it, and let the failure report the *actual* output;
then lock that actual value in as the assertion. Pin behavior even if it looks
buggy (record the suspected bug separately — don't fix it mid-refactor). Once the
seam is green, you're in the ordinary covered case. Full technique in
`legacy-coverage.md`; book-length treatment in Feathers, *Working Effectively with
Legacy Code*.

---

## Green-bar patterns (Ch. 28) — making the test pass fast

**Fake It ('Til You Make It)** — *First implementation?* Return a constant. Then
gradually replace the constant with variables, driven by removing the duplication
between the test's expected value and the code. Powerful because (a) green feels
categorically different from red — you can refactor with confidence — and (b) it
controls scope: one concrete case, then generalize.

**Triangulate** — *Most conservative way to drive abstraction?* Only generalize
when you have two or more examples. Write a second assert with different data; the
two cases force the general implementation. Slow — the rules are crisp but it's the
lowest gear. Use only when you can't see the right abstraction from one case.

**Obvious Implementation** — *Simple operation you know how to write?* Just write
it. Fake It and Triangulate are tiny deliberate steps; don't use them when the real
code is small and certain. But watch your surprise rate — if obvious
implementations keep coming back red (off-by-one, sign errors), downshift to
smaller steps.

**One to Many** — *Implement an operation over a collection?* Do it for a single
object first, then introduce the collection. Add the collection parameter alongside
the scalar, switch the body to use the collection, then drop the scalar parameter —
each move keeps a green bar (Isolate Change).

---

## Refactoring patterns (Ch. 31) — removing duplication under green

All refactoring in TDD is driven by **eliminating duplication**, and only ever with
a green bar. Take small steps by hand; lean on automated refactoring tools when
available.

- **Reconcile Differences** — To merge two similar chunks of code, first make them
  *identical* step by step, then unify.
- **Isolate Change** — Before changing one part, isolate it (e.g., add the new
  parameter) so the change can't ripple into the tests or other code.
- **Migrate Data** — Move from one internal representation to another by temporarily
  keeping both, shifting readers over, then dropping the old.
- **Extract Method** — Turn a fragment into a named method to shrink a long method
  and expose duplication.
- **Inline Method** — Fold a method back into its caller when the indirection no
  longer earns its keep.
- **Extract Interface** — Pull out an interface to allow a second implementation
  (often to enable Self Shunt or a Mock).
- **Move Method** — Relocate a method to the class whose data it actually uses.
- **Method Object** — Turn a gnarly method (many locals, resists Extract Method)
  into its own object, locals becoming fields — room to then refactor freely.
- **Add Parameter / Method Parameter → Constructor Parameter** — Adjust how an
  object receives what it needs, moving repeated arguments into construction.

---

## Design patterns that recur in TDD (Ch. 30)

Named here because refactoring toward green repeatedly rediscovers them:

- **Null Object** — Represent "nothing" as an object with the normal protocol
  (a no-op) instead of scattering `if (x != null)` checks.
- **Template Method** — A method written entirely in terms of other methods,
  capturing an invariant sequence (e.g. `setUp → run → tearDown`) while leaving the
  steps overridable.
- **Pluggable Object / Pluggable Selector** — Replace spreading conditionals with
  polymorphic objects (or a dynamically selected method). The *second* time you
  write the same conditional, pull out a Pluggable Object.
- **Factory Method** — Create objects in a method rather than a constructor when you
  need the flexibility to return a different class later.
- **Imposter** — Introduce a variation by adding a new object with the same protocol
  but a different implementation (Null Object and Composite are Imposters).
- **Composite** — Make an object whose behavior is the composition of a list of
  others behave as an Imposter for a single one.

---

## Mastering TDD — the three things that surprise learners (Ch. 32)

1. **Three gears to green** — Fake It, Triangulate, Obvious Implementation. Shift by
   confidence; the tendency over time is toward smaller steps under uncertainty and
   bigger steps when the road is clear.
2. **Duplication between test and code drives design** — the mechanical engine of
   TDD isn't the test, it's removing the duplication the test exposes.
3. **Control the step size deliberately** — take tiny steps for traction when the
   problem is slippery; cruise with Obvious Implementation when it's clear. The skill
   is *being able to change gears*, not always using one.

Why it works: it shortens the feedback loop on both implementation *and* design
decisions from weeks to seconds, and it acts as an "attractor" — write a test per
increment, refactor between increments, add features only on a green bar, and the
codebase converges toward correctness as a limit rather than decaying over time.

---

*Source: Kent Beck, "Test-Driven Development: By Example," Addison-Wesley, 2002. ISBN 0-321-14653-0.*
