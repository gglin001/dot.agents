# Shared Context

Use this file for project-level facts that should survive individual task turnover.
Keep role workflow and status rules in `.agents/prompt-tasks/contract.md`, not here.

## Goal Snapshot

- Replace open-ended autonomous work with deterministic task cards written in the voice of a human operator.

## Non-Negotiables

- Task cards must be concrete enough that one consumer round can execute without guessing hidden intent.
- Queue growth must be justified by repository evidence, not by backlog vanity.
- Delivery and review evidence must be durable for later rounds.

## Quality Signals

- Fill in repository-specific failing tests, coverage gaps, release criteria, or performance targets here.

## Known Constraints

- Fill in read-only areas, slow validation paths, external dependencies, or deployment constraints here.

## Global Risks

- Queue bloat: the producer creates speculative or overlapping tasks.
- Hidden dependency: a task looks local but depends on unfinished work elsewhere.
- Review drift: the consumer marks `DONE` without sufficient evidence.
- Git churn: producer and consumer update the same queue files from different worktrees without clear checkpoint boundaries.

## Active Priorities

- Fill in top repository priorities that should shape near-term task selection.

## Operator Notes

- Human-authored task cards remain the reference style until enough high-quality producer cards exist.
