# Agent Skills

Portable, agent-agnostic skills, version-controlled here as the **source of truth**. They are written for any LLM coding agent — [Claude Code](https://docs.claude.com/en/docs/claude-code), Codex, Cursor, or anything else that can load a Markdown procedure — not for one vendor. Each skill is a top-level directory with a `SKILL.md` (frontmatter + procedure) and optional `references/` files loaded on demand.

## Layout

```text
skills/<skill-name>/
  SKILL.md          # name, description (the trigger), and the procedure
  agents/
    openai.yaml     # per-agent interface descriptor (display name, short description)
  references/       # detailed material, loaded only when needed
```

`SKILL.md` is the portable core and carries no vendor-specific **instructions**. Anything an
individual agent needs on top of that lives in `agents/`, so adding support for a new agent means
adding a descriptor there rather than editing the procedure. The one exception is declarative
frontmatter metadata: `disable-model-invocation` is read by Claude Code and inert everywhere else,
and it is the only way to express "this skill is invoked by hand, never autonomously".

## How these are used

Each agent looks for skills in its own directory, so activate a skill by symlinking it from here —
this repo stays the single place you edit, and the change applies everywhere the symlinks point:

```sh
ln -s "$PWD/skills/tdd" ~/.claude/skills/tdd     # Claude Code (or a project's .claude/skills/)
ln -s "$PWD/skills/tdd" ~/.codex/skills/tdd      # another agent — adjust the path to its convention
```

Or link the whole set at once:

```sh
for d in "$PWD"/skills/*/; do ln -sfn "$d" ~/.claude/skills/"$(basename "$d")"; done
```

If an agent has no skills directory, the procedure still works read as-is: point the agent at the
`SKILL.md` (paste it, include it in the system prompt, or reference the file) and it will follow.

## Skills here

> **Port in progress.** The full set of 23 skills is being re-adapted together against
> [`docs/import-policy.md`](docs/import-policy.md). Skills marked *verbatim* below are currently
> unmodified upstream copies awaiting adaptation — the descriptions here describe the intended
> result, not what is on disk today. See `NOTICE.md` for per-file status.

- **[tdd](skills/tdd/SKILL.md)** — test-driven development: build features and fix bugs test-first, red-green-refactor. Reference material on [good and bad tests](skills/tdd/references/good-and-bad-tests.md) and [mocking](skills/tdd/references/mocking.md). Adapted from Matt Pocock's *tdd* skill.
- **[grilling](skills/grilling/SKILL.md)** — grill the user relentlessly about a plan, decision, or idea to stress-test their thinking, one question at a time. Adapted from Matt Pocock's *grilling* skill, extended with a facts-first opening move, a stopping heuristic keyed to the stakes, and a nudge toward structured question tools.
- **[to-spec](skills/to-spec/SKILL.md)** — synthesize a converged conversation into a spec — problem, solution, user stories, and the implementation and testing decisions already settled — written to `.scratch/<feature-slug>/spec.md`. No interview: it writes down a decision that was already made, and confirms only the test seams. Adapted from Matt Pocock's *to-spec* skill, stripped to local markdown output.
- **[to-tickets](skills/to-tickets/SKILL.md)** — break a plan or conversation into tracer-bullet vertical slices, each sized to one context window and declaring the tickets that block it, written to `.scratch/` as one markdown file per ticket. Includes the expand–contract sequence for wide refactors that can't be vertically sliced. Adapted from Matt Pocock's *to-tickets* skill, stripped to local markdown output.
- **[code-review](skills/code-review/SKILL.md)** — review a diff along two axes kept deliberately separate: **Standards** (repo conventions plus a smell baseline from Fowler's *Refactoring*) and **Spec** (does it do what was actually asked?). Neither axis is allowed to mask the other. Adapted from Matt Pocock's *code-review* skill.
- **[implement](skills/implement/SKILL.md)** — build the work from a spec or a set of `to-tickets` tickets: work the frontier one ticket at a time, drive real behaviour test-first with `tdd`, then check the result with `code-review`. The glue that connects the three. Adapted from Matt Pocock's *implement* skill.
- **[resolving-merge-conflicts](skills/resolving-merge-conflicts/SKILL.md)** — resolve an in-progress git merge or rebase: understand each side's intent from its commits and PRs, preserve both where possible, run the project's checks, then finish. Adapted from Matt Pocock's *resolving-merge-conflicts* skill.
- **[setup-skills](skills/setup-skills/SKILL.md)** — opt-in configuration for the skills that read or write an issue tracker: point them at GitHub, GitLab, or local markdown, set the triage label vocabulary, and choose the domain doc layout. Never a prerequisite — unconfigured, everything defaults to local markdown under `.scratch/`. Adapted from Matt Pocock's *setup-matt-pocock-skills* skill.
- **[codebase-design](skills/codebase-design/SKILL.md)** — shared vocabulary for designing **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam. Use when deciding where a seam goes, hunting deepening opportunities, or when another skill needs the deep-module language. Adapted from Matt Pocock's *codebase-design* skill.

## Provenance

Skills derived from [mattpocock/skills](https://github.com/mattpocock/skills) are ported under the
rules in [`docs/import-policy.md`](docs/import-policy.md) — layout, invocation, tracker handling,
naming, and attribution. Read it before adding or re-adapting one.

Every skill here now derives from [mattpocock/skills](https://github.com/mattpocock/skills). Book
summaries and source notes live in the
[knowledge-accumulation](https://github.com/amornsit/knowledge-accumulation) repo, which remains the
home for that material.

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
