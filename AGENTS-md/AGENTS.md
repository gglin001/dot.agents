# Repository Guidelines

## Markdown Output Guidelines

- When using Markdown, always leave one blank line after any heading (# / ## / ###) before writing the body text or a list.
- When writing Markdown, always insert a blank line between a paragraph ending with a colon (e.g., `...:`) and the following list.
- Always use half-width (ASCII) punctuation marks (e.g., `,`, `.`, `!`, `?`, `:`) and strictly avoid full-width punctuation marks (e.g., `，`, `。`, `！`, `？`, `：`), even when outputting text in Chinese or other CJK languages.
- Always ensure there is a single space after any half-width punctuation mark (e.g., `你好, 世界` instead of `你好,世界`).

## Workspace Hygiene and `.gitignore` Policy

- Keep `.gitignore` narrow and targeted; do not switch to a deny-all whitelist pattern unless explicitly requested.
- `.gitignore` only affects Git tracking, so agents may still read ignored files, including relevant code under `third_party/` and safe symlinked contents.
- When searching under `third_party/`, prefer `rg -u` or `rg -uL` so `.gitignore` rules and symlinks do not hide relevant files.
- Put disposable scripts and outputs in `debug_agent/` instead of broadening ignore rules.

## Agent Scratch Workflow

- For debugging, repro, validation, or inspection, prefer saving helper scripts, fixtures, and outputs under `debug_agent/` and running them from there.
- Use descriptive names such as `debug_agent/repro_matmul_stride.py`, and keep useful scratch artifacts during the task so the workflow stays visible and reproducible.
- `python - <<'PY'` is a discouraged style example; reserve inline heredocs or one-liners for truly tiny throwaway commands, and otherwise default to saved files in `debug_agent/`.
