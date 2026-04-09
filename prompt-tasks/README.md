# prompt-tasks

`prompt-tasks` is a task-first harness for autonomous development.

It splits work into two loops:

- Producer: creates at most one concrete task card from repository reality.
- Consumer: executes one `TODO` task card end to end, then hands the decision to review.

The goal is simple: keep autonomous work deterministic at the task boundary.

## Runtime Layout

- Runtime CWD: target project root containing `.agents/`.
- Prompt-task runtime files: `.agents/prompt-tasks/`.
- Shared skills: `.agents/skills/`.

## Core Files

- `.agents/prompt-tasks/prompt-tasks-contract.md`: role boundaries and queue rules.
- `.agents/prompt-tasks/tasks/context.md`: project-level goals and constraints.
- `.agents/prompt-tasks/tasks/index.md`: canonical queue.
- `.agents/prompt-tasks/tasks/notes.md`: cross-task dated facts.
- `.agents/prompt-tasks/tasks/templates/task.template.md`: task card template.
- `.agents/prompt-tasks/loop/producer.md`: producer loop prompt.
- `.agents/prompt-tasks/loop/consumer.md`: consumer loop prompt.

## Task Flow

1. Producer reads queue and repository evidence.
2. Producer creates at most one new task card, or records a no-op note.
3. Consumer picks one actionable `TODO` task and marks it `DOING`.
4. Consumer implements and validates.
5. `task-review` decides final state: `DONE`, `TODO`, `BLOCKED`, or `DROP`.
6. Queue and task card must stay in sync.

## Quick Start

Copy `.agents/` into your target repository:

```bash
cp -R /path/to/dot.agents/prompt-tasks/.agents /path/to/target-project/.agents
```

Run producer and consumer in two separate local checkouts(prefer):

```bash
cd /path/to/target-project-producer
.agents/prompt-tasks/scripts/run-producer-loop.sh
```

```bash
cd /path/to/target-project-consumer
.agents/prompt-tasks/scripts/run-consumer-loop.sh
```

## Practical Notes

- Treat git history plus `.agents/prompt-tasks/tasks/` as the synchronization layer.
- Human-authored cards are valid first-class inputs.
- Example card: `.agents/prompt-tasks/tasks/examples/PT-HUMAN-REFERENCE.md`.
