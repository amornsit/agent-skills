# Import policy

How a skill from [mattpocock/skills](https://github.com/mattpocock/skills) becomes a skill here.
Every rule below is a decision that was made deliberately — follow it, and when a skill gives you a
reason to break it, say so rather than breaking it quietly.

The upstream copy point is **`9603c1c`**. Recreate the vendored snapshot with:

```sh
git clone --depth 1 https://github.com/mattpocock/skills.git .upstream && rm -rf .upstream/.git
```

`.upstream/` is gitignored. It exists so every adaptation can be justified as a diff.

## The rule that governs the rest

**Adapt against the diff, never from memory.** Before editing a ported skill, run:

```sh
diff -u .upstream/skills/<category>/<name>/SKILL.md skills/<name>/SKILL.md
```

Every hunk is a decision you are making or inheriting. An adaptation you cannot justify out loud is
one to revert. This is the whole reason the snapshot is vendored — adapting one-by-one let earlier
choices become invisible givens, and this exercise exists to stop that.

House style is [`writing-great-skills`](../skills/writing-great-skills/SKILL.md) once ported — its
vocabulary (context load, information hierarchy, leading words, the failure modes) is the standard
these skills are held to.

**Formatting hunks are not decisions.** Reflowing to 100 columns, normalising emphasis to satisfy
`MD049`, and tagging code fences are expected, unremarkable diff noise — make them without
justifying them. Emphasis style is enforced *per file*, so match whatever the file already uses
rather than imposing one repo-wide.

## 0. The roster

All 22 upstream `engineering/` and `productivity/` skills are in scope. **This list is the
authority** — never take a roster from a task prompt, which may be incomplete.

```text
code-spec-review codebase-design   diagnosing-bugs   domain-modeling
grill-me         grill-with-docs   grilling          handoff
implement        improve-codebase-architecture       prototype
research         resolving-merge-conflicts           setup-skills   (←setup-matt-pocock-skills)
tdd              teach             to-spec           to-tickets
triage           wayfinder         which-skill       (←ask-matt)
writing-great-skills
```

Upstream's `deprecated/`, `in-progress/`, `misc/`, and `personal/` trees are **out** of scope — a
reference to anything in them (e.g. `qa`) is the off-roster case in §4.

## 1. Layout

```text
skills/<name>/
  SKILL.md          # frontmatter + procedure — the portable core
  agents/
    openai.yaml     # Codex interface metadata
  references/       # material disclosed out of SKILL.md, loaded on demand
  scripts/          # executable assets the skill runs or tells the user to copy
```

- Flat under `skills/`. No category directories — upstream's own boundaries are arbitrary
  (`grilling` is productivity, its one-line wrapper `grill-with-docs` is engineering).
- Upstream sibling files (`mocking.md`, `LOGIC.md`, `UI.md`, `HTML-REPORT.md`, `GLOSSARY.md`, …)
  become `references/<kebab-case-name>.md`. Update the context pointer in `SKILL.md` to match.
- Skill directory name is the `name:` field, kebab-case, and must be globally unique — agents
  install skills flat, so `skills/tdd/` lands at `~/.claude/skills/tdd`.
- Reference filenames lowercase the upstream name and keep its hyphens: `DESIGN-IT-TWICE.md` →
  `design-it-twice.md`. Expand bare acronyms so the filename says what it holds: `UI.md` →
  `ui-prototypes.md`, not `ui.md`.
- **Port non-markdown assets verbatim into `scripts/`, keeping the upstream filename and the
  executable bit.** A shell template the skill cites by path is content, not prose — never replace
  one with a description of what it does. `references/` is for markdown; `scripts/` is for
  everything the agent or user actually runs.
- Every `SKILL.md` needs a body `# H1` after the frontmatter. Upstream skills routinely open on
  prose; `MD041` rejects that here.

## 2. Invocation

A skill is user-invoked in **both** harnesses or neither. Keep these in sync:

| Invocation | `SKILL.md` frontmatter | `agents/openai.yaml` | `description` |
|---|---|---|---|
| **Model-invoked** | omit `disable-model-invocation` | omit `policy` block | model-facing, rich triggers |
| **User-invoked** | `disable-model-invocation: true` | `policy.allow_implicit_invocation: false` | human-facing one-liner |

- **Default to upstream's choice.** It reflects real use. Override only with a stated reason.
- **User-invoked descriptions get rewritten**, not copied: strip "Use when the user says…" trigger
  lists down to a one-line summary a human reads in a slash-command menu. Where upstream's is already
  a clean human-facing one-liner, keeping it verbatim is a valid outcome — verify, don't churn.
- The same applies to `agents/openai.yaml`: upstream sometimes already ships the `policy` block this
  section asks for. Check before editing; a no-op is the correct result there.
- **Model-invoked descriptions keep one trigger per branch.** Synonyms renaming a single branch are
  duplication — collapse them.
- `disable-model-invocation` is a Claude Code field and is inert elsewhere. It is permitted in
  `SKILL.md` because it is declarative metadata, not instruction. The portability principle bans
  vendor-specific instructions **in the procedure body** — that ban still stands. The same reasoning
  covers any other declarative frontmatter key upstream carries, such as `argument-hint`: keep them.
- `interface.short_description` in `agents/openai.yaml` is a **human-facing blurb for a skill
  picker**, not a copy of `description`. Write it fresh: under ~60 characters, no trigger phrasing,
  no trailing period. Rewriting upstream's is expected and needs no justification.

## 3. Output target (the tracker)

Eight skills read or write an issue tracker: `to-spec`, `to-tickets`, `triage`, `wayfinder`,
`code-spec-review`, `which-skill`, `implement` — which upstream does not flag, but which consumes tickets
from the tracker and is `to-tickets`' handoff target — and `prototype`, which records its verdict on
the implementation issue. All eight need the same guarantee.

If a skill you are porting writes to an issue and is not on this list, it belongs on it: add the
fallback and say so in your report rather than leaving the write unpinned.

- The mechanism is [`setup-skills`](../skills/setup-skills/SKILL.md), which writes a tracker doc the
  others consult. Upstream calls this `setup-matt-pocock-skills`; rename every reference.
- **Setup is opt-in, never a prerequisite.** Upstream only guarantees the fallback in `wayfinder`;
  give all eight the same guarantee, in these words or close to them:

  > If no tracker has been configured, default to the local-markdown tracker.

  Upstream's "run `/setup-skills` if not" phrasing, used alone, is a bug here — it pushes an
  unconfigured repo into setup instead of degrading gracefully. Mention setup as the way to *change*
  the target, not as a gate before first use.
- **Put the fallback sentence at the point of first tracker use**, not only in a preamble. A reader
  who jumps straight to the publish step must still meet it there.
- Name `setup-skills` as a bare slash command (`/setup-skills`) rather than linking its `SKILL.md`.
  The tracker skills mention it in passing; a link implies the reader should go read it.
- The local backend is specified in `skills/setup-skills/references/issue-tracker-local.md` — the
  single source of truth for it. **Read that file rather than reinventing the paths.** One directory
  per feature, its slug chosen by whichever skill writes first and reused by every skill after:

  ```text
  .scratch/<feature-slug>/spec.md                  # to-spec
  .scratch/<feature-slug>/map.md                   # wayfinder
  .scratch/<feature-slug>/issues/NN-<slug>.md      # to-tickets, implement
  .scratch/<feature-slug>/wayfinding/NN-<slug>.md  # wayfinder decision tickets
  ```

  Decision tickets and implementation tickets keep **separate numbering** — both count from `01`, so
  sharing `issues/` would let `to-tickets` overwrite `wayfinder`'s resolved decisions.
- **Mentioning a tracker artifact by path or URL is not a write.** A skill that only reads or cites
  one does not join this list.

## 4. Naming

- `setup-matt-pocock-skills` → **`setup-skills`**
- `ask-matt` → **`which-skill`**
- Attribution belongs in [`NOTICE.md`](../NOTICE.md), not in a skill name.
- Cross-skill references point inside this repo — `[tdd](../tdd/SKILL.md)` written as a real link
  from one skill to another — and slash-command mentions use the renamed command.
- **Link freely to any skill on the roster, ported or not.** Mid-port the target may not exist yet;
  that is expected and is not a reason to weaken the link. `lychee` runs once when the roster is
  complete, not per skill. "Freely" governs *whether the target existing yet matters* — not how many
  links to add.
- **Link a target once per skill**, at the first place the text names it. Later mentions stay prose —
  three links to the same file is noise, not navigation.
- **Add a link only where the text already implies the handoff.** Convert a slash command or a named
  skill into a link; follow a reach clause in the target's own description where the subject genuinely
  matches. Do not wire in neighbouring skills because the workflow suggests they belong — a glue skill
  like `implement` would otherwise accumulate half the roster. When you add a link upstream did not
  name, say so in your report and in the footer.
- When upstream references a skill that is **not** on our roster (e.g. `qa`, which lives in
  upstream's `deprecated/`), replace the reference with the behaviour it described. Do not name a
  skill this repo does not ship, and do not silently delete the guidance.

## 5. Aliases

A thin alias skill earns a slot when it **composes** skills or fixes a genuinely bad trigger.
`grill-with-docs` qualifies on composition. `grill-me` does not — it is a nicer name for a directly
typeable command — and is ported as a **deliberate exception**, because `grilling` is model-invoked
and so carries a model-facing description, leaving no clean human-facing entry in the picker.

Treat that as the bar for any future alias: composition, a broken trigger, or a model-invoked skill
with no human-facing entry point. Not preference.

## 6. Attribution

Every ported file gets a footer:

```markdown
*Adapted from Matt Pocock's "<name>" skill (github.com/mattpocock/skills) — MIT © Matt Pocock.
<One sentence naming what changed here, including any local extension.> See [NOTICE.md](<path>).*
```

- **Link depth is relative — count it, don't copy it.** From `skills/<name>/SKILL.md` that is
  `../../NOTICE.md`; from `skills/<name>/references/<file>.md` it is `../../../NOTICE.md`.
- **Placement:** last thing in the file, preceded by a `---` thematic break, set in italics.
- **Name local extensions in the footer.** An addition with no upstream equivalent is the one thing
  a future reader cannot recover from the diff alone, so it has to be stated.
- **Template files are exempt.** A reference file that exists to be *copied into the user's repo*
  (the `issue-tracker-*.md` seeds) carries a footer that would become dead weight at its
  destination. Keep the footer in this repo and instruct the skill to strip it on copy.
  **The test is whether the file itself travels.** A file that *contains* a fenced template the
  skill transcribes is read in place and is not exempt; only a file that gets copied wholesale is.
- **Removals count as local changes too.** De-vendoring a harness-specific instruction, or dropping
  upstream guidance, is exactly the kind of hunk a reader would otherwise misread as cosmetic. Name
  it.
- **"Reproduced verbatim" is a complete sentence.** When a port is deliberately unchanged, say so
  plainly. Never invent an adaptation to fill the slot.
- **Editing a file another skill owns** — as `wayfinder` did to `issue-tracker-local.md` — means
  updating that file's footer and its `NOTICE.md` row too, not your own.

Add a row to `NOTICE.md` with **File here**, **Derived from**, **Copied at** (`9603c1c`), and
**Relationship** — a short phrase describing the adaptation, matching the footer.

## 7. Roster maintenance

`which-skill` is hand-written and hardcodes the roster. Adding, removing, or renaming any skill means
updating, in the same commit:

- `which-skill/SKILL.md`
- `README.md` — "Skills here"
- `NOTICE.md` — the provenance table

## Checklist per skill

- [ ] `diff -u` against `.upstream/` reviewed; every hunk justified
- [ ] Lands at `skills/<name>/` with `agents/openai.yaml`
- [ ] Sibling files moved to `references/`, context pointers updated
- [ ] Invocation set in both harnesses, description rewritten to match the audience
- [ ] `interface.short_description` written fresh for a picker, not copied from `description`
- [ ] Tracker references renamed, fallback stated at the point of first tracker use
- [ ] Cross-skill links repointed into this repo; off-roster references replaced with behaviour
- [ ] Attribution footer added at the correct depth, local extensions named, `NOTICE.md` row added
- [ ] Non-markdown assets ported to `scripts/`, verbatim, executable bit preserved
- [ ] `markdownlint-cli2` reports no issues **in your skill's files**. The repo config's `globs` key
      widens any path argument to `**/*.md`, so a run always reports other skills' failures too —
      those belong to skills still awaiting adaptation. Ignore them; fix only your own.
      (`lychee` runs once at the end of the port, not per skill.)
