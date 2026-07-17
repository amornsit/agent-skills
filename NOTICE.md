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
| `tdd/references/good-and-bad-tests.md` | `skills/engineering/tdd/tests.md` | `9603c1c` | Reproduced verbatim; attribution footer appended |
| `tdd/references/mocking.md` | `skills/engineering/tdd/mocking.md` | `9603c1c` | Reproduced, with minor Markdown formatting fixes; attribution footer appended |
| `grilling/SKILL.md` | `skills/productivity/grilling/SKILL.md` | `9603c1c` | Adapted and extended |
| `to-tickets/SKILL.md` | `skills/engineering/to-tickets/SKILL.md` | `9603c1c` | Adapted; stripped to local markdown output |
| `code-review/SKILL.md` | `skills/engineering/code-review/SKILL.md` | `9603c1c` | Adapted; both axes kept, smell baseline moved to `references/` |
| `code-review/references/code-smells.md` | the smell baseline in `skills/engineering/code-review/SKILL.md` | `9603c1c` | Reproduced, reformatted as a reference file and extended |
| `*/agents/openai.yaml` | that repo's `agents/openai.yaml` convention | `9603c1c` | Format followed; no content copied |

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

The `tdd` and `working-with-legacy-code` skills distill ideas from Kent Beck's
*Test-Driven Development: By Example* and Michael Feathers' *Working Effectively with
Legacy Code* respectively. Those books remain the property of their authors and
publishers; each skill cites its source. The wording of the skills is original.

`code-review/references/code-smells.md` names the code smells catalogued in Martin Fowler's
*Refactoring* (ch. 3). The wording of each entry comes from Matt Pocock's compression of that
catalogue (see the table above), not from the book itself; the book remains the property of its
author and publisher.
