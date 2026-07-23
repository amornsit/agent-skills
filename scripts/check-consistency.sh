#!/usr/bin/env bash
#
# Consistency checks for the skills roster.
#
# Every check here maps to a defect that actually shipped, not a hypothetical.
# markdownlint catches style and lychee catches dead links; these catch the
# things that fail *silently* — a router that no longer mentions a skill, a
# skill that is user-invoked in one harness and model-invoked in another, or a
# name a harness built-in quietly shadows.
#
# Usage: bash scripts/check-consistency.sh
# Exits non-zero on the first category that fails, after reporting all of them.

set -uo pipefail
cd "$(dirname "$0")/.."

fail=0
note() { printf '  %s\n' "$1"; fail=1; }
ok()   { printf '\033[32m  ok\033[0m\n'; }
head_() { printf '\n%s\n' "$1"; }

# Frontmatter only — writing-great-skills DISCUSSES disable-model-invocation in
# its prose, so a whole-file grep gives a false positive.
frontmatter() { awk '/^---$/{n++; next} n==1' "$1"; }

skills=$(find skills -mindepth 1 -maxdepth 1 -type d | sort)

# --- 1. roster sync -----------------------------------------------------------
head_ "1. Roster appears in which-skill, README, and NOTICE"
for d in $skills; do
  n=$(basename "$d")
  grep -q "\b$n\b"            skills/which-skill/SKILL.md || note "$n missing from which-skill"
  grep -q "skills/$n/SKILL.md" README.md                  || note "$n missing from README"
  grep -q "\`skills/$n/"       NOTICE.md                   || note "$n missing from NOTICE.md"
done
# ...and nothing stale pointing at a skill that no longer exists.
grep -oE '\(skills/[a-z-]+/SKILL\.md\)' README.md | tr -d '()' | sort -u | while read -r p; do
  [ -e "$p" ] || note "README links a skill that does not exist: $p"
done
grep -oE '^\| `skills/[^`*]+`' NOTICE.md | tr -d '|` ' | while read -r p; do
  [ -e "$p" ] || note "NOTICE.md row for a file that does not exist: $p"
done
[ $fail -eq 0 ] && ok

# --- 2. invocation pair -------------------------------------------------------
head_ "2. Invocation flags agree across both harnesses"
before=$fail
for d in $skills; do
  n=$(basename "$d")
  frontmatter "$d/SKILL.md" | grep -q '^disable-model-invocation: true' && a=1 || a=0
  grep -q 'allow_implicit_invocation: false' "$d/agents/openai.yaml" 2>/dev/null && b=1 || b=0
  [ "$a" = "$b" ] || note "$n: SKILL.md=$a openai.yaml=$b — user-invoked in both or neither"
done
[ $fail -eq $before ] && ok

# --- 3. built-in collisions ---------------------------------------------------
# A skill whose name a harness already uses is silently shadowed: correctly
# written, correctly linked, and never registered. This list is hand-maintained
# and WILL go stale — it is a smoke alarm, not a guarantee. The real test is
# loading the skills in a live session and counting what appears.
head_ "3. No skill name collides with a known harness built-in"
before=$fail
builtins="code-review review security-review init verify simplify run loop schedule
update-config keybindings-help fewer-permission-prompts claude-api claude-in-chrome
deep-research dataviz artifact-design artifact-capabilities skill-creator help clear
config compact resume model agents hooks mcp memory status cost doctor login logout
permissions terminal-setup export ide todos upgrade"
for d in $skills; do
  n=$(basename "$d")
  for b in $builtins; do
    [ "$n" = "$b" ] && note "$n collides with the built-in /$b — it will be shadowed"
  done
done
[ $fail -eq $before ] && ok

# --- 4. tracker fallback ------------------------------------------------------
head_ "4. Tracker skills degrade to local markdown when unconfigured"
before=$fail
for n in to-spec to-tickets triage wayfinder code-spec-review implement prototype file-ticket \
         ticket-commit; do
  # The sentence wraps across lines, so normalise whitespace before matching.
  tr '\n' ' ' < "skills/$n/SKILL.md" | grep -q 'no tracker has been configured' \
    || note "$n missing the local-markdown fallback"
done
[ $fail -eq $before ] && ok

# --- 5 & 6. attribution and footer depth --------------------------------------
# Files written here, rather than ported, have nothing upstream to attribute.
# They declare themselves in NOTICE.md's "Original to this repo" table and are
# held to the NOTICE-row requirement only. Anything NOT in that table is assumed
# ported and must carry a footer — so a genuinely new file that forgets to
# declare itself still fails loudly.
originals=$(awk '/^## Original to this repo/{o=1; next} /^## /{o=0} o' NOTICE.md \
  | grep -oE '^\| `[^`]+`' | tr -d '|` ')

head_ "5 & 6. Every ported file is attributed, at the right link depth"
before=$fail
while read -r f; do
  grep -q "\`$f\`" NOTICE.md || note "$f has no NOTICE.md row"
  if printf '%s\n' "$originals" | grep -qx "$f"; then continue; fi
  grep -q 'mattpocock' "$f" || note "$f has no attribution footer"
  case "$f" in
    skills/*/references/*) want='../../../NOTICE.md' ;;
    *)                     want='../../NOTICE.md'    ;;
  esac
  grep -q "$want" "$f" || note "$f: footer should link $want"
done < <(find skills -name '*.md' | sort)
[ $fail -eq $before ] && ok

# --- 7. orphan reference files ------------------------------------------------
head_ "7. Every reference file is reachable from its SKILL.md"
before=$fail
for f in skills/*/references/*.md; do
  [ -e "$f" ] || continue
  s="$(dirname "$(dirname "$f")")/SKILL.md"
  grep -q "$(basename "$f")" "$s" || note "$f is orphaned — no context pointer in $s"
done
[ $fail -eq $before ] && ok

# --- 8. structural completeness -----------------------------------------------
head_ "8. Every skill has SKILL.md and agents/openai.yaml"
before=$fail
for d in $skills; do
  [ -f "$d/SKILL.md" ]            || note "$d missing SKILL.md"
  [ -f "$d/agents/openai.yaml" ]  || note "$d missing agents/openai.yaml"
done
[ $fail -eq $before ] && ok

printf '\n'
if [ $fail -eq 0 ]; then
  printf '\033[32mAll consistency checks passed (%s skills).\033[0m\n' "$(echo "$skills" | wc -l | tr -d ' ')"
else
  printf '\033[31mConsistency checks FAILED — see above.\033[0m\n'
fi
exit $fail
