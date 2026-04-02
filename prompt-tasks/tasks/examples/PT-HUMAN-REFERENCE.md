# Example Task Card

This file is an example only. Do not add it to the live queue unless you intentionally want to execute it.

- ID: `PT-20260402-human-reference`
- Title: `Document the prompt-tasks queue contract`
- Status: `DONE`
- Source: `human`
- Parent Goal: `Bootstrap prompt-driven autonomous development in this repository`
- Depends On: `none`
- Related Tasks: `none`
- Blocked By: `none`
- Repo Scope: `prompt-tasks/README.md`, `prompt-tasks/AGENTS.md`, `prompt-tasks/tasks/`
- Validation: `Read the docs and confirm that a producer and consumer can both locate the queue contract, task lifecycle, and shared files without extra explanation.`
- Exit Criteria: `The queue contract, role split, statuses, and task card format are all documented in one discoverable path.`
- Created At: `2026-04-02`
- Updated At: `2026-04-02`

## User Prompt

Document the `prompt-tasks` workflow so that a producer agent, a consumer agent, and a human operator can all locate the same queue contract without relying on implicit knowledge.

Touch only the workflow docs and task metadata under `prompt-tasks/`. Do not turn this into a code change outside the harness.

Make sure the documentation explains:

- where the shared queue lives
- which role writes tasks and which role executes them
- why review decides the final task status
- how `TODO`, `DONE`, and `DROP` relate to the extra working states

Validation is documentation-based: after editing, re-read the docs as if you were a new operator and check that the answer to each question above is explicit.

Record any queue design tradeoff that a later producer or consumer should know.

## Context Snapshot

- Current repo fact: the repository already contains `autonomous-loop`, which chooses work from durable state rather than from an explicit queue.
- Current quality signal: this new harness needs a visible contract before autonomous rounds can use it consistently.
- Risk or assumption: if the contract is spread across too many files, the producer and consumer will drift.

## Delivery Notes

- The contract was centered around `prompt-tasks/AGENTS.md` for role and status rules.
- `prompt-tasks/README.md` documents the rationale, runtime model, and layout.
- The queue template and shared files live under `prompt-tasks/tasks/`.

## Review Record

- Reviewer: `human`
- Decision: `DONE`
- Evidence: `README.md`, `AGENTS.md`, and the task template all point to the same queue contract and status model.
- Follow-up: `Add repository-specific seed tasks once a real target repo and validation target exist.`
