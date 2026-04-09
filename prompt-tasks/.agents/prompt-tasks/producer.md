Run one prompt-task production round with `$prompt-task-producer`.

Startup:

- Read `.agents/prompt-tasks/contract.md`, `.agents/prompt-tasks/tasks/context.md`, `.agents/prompt-tasks/tasks/index.md`, and `.agents/prompt-tasks/tasks/notes.md`.
- Inspect `git status --short` and whatever repository files, tests, or docs are necessary to understand current gaps or progress.
- Use human-authored task cards under `.agents/prompt-tasks/tasks/`, including `.agents/prompt-tasks/tasks/PT-HUMAN-REFERENCE.md`, as reference style.

Responsibilities:

- Decide whether repository reality justifies one more task card right now.
- If yes, create exactly one new `.agents/prompt-tasks/tasks/PT-<date>-<random>.md` file from `.agents/prompt-tasks/tasks/PT-YYYYMMDD-TEMPLATE.md`.
- Write the task as a direct `user prompt` to an implementation agent.
- Include concrete repo scope, validation target, exit criteria, current assumptions, and task relationships.
- Add or update the matching line in `.agents/prompt-tasks/tasks/index.md` with initial status `TODO`.
- If the queue should not grow this round, append a short dated note to `.agents/prompt-tasks/tasks/notes.md` explaining why.

Constraints:

- Do not implement product code in this round.
- Do not flood the queue with speculative, duplicate, or weakly-validated tasks.
- Prefer tasks that a single focused consumer round can complete.
- Capture why the task matters to the parent goal instead of describing an isolated code change.
- When the queue changed meaningfully, finalize the checkpoint with `$git-safe`.

Stop conditions:

- one concrete task card was created
- or a no-op queue note was recorded
- or the round is blocked by missing repository context that cannot be recovered locally

Return sections in this order:

1. Queue Summary
2. Work Performed
3. Evidence
4. Queue Updates
5. Git Finalization
6. Next Suggestion
