# prompt-tasks Operating Contract

This file is the single source of truth for prompt-tasks behavior.
If any instruction in `producer.md`, `consumer.md`, or skill docs conflicts with this file, this file wins.

## Canonical Runtime Files

- `.agents/prompt-tasks/contract.md`: normative workflow and state rules
- `.agents/prompt-tasks/tasks/context.md`: project facts, goals, constraints, and risks
- `.agents/prompt-tasks/tasks/index.md`: canonical queue, one line per live task card
- `.agents/prompt-tasks/tasks/notes.md`: dated cross-task facts
- `.agents/prompt-tasks/tasks/PT-YYYYMMDD-TEMPLATE.md`: task card template

## Shared Truth

- Every live task card has exactly one matching queue line in `index.md`.
- Every queue line maps to exactly one task card in `.agents/prompt-tasks/tasks/`.
- Human-authored task cards are authoritative examples of local style and intent.
- `context.md` stores project facts, not role workflow rules.

## Status Model

Durable outcomes:

- `TODO`
- `DONE`
- `DROP`

Working states:

- `DOING`
- `REVIEW`
- `BLOCKED`

State definitions:

- `TODO`: actionable now by a consumer.
- `DOING`: claimed by one consumer and actively in progress.
- `REVIEW`: implementation reached a decision point, review not finalized yet.
- `BLOCKED`: still relevant, currently not actionable due to a concrete blocker.
- `DONE`: exit criteria met, validation evidence present, review accepted.
- `DROP`: task is obsolete, duplicate, or based on a wrong premise.

## Task Card Contract

Required fields near the top:

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

Required sections:

- `User Prompt`
- `Context Snapshot`
- `Delivery Notes`
- `Review Record`

Field semantics:

- `Depends On` is for hard sequencing requirements.
- `Related Tasks` is for non-blocking links that affect reasoning.
- `Blocked By` must name the concrete blocker, not a vague statement.
- `User Prompt` must read as a direct instruction from a human operator.

## Role Contracts

### Producer Round

Round objective:

- create at most one new actionable task card, or
- append one no-growth note to `notes.md` with a concrete reason.

Required steps:

1. Read `contract.md`, `context.md`, `index.md`, and `notes.md`.
2. Inspect repository reality before deciding queue changes.
3. Prefer refining task relations over creating overlapping work.
4. If creating a task, create exactly one `PT-<date>-<random>.md` from template, set `Status: TODO`, write a concrete `User Prompt`, and update `index.md` in the same round.
5. If not creating a task, append a dated reason to `notes.md`.
6. If queue artifacts changed meaningfully, checkpoint with `$git-safe`.

Producer constraints:

- Do not implement product code.
- Do not create speculative wishlist tasks.
- Do not create more than one new task card per round.

### Consumer Round

Round objective:

- execute one actionable `TODO` task end to end, then hand the decision to review.

Required steps:

1. Read `contract.md`, `context.md`, `index.md`, and `notes.md`.
2. Select one actionable `TODO` task with no unmet hard dependency.
3. Claim it by setting `Status: DOING` in both the task card and `index.md`.
4. Implement within declared scope, or record scope spillover explicitly.
5. Run the task validation path, or document exactly why it could not run.
6. Run review in the same round and let review decide the final state.
7. If queue or code changed meaningfully, checkpoint with `$git-safe`.

Consumer constraints:

- Do not pick multiple tasks in one round.
- Do not mark `DONE` without review evidence.
- Do not hide dependency discoveries or relation updates.

### Review Round

Round objective:

- accept or reject closure quality with evidence.

Required steps:

1. Re-read the task card contract: `Repo Scope`, `Validation`, `Exit Criteria`, relations.
2. Inspect changed files and validation evidence against the card.
3. Choose exactly one outcome: `DONE`, `TODO`, `BLOCKED`, or `DROP`.
4. Write rationale and evidence into `Review Record`.
5. Sync final status in both the task card and `index.md`.
6. Append reusable cross-task facts to `notes.md` when relevant.

Review constraints:

- No rubber-stamping.
- No `DONE` with missing or contradictory validation evidence.
- No queue and card status divergence.

## Queue Quality Rules

- One task should fit one focused consumer round.
- Prefer one main repo slice, one primary validation path, and one intended checkpoint.
- Explain why the task matters to `Parent Goal`.
- Keep dependency links explicit.
- Keep backlog density high; avoid speculative growth.

## Concurrency and Git

- Preferred operating model: separate producer and consumer worktrees.
- Shared synchronization layer: git history plus `.agents/prompt-tasks/tasks/`.
- Resolve only conflicts related to the current checkpoint.
- If a conflict changes task semantics and cannot be resolved confidently, stop and report.

## Human Override

- Humans may edit queue order, card content, priorities, and statuses at any time.
- Human edits to task cards or `context.md` are authoritative.
- If human edits conflict with an in-flight round, preserve human intent and narrow the round scope.
