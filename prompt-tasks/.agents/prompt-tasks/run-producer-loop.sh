#!/usr/bin/env bash

set -eu

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
HARNESS_ROOT="$SCRIPT_DIR"
PROMPT_FILE="$HARNESS_ROOT/producer.md"
LOG_DIR=${LOG_DIR:-"$HARNESS_ROOT/debug"}
LOG_FILE=${LOG_FILE:-"$LOG_DIR/producer.log"}
CODEX_BIN=${CODEX_BIN:-codex}
ROUNDS=${ROUNDS:-50}
SLEEP_SECONDS=${SLEEP_SECONDS:-20}

mkdir -p "$LOG_DIR"

count=1
while [ "$count" -le "$ROUNDS" ]; do
  printf -- "--- %s : Starting producer iteration %s / %s ---\n" "$(date)" "$count" "$ROUNDS" | tee -a "$LOG_FILE"
  "$CODEX_BIN" --yolo exec "$(<"$PROMPT_FILE")" 2>&1 | tee -a "$LOG_FILE"
  count=$((count + 1))
  sleep "$SLEEP_SECONDS"
done
