# Import policy

Every skill here is ported from [mattpocock/skills](https://github.com/mattpocock/skills) at
`9603c1c`. The port is complete; this file is what outlives it — the rules that still bind, the
decisions worth not re-litigating, and how to take a change from upstream.

The full porting procedure that produced these 22 skills lived here and has been removed. Recover it
from git history (`git log --follow CONTRIBUTING.md`) if you ever re-run a port at that scale.

## Roster maintenance

`which-skill` is hand-written and hardcodes the roster. **Adding, removing, or renaming any skill
means updating, in the same commit:**

- `skills/which-skill/SKILL.md` — the routing prose
- `README.md` — "Skills here"
- `NOTICE.md` — the provenance table

A router that never mentions a new skill, or still routes to a deleted one, is a router that lies —
and it fails silently. This rule has already been broken twice: upstream's own router omits
`resolving-merge-conflicts`, and the `code-review` → `code-spec-review` rename here updated six
surfaces but missed the README label.

[`scripts/check-consistency.sh`](scripts/check-consistency.sh) enforces it, along with the other
conventions below, in both the pre-commit hook and CI. Run it directly any time:

```sh
bash scripts/check-consistency.sh
```

Two things it cannot do. Its built-in collision list is hand-maintained and will go stale — it is a
smoke alarm, not a guarantee, and the real test is loading the skills in a live session and counting
what registers. And it cannot judge prose: a description that over-promises what its body delivers
passes cleanly.

## Conventions a new skill must follow

- **Layout** — `skills/<name>/` with `SKILL.md`; `references/` for markdown loaded on demand,
  `scripts/` for anything executable, `agents/openai.yaml` for Codex metadata. Flat, no categories.
- **Invocation** — user-invoked in *both* harnesses or neither: `disable-model-invocation: true` in
  `SKILL.md` paired with `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. A
  user-invoked description is a human-facing one-liner; a model-invoked one carries one trigger per
  branch.
- **Output target** — a skill that writes to an issue must degrade gracefully: *"If no tracker has
  been configured, default to the local-markdown tracker,"* stated at the point of first tracker use.
  The local paths are specified in
  [`issue-tracker-local.md`](skills/setup-skills/references/issue-tracker-local.md), which is
  their single source of truth — read it rather than reinventing them.
- **Attribution** — an MIT footer naming what changed, and a `NOTICE.md` row. Depth is relative:
  `../../NOTICE.md` from `SKILL.md`, `../../../` from `references/`. A file designed to be *copied
  out* of this repo carries a self-contained notice instead, since a `NOTICE.md` link is dead at its
  destination.
- **Links** — point inside this repo, once per target at first mention.

## Decisions worth not re-litigating

- **`setup-skills` is optional, never a prerequisite.** Upstream gates its engineering flows behind
  setup; here, everything works unconfigured on local markdown. Setup changes the target, it doesn't
  unlock the skills.
- **`which-skill` is not a tracker skill.** It is a router: it cites tracker artifacts but writes
  nothing. An earlier draft put it on that list to hit a count, which manufactured a bug. A skill
  joins that list **by writing, never by arithmetic**.
- **`disable-model-invocation` is allowed in `SKILL.md`** despite being Claude-specific. It is
  declarative metadata, not instruction, and inert elsewhere — the portability rule bans
  vendor-specific instructions *in the procedure body*, and that ban still stands.
- **`grill-me` is a deliberate exception** to the rule that an alias must compose skills or fix a
  bad trigger. `grilling` is model-invoked, so its description is model-facing; `grill-me` is the
  only clean human-facing entry point.
- **Names must not collide with harness built-ins.** `code-review` was shadowed by Claude Code's
  own command — correctly written, correctly linked, and silently never registered. Check a new
  skill actually appears in a live session; no file-level check can catch this.

## Re-syncing from upstream

`NOTICE.md` pins every file to `9603c1c`. To see what has changed since:

```sh
gh api repos/mattpocock/skills/compare/9603c1c...main --jq '.files[].filename'
```

Cross-reference against `NOTICE.md`'s "Derived from" column. To diff a specific skill, restore the
vendored snapshot (gitignored):

```sh
git clone --depth 1 https://github.com/mattpocock/skills.git .upstream && rm -rf .upstream/.git
diff -u .upstream/skills/<bucket>/<name>/SKILL.md skills/<name>/SKILL.md
```

When you take a newer copy, update that file's **Copied at** in `NOTICE.md` to the SHA you took it
from.

## A caveat on this document

Parts of it were written *after* the situations they describe — the tracker-path contract came from
a collision it now prevents, the travelling-file rule from the script that needed it. That makes it
a fair guide going forward and a poor audit of what came before. Judge existing skills against the
upstream diff, not against this file.
