---
name: git-safe
description: "Checkpoint a prompt-task queue or implementation change by staging the intended files, making one commit, syncing linearly with upstream, and pushing without force."
---

# Git Safe

## Use When

- A producer or consumer round produced a meaningful checkpoint
- The intended scope is small enough to stage intentionally
- Queue and task metadata are already in the state you want to preserve

## Workflow

### 1. Preconditions

- Confirm the current directory is inside a git repository with `git rev-parse --is-inside-work-tree`.
- Resolve the current branch with `git branch --show-current`.
- If the branch is empty, stop and report `detached HEAD, cannot choose safe push target`.
- Confirm `origin` exists with `git remote get-url origin`.
- Inspect `git status --short` before staging anything.

### 2. Scope the checkpoint

- Stage only the files that belong to the current queue or task checkpoint.
- Exclude unrelated dirty files.
- Recheck the staged scope with `git diff --cached --name-only`.
- If the staged diff is empty, stop and report `no changes to commit`.

### 3. Commit once

- Create one commit for the checkpoint.
- Preferred message prefixes:
  - `prompt-task-producer: <summary>`
  - `prompt-task-consumer: <summary>`
  - `prompt-tasks: <summary>`
- Keep the subject short, concrete, and mostly lowercase.

### 4. Sync linearly and push

- Detect upstream with `git rev-parse --abbrev-ref --symbolic-full-name @{u}`.
- If no upstream exists, run `git push -u origin <branch>`.
- If upstream exists:
  - run `git fetch origin`
  - push normally
  - if the push is rejected because the branch moved, do a linear sync with rebase after the checkpoint commit already exists
  - resolve only conflicts that belong to the intended checkpoint
  - if conflicts touch unrelated files or change the task semantics, stop and report instead of guessing
- Never force push.
- Never create a merge commit in this workflow.

### 5. Report

- Return the short commit hash
- Return the commit subject
- Return the branch and upstream
- Return the committed files
- Return whether the push succeeded directly or needed a rebase

## Edge Cases

- If `origin` is missing, report `origin remote missing, configure remote then retry`.
- If the push stays rejected after a reasonable linear sync attempt, report `push rejected after linear sync, manual intervention required`.
- If a hook or policy blocks the commit, report the failure and stop.
- If a conflict falls outside the checkpoint scope, stop and report `unrelated conflict encountered, leaving tree for human or later round`.

## Guardrails

- Do not use destructive git commands.
- Do not stage unrelated files.
- Do not force push, amend, or rewrite unrelated history.
- Do not resolve conflicts by deleting or overriding changes you do not understand.
