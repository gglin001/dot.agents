---
name: prompt-task-consumer
description: "Select one TODO task card, implement it end to end, validate it, then hand the decision to task-review before finalizing the checkpoint."
---

# Prompt Task Consumer

## Use When

- Running `.agents/prompt-tasks/loop/consumer.md`
- The queue already contains concrete `TODO` tasks
- One focused implementation round should be executed from an explicit task card

## Role Boundary

- You consume one task at a time.
- You own implementation, validation, relation updates, and the handoff into review.
- Review decides the final task state, not the implementation step itself.

## Inputs

- `.agents/prompt-tasks/prompt-tasks-contract.md`
- `.agents/prompt-tasks/tasks/context.md`
- `.agents/prompt-tasks/tasks/index.md`
- one chosen `.agents/prompt-tasks/tasks/PT-*.md` task card
- relevant repository code, tests, docs, and git state

## Workflow

### 1. Choose one task

- Prefer the oldest actionable `TODO` with clear scope and no unmet hard dependency.
- If the queue has no actionable `TODO`, append a note to `.agents/prompt-tasks/tasks/notes.md` and stop.

### 2. Claim it visibly

- Move the task card to `Status: DOING`.
- Update the matching line in `.agents/prompt-tasks/tasks/index.md`.
- Record any immediate uncertainty or missing dependency in `Delivery Notes`.

### 3. Implement the task

- Stay inside the task scope unless the task card explicitly calls for one linked change.
- If you uncover new dependency structure, update `Depends On` or `Related Tasks`.
- Keep evidence in the task card concise and factual.

### 4. Validate

- Run the validation path stated in the task card whenever feasible.
- If validation cannot run, record the exact reason and reduce your confidence accordingly.
- Do not hand incomplete evidence to review as if it were complete.

### 5. Review before closure

- Set the task to `REVIEW` if you need to persist the pre-review state.
- Call `$task-review` in the same round whenever possible.
- Let review write the final outcome: `DONE`, `TODO`, `BLOCKED`, or `DROP`.

### 6. Finalize the checkpoint

- If the round produced meaningful queue or code changes, call `$git-safe`.
- Keep the checkpoint scoped to the chosen task and its necessary queue updates.

## Guardrails

- Do not pick multiple queue items.
- Do not silently split the task without documenting the split.
- Do not mark `DONE` without review evidence.
- Do not ignore related tasks when they materially affect correctness or future work.
