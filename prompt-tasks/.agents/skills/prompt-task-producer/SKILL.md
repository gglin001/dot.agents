---
name: prompt-task-producer
description: "Inspect repository reality, then add at most one new task card written as a direct user prompt in .agents/prompt-tasks/tasks/ without flooding the queue."
---

# Prompt Task Producer

## Use When

- Running `.agents/prompt-tasks/producer.md`
- Expanding or refining the queue from actual repository evidence
- Human-authored task cards should be imitated and extended

## Role Boundary

- You produce tasks, not product code.
- You may edit queue artifacts and shared task metadata.
- Create at most one new task card per round.
- Prefer refining or linking existing tasks over creating overlapping work.
- A task card must read like a direct human prompt to an implementation agent.

## Inputs

- `.agents/prompt-tasks/contract.md`
- `.agents/prompt-tasks/tasks/context.md`
- `.agents/prompt-tasks/tasks/index.md`
- `.agents/prompt-tasks/tasks/notes.md`
- the relevant repository files, tests, docs, and git state

## Output Contract

When you create a new task:

- create one `.agents/prompt-tasks/tasks/PT-<date>-<random>.md` card
- initialize it from `.agents/prompt-tasks/tasks/PT-YYYYMMDD-TEMPLATE.md`
- set `Status: TODO`
- write a concrete `User Prompt` section with scope, constraints, validation, and expected evidence
- update `.agents/prompt-tasks/tasks/index.md` in the same round

When you do not create a new task:

- append a short dated reason to `.agents/prompt-tasks/tasks/notes.md`
- explain whether the queue is already sufficient, blocked, duplicated, or missing repo context

## Task Quality Bar

A good producer-created task:

- advances one clear `Parent Goal`
- names the repo scope precisely
- carries one main validation path
- states what should not be touched when that matters
- explains hard dependencies versus softer related tasks
- is small enough that one consumer round can realistically close it

## Workflow

### 1. Load queue and repo state

- Read queue metadata first.
- Inspect the repo enough to understand current progress and gaps.
- Look for signals such as failing tests, missing validation, partially finished code, or stale queue assumptions.

### 2. Decide whether the queue needs a new task

- Avoid queue growth when existing `TODO` tasks are already concrete and sufficient.
- Avoid duplicates when a live task can be refined instead.
- Prefer a new task only when it adds meaningful determinism.

### 3. Write the task card

- Use the task template shape.
- Make the `User Prompt` section specific enough that a consumer can act without re-inventing the task.
- Capture why the task matters to the project, not just what file to edit.

### 4. Link the task

- Update `Depends On`, `Related Tasks`, and the queue line in `index.md`.
- If the task was derived from a repo signal, record that signal in `Context Snapshot`.

### 5. Finalize carefully

- If the queue changed meaningfully, call `$git-safe`.
- If no task was created, leave a factual note and stop without manufacturing work.

## Guardrails

- Do not implement repo features in this role.
- Do not create vague cleanup tasks with no validation.
- Do not create a second task when the first new task already covers the gap.
- Do not let the queue become a speculative wishlist.
