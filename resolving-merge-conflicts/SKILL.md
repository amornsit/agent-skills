---
name: resolving-merge-conflicts
description: Resolve an in-progress git merge or rebase conflict — understand each side's intent, preserve both where possible, then run the project's checks and finish. Use when a merge or rebase has stopped with conflicts to resolve.
---

# Resolving Merge Conflicts

1. **See the current state** of the merge/rebase. Check git history, and the conflicting files.

2. **Find the primary sources** for each conflict. Understand deeply why each change was made, and
   what the original intent was. Read the commit messages, check the PRs, check original
   issues/tickets.

3. **Resolve each hunk.** Preserve both intents where possible. Where incompatible, pick the one
   matching the merge's stated goal and note the trade-off. Do **not** invent new behaviour. Always
   resolve; never `--abort`.

4. Discover the project's **automated checks** and run them — typically typecheck, then tests, then
   format. Fix anything the merge broke.

5. **Finish the merge/rebase.** Stage everything and commit. If rebasing, continue the rebase process
   until all commits are rebased.

---

*Adapted from Matt Pocock's "resolving-merge-conflicts" skill (github.com/mattpocock/skills) —
MIT © Matt Pocock. Reproduced with a body heading and a richer trigger description; the procedure is
unchanged. See [NOTICE.md](../NOTICE.md).*
