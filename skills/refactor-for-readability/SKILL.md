---
name: refactor-for-readability
description: Refactor existing code to make its intent, control flow, and data easier to understand while preserving behavior. Use when the user asks to make code more human readable or simplify confusing code.
---

# Refactor for Readability

Make the requested code easier for a maintainer familiar with the language to explain. Reduce the
facts they must remember and the jumps they must make between definitions to understand a behavior.
Preserve observable behavior throughout the refactor.

## Understand the reading problem

Use the user's requested files, symbols, or area. Read applicable repository guidance, nearby code,
relevant callers, and existing tests. Follow established domain terms, including a glossary when
one exists. Infer the target from the conversation when clear; ask for a target if none is available.

Identify the actual obstacles before editing: an ambiguous name, a buried decision, mixed concerns,
hidden mutation, or repeated jumps between trivial helpers. Prioritize changes that remove those
obstacles within the requested scope. If the user requests advice or a proposal, provide that
without editing the code.

## Qualities to improve

- **Names reveal meaning.** Name values and operations for their domain role. Make units and boolean
  meaning clear, such as `timeoutSeconds` and `isEligible`. Give the same concept the same name;
  choose a more specific name when `data`, `result`, or `process` leaves the reader guessing.
- **Control flow reads in order.** Keep the normal path easy to follow. Use guard clauses when they
  clarify exceptional cases, and name a compound condition when the name explains a business rule.
  Choose loops, expressions, or pipelines according to which makes the sequence and exits clearest.
- **Related logic stays together.** Keep a calculation and its relevant conditions close. Extract a
  helper when it names a coherent operation and lets the caller reason without reopening its body.
  Inline a helper when it only adds a jump. Judge function size by how much the reader must track.
- **Data and effects are explicit.** Make inputs, outputs, units, missing values, and failure cases
  understandable using the project's type and naming conventions. Keep mutation, I/O, and other
  effects visible at the level where a reader needs to reason about their order. Limit temporary
  state to the scope that needs it.
- **Abstractions earn their cost.** Share a rule when callers mean the same thing and should change
  together. Allow similar-looking code to stay separate when it represents different rules. Prefer
  a direct implementation until an abstraction makes the reader learn fewer concepts.
- **Patterns are consistent.** Use familiar language idioms and the repository's established
  conventions for naming, errors, and formatting. Keep comparable branches shaped alike when that
  makes their differences easier to see.
- **Comments explain reasoning.** Preserve useful explanations of constraints, invariants, and
  surprising choices. Improve names and structure where a comment merely translates the code.
  Add a short explanation when the reason cannot be expressed by the code itself.

These are decision criteria, not quotas. Each change should make a concrete reading task easier;
leave already clear code alone.

## Refactor within the existing contract

Make focused edits that address the identified obstacles. Keep public names, signatures, serialized
fields, configuration keys, and other externally consumed contracts compatible. Before renaming a
symbol, check its uses, including reflective or string-based references when relevant.

Preserve return values, exceptions, evaluation order, short-circuiting, mutations, and the order of
side effects. Pay particular attention when flattening conditions or moving work into helpers:
cleanup, lazy evaluation, and asynchronous work can make a seemingly cosmetic change behavioral.

Keep architecture changes and discovered bugs separate unless the user's request includes them.
When a proposed simplification depends on an unverified behavioral assumption, retain that part and
explain the uncertainty while completing the changes that can be justified.

## Verify and reread

Use the relevant existing checks, including tests, type checking, and linting as the project provides
them. Establish a baseline before changes whose equivalence is uncertain. Add a focused behavior
test only when a meaningful risk lacks coverage; test observable outcomes, not the new helper layout.
Simple naming and formatting changes do not need new tests just to record the refactor.

Review the final diff for changed behavior and unrelated churn. Reread the edited path as a
maintainer: can you explain its purpose, normal steps, exceptions, and effects with less backtracking?
Rework edits that add indirection or obscure details the reader needs.

Finish with the changed files, the main improvements to understanding, and the checks performed.
State any verification gaps or deferred changes plainly. Passing checks supports confidence in
behavior preservation; it does not by itself demonstrate readability.
