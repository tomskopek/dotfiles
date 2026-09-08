# Example config for `bay` — copy to ~/.config/bay/config.sh and edit.
# Every value below is already the default, so the file is optional.
#
# Workspace paths (WS_ROOT, DEV_ROOT) come from ~/.config/ws/config.sh.

# Command started in the claude window. Empty leaves a plain shell.
BAY_CLAUDE_CMD="claude"

# Command started in the vim window. Empty leaves a plain shell.
BAY_EDITOR_CMD="nvim"

# Panes in the srv window. bay splits them and runs nothing, so the servers
# are yours to start.
BAY_SRV_PANES=3

# Plain clones from DEV_ROOT to list in the hub. Use this for work that needs
# no worktree, such as your dotfiles. Such a session gets the same four
# windows, rooted in the clone itself. C-d (tear down) refuses on these rows,
# because there is no workspace to remove.
BAY_DEV_REPOS="dotfiles"

# Instead of the allowlist above, list every repo in DEV_ROOT. Repos named in
# WS_EXCLUDE_REPOS (ws config) stay hidden. Off by default: with many clones
# the hub gets long.
BAY_INCLUDE_DEV_REPOS=0

# --- alerting (bay-hook) ------------------------------------------------------
# `bay-hook` marks a session 🔔 when its agent is blocked on you and ✅ when it
# finishes. Run `bay-hook install` for the settings.json block.

# Flash a tmux message on every client that is not already looking at the
# session. Set to 0 for marks only, with no interruption.
BAY_ALERT_MESSAGE=1

# States that raise an alert. Use "wait" alone to be told about blocks only.
BAY_ALERT_STATES="wait done"

# Run on the same transitions, with the state and the session name as $1 and
# $2. Empty means do nothing. macOS desktop notification:
# BAY_ALERT_CMD='f() { osascript -e "display notification \"$2\" with title \"bay: $1\""; }; f'
# Or a sound:
# BAY_ALERT_CMD='f() { afplay /System/Library/Sounds/Glass.aiff; }; f'
BAY_ALERT_CMD=""

# --- the working spinner ------------------------------------------------------
# The mark on a working agent animates. fzf has no timer event, so `bay --tick`
# posts one frame at a time to the port fzf opens with --listen. It stops when
# the hub closes, and skips the redraw while no agent is working.

# Frames, separated by "|". Each is padded to three display cells to line up
# with the other marks: a one-cell glyph needs two trailing spaces, a two-cell
# emoji needs one. Some alternatives, all dependency-free:
#   braille  "⠋  |⠙  |⠹  |⠸  |⠼  |⠴  |⠦  |⠧  |⠇  |⠏  "
#   moon     "🌑 |🌒 |🌓 |🌔 |🌕 |🌖 |🌗 |🌘 "
#   pulse    "▁  |▃  |▄  |▅  |▆  |▇  |▆  |▅  |▄  |▃  "
BAY_SPIN_FRAMES="◐  |◓  |◑  |◒  "

# Seconds between frames. Four frames at 0.2 is one turn per second.
BAY_SPIN_INTERVAL=0.2

# Frames after which a hub left open stops ticking, so it cannot spin forever.
BAY_SPIN_CAP=900
