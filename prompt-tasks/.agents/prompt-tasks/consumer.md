Run one prompt-task consumption round with `$prompt-task-consumer`.

Startup:

- Read `.agents/prompt-tasks/contract.md`, `.agents/prompt-tasks/tasks/context.md`, `.agents/prompt-tasks/tasks/index.md`, and `.agents/prompt-tasks/tasks/notes.md`.
- Inspect `git status --short` and any repo files needed to understand the chosen task.
- Sync your understanding of task relationships before claiming work.

Round objective:

- Execute exactly one actionable `TODO` task end to end.
- Hand the final status decision to `$task-review` in the same round.

Constraints:

- Follow the consumer role contract in `.agents/prompt-tasks/contract.md`.
- Do not work on multiple `TODO` tasks in one round.
- Do not mark a task `DONE` without review evidence.
- Do not hide scope spillover; record it explicitly in the task card and queue.
- If no actionable `TODO` exists, append a short note to `.agents/prompt-tasks/tasks/notes.md` and stop.
- If the round produced meaningful queue or code changes, finalize the checkpoint with `$git-safe`.

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
