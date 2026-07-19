---
name: setup-skills
description: Point this repo's engineering skills at an issue tracker, triage label vocabulary, and domain doc layout. Optional — the skills work without it.
disable-model-invocation: true
---

# Setup Skills

Scaffold the per-repo configuration the engineering skills read:

- **Issue tracker** — where issues live (local markdown, GitHub, GitLab, or a workflow you describe)
- **Triage labels** — the strings used for the five canonical triage roles
- **Domain docs** — where `CONTEXT.md` and ADRs live, and the consumer rules for reading them

**This is opt-in, not a prerequisite.** Every skill that reads a tracker defaults to the local
markdown tracker — `.scratch/<feature-slug>/spec.md` and `.scratch/<feature-slug>/issues/NN-<slug>.md`
— when no configuration exists. Run this skill when you want to point them somewhere else, or to
change a target already configured. A repo that never runs it still works.

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm
with the user, then write.

## Process

### 1. Explore

Look at the current repo to understand its starting state. Read whatever exists; don't assume:

- `git remote -v` and `.git/config` — is this a GitHub repo? Which one?
- `AGENTS.md` and `CLAUDE.md` at the repo root — does either exist? Is there already an `## Agent skills` section in either?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?
- `.scratch/` — sign that the local-markdown tracker is already in use
- Is the `triage` skill installed? (a `triage` skill folder alongside this one, or `triage` in your available skills.) This decides whether Section B runs at all.
- Monorepo signals — a `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or a populated `packages/*` with its own `src/`. Present only in a genuinely large multi-package repo; their absence means single-context, which is almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing. Then take the sections in order — one section, one answer, then the next.

Lead each section with the recommended answer so the user can accept it in a word. Give a one-line explainer only when the choice genuinely branches; skip the section entirely when exploration already settled it (Section B when `triage` isn't installed, Section C when there's no monorepo).

**Section A — Issue tracker.**

> Explainer: The "issue tracker" is where issues live for this repo. Skills like [to-tickets](../to-tickets/SKILL.md), [triage](../triage/SKILL.md), [to-spec](../to-spec/SKILL.md), [wayfinder](../wayfinder/SKILL.md), and [code-review](../code-spec-review/SKILL.md) read from and write to it — they need to know whether to call `gh issue create`, write a markdown file under `.scratch/`, or follow some other workflow you describe. Pick the place you actually track work for this repo.

Default posture: local markdown, which is what the skills assume when unconfigured — propose it unless the repo says otherwise. If a `git remote` points at GitHub, propose GitHub instead; if a remote points at GitLab (`gitlab.com` or a self-hosted host), propose GitLab. The full set:

- **Local markdown** — issues live as files under `.scratch/<feature>/` in this repo (good for solo projects or repos without a remote)
- **GitHub** — issues live in the repo's GitHub Issues (uses the `gh` CLI)
- **GitLab** — issues live in the repo's GitLab Issues (uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI)
- **Other** (Jira, Linear, etc.) — ask the user to describe the workflow in one paragraph; the skill will record it as freeform prose

Record the choice in `docs/agents/issue-tracker.md`. The GitHub and GitLab templates carry a "PRs as a request surface" flag, defaulted **off** — leave it off and don't raise it; a user who wants external PRs in the triage queue can flip the flag in the file later.

**Section B — Triage label vocabulary.** Skip this section entirely if the `triage` skill isn't installed (exploration told you) — an uninstalled skill needs no labels.

If it is installed, ask exactly one question:

> Do you want to keep the default triage labels? (recommended: **yes**)

The defaults are the five canonical roles, each label string equal to its name: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. On **yes**, write them as-is. Only if the user says no — usually because their tracker already uses other names (e.g. `bug:triage` for `needs-triage`) — collect the overrides so `triage` applies existing labels instead of creating duplicates.

**Section C — Domain docs.** Default to **single-context** — one `CONTEXT.md` + `docs/adr/` at the repo root. This fits almost every repo; write it without asking.

Offer **multi-context** — a root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files — only when exploration found monorepo signals. Then confirm which layout they want.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, and `docs/agents/triage-labels.md` (the last only when `triage` is installed)

Let them edit before writing.

### 4. Write

**Pick the file to edit:**

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create — don't pick for them.

Never create `AGENTS.md` when `CLAUDE.md` already exists (or vice versa) — always edit the one that's already there.

If an `## Agent skills` block already exists in the chosen file, update its contents in-place rather than appending a duplicate. Don't overwrite user edits to the surrounding sections.

The block:

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

Include the `### Triage labels` sub-block, and write `docs/agents/triage-labels.md`, only when `triage` is installed and Section B ran. When it isn't, both are omitted.

Then write the docs files using the seed templates in this skill's `references/` as a starting point:

- [issue-tracker-local.md](./references/issue-tracker-local.md) — local-markdown issue tracker
- [issue-tracker-github.md](./references/issue-tracker-github.md) — GitHub issue tracker
- [issue-tracker-gitlab.md](./references/issue-tracker-gitlab.md) — GitLab issue tracker
- [triage-labels.md](./references/triage-labels.md) — label mapping (only if `triage` is installed)
- [domain.md](./references/domain.md) — domain doc consumer rules + layout

Each template carries an attribution footer for this repo's provenance records — drop it when
copying the template into the user's repo, where it points nowhere.

For "other" issue trackers, write `docs/agents/issue-tracker.md` from scratch using the user's description.

### 5. Done

Tell the user which engineering skills will now read from these files, and that the tracker target
has changed from the local-markdown default to whatever they picked (or stayed on it). Mention they
can edit `docs/agents/*.md` directly later — re-running this skill is only necessary if they want to
switch issue trackers or restart from scratch.

---

*Adapted from Matt Pocock's "setup-matt-pocock-skills" skill (github.com/mattpocock/skills) — MIT ©
Matt Pocock. Renamed to `setup-skills` and de-branded; reframed from a mandatory first run into
opt-in configuration over a local-markdown default; the seed templates moved to `references/`, the
consuming-skill list repointed at this repo's roster, and the `policy` block moved to `agents/`. See
[NOTICE.md](../../NOTICE.md).*
