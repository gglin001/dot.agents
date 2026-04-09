---
name: task-review
description: "Review a just-implemented prompt task with a code-review mindset, then decide the final task status and write the evidence back into the queue."
---

# Task Review

## Use When

- A consumer round believes a task has reached a decision point
- Implementation exists, but the final task state has not yet been accepted
- The same agent needs to switch from builder mode to reviewer mode

## Canonical Rule Source

Read `.agents/prompt-tasks/contract.md` first.
The contract defines allowed outcomes, queue synchronization, and acceptance rules.
If this skill and the contract differ, the contract wins.

## Review Mindset

- Review like a skeptical code reviewer, not like a finisher protecting sunk cost.
- Look for correctness gaps, missing validation, scope drift, undeclared side effects, and broken task relations.
- The output is a decision plus evidence, not just a summary of work done.

## Allowed Outcomes

- `DONE`: exit criteria are met and evidence supports acceptance
- `TODO`: useful progress exists but the task is not complete enough to close
- `BLOCKED`: the task remains relevant but cannot move without outside help, upstream work, or missing information
- `DROP`: the task is obsolete, duplicated, based on a wrong premise, or no longer worth doing

## Workflow

1. Re-read the full task card, focusing on `Repo Scope`, `Validation`, `Exit Criteria`, and task relations.
2. Inspect implementation diffs and validation evidence against the written contract.
3. Choose exactly one outcome: `DONE`, `TODO`, `BLOCKED`, or `DROP`.
4. Write rationale and evidence in `Review Record`.
5. Sync status in both the task card and `.agents/prompt-tasks/tasks/index.md`.
6. If review found reusable facts, append them to `.agents/prompt-tasks/tasks/notes.md`.

## Guardrails

- Do not rubber-stamp your own implementation.
- Do not mark `DONE` when validation is missing or contradictory.
- Do not use `DROP` as shorthand for "too hard right now"; use `BLOCKED` or return to `TODO`.
- Do not leave the queue and the task card out of sync.
