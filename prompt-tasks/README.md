# prompt-tasks

`prompt-tasks` is a task-first autonomous development harness.

Unlike [`autonomous-loop`](../autonomous-loop/README.md), it does not ask the agent to decide "what should I do next?" from open-ended repository evidence. It asks one agent to write the next task as if a human had written a concrete `user prompt`, then asks another agent to execute exactly one such task end to end.

This `dot.agents` repository is a collection of harness experiments. In real usage, copy `prompt-tasks/.agents/` into a target project repository and run everything there.

## CWD and Copy Model

- Runtime CWD is the target project root that contains `.agents/`.
- All queue files, loop prompts, skills, and scripts live under `.agents/`.
- `prompt-tasks/README.md` is reference documentation only.
- The operating contract lives in `.agents/prompt-tasks-contract.md`.

## Core Model

- One shared `.agents/tasks/` directory is the durable interface between human operators, the producer loop, and the consumer loop.
- Every task card is written as a direct `user prompt` to an implementation agent.
- The producer understands repository reality and turns that reality into one more concrete task card.
- The consumer selects one `TODO` task, implements it, validates it, reviews it, and only then decides the final task status.
- Human-authored task cards are first-class inputs. Early in a project they are also the reference style that the producer should imitate.

## Why This Exists

The central claim is simple: unattended agent development should be a continuation of a normal human development process, not a mysterious replacement for it.

That means:

- each round should begin from a concrete task, not from a vague instruction to "figure out what matters"
- the task should look like something a human operator would plausibly write
- the producer replaces the human act of writing the next prompt
- the consumer replaces the human act of carrying that prompt through implementation and review

This keeps the loop deterministic at the task boundary. The agent is treated like a non-mystical engineer that needs a clear assignment.

## Task Lifecycle

The minimum durable statuses are `TODO`, `DONE`, and `DROP`, but the workflow uses a few more transient states to make handoff and recovery safer:

- `TODO`: ready for a consumer round
- `DOING`: currently claimed by a consumer
- `REVIEW`: implementation finished, review still deciding the outcome
- `BLOCKED`: cannot continue until some dependency or information gap is resolved
- `DONE`: accepted by review with evidence
- `DROP`: intentionally abandoned because the task is obsolete, duplicated, wrong, or no longer worth doing

The consumer must not move a task straight from coding to `DONE` without running the review step.

## Shared Files

- `.agents/prompt-tasks-contract.md`: role boundaries, queue contract, state rules
- `.agents/tasks/context.md`: project-level goals, constraints, and quality signals shared by all rounds
- `.agents/tasks/index.md`: canonical task list
- `.agents/tasks/notes.md`: dated queue, implementation, and review notes that do not belong to only one task
- `.agents/tasks/templates/task.template.md`: template for both human-written and producer-written task cards

## Directory Layout

```text
prompt-tasks/
├── README.md
└── .agents/
    ├── prompt-tasks-contract.md
    ├── loop/
    │   ├── producer.md
    │   └── consumer.md
    ├── skills/
    │   ├── prompt-task-producer/
    │   ├── prompt-task-consumer/
    │   ├── task-review/
    │   └── git-safe/
    ├── scripts/
    │   ├── bootstrap-worktrees.sh
    │   ├── run-producer-loop.sh
    │   ├── run-consumer-loop.sh
    │   └── run-pair.sh
    └── tasks/
        ├── context.md
        ├── index.md
        ├── notes.md
        ├── examples/
        └── templates/
```

## Safe Runtime Model

Running two loops against the exact same working tree is fragile. Both agents need the same `.agents/tasks/` directory, but they do not need the same live filesystem instance.

The recommended model is:

1. create two worktrees or clones of the same repository
2. run the producer loop in one worktree
3. run the consumer loop in the other worktree
4. use the shared git history plus `.agents/tasks/` files as the durable synchronization layer

This is why `prompt-tasks` includes a git finalization skill that stages the intended checkpoint, syncs linearly, and only resolves conflicts that are genuinely part of the current task.

## Quick Start

Copy `.agents/` into your target project repository:

```bash
cp -R /path/to/dot.agents/prompt-tasks/.agents /path/to/target-project/.agents
```

Then run in the target project root:

```bash
.agents/scripts/bootstrap-worktrees.sh
```

Then run the producer loop in the producer worktree:

```bash
cd ../<repo-name>-producer
.agents/scripts/run-producer-loop.sh
```

And the consumer loop in the consumer worktree:

```bash
cd ../<repo-name>-consumer
.agents/scripts/run-consumer-loop.sh
```

Or launch both after you set two distinct worktree paths:

```bash
PRODUCER_WORKDIR=../<repo-name>-producer \
CONSUMER_WORKDIR=../<repo-name>-consumer \
.agents/scripts/run-pair.sh
```

## Human Bootstrapping

In the early phase of a project, humans should add task cards directly. Those cards become the reference examples for tone, granularity, and acceptance criteria. Over time, the producer should learn the local style by imitating the best human-authored prompts already present in `.agents/tasks/`.

`.agents/tasks/examples/PT-HUMAN-REFERENCE.md` shows the intended shape of such a task card.

## Relationship to `autonomous-loop`

Use `autonomous-loop` when the system should reason from durable state and current evidence to choose its own next move.

Use `prompt-tasks` when you want the opposite boundary:

- the system must always act on one explicit task
- task creation and task execution are separated
- queue quality matters as much as implementation quality
- human prompts and agent prompts should converge toward the same style
