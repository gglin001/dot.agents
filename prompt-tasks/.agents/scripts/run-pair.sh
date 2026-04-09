#!/usr/bin/env bash

set -eu

PRODUCER_WORKDIR=${PRODUCER_WORKDIR:-}
CONSUMER_WORKDIR=${CONSUMER_WORKDIR:-}

if [ -z "$PRODUCER_WORKDIR" ] || [ -z "$CONSUMER_WORKDIR" ]; then
  echo "Set PRODUCER_WORKDIR and CONSUMER_WORKDIR to two distinct repository directories."
  exit 1
fi

if [ "$PRODUCER_WORKDIR" = "$CONSUMER_WORKDIR" ]; then
  echo "Producer and consumer must not share the same live checkout."
  exit 1
fi

producer_pid=
consumer_pid=

cleanup() {
  if [ -n "${producer_pid:-}" ]; then
    kill "$producer_pid" 2>/dev/null || true
  fi

  if [ -n "${consumer_pid:-}" ]; then
    kill "$consumer_pid" 2>/dev/null || true
  fi
}

trap cleanup INT TERM EXIT

(cd "$PRODUCER_WORKDIR" && .agents/scripts/run-producer-loop.sh) &
producer_pid=$!

(cd "$CONSUMER_WORKDIR" && .agents/scripts/run-consumer-loop.sh) &
consumer_pid=$!

wait "$producer_pid" "$consumer_pid"
