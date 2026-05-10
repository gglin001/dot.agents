Run one prompt-task production round with `$prompt-task-producer`.

Startup:

- Read `.agents/prompt-tasks/contract.md`, `.agents/prompt-tasks/tasks/context.md`, `.agents/prompt-tasks/tasks/index.md`, and `.agents/prompt-tasks/tasks/notes.md`.
- Inspect `git status --short` plus the relevant repository files, tests, and docs needed to judge current gaps.
- Use human-authored task cards under `.agents/prompt-tasks/tasks/`, including `.agents/prompt-tasks/tasks/PT-HUMAN-REFERENCE.md`, as style references.

Round objective:

- Create exactly one new actionable `TODO` card, or
- Record a no-growth decision with a dated note in `.agents/prompt-tasks/tasks/notes.md`.

Constraints:

- Follow the producer role contract in `.agents/prompt-tasks/contract.md`.
- Do not implement product code in this round.
- Create at most one new task card.
- If queue artifacts changed meaningfully, finalize the checkpoint with `$git-safe`.

Stop conditions:

- one concrete task card was created
- or a no-growth queue note was recorded
- or the round is blocked by missing repository context that cannot be recovered locally

Return sections in this order:

1. Queue Summary
2. Work Performed
3. Evidence
4. Queue Updates
5. Git Finalization
6. Next Suggestion
