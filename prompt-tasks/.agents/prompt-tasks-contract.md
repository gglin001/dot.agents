# prompt-tasks Operating Contract

All autonomous work in a repository using this harness is task-driven.

## Shared Truth

- `.agents/tasks/index.md` is the canonical queue. Every live task must have exactly one matching line there.
- Each queue line maps to exactly one task card in `.agents/tasks/`.
- `.agents/tasks/context.md` stores project-level goals, constraints, and quality signals.
- `.agents/tasks/notes.md` stores dated facts that are useful across tasks.
- Human-authored task cards are first-class and should be treated as authoritative examples of local style.

## Role Split

### Producer

- Inspect repository reality, not just the `.agents/` metadata.
- Create at most one new task card per round.
- Prefer refining or linking existing tasks over creating overlapping work.
- Write the task as a direct `user prompt` to an implementation agent.
- Do not implement product code in producer rounds except queue-maintenance changes needed to express the task clearly.

### Consumer

- Select one actionable `TODO` task.
- Claim it by moving it to `DOING` in both the task card and `index.md`.
- Implement and validate exactly that task or explicitly record scope spillover.
- Run review in the same round. Review, not coding, decides the final status.
- Use `.agents/tasks/notes.md` for cross-task facts that matter outside one task card.

## Status Model

Required durable outcomes:

- `TODO`
- `DONE`
- `DROP`

Supported working states:

- `DOING`
- `REVIEW`
- `BLOCKED`

State rules:

- `TODO` means a consumer can pick the task now.
- `DOING` means a consumer claimed the task and may still be editing or validating.
- `REVIEW` means implementation reached a decision point but the review outcome is not yet written.
- `BLOCKED` means the task is still relevant but cannot currently move.
- `DONE` requires validation evidence plus a positive review record.
- `DROP` requires an explicit reason such as duplication, obsolescence, or a wrong premise.

## Task Card Requirements

Every task card must carry these fields near the top:

- `ID`
- `Title`
- `Status`
- `Source`
- `Parent Goal`
- `Depends On`
- `Related Tasks`
- `Blocked By`
- `Repo Scope`
- `Validation`
- `Exit Criteria`
- `Created At`
- `Updated At`

Every task card must also contain these sections:

- `User Prompt`
- `Context Snapshot`
- `Delivery Notes`
- `Review Record`

The `User Prompt` section is the core contract. It should read like a clear instruction from a human operator to a strong but non-omniscient engineer.

## Queue Quality Rules

- A good task fits one focused consumer round.
- Prefer one primary repo slice, one main validation path, and one intended checkpoint.
- Tasks must explain why they matter to the parent goal.
- Links between tasks should be explicit. Use `Depends On` for hard ordering and `Related Tasks` for softer connections.
- Do not generate speculative backlog just because the queue looks small.

## Concurrency and Git

- The safe operating model is two separate worktrees or clones, not two long-running agents inside one mutable worktree.
- Treat git history plus the `.agents/tasks/` directory as the shared synchronization layer.
- Both producer and consumer should finalize meaningful queue or code checkpoints with the local `git-safe` skill.
- Only resolve conflicts that belong to the current checkpoint. If a conflict is unrelated or changes task semantics, stop and report instead of guessing.

## Human Intervention

- Humans may create, edit, reorder, or drop tasks at any time.
- A human rewrite of a task card or `context.md` is authoritative.
- If human edits conflict with the current round, preserve the new human intent and narrow the round accordingly.
