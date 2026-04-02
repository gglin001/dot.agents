#!/usr/bin/env bash

set -eu

REPO_ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PARENT_DIR=$(dirname "$REPO_ROOT")
REPO_NAME=$(basename "$REPO_ROOT")

PRODUCER_DIR=${PRODUCER_DIR:-"$PARENT_DIR/${REPO_NAME}-producer"}
CONSUMER_DIR=${CONSUMER_DIR:-"$PARENT_DIR/${REPO_NAME}-consumer"}
PRODUCER_BRANCH=${PRODUCER_BRANCH:-"prompt-tasks/producer"}
CONSUMER_BRANCH=${CONSUMER_BRANCH:-"prompt-tasks/consumer"}

cd "$REPO_ROOT"

add_worktree() {
  local branch=$1
  local dir=$2

  if [ -d "$dir/.git" ] || [ -f "$dir/.git" ]; then
    return 0
  fi

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$dir" "$branch"
  else
    git worktree add -b "$branch" "$dir" HEAD
  fi
}

add_worktree "$PRODUCER_BRANCH" "$PRODUCER_DIR"
add_worktree "$CONSUMER_BRANCH" "$CONSUMER_DIR"

cat <<EOF
Producer worktree: $PRODUCER_DIR
Consumer worktree: $CONSUMER_DIR

Next steps:
  cd "$PRODUCER_DIR" && prompt-tasks/scripts/run-producer-loop.sh
  cd "$CONSUMER_DIR" && prompt-tasks/scripts/run-consumer-loop.sh
EOF
