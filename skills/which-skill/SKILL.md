---
name: which-skill
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
disable-model-invocation: true
---

# Which Skill

You don't remember every skill, so ask.

A **flow** is a path through the skills. Most paths run along one **main flow**, and three **on-ramps**
merge onto it. Everything else is standalone, or a vocabulary layer that runs underneath.

## The main flow: idea → ship

The route most work travels. You have an idea and want it built.

1. **[`/grill-with-docs`](../grill-with-docs/SKILL.md)** — sharpen the idea by interview. Start here
   when you **have a codebase**: it's stateful, retaining what it learns in `CONTEXT.md` and ADRs.
   (No codebase? Use [`/grill-me`](../grill-me/SKILL.md) — see Standalone. Both run the same
   [`/grilling`](../grilling/SKILL.md) primitive; `grill-with-docs` is the one that leaves a paper
   trail.)
2. **Branch — can you settle every question in conversation?** If a question needs a runnable answer
   (state, business logic, a UI you have to see), detour through a prototype, bridged by
   [`/handoff`](../handoff/SKILL.md) in both directions (see Crossing sessions):
   - `/handoff` out, then open a fresh session against that file,
   - [`/prototype`](../prototype/SKILL.md) to answer the question with throwaway code,
   - `/handoff` back what you learned, and reference it from the original idea thread.
3. **Branch — is this a multi-session build?**
   - **Yes** → [`/to-spec`](../to-spec/SKILL.md) (turn the thread into a spec), then
     [`/to-tickets`](../to-tickets/SKILL.md) to split it into tracer-bullet tickets, each declaring
     its **blocking edges**. On the local-markdown default that's one file per ticket under
     `.scratch/<feature-slug>/issues/`, worked blockers-first by hand; on a hosted tracker the edges
     become native blocking links, so any ticket whose blockers are done can be grabbed — kick off
     [`/implement`](../implement/SKILL.md) per ticket, **clearing context between each one**.
   - **No** → `/implement` right here, in the same context window.

   Either way, `/implement` builds each ticket by driving [`/tdd`](../tdd/SKILL.md) internally — one
   red-green slice at a time — then closes out by running
   [`/code-review`](../code-review/SKILL.md), a two-axis review (Standards + Spec) of the diff,
   before committing. Reach for `/tdd` on its own when you just want to build a concrete behaviour
   test-first without a full spec, and `/code-review` on its own whenever you want to review a branch
   or PR against a fixed point.

### Context hygiene

Keep steps 1–3 in **one unbroken context window** — don't compact or clear until after
`/to-tickets` — so the grilling, spec, and tickets all build on the same thinking. Each `/implement`
then starts fresh, working from the ticket.

The limit on this is the
**[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)**: the window (~120k tokens on
state-of-the-art models) within which the model still reasons sharply. If a session approaches it
before `/to-tickets`, don't push on degraded — `/handoff` and continue in a fresh thread.

## On-ramps

A starting situation that generates work, then merges onto the main flow.

- **Bugs and requests piling up** → [`/triage`](../triage/SKILL.md). It moves issues through triage
  roles and produces agent-ready issues, which `/implement` later picks up.

  Triage is only for issues **you didn't create** — bug reports, incoming feature requests, anything
  that arrives raw. Tickets that `/to-tickets` produced are already agent-ready, so **don't triage
  them**.

- **Something's broken** → [`/diagnosing-bugs`](../diagnosing-bugs/SKILL.md). For the hard ones: the
  bug that resists a first glance, the intermittent flake, the regression that crept in between two
  known-good states. It refuses to theorise until it has a **tight feedback loop** — one command that
  already goes red on *this* bug — then fixes with a regression test. Its post-mortem hands off to
  [`/improve-codebase-architecture`](../improve-codebase-architecture/SKILL.md) when the real finding
  is that there's no good seam to lock the bug down.

- **A huge, foggy effort — a greenfield project or a huge feature build, too big for one session** →
  [`/wayfinder`](../wayfinder/SKILL.md), the most cognitively demanding flow here. When the way from
  here to the destination isn't visible yet, it charts a **shared map** of **decision tickets** and
  resolves them one at a time — producing **decisions, not deliverables** — until the fog is pushed
  back and the way is clear. Where `/grill-with-docs` sharpens an idea you can hold in one session,
  wayfinder is for the idea you can't — and it's slower and denser, so save it for exactly that,
  never a well-scoped feature.

  When the map clears, **it hands off, it doesn't build**: merge onto the main flow at `/to-spec`,
  which collapses the map's linked decisions into a buildable plan, then `/to-tickets` and
  `/implement` as usual. Looping the map straight into `/implement` skips that collapse and throws
  the linked detail away — go straight to `/implement` only when the effort turned out genuinely
  small.

