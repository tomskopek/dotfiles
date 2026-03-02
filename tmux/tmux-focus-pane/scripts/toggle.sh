#!/usr/bin/env bash
# Toggle the current pane between the split layout and its own full-screen window.
# Uses swap-pane to preserve the original layout exactly.

FOCUSED=$(tmux show-env -g TMUX_FOCUS_ACTIVE 2>/dev/null | cut -d= -f2)
KEY=$(tmux show-env -g TMUX_FOCUS_KEY 2>/dev/null | cut -d= -f2)
KEY="${KEY:-F}"

if [ "$FOCUSED" = "1" ]; then
  # === UNFOCUS: swap pane back into its original position ===
  ORIG_WIN=$(tmux show-env -g TMUX_FOCUS_ORIG_WIN | cut -d= -f2)
  PLACEHOLDER=$(tmux show-env -g TMUX_FOCUS_PLACEHOLDER | cut -d= -f2)
  PANE=$(tmux show-env -g TMUX_FOCUS_PANE | cut -d= -f2)
  TEMP_WIN=$(tmux show-env -g TMUX_FOCUS_TEMP_WIN | cut -d= -f2)

  # Swap back: original pane returns to placeholder's position in the layout
  tmux swap-pane -s "$PANE" -t "$PLACEHOLDER"

  # Kill the temp window (now contains the placeholder process)
  tmux kill-window -t "$TEMP_WIN" 2>/dev/null

  # Switch back to original window and select the returned pane
  tmux select-window -t "$ORIG_WIN"
  tmux select-pane -t "$PANE"

  tmux set-env -g TMUX_FOCUS_ACTIVE 0
  tmux set-env -gu TMUX_FOCUS_ORIG_WIN
  tmux set-env -gu TMUX_FOCUS_PLACEHOLDER
  tmux set-env -gu TMUX_FOCUS_PANE
  tmux set-env -gu TMUX_FOCUS_TEMP_WIN
else
  # === FOCUS: swap pane out to its own full-screen window ===
  PANE=$(tmux display -p '#{pane_id}')
  ORIG_WIN=$(tmux display -p '#{window_id}')

  # Create a temp window with a placeholder process (don't switch yet)
  PLACEHOLDER=$(tmux new-window -dP -F '#{pane_id}' -n 'focused' \
    "printf '\033[1;33m  pane focused in window [focused]\n  prefix + $KEY to toggle back\033[0m'; cat")
  TEMP_WIN=$(tmux display -p -t "$PLACEHOLDER" '#{window_id}')

  # Swap: our pane goes to temp window, placeholder takes its place in the layout
  tmux swap-pane -s "$PANE" -t "$PLACEHOLDER"

  tmux set-env -g TMUX_FOCUS_ACTIVE 1
  tmux set-env -g TMUX_FOCUS_ORIG_WIN "$ORIG_WIN"
  tmux set-env -g TMUX_FOCUS_PLACEHOLDER "$PLACEHOLDER"
  tmux set-env -g TMUX_FOCUS_PANE "$PANE"
  tmux set-env -g TMUX_FOCUS_TEMP_WIN "$TEMP_WIN"

  # Switch to the focused window
  tmux select-window -t "$TEMP_WIN"
fi
