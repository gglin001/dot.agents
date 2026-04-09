# Shared Context

Use this file for project-level facts that should survive individual task turnover.

## Overall Goal

- Replace open-ended autonomous work with deterministic task cards written in the voice of a human operator.

## Current Expectations

- A good task fits one primary repo slice, one main validation path, and one intended checkpoint.
- Producer output should reduce ambiguity, not increase backlog volume.
- Consumer output should leave enough evidence that a later round can understand what actually happened.

## Current Quality Signals

- Fill in repository-specific failing tests, coverage gaps, release criteria, or performance targets here.

## Known Constraints

- Fill in read-only areas, slow validation paths, external dependencies, or deployment constraints here.

## Global Risks

- Queue bloat: the producer creates speculative or overlapping tasks.
- Hidden dependency: a task looks local but depends on unfinished work elsewhere.
- Review drift: the consumer marks `DONE` without sufficient evidence.
- Git churn: producer and consumer update the same queue files from different worktrees without clear checkpoint boundaries.

## Operator Notes

- Human-authored task cards are the reference style until enough good producer-created cards exist.
- Prefer explicit task relations over implicit memory.
