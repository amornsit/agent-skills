---
name: file-ticket
description: File a single bug report or feature request straight to your issue tracker, without a spec or a plan.
disable-model-invocation: true
---

# File Ticket

One request in, one ticket out. Use this when you want to **get something out of your head and onto
the tracker** — a bug you just hit, a feature you thought of in the shower — without stopping to
grill it, spec it, or break it into slices.

The ticket is still **grounded in the code**: by default, before asking the user anything, scout the
codebase for where the request lands and what the project calls it. That costs a minute and buys a
ticket that names real modules in the project's own vocabulary, asks only the questions reading
couldn't answer, and catches the request that turns out to be already built. What it deliberately
skips is the *planning* — the interview, the spec, the slicing. And when the user just wants it
written down, the scout is skippable too (see the fast path below).

What you file is not a queue entry — it's where the thinking about this piece of work lands and
**accumulates** from here on.

The issue tracker and triage label vocabulary should have been provided to you. If no tracker has
been configured, default to the local-markdown tracker. `/setup-skills` changes the target; it is not
a gate you must pass before starting.

## What this is not

This skill files **one** ticket and stops. It does not plan, decompose, or estimate.

- The request is a whole feature needing several tickets → this is the wrong tool. Say so, and point
  at the main flow: [`/grill-with-docs`](../grill-with-docs/SKILL.md) →
  [`/to-spec`](../to-spec/SKILL.md) → [`/to-tickets`](../to-tickets/SKILL.md). File one ticket only
  if the user wants a placeholder to come back to.
- The bug needs to be *fixed*, not recorded → [`/diagnosing-bugs`](../diagnosing-bugs/SKILL.md).
- The ticket needs evaluating, verifying, and turning into an agent brief →
  [`/triage`](../triage/SKILL.md), which is where every ticket this skill files goes next.

## Process

### 1. Take the report

Work from what the user said — the argument to the skill, or the last thing in the conversation.

**Fast path.** If the user just wants it noted — their own idea, phrased as "jot this down", "don't
ask me questions", "placeholder" — or the report already answers its checklist, **skip steps 3–5**
and publish now. Still classify it, still file at `needs-triage`. The scout is a service, not a toll:
a ticket the user had to sit through an interview for is a ticket they file less often.

When you take the fast path, say so in the body — the template has a `Filed fast:` line. Without it
a `Where: Unknown` is ambiguous between *the scout ran and found nothing* and *the scout never ran*,
and those two deserve opposite amounts of suspicion from whoever triages it.

### 2. Classify it

Pick one category role: `bug` (something is broken) or `enhancement` (new feature or improvement).
These are [`/triage`](../triage/SKILL.md)'s category roles — same vocabulary, so the ticket lands in
its state machine already half-labelled. If the report is genuinely both, or you can't tell, file it
as the one the user's own words lean toward and note the ambiguity in the body.

### 3. Explore the codebase

Find the code the request lands on, before you ask the user anything. A **scout, not an
investigation** — you are locating the request on the map, not diagnosing it. Search by the domain
concept rather than the reporter's exact wording, use the project's domain glossary vocabulary, and
respect ADRs in the area you're reading.

You're after three things, and you stop once you have them:

- **Where it lives** — the module, command, endpoint, or page the request touches, so the ticket
  carries a real `Where` instead of the reporter's guess.
- **The project's word for it** — so the title and body use the codebase's vocabulary and the next
  reader can find it.
- **Whether it already exists** — a feature already built, or a bug already handled somewhere.

Timebox it. If a few searches don't locate the surface, write `Unknown` and file anyway — an
unlocated ticket still beats an unfiled one, and triage explores properly.

Two things this scout does **not** do. It doesn't diagnose: don't chase the root cause, don't read
the call chain to the bottom, don't start a fix. And it doesn't decide. If the behaviour looks like
it already exists, **tell the user what you found and ask** whether to file anyway — a request that
looks implemented is often implemented *differently* than the user needs. `wontfix` is triage's call,
never this skill's.

### 4. Fill the gaps — one round only

Check the report against the checklist for its category, then **subtract everything the codebase
already answered**. Ask about what is actually missing — never a question the user already answered,
and never one you could have answered by reading.

