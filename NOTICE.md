# Third-party notices

This repository is MIT licensed (see [LICENSE](LICENSE)). Portions of it are derived from
third-party MIT-licensed work, reproduced here with the required copyright and permission
notices.

## mattpocock/skills

Source: <https://github.com/mattpocock/skills>

The following files are copied from, or adapted from, that repository. **Copied at** records the
upstream commit the copy was taken from, so a later revision of that file upstream can be diffed
against what we took (see [Checking for upstream changes](#checking-for-upstream-changes) below).

| File here | Derived from | Copied at | Relationship |
|-----------|--------------|-----------|--------------|
| `skills/tdd/SKILL.md` | `skills/engineering/tdd/SKILL.md` | `9603c1c` | Adapted; sibling `tests.md`/`mocking.md` moved to `references/` with context pointers repointed and reworded to say when each loads, description collapsed its "red-green-refactor" synonym, links added to `codebase-design` and `code-review` |
| `skills/tdd/references/good-and-bad-tests.md` | `skills/engineering/tdd/tests.md` | `9603c1c` | Verbatim; renamed to say what it holds and moved under `references/` |
| `skills/tdd/references/mocking.md` | `skills/engineering/tdd/mocking.md` | `9603c1c` | Moved under `references/`; prose unchanged, bold pseudo-headings promoted to `###` for `MD036` |
| `skills/grilling/SKILL.md` | `skills/productivity/grilling/SKILL.md` | `9603c1c` | Adapted; body H1 added, redundant `'grill'` trigger branch dropped from the description, plus a local stopping heuristic keyed to the stakes of the decision |
| `skills/to-spec/SKILL.md` | `skills/engineering/to-spec/SKILL.md` | `9603c1c` | Adapted; tracker renamed to `/setup-skills` and the setup gate replaced by a local-markdown fallback at the publish step, plus a local handoff to `to-tickets` and `implement` |
| `skills/to-tickets/SKILL.md` | `skills/engineering/to-tickets/SKILL.md` | `9603c1c` | Adapted; tracker renamed to `/setup-skills`, setup gate replaced with a local-markdown default restated at the publish step, both backends kept, description rewritten human-facing |
| `skills/code-review/SKILL.md` | `skills/engineering/code-review/SKILL.md` | `9603c1c` | Adapted; setup gate replaced with a local-markdown tracker fallback at first tracker use, `codebase-design` pointer added, description triggers collapsed, smell baseline kept inline |
| `skills/implement/SKILL.md` | `skills/engineering/implement/SKILL.md` | `9603c1c` | Adapted; `/tdd` and `/code-review` turned into cross-skill links, `to-spec`/`to-tickets` named as inputs, ticket-fetch paragraph added with the local-markdown tracker fallback |
| `skills/resolving-merge-conflicts/SKILL.md` | `skills/engineering/resolving-merge-conflicts/SKILL.md` | `9603c1c` | Adapted; procedure kept verbatim, `# H1` added for `MD041`, description rewritten to front-load its leading word |
| `skills/setup-skills/SKILL.md` | `skills/engineering/setup-matt-pocock-skills/SKILL.md` | `9603c1c` | Adapted; renamed and de-branded, reframed from a mandatory first run into opt-in configuration over a local-markdown default |
| `skills/setup-skills/references/issue-tracker-local.md` | `skills/engineering/setup-matt-pocock-skills/issue-tracker-local.md` | `9603c1c` | Reproduced; noted as the unconfigured default rather than one option among equals, and the Wayfinding section's `<effort>` namespace reconciled with Conventions' `<feature-slug>`, with decision tickets moved to `wayfinding/` so they cannot collide with `issues/` on `NN` |
| `skills/setup-skills/references/issue-tracker-github.md` | `skills/engineering/setup-matt-pocock-skills/issue-tracker-github.md` | `9603c1c` | Reproduced; "PRDs" reworded to this repo's "spec" vocabulary |
| `skills/setup-skills/references/issue-tracker-gitlab.md` | `skills/engineering/setup-matt-pocock-skills/issue-tracker-gitlab.md` | `9603c1c` | Reproduced; "PRDs" reworded to this repo's "spec" vocabulary |
| `skills/setup-skills/references/triage-labels.md` | `skills/engineering/setup-matt-pocock-skills/triage-labels.md` | `9603c1c` | Reproduced; left-hand column relabelled "Canonical role" |
| `skills/setup-skills/references/domain.md` | `skills/engineering/setup-matt-pocock-skills/domain.md` | `9603c1c` | Reproduced; references to skills outside this repo's roster replaced with the behaviour they described |
| `skills/codebase-design/SKILL.md` | `skills/engineering/codebase-design/SKILL.md` | `9603c1c` | Adapted; description tightened to one trigger per branch, sibling files moved to `references/` |
| `skills/codebase-design/references/deepening.md` | `skills/engineering/codebase-design/DEEPENING.md` | `9603c1c` | Reproduced as reference material; renamed and links repointed |
| `skills/codebase-design/references/design-it-twice.md` | `skills/engineering/codebase-design/DESIGN-IT-TWICE.md` | `9603c1c` | Reproduced as reference material; renamed and links repointed |
| `skills/writing-great-skills/SKILL.md` | `skills/productivity/writing-great-skills/SKILL.md` | `9603c1c` | Reproduced as this repo's house style guide; `GLOSSARY.md` moved to `references/` with its context pointers repointed |
| `skills/writing-great-skills/references/glossary.md` | `skills/productivity/writing-great-skills/GLOSSARY.md` | `9603c1c` | Reproduced as reference material; renamed and link back to the skill repointed |
| `skills/diagnosing-bugs/SKILL.md` | `skills/engineering/diagnosing-bugs/SKILL.md` | `9603c1c` | Adapted; description tightened to one trigger per branch, cross-skill handoffs repointed into this repo |
| `skills/diagnosing-bugs/scripts/hitl-loop.template.sh` | `skills/engineering/diagnosing-bugs/scripts/hitl-loop.template.sh` | `9603c1c` | Reproduced verbatim |
| `skills/domain-modeling/SKILL.md` | `skills/engineering/domain-modeling/SKILL.md` | `9603c1c` | Adapted; description tightened to one trigger per branch, sibling files moved to `references/`, file-structure trees aligned with the layout `setup-skills` documents for consuming skills |
| `skills/domain-modeling/references/adr-format.md` | `skills/engineering/domain-modeling/ADR-FORMAT.md` | `9603c1c` | Reproduced as reference material; renamed, with a note added on where context-scoped ADRs live in a multi-context repo |
| `skills/domain-modeling/references/context-format.md` | `skills/engineering/domain-modeling/CONTEXT-FORMAT.md` | `9603c1c` | Reproduced as reference material; renamed and "the skill infers" rewritten as a direct instruction |
| `skills/prototype/SKILL.md` | `skills/engineering/prototype/SKILL.md` | `9603c1c` | Adapted; sibling files moved to `references/` with acronyms expanded, branch pointers rewritten to say when to load each file, local-markdown tracker fallback added |
| `skills/prototype/references/logic-prototypes.md` | `skills/engineering/prototype/LOGIC.md` | `9603c1c` | Reproduced as reference material; renamed and links repointed |
| `skills/prototype/references/ui-prototypes.md` | `skills/engineering/prototype/UI.md` | `9603c1c` | Reproduced as reference material; renamed and links repointed |
| `skills/research/SKILL.md` | `skills/engineering/research/SKILL.md` | `9603c1c` | Adapted; description collapsed to one trigger per branch, and the delegation step reworded from a harness-specific "background agent" to a portable sub-agent instruction |
| `skills/triage/SKILL.md` | `skills/engineering/triage/SKILL.md` | `9603c1c` | Adapted; siblings moved to `references/`, tracker fallback and label-mapping degradation added, cross-skill links repointed |
| `skills/triage/references/agent-brief.md` | `skills/engineering/triage/AGENT-BRIEF.md` | `9603c1c` | Renamed from `AGENT-BRIEF.md`; guidance reproduced, GitHub-specific wording de-vendored |
| `skills/triage/references/out-of-scope.md` | `skills/engineering/triage/OUT-OF-SCOPE.md` | `9603c1c` | Renamed from `OUT-OF-SCOPE.md`; reproduced, fences tagged and nested for lint |
| `skills/wayfinder/SKILL.md` | `skills/engineering/wayfinder/SKILL.md` | `9603c1c` | Adapted; tracker renamed to `/setup-skills` and its setup gate dropped, fallback restated at the map-creation step with local-markdown paths, research/prototype/grilling/domain-modeling handoffs linked |
| `skills/improve-codebase-architecture/SKILL.md` | `skills/engineering/improve-codebase-architecture/SKILL.md` | `9603c1c` | Adapted; `HTML-REPORT.md` moved to `references/` with its context pointer repointed, slash commands turned into cross-skill links |
| `skills/improve-codebase-architecture/references/html-report.md` | `skills/engineering/improve-codebase-architecture/HTML-REPORT.md` | `9603c1c` | Reproduced; renamed and moved under `references/`, `codebase-design` mentions turned into links |
| `skills/handoff/SKILL.md` | `skills/productivity/handoff/SKILL.md` | `9603c1c` | Reproduced verbatim; `# H1` added for `MD041`, no other change |
| `skills/teach/SKILL.md` | `skills/productivity/teach/SKILL.md` | `9603c1c` | Adapted; sibling `*-FORMAT.md` files moved to `references/` with pointers repointed, upstream's orphaned `GLOSSARY-FORMAT.md` given the pointer it never had, and a `research` handoff added |
| `skills/teach/references/mission-format.md` | `skills/productivity/teach/MISSION-FORMAT.md` | `9603c1c` | Reproduced verbatim as reference material; renamed |
| `skills/teach/references/resources-format.md` | `skills/productivity/teach/RESOURCES-FORMAT.md` | `9603c1c` | Reproduced as reference material; renamed, with the back-link to `SKILL.md` repointed a directory up |
| `skills/teach/references/glossary-format.md` | `skills/productivity/teach/GLOSSARY-FORMAT.md` | `9603c1c` | Reproduced verbatim as reference material; renamed |
| `skills/teach/references/learning-record-format.md` | `skills/productivity/teach/LEARNING-RECORD-FORMAT.md` | `9603c1c` | Reproduced verbatim as reference material; renamed |
| `skills/grill-me/SKILL.md` | `skills/productivity/grill-me/SKILL.md` | `9603c1c` | Body H1 added; `/grilling` slash command converted to a cross-skill link. Otherwise verbatim |
| `skills/grill-with-docs/SKILL.md` | `skills/engineering/grill-with-docs/SKILL.md` | `9603c1c` | Body H1 added; `/grilling` and `/domain-modeling` slash commands converted to cross-skill links. Otherwise verbatim |
| `skills/which-skill/SKILL.md` | `skills/engineering/ask-matt/SKILL.md` | `9603c1c` | Adapted; renamed from `ask-matt`, `setup-skills` demoted from precondition to optional configuration, `/compact` generalised from a Claude Code built-in, `resolving-merge-conflicts` added (unrouted upstream), slash commands turned into links |
| `skills/*/agents/openai.yaml` | that repo's `agents/openai.yaml` convention | `9603c1c` | Format followed; no content copied |

### Checking for upstream changes

Every copy above was taken from upstream `9603c1c` (`main` as of 2026-07-17). To see whether
anything we derived from has changed upstream since:

```sh
gh api repos/mattpocock/skills/compare/9603c1c...main --jq '.files[].filename'
```

Cross-reference the output against the "Derived from" column. Note that these files each last
changed upstream well before our copy point — `tests.md` at `43ea088`, `mocking.md` at `62f43a1`,
`grilling/SKILL.md` at `170ad48` — so the copies are of settled, not in-flight, versions.

When copying a new file from that repo, add a row and set **Copied at** to the upstream `main` SHA
you took it from — `gh api repos/mattpocock/skills/commits/main --jq '.sha[0:7]'`.

Original notice:

```text
MIT License

Copyright (c) 2026 Matt Pocock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Book-derived material

`skills/code-review/SKILL.md` names the code smells catalogued in Martin Fowler's *Refactoring*
(ch. 3). The wording of each entry comes from Matt Pocock's compression of that catalogue (see the
table above), not from the book itself; the book remains the property of its author and publisher.
