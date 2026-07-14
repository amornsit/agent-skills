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
