# dot.agents

This repository contains practical `.agents` experiments and patterns. Its goal is to build agent harnesses that enable coding agents such as Codex, Claude Code, and Gemini CLI to support continuous, unsupervised development.

## Experiments

- `autonomous-loop`: a self-directed loop that chooses the next move from durable repository state and current evidence.
- `prompt-tasks`: a task-first loop where a producer writes concrete "user prompt" task cards and a consumer implements one task at a time with review before closing status.
