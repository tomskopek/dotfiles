# Example config for `ws` — copy to ~/.config/ws/config.sh and edit.
#
# Kept out of this repo on purpose: it names your repos and local config
# paths, which are usually work-specific. Sourced by ws, so it's plain bash.

# Where workspaces are created, and where canonical clones live.
WS_ROOT="$HOME/ws"
DEV_ROOT="$HOME/dev"

# Branch prefix for a new worktree, e.g. workspace "fix-login" -> tom/fix-login.
WS_BRANCH_PREFIX="tom/"

# Never offer these in the repo picker (duplicate clones, dotfiles, ...).
WS_EXCLUDE_REPOS="dotfiles scratch"

# Show these first in the picker.
WS_PINNED_REPOS="webapp"

# Untracked paths copied into every new worktree from its canonical clone.
WS_COMMON_COPY=".env CLAUDE.local.md .claude/settings.local.json"

# Optional: extra untracked paths, per repo. $1 is the repo name.
ws_copy_list() {
  case "$1" in
    webapp) echo "packages/server/certs config/local.yml" ;;
  esac
}

# Optional: extra setup after deps install. $1 = repo name, $2 = worktree path.
# ws_setup() {
#   case "$1" in
#     webapp) (cd "$2" && git submodule update --init --recursive) ;;
#   esac
# }

# Optional: canonical clone path, if it isn't $DEV_ROOT/<name>. When you alias
# a name this way, add the real directory to WS_EXCLUDE_REPOS so the picker
# doesn't offer both. Teardown doesn't rely on this — it asks git which clone a
# worktree belongs to — so removing an alias never orphans existing workspaces.
# ws_repo_path() {
#   case "$1" in
#     webapp) echo "$DEV_ROOT/webapp-main" ;;
#     *) echo "$DEV_ROOT/$1" ;;
#   esac
# }
