---
name: task-review
description: "Review a just-implemented prompt task with a code-review mindset, then decide the final task status and write the evidence back into the queue."
---

# Task Review

## Use When

- A consumer round believes a task has reached a decision point
- Implementation exists, but the final task state has not yet been accepted
- The same agent needs to switch from builder mode to reviewer mode

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

### 1. Re-read the task contract

- Read the task card from top to bottom.
- Re-check `Repo Scope`, `Validation`, `Exit Criteria`, `Depends On`, and `Related Tasks`.

### 2. Review the implementation

- Inspect the changed files and validation evidence.
- Compare the actual change against the stated task contract.
- Treat missing tests or weak evidence as review issues, not as minor paperwork.

### 3. Decide the outcome

- Choose exactly one final status.
- Write the reason in `Review Record`.
- Update both the task card and the matching queue line in `.agents/tasks/index.md`.

### 4. Preserve cross-task knowledge

- If review discovered a reusable fact, append it to `.agents/tasks/notes.md`.
- If review exposed follow-up work, link it explicitly rather than relying on memory.

## Guardrails

- Do not rubber-stamp your own implementation.
- Do not mark `DONE` when validation is missing or contradictory.
- Do not use `DROP` as a shorthand for "too hard right now"; use `BLOCKED` or return to `TODO`.
- Do not leave the queue and the task card out of sync.
