# tmux-focus-pane

Pop any pane out to a full-screen window, then pop it back — with the original layout preserved exactly.

Unlike tmux's built-in `break-pane`/`join-pane` (or zoom), this plugin uses `swap-pane` under the hood so your split ratios, positions, and geometry stay pixel-perfect when the pane returns.

## How it works

```
┌──────┬──────┐                           ┌─────────────┐
│      │  B   │                           │             │
│  A   ├──────┤  ── prefix + F on B ──▶   │      B      │
│      │  C   │                           │  (focused)  │
└──────┴──────┘                           └─────────────┘

  original window                          new window
  A stays put, a                           B is now
  placeholder marks                        full-screen
  B's spot

┌─────────────┐                           ┌──────┬──────┐
│             │                           │      │  B   │
│      B      │  ── prefix + F again ──▶  │  A   ├──────┤
│  (focused)  │                           │      │  C   │
└─────────────┘                           └──────┴──────┘

  focused window                           layout restored
                                           exactly as before
```

A yellow placeholder sits in the vacated slot so you always know where the pane went.

## Installation

### With [TPM](https://github.com/tmux-plugins/tpm) (recommended)

Add to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tomskopek/tmux-focus-pane'
```

Then press `prefix + I` to install.

### Manual

Clone the repo:

```sh
git clone https://github.com/tomskopek/tmux-focus-pane ~/.tmux/plugins/tmux-focus-pane
```

Add to your `~/.tmux.conf`:

```tmux
run-shell ~/.tmux/plugins/tmux-focus-pane/focus-pane.tmux
```

Reload:

```sh
tmux source-file ~/.tmux.conf
```

## Usage

| Action | Default key |
|---|---|
| Focus / unfocus pane | `prefix + F` |

When a pane is focused, a placeholder with a yellow message appears in the original position. Press the same key again to swap it back.

## Configuration

Add any of these to `~/.tmux.conf` **before** the TPM `run` line:

```tmux
# Change the keybinding (default: F)
set -g @focus-pane-key 'Z'
```

## Why not just use zoom?

tmux's built-in `resize-pane -Z` (zoom) works well for quick peeks, but:

- Zoom hides all other panes — you can't interact with them or see their output while one is zoomed
- Zoom is scoped to the same window, so it clutters your window list less, but you can't e.g. have the zoomed view on one monitor and the splits on another

`tmux-focus-pane` breaks the pane into its own window so the rest of your layout remains visible and usable in the original window.

## License

[MIT](LICENSE)
