#!/usr/bin/env bash

set -eu

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/../../.." && pwd)
HARNESS_ROOT="$REPO_ROOT/.agents/prompt-tasks"
PROMPT_FILE="$HARNESS_ROOT/loop/consumer.md"
LOG_DIR=${LOG_DIR:-"$HARNESS_ROOT/debug"}
LOG_FILE=${LOG_FILE:-"$LOG_DIR/consumer.log"}
CODEX_BIN=${CODEX_BIN:-codex}
ROUNDS=${ROUNDS:-50}
SLEEP_SECONDS=${SLEEP_SECONDS:-20}

mkdir -p "$LOG_DIR"

count=1
while [ "$count" -le "$ROUNDS" ]; do
  printf -- "--- %s : Starting consumer iteration %s / %s ---\n" "$(date)" "$count" "$ROUNDS" | tee -a "$LOG_FILE"
  "$CODEX_BIN" --yolo exec "$(<"$PROMPT_FILE")" 2>&1 | tee -a "$LOG_FILE"
  count=$((count + 1))
  sleep "$SLEEP_SECONDS"
done
