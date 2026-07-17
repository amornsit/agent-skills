# Skills

Portable [Claude Code](https://docs.claude.com/en/docs/claude-code) skills, version-controlled here as the **source of truth**. Each skill is a directory with a `SKILL.md` (frontmatter + procedure) and optional `references/` files loaded on demand.

## Layout

```text
skills/
  <skill-name>/
    SKILL.md        # name, description (the trigger), and the procedure
    references/     # detailed material, loaded only when needed
```

## How these are used

Claude Code discovers skills from `~/.claude/skills/` (personal) or a project's `.claude/skills/`. To activate a skill kept here, symlink it into your personal skills directory so this repo stays the single place you edit:

```sh
ln -s "$PWD/skills/tdd-for-llm" ~/.claude/skills/tdd-for-llm
```

Edit the files here; the change applies everywhere the symlink points.

## Skills here

- **[tdd-for-llm](tdd-for-llm/SKILL.md)** — test-driven development discipline for an LLM coding agent, adapted from Kent Beck's *Test-Driven Development: By Example*. Enforces red→green→refactor, one failing test at a time, the three gears to green (Fake It / Triangulate / Obvious Implementation), and characterization tests before refactoring untested code. Companion to the [book summary](../summaries/test-driven-development-by-example-summary.md).
- **[working-with-legacy-code](working-with-legacy-code/SKILL.md)** — getting untested, hard-to-test code safely under test, adapted from Michael Feathers' *Working Effectively with Legacy Code*. The Legacy Code Change Algorithm, characterization tests, seams, and dependency-breaking techniques.
- **[grilling](grilling/SKILL.md)** — grill the user relentlessly about a plan, decision, or idea to stress-test their thinking, one question at a time. Adapted from Matt Pocock's *grilling* skill, extended with a facts-first opening move, a stopping heuristic keyed to the stakes, and a nudge toward structured question tools.

### How these two relate

They **chain, they don't compete** — a deliberate split so it's clear which to use:

- **`tdd-for-llm`** owns writing/changing code *test-first* — greenfield, or code already under test.
- **`working-with-legacy-code`** owns the step before that: making untested, dependency-tangled code *testable*. Once the code is pinned under a characterization test, it **hands off to `tdd-for-llm`** for the actual change.

Rough rule: *can't test it yet* → legacy skill; *can test it (or it's new)* → `tdd-for-llm`.
