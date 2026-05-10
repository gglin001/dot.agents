---
name: prompt-task-consumer
description: "Select one TODO task card, implement it end to end, validate it, then hand the decision to task-review before finalizing the checkpoint."
---

# Prompt Task Consumer

## Use When

- Running `.agents/prompt-tasks/consumer.md`
- The queue contains actionable `TODO` tasks
- You need one deterministic consumer round

## Canonical Rule Source

Read `.agents/prompt-tasks/contract.md` first.
Role boundaries, status transitions, and task-card requirements are defined there.
If this skill and the contract differ, the contract wins.

## Read Order

1. `.agents/prompt-tasks/contract.md`
2. `.agents/prompt-tasks/tasks/context.md`
3. `.agents/prompt-tasks/tasks/index.md`
4. `.agents/prompt-tasks/tasks/notes.md`
5. One selected `.agents/prompt-tasks/tasks/PT-*.md` card
6. Relevant repository code, tests, docs, and `git status --short`

## Round Workflow

1. Select one actionable `TODO` task with no unmet hard dependency.
2. Claim it by setting `Status: DOING` in both the card and `index.md`.
3. Implement inside declared scope, or record explicit spillover.
4. Run validation specified by the task, or document the exact blocker.
5. Hand off to `$task-review` in the same round.
6. Apply review outcome and keep task card plus `index.md` synchronized.
7. If queue or code changed meaningfully, finalize with `$git-safe`.

## Consumer-Specific Guardrails

- Do not consume multiple tasks in one round.
- Do not hide scope changes, relation updates, or discovered blockers.
- Do not mark a task `DONE` without review acceptance and evidence.
- If no actionable `TODO` exists, append a dated note to `notes.md` and stop.