<bug-checklist>

- What happened (the actual behaviour), and what was expected instead
- The steps that produce it, or the smallest input that does
- Where — command, page, endpoint, or module
- Whether it is reproducible or intermittent, and when it started if known

</bug-checklist>

<enhancement-checklist>

- The problem it solves, not the solution the user reached for
- Who hits that problem, and how often
- What they do today instead

</enhancement-checklist>

Ask in **a single message**, at most three questions, then write. If the user says they don't know
or doesn't answer, record it as `Unknown` in the ticket body and file anyway — an unknown written
down is triage input; an unfiled ticket is nothing. Do not open an interview. If the answers reveal
the request is much bigger than one ticket, stop and say so (see "What this is not").

### 5. Check it isn't already filed

Search the tracker for an open ticket describing the same behaviour, using the domain vocabulary the
scout just gave you rather than the user's wording. If one exists, don't file a second: show it to
the user and offer to append what's new to it as a comment instead. Duplicate tickets cost more in
triage than they save here.

Checking whether the request was *previously rejected* — `.out-of-scope/` and the reasoning behind it
— stays triage's job. Leave it there.

### 6. Publish it

**If no tracker has been configured, default to the local-markdown tracker** (`/setup-skills`
changes the target).

- **Local markdown (the default)** → one file at `.scratch/<feature-slug>/issues/<NN>-<slug>.md`.
  List `.scratch/` first and **reuse an existing feature directory** if the request belongs to one;
  create a new slug only when nothing matches, and ask rather than guess when two plausibly match.
  `NN` continues that directory's existing numbering. Use the template below.
- **A hosted issue tracker (GitHub, Linear, …)** → open one issue with the same body, and apply the
  category role (`bug`/`enhancement`) and the state role `needs-triage` as labels.

Tickets filed here land in **`needs-triage`**, never `ready-for-agent` — and the codebase scout does
not change that. A scout locates the request; it does not **verify** it. Nobody has reproduced the
bug, confirmed the diagnosis, or written acceptance criteria, and those are what make a brief
agent-ready. Labelling a located-but-unverified ticket `ready-for-agent` sends an agent off to build
against a guess.

<ticket-template>

```markdown
# <NN> — <Ticket title>

**Type:** bug | enhancement

**Status:** needs-triage

**Filed fast:** no codebase scout, no duplicate check — include this line only when step 1's fast
path was taken, and omit it entirely otherwise.

**What happened / what's wanted:** the behaviour, in the reporter's terms. For a bug, the actual
behaviour and the expected one. For an enhancement, the problem being solved — not the solution.

**Where:** the module, command, endpoint, or page the scout located, in the project's own vocabulary.
`Unknown` if the scout came up empty — say so rather than guessing.

**What the scout found:** one or two lines on the relevant code and how it behaves today, so triage
starts where you stopped. Omit if nothing was found. This is a starting point, not a diagnosis —
mark anything uncertain as such.

**Steps to reproduce** (bugs only, omit for enhancements):

1. step
2. step

**Open questions:** anything asked but not answered, so triage doesn't re-ask it blind.

## Comments
```

</ticket-template>

Avoid pinning line numbers or pasting code — a ticket outlives the lines it names. Name modules and
functions, which survive longer.

The trailing `## Comments` heading is deliberate: it leaves the file ready to be appended to. On a
hosted tracker the comment thread plays the same role, so omit the heading there.

### 7. Hand off

Report where the ticket landed — the file path or the issue URL — and stop. Don't start work on it.
When the user is ready to evaluate what's piled up, that's [`/triage`](../triage/SKILL.md).

The ticket is now the **durable context layer** for this piece of work, not an inbox row. Everything
that happens next appends to it: triage notes, decisions and what was considered and rejected, links
to the code and docs as they change. Later skills append to this file rather than opening a second
one — a decision recorded next to the request that prompted it is one the next reader can still find.

---

*Original to this repo — not derived from
[mattpocock/skills](https://github.com/mattpocock/skills). It reuses that repo's triage role
vocabulary and local-markdown tracker conventions, both of which arrived here via the ported skills.
See [NOTICE.md](../../NOTICE.md).*
