#!/usr/bin/env bash

set -eu

REPO_ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PROMPT_FILE="$REPO_ROOT/.agents/loop/consumer.md"
LOG_DIR=${LOG_DIR:-"$REPO_ROOT/.agents/debug"}
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
