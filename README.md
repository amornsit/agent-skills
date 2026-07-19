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

All 22 derive from [mattpocock/skills](https://github.com/mattpocock/skills), ported under
[`docs/import-policy.md`](docs/import-policy.md). Start with
**[which-skill](skills/which-skill/SKILL.md)** if you don't know which one you want — it is the
router over everything below and how the flows connect.

Grouped by how they are reached. **User-invoked** skills fire only when you type their name, so they
cost no context; **model-invoked** skills can also fire on their own.

### The main flow: idea → ship

- **[grill-with-docs](skills/grill-with-docs/SKILL.md)** *(user)* — sharpen an idea by interview, leaving a paper trail in `CONTEXT.md` and ADRs. The on-ramp when you have a codebase.
- **[to-spec](skills/to-spec/SKILL.md)** *(user)* — synthesize a converged conversation into a spec. No interview: it writes down a decision already made.
- **[to-tickets](skills/to-tickets/SKILL.md)** *(user)* — split a spec or plan into tracer-bullet tickets, each sized to one context window and declaring its blocking edges.
- **[implement](skills/implement/SKILL.md)** *(user)* — build a ticket or spec, driving `tdd` internally and closing with `code-review`.
- **[tdd](skills/tdd/SKILL.md)** *(model)* — red → green at pre-agreed seams. Reference material on [good and bad tests](skills/tdd/references/good-and-bad-tests.md) and [mocking](skills/tdd/references/mocking.md).
- **[code-review](skills/code-review/SKILL.md)** *(model)* — review a diff along two axes kept deliberately separate: **Standards** (repo conventions plus a smell baseline from Fowler's *Refactoring*) and **Spec** (does it do what was actually asked?). Neither is allowed to mask the other.

### On-ramps

- **[triage](skills/triage/SKILL.md)** *(user)* — move incoming issues and external PRs through a state machine of triage roles, ending in agent-ready briefs.
- **[diagnosing-bugs](skills/diagnosing-bugs/SKILL.md)** *(model)* — refuses to theorise until it has one command that goes red on *this* bug, then fixes with a regression test.
- **[wayfinder](skills/wayfinder/SKILL.md)** *(user)* — chart a huge, foggy effort as a shared map of decision tickets, resolved one at a time until the way is clear. Produces decisions, not deliverables.

### Design and upkeep

- **[improve-codebase-architecture](skills/improve-codebase-architecture/SKILL.md)** *(user)* — scan for deepening opportunities, present them as a visual HTML report, then grill through the one you pick.
- **[codebase-design](skills/codebase-design/SKILL.md)** *(model)* — the deep-module vocabulary: a lot of behaviour behind a small interface at a clean seam.
- **[domain-modeling](skills/domain-modeling/SKILL.md)** *(model)* — sharpen the project's domain language and record hard-to-reverse decisions as ADRs.
- **[prototype](skills/prototype/SKILL.md)** *(model)* — a throwaway program answering one design question. Keep the answer, delete the code.

### Standalone

- **[grilling](skills/grilling/SKILL.md)** *(model)* — interrogate a plan one question at a time, resolving the decision tree in dependency order. The primitive beneath both grill wrappers.
- **[grill-me](skills/grill-me/SKILL.md)** *(user)* — the same interview with no codebase and no paper trail.
- **[resolving-merge-conflicts](skills/resolving-merge-conflicts/SKILL.md)** *(model)* — recover why each side made its change, preserve both where possible, run the project's checks, then finish.
- **[research](skills/research/SKILL.md)** *(model)* — delegate reading legwork to a sub-agent, which leaves a cited Markdown file behind.
- **[handoff](skills/handoff/SKILL.md)** *(user)* — compact a conversation into a document a fresh session can pick up. Forks, where compaction continues.
- **[teach](skills/teach/SKILL.md)** *(user)* — learn a concept over multiple sessions, using the current directory as a stateful workspace.
- **[writing-great-skills](skills/writing-great-skills/SKILL.md)** *(user)* — the house style for writing skills: context load, information hierarchy, leading words, failure modes.

### Configuration

- **[setup-skills](skills/setup-skills/SKILL.md)** *(user)* — **optional.** Point the tracker-aware skills at GitHub, GitLab, or local markdown. Never a prerequisite: unconfigured, everything defaults to local markdown under `.scratch/`.
- **[which-skill](skills/which-skill/SKILL.md)** *(user)* — the router above.

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
