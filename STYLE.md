# Coding Style

This style is for Codex-driven engineering work. It favors direct progress toward the intended system shape over conservative local patches.

## Core Direction

- Treat the requested end state as the main constraint. For refactors, migrations, cleanups, and architecture work, make the coordinated changes needed to reach that state.
- Prefer correct architecture over low-risk patching. If the current structure conflicts with the target design, reshape the structure instead of hiding the problem behind local fixes.
- Keep implementation simple, clear, and direct. Add abstraction only when it removes real complexity or expresses a stable boundary.
- Remove obsolete code paths, fallback branches, mock modes, stale wrappers, and outdated tests when they no longer serve the target design.
- Preserve correctness, tests, and user-stated constraints while avoiding unnecessary conservatism.

## Encouraged

- Use the repository's real extension points, typed APIs, parsers, dialects, passes, configuration mechanisms, and helper conventions.
- Keep module responsibilities and phase boundaries explicit. Names should match what the code actually does.
- Make scripts and CLIs small and predictable. Prefer one clear path, standard argument parsing, useful `--help`, and minimal modes.
- Update code, tests, docs, build files, and examples together when a change crosses those boundaries.
- Build focused tests around representative behavior. Include unsupported or diagnostic cases when they protect important semantics.
- Keep debugging reproducible. Save repro scripts, logs, dumps, fixtures, and temporary outputs under `debug_agent/` unless a project-specific debug directory already exists.
- Write comments only where they clarify non-obvious intent, constraints, temporary limits, or future work.
- Keep user-facing docs short when they are operational, and detailed only when the goal is deep technical understanding.

## Restricted

- Do not stop at narrow tweaks when the task asks for broad restructuring or migration.
- Do not keep compatibility layers, aliases, modes, or fallback code just because they already exist.
- Do not solve structural problems with string matching, naming hacks, broad special cases, or patch-style edits when a standard mechanism is available.
- Do not over-engineer simple scripts with unnecessary classes, frameworks, configuration layers, or many execution modes.
- Do not add noisy documentation, template text, exhaustive command catalogs, or broad explanations that do not help the next action.
- Do not copy large upstream test suites when a smaller, representative set can cover the intended behavior.
- Do not modify lock files, generated files, vendored code, or external dependency snapshots unless the task requires it.
- Do not spend disproportionate time on style polish, micro-optimizations, or incidental cleanup unless it materially advances the requested outcome.

## Verification

- Run the most relevant build, test, lint, or repro command available for the touched area.
- Prefer exact failing commands from the prompt when fixing errors.
- When a full validation is too expensive or unavailable, run the closest focused check and state the remaining risk.
- Keep verification output useful: capture enough information to reproduce the result without flooding the workspace or final response.
