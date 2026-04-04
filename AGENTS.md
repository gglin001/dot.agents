# dot.agents Operating Contract

This repository is a collection of harness experiments. Every subproject should be maintainable on its own, while sharing a consistent philosophy across the repo.

## Core Philosophy

- Prefer explicit contracts over implicit behavior.
- Make autonomous loops deterministic at clear boundaries.
- Separate role responsibilities when role split improves reliability.
- Keep each harness practical for real repository operation, not demo-only.
- Treat human edits as authoritative intent.

## Repository Scope

The root repository exists to host and evolve multiple harness patterns:

- `autonomous-loop`: state-driven loop where the agent decides next moves from durable state and repository evidence.
- `prompt-tasks`: task-driven loop where a producer writes one concrete task prompt and a consumer executes one task with review.

Each harness must preserve its own local semantics. Do not force a single runtime model across all subprojects.

## Subproject Contract

Each subproject must provide these artifacts:

- `README.md` with purpose, runtime model, and quick start.
- `.agents/` with runnable prompts, skills, and any harness-local scripts or metadata.
- Clear durable state location for the loop model used by that subproject.

Each subproject should also satisfy:

- Running instructions are executable without hidden setup assumptions.
- Paths and examples are written from the intended CWD for that harness.
- Safety constraints are explicit, especially around git and concurrent agents.

## Documentation Rules

- Root `README.md` is an index and comparison view, not a full operator manual for each harness.
- Subproject `README.md` is the canonical operator manual for that harness.
- If a behavior rule is runtime-critical, store it under that harness `.agents/` tree so copied harnesses keep their contract.
- Avoid duplicate contracts spread across multiple files unless one file is explicitly a short index pointer.

## Change Workflow

When adding or modifying a harness, keep changes scoped and verifiable:

1. Update the harness files under its own directory first.
2. Update the harness `README.md` so operators can run the latest layout.
3. Update root `README.md` if experiment positioning changed.
4. Validate scripts with syntax checks and run the smallest meaningful command path.
5. Record any breaking path or contract migration clearly in docs.

## New Harness Checklist

Before considering a new subproject ready:

- The harness has a clear loop boundary and status model.
- The harness can run from a documented CWD with explicit paths.
- Required `.agents` files are present and referenced correctly.
- Quick start steps are complete enough for another operator to run.
- Safety model for git, conflicts, and concurrency is documented.

## Maintenance Guardrails

- Do not silently change a harness contract that existing prompts depend on.
- Do not move runtime-critical files without updating all references in prompts, skills, scripts, and docs.
- Prefer additive migrations with transitional notes when structure changes are large.
- Keep examples realistic and aligned with current file layout.

## Human Override

- Human maintainers may edit contracts, priorities, and structure at any time.
- If instructions conflict, prefer the most local harness contract unless a human explicitly sets a repo-wide override.
