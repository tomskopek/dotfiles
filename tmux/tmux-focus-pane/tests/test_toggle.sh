#!/usr/bin/env bash
# Test toggle-focus.sh with various layouts.
# Must be run from inside a tmux session.

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../scripts" && pwd)/toggle.sh"
PASS=0
FAIL=0

# Clean up any leftover state
tmux set-env -g TMUX_FOCUS_ACTIVE 0 2>/dev/null
tmux set-env -gu TMUX_FOCUS_ORIG_WIN 2>/dev/null
tmux set-env -gu TMUX_FOCUS_PLACEHOLDER 2>/dev/null
tmux set-env -gu TMUX_FOCUS_PANE 2>/dev/null
tmux set-env -gu TMUX_FOCUS_TEMP_WIN 2>/dev/null

test_layout() {
  local name="$1"
  shift

  tmux new-window -n "test-$name"
  sleep 0.2

  for cmd in "$@"; do
    eval "$cmd"
    sleep 0.2
  done

  local layout_before=$(tmux display -p '#{window_layout}')

  bash "$SCRIPT"
  sleep 0.3

  bash "$SCRIPT"
  sleep 0.3

  local layout_after=$(tmux display -p '#{window_layout}')

  if [ "$layout_before" = "$layout_after" ]; then
    echo "PASS: $name"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $name"
    echo "  before: $layout_before"
    echo "  after:  $layout_after"
    FAIL=$((FAIL + 1))
  fi

  tmux kill-window
  sleep 0.1
}

echo "=== Testing tmux-focus-pane ==="
echo ""

# 2 panes side by side
test_layout "2-pane-horizontal" \
  "tmux split-window -h"

# 2 panes stacked
test_layout "2-pane-vertical" \
  "tmux split-window -v"

# 1 left, 2 stacked right — focus bottom-right
test_layout "3-pane-right-stack" \
  "tmux split-window -h" \
  "tmux split-window -v"

# 2 stacked left, 1 right — focus top-left
test_layout "3-pane-left-stack-focus-top" \
  "tmux split-window -h" \
  "tmux select-pane -L" \
  "tmux split-window -v" \
  "tmux select-pane -U"

# 2x2 grid — focus top-right
test_layout "4-pane-grid-focus-topright" \
  "tmux split-window -h" \
  "tmux split-window -v" \
  "tmux select-pane -L" \
  "tmux split-window -v" \
  "tmux select-pane -R" \
  "tmux select-pane -U"

# 2x2 grid — focus bottom-left
test_layout "4-pane-grid-focus-bottomleft" \
  "tmux split-window -h" \
  "tmux split-window -v" \
  "tmux select-pane -L" \
  "tmux split-window -v"

# 70/30 horizontal — focus the large pane
test_layout "uneven-70-30" \
  "tmux split-window -h -l 30%" \
  "tmux select-pane -L"

# 3 columns, middle split vertically — focus top-middle
test_layout "3-col-middle-split" \
  "tmux split-window -h -l 33%" \
  "tmux split-window -h -l 50%" \
  "tmux select-pane -L" \
  "tmux split-window -v" \
  "tmux select-pane -U"

# main pane left, 4 stacked right — focus the main pane
test_layout "5-pane-main-left" \
  "tmux split-window -h -l 30%" \
  "tmux split-window -v" \
  "tmux split-window -v" \
  "tmux select-pane -U" \
  "tmux select-pane -U" \
  "tmux split-window -v" \
  "tmux select-pane -L"

# 3 horizontal columns — focus the middle one
test_layout "3-horiz-focus-middle" \
  "tmux split-window -h" \
  "tmux split-window -h" \
  "tmux select-pane -L"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
