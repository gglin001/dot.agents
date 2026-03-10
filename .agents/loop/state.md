# Mission

- Build an AI-agent-driven repository practice that stays self-directed as model capability improves.

# Constraints

- Optimize for autonomous progress, not rigid stage-machine determinism.
- Prefer simpler workflows over multi-role orchestration.
- Keep hard guardrails only around validation evidence, durable state, and git side effects.
- Rewrite stale plans freely when new evidence points to a better path.

# Current Strategy

- Use one autonomous execution skill to choose the next action from repository evidence, then preserve meaningful checkpoints with one safe git skill.

# Evidence

- 2026-03-10: The previous workflow split one round into `loop-start`, `loop-arch`, `loop-build`, and `loop-git`.
- 2026-03-10: The previous control plane was `.agents/loop/todo.md`, which optimized for deterministic dispatch and backlog discipline.
- 2026-03-10: The target model is a self-driven agent that can inspect, decide, implement, and validate inside the same round.

# Next Options

- Run the first `autonomous-loop` round on a real repository task and observe whether this state file carries enough context.
- If state maintenance becomes repetitive, add a tiny helper script instead of restoring extra planner roles.
- Compress `Evidence` when it becomes noisy, rather than growing more workflow phases.

# Blockers

- None.
