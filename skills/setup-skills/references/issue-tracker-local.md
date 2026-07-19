# Issue tracker: Local Markdown

Issues and specs (you may know a spec as a PRD) for this repo live as markdown files in `.scratch/`.
This is the default — skills assume it when no other tracker has been configured.

## Conventions

- One feature per directory: `.scratch/<feature-slug>/`
- **The slug is chosen once, by whichever skill writes for that feature first**, and is a kebab-case
  short name for the feature. Every later skill **reuses** it: list `.scratch/` and match against the
  existing directories before writing. Create a new directory only when nothing matches, and when two
  plausibly match, ask rather than guess. A spec and its tickets sharing one directory is the whole
  point of the convention — a second directory for the same feature silently splits it.
- The spec is `.scratch/<feature-slug>/spec.md`
- Implementation issues are one file per ticket at `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numbered from `01` — never a single combined tickets file
- Triage state is recorded as a `Status:` line near the top of each issue file (see `triage-labels.md` for the role strings)
- Comments and conversation history append to the bottom of the file under a `## Comments` heading

## When a skill says "publish to the issue tracker"

Create a new file under `.scratch/<feature-slug>/` (creating the directory if needed).

## When a skill says "fetch the relevant ticket"

Read the file at the referenced path. The user will normally pass the path or the issue number directly.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a file with one **child** file per ticket.

- **Map**: `.scratch/<effort>/map.md` — the Notes / Decisions-so-far / Fog body.
- **Child ticket**: `.scratch/<effort>/issues/NN-<slug>.md`, numbered from `01`, with the question in the body. A `Type:` line records the ticket type (`research`/`prototype`/`grilling`/`task`); a `Status:` line records `claimed`/`resolved`.
- **Blocking**: a `Blocked by: NN, NN` line near the top. A ticket is unblocked when every file it lists is `resolved`.
- **Frontier**: scan `.scratch/<effort>/issues/` for files that are open, unblocked, and unclaimed; first by number wins.
- **Claim**: set `Status: claimed` and save before any work.
- **Resolve**: append the answer under an `## Answer` heading, set `Status: resolved`, then append a context pointer (gist + link) to the map's Decisions-so-far in `map.md`.

---

*Adapted from Matt Pocock's "setup-matt-pocock-skills" skill (github.com/mattpocock/skills) — MIT ©
Matt Pocock. Reproduced, with a note added that this backend is the unconfigured default rather than
one option among equals. See [NOTICE.md](../../../NOTICE.md).*