## Codebase health

Not feature work — upkeep.

- `/improve-codebase-architecture` — run whenever you have a spare moment to keep the codebase good
  for agents to operate in. It surfaces **deepening opportunities**; picking one *generates an idea*
  you can take into the main flow at `/grill-with-docs`. It's the survey that finds the candidates;
  `/codebase-design` (below) is the bench you design the chosen one on.

## Vocabulary underneath

Two model-invoked references that run *beneath* the other skills — each the single source of truth
for its vocabulary. Reach for them directly when the **words**, not the process, are the problem; or
let the skills above pull them in.

- [`/domain-modeling`](../domain-modeling/SKILL.md) — sharpen the project's *domain* language:
  challenge a fuzzy term, resolve an overloaded word ("account" doing three jobs), record a
  hard-to-reverse decision as an ADR. It's the active discipline `/grill-with-docs` drives to keep
  `CONTEXT.md` a clean glossary.
- [`/codebase-design`](../codebase-design/SKILL.md) — the deep-module vocabulary (module, interface,
  depth, seam, adapter, leverage, locality) for designing a module's *shape*: a lot of behaviour
  behind a small interface at a clean seam. `/tdd` and `/improve-codebase-architecture` both speak
  it.

## Crossing sessions

- `/handoff` — when a thread is full or you need to branch off (e.g. into a `/prototype` session),
  this compacts the conversation into a markdown file. You don't continue in place — you **open a new
  session and reference that file** to carry the context across. It's the bridge between context
  windows, in either direction. Use it when you want a **fresh session** but need the **current
  conversation preserved**.
- **Your harness's built-in compaction**, where it has one — stay in the **same conversation**,
  letting the earlier turns be summarized. Use it at **intentional breaks between phases**, when you
  don't mind losing the verbatim history. Don't compact mid-phase — the agent can lose its way.
  `/handoff` forks; compaction continues.

## Standalone

Off the main flow entirely.

- `/grill-me` — the same relentless interview as `/grill-with-docs`, but for when you have **no
  codebase**. Stateless: it saves nothing locally, builds no `CONTEXT.md`. Reach for it to sharpen
  any plan or design that doesn't live in a repo.
- `/prototype` — a small, throwaway program that answers one design question: does this state model
  feel right, or what should this UI look like. Throwaway from day one — keep the answer, delete the
  code. It's the detour in step 2 of the main flow, but reach for it any time a design question is
  hard to settle on paper.
- [`/research`](../research/SKILL.md) — delegate reading legwork to a sub-agent: it investigates a
  question against **primary sources**, then leaves a cited Markdown file in the repo. Keep working
  while it reads. The file it produces is something to take *into* the main flow at
  `/grill-with-docs` — research feeds the thinking, it doesn't replace it.
- [`/resolving-merge-conflicts`](../resolving-merge-conflicts/SKILL.md) — a merge or rebase has
  stopped on conflicts. It reads each side's commits and PRs to recover *why* both changes were made,
  preserves both where it can, then runs the project's checks before finishing. Reach for it the
  moment git stops, rather than resolving by hand and hoping.
- [`/teach`](../teach/SKILL.md) — learn a concept over multiple sessions, using the current directory
  as a stateful workspace.
- [`/writing-great-skills`](../writing-great-skills/SKILL.md) — reference for writing and editing
  skills well. It is the house style for this repo.

## Configuration

[`/setup-skills`](../setup-skills/SKILL.md) — **optional.** Point the tracker-aware skills at GitHub,
GitLab, or local markdown, set the triage label vocabulary, and choose the domain doc layout. Nothing
here waits on it: unconfigured, every skill that reads or writes issues defaults to local markdown
under `.scratch/`. Run it when you want a different target, not before you start.

---

*Adapted from Matt Pocock's "ask-matt" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
Renamed from `ask-matt`; `setup-matt-pocock-skills` renamed and demoted from a precondition to
optional configuration, matching this repo's local-markdown default; `/compact` generalised from a
Claude Code built-in to any harness's compaction; `resolving-merge-conflicts` added, which the
upstream router does not mention; slash commands turned into cross-skill links.
See [NOTICE.md](../../NOTICE.md).*
