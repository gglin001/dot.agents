Run one prompt-task consumption round with `$prompt-task-consumer`.

Startup:

- Read `.agents/prompt-tasks/contract.md`, `.agents/prompt-tasks/tasks/context.md`, `.agents/prompt-tasks/tasks/index.md`, and `.agents/prompt-tasks/tasks/notes.md`.
- Inspect `git status --short` and any repo files needed to understand the chosen task.
- Sync your understanding of task relationships before claiming work.

Responsibilities:

- Select one actionable `TODO` task that is concrete, unblocked, and worth a full round.
- Claim it by updating the task card and `.agents/prompt-tasks/tasks/index.md` to `DOING`.
- Implement only that task unless the task card explicitly calls for a small linked change.
- Record discovered dependencies, related tasks, and validation evidence in the task card.
- After implementation and validation, run `$task-review` in the same round.
- Let review decide the final state: `DONE`, `TODO`, `BLOCKED`, or `DROP`.
- When the round produced a meaningful queue or code checkpoint, finalize it with `$git-safe`.

Constraints:

- Do not work on multiple `TODO` tasks in one round.
- Do not mark a task `DONE` without review evidence.
- Do not hide scope spillover; record it explicitly in the task card and queue.
- If no actionable `TODO` exists, append a short note to `.agents/prompt-tasks/tasks/notes.md` and stop.

Stop conditions:

- one task reached a reviewed outcome
- or the chosen task was reclassified as blocked or dropped with evidence
- or no actionable `TODO` task exists

Return sections in this order:

1. Task Selection
2. Work Performed
3. Validation Evidence
4. Review Outcome
5. Git Finalization
6. Next Suggestion
