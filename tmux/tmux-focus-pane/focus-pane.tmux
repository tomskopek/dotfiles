#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
    local key
    key=$(tmux show-option -gqv "@focus-pane-key")
    key="${key:-F}"

    tmux set-env -g TMUX_FOCUS_KEY "$key"
    tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/toggle.sh"
}

main
