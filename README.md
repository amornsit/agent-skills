# Agent Skills

Portable, agent-agnostic skills, version-controlled here as the **source of truth**. They are written for any LLM coding agent — [Claude Code](https://docs.claude.com/en/docs/claude-code), Codex, Cursor, or anything else that can load a Markdown procedure — not for one vendor. Each skill is a top-level directory with a `SKILL.md` (frontmatter + procedure) and optional `references/` files loaded on demand.

## Layout

```text
<skill-name>/
  SKILL.md          # name, description (the trigger), and the procedure
  agents/
    openai.yaml     # per-agent interface descriptor (display name, short description)
  references/       # detailed material, loaded only when needed
```

`SKILL.md` is the portable core and carries no vendor-specific instructions. Anything an individual
agent needs on top of that lives in `agents/`, so adding support for a new agent means adding a
descriptor there rather than editing the procedure.

## How these are used

Each agent looks for skills in its own directory, so activate a skill by symlinking it from here —
this repo stays the single place you edit, and the change applies everywhere the symlinks point:

```sh
ln -s "$PWD/tdd" ~/.claude/skills/tdd     # Claude Code (or a project's .claude/skills/)
ln -s "$PWD/tdd" ~/.codex/skills/tdd      # another agent — adjust the path to its convention
```

If an agent has no skills directory, the procedure still works read as-is: point the agent at the
`SKILL.md` (paste it, include it in the system prompt, or reference the file) and it will follow.

## Skills here

- **[tdd](tdd/SKILL.md)** — test-driven development discipline for an LLM coding agent, adapted from Kent Beck's *Test-Driven Development: By Example*. Enforces red→green→refactor, one failing test at a time, the three gears to green (Fake It / Triangulate / Obvious Implementation), and characterization tests before refactoring untested code. Companion to the [book summary](https://github.com/amornsit/knowledge-accumulation/blob/main/summaries/test-driven-development-by-example-summary.md).
- **[working-with-legacy-code](working-with-legacy-code/SKILL.md)** — getting untested, hard-to-test code safely under test, adapted from Michael Feathers' *Working Effectively with Legacy Code*. The Legacy Code Change Algorithm, characterization tests, seams, and dependency-breaking techniques.
- **[grilling](grilling/SKILL.md)** — grill the user relentlessly about a plan, decision, or idea to stress-test their thinking, one question at a time. Adapted from Matt Pocock's *grilling* skill, extended with a facts-first opening move, a stopping heuristic keyed to the stakes, and a nudge toward structured question tools.
- **[to-tickets](to-tickets/SKILL.md)** — break a plan or conversation into tracer-bullet vertical slices, each sized to one context window and declaring the tickets that block it, written to `.scratch/` as one markdown file per ticket. Includes the expand–contract sequence for wide refactors that can't be vertically sliced. Adapted from Matt Pocock's *to-tickets* skill, stripped to local markdown output.
- **[code-review](code-review/SKILL.md)** — review a diff along two axes kept deliberately separate: **Standards** (repo conventions plus a [smell baseline](code-review/references/code-smells.md) from Fowler's *Refactoring*) and **Spec** (does it do what was actually asked?). Neither axis is allowed to mask the other. Adapted from Matt Pocock's *code-review* skill.
- **[implement](implement/SKILL.md)** — build the work from a spec or a set of `to-tickets` tickets: work the frontier one ticket at a time, drive real behaviour test-first with `tdd`, then check the result with `code-review`. The glue that connects the three. Adapted from Matt Pocock's *implement* skill.
- **[resolving-merge-conflicts](resolving-merge-conflicts/SKILL.md)** — resolve an in-progress git merge or rebase: understand each side's intent from its commits and PRs, preserve both where possible, run the project's checks, then finish. Adapted from Matt Pocock's *resolving-merge-conflicts* skill.

### How tdd and working-with-legacy-code relate

They **chain, they don't compete** — a deliberate split so it's clear which to use:

- **`tdd`** owns writing/changing code *test-first* — greenfield, or code already under test.
- **`working-with-legacy-code`** owns the step before that: making untested, dependency-tangled code *testable*. Once the code is pinned under a characterization test, it **hands off to `tdd`** for the actual change.

Rough rule: *can't test it yet* → legacy skill; *can test it (or it's new)* → `tdd`.

## Provenance

The `tdd` and `working-with-legacy-code` skills were distilled from book summaries in the
[knowledge-accumulation](https://github.com/amornsit/knowledge-accumulation) repo, which
remains the home for the source notes and summaries. This repo is just the runnable skills.

## Linting

Markdown style and links are checked automatically — there's no Python or Node project to set up.

- **Locally:** install the runner once, then enable the git hook:

  ```sh
  brew install pre-commit        # or: pipx install pre-commit / uv tool install pre-commit
  pre-commit install
  ```

- **In CI:** [`.github/workflows/lint.yml`](.github/workflows/lint.yml) runs `markdownlint-cli2`
  plus [`lychee`](https://github.com/lycheeverse/lychee) dead-link checking on every push and PR.

## License

[MIT](LICENSE) — use, copy, and adapt these skills freely.

Portions are derived from MIT-licensed work by [Matt Pocock](https://github.com/mattpocock/skills);
those notices are collected in [NOTICE.md](NOTICE.md). Skills that distill a book cite their source
and remain original wording.
