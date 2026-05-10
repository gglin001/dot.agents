---
name: prompt-task-producer
description: "Inspect repository reality, then add at most one new task card written as a direct user prompt in .agents/prompt-tasks/tasks/ without flooding the queue."
---

# Prompt Task Producer

## Use When

- Running `.agents/prompt-tasks/producer.md`
- Expanding or refining the queue from actual repository evidence
- You need one deterministic producer round

## Canonical Rule Source

Read `.agents/prompt-tasks/contract.md` first.
Role boundaries, state rules, task schema, and stop conditions are defined there.
If this skill and the contract differ, the contract wins.

## Read Order

1. `.agents/prompt-tasks/contract.md`
2. `.agents/prompt-tasks/tasks/context.md`
3. `.agents/prompt-tasks/tasks/index.md`
4. `.agents/prompt-tasks/tasks/notes.md`
5. Relevant repository code, tests, docs, and `git status --short`

## Round Workflow

1. Decide queue growth from repository evidence.
2. If queue should grow, create exactly one task card from template and set `Status: TODO`.
3. If queue should not grow, append one short dated reason to `notes.md`.
4. Keep task links explicit: update `Depends On` and `Related Tasks` when needed.
5. Keep queue synchronization strict: task card and `index.md` must match in the same round.
6. If queue artifacts changed meaningfully, finalize with `$git-safe`.

## Producer-Specific Guardrails

- Do not implement product code in this role.
- Do not create more than one new task card in a round.
- Do not create vague tasks lacking concrete validation.
- Do not create duplicate tasks when an existing card can be refined.
- Prefer no-growth notes over speculative backlog expansion.
