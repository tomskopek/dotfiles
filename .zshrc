# Profiling: `zsht` runs a shell with this on and prints a zprof report.
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# --- shell basics (replacing oh-my-zsh, which was slow) --------------------------------------------
# oh-my-zsh cost ~160ms of every shell's startup, and its robbyrussell prompt
# ran a `git status` for the ✗ marker on every single prompt, adding ~100ms
# Everything below is what it actually gave us: the prompt, some git aliases,
# its history and directory options, and its completion setup.

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups \
       hist_ignore_space hist_verify share_history
setopt autocd auto_pushd pushd_ignore_dups pushd_minus
setopt always_to_end complete_in_word interactive_comments long_list_jobs \
       no_flow_control prompt_subst

# Completion. The security scan is most of what compinit costs, so skip it and
# rebuild the dump at most once a day.
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qNmh-24) ]]; then compinit -C; else compinit; fi
[[ -d $HOME/.zcompcache ]] || mkdir -p $HOME/.zcompcache
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Kept from its lib: the non-git aliases worth having.
alias ls='ls -G'
alias l='ls -lah'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'

# Config split out by topic, from this repo. Sourced explicitly rather than
# globbed so the order stays visible: git.zsh defines the $_git_prompt segment
# that PROMPT interpolates below. $0 is just "zsh" in an rc file, so the path
# comes from %x, resolved through the ~/.zshrc symlink with :A.
ZSH_TOPIC_DIR="${${(%):-%x}:A:h}/zsh"
source "$ZSH_TOPIC_DIR/git.zsh"

PROMPT='%(?.%F{green}.%F{red})➜%f  %F{cyan}%c%f ${_git_prompt}'

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
# Sourcing nvm.sh cost ~930ms of this shell's ~1.17s startup, nearly all of it
# in nvm_auto resolving the default alias through dozens of subshells. Put the
# default version's bin on PATH directly -- node, npm and npx then work with no
# nvm at all -- and load nvm itself only if you actually call it.
() {
  local want bins
  [ -r "$NVM_DIR/alias/default" ] && read -r want < "$NVM_DIR/alias/default"
  bins=("$NVM_DIR"/versions/node/v${want#v}*/bin(Nn))
  (( $#bins )) || bins=("$NVM_DIR"/versions/node/*/bin(Nn))
  (( $#bins )) && export PATH="${bins[-1]}:$PATH"
}
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

# Automatically activate venv
function chpwd() {
  if [[ -f .venv/bin/activate ]]; then
    source .venv/bin/activate
  elif [[ -f venv/bin/activate ]]; then
    source venv/bin/activate
  fi
}

# Set up fzf key bindings and fuzzy completion. `fzf --zsh` is a ~30ms fork
# every shell, so cache it and refresh only when the binary changes.
_fzf_init="$HOME/.cache/fzf-init.zsh"
if [[ ! -s $_fzf_init || $commands[fzf] -nt $_fzf_init ]]; then
  mkdir -p ${_fzf_init:h} && fzf --zsh > $_fzf_init
fi
source $_fzf_init

alias zshc='vim ~/.zshrc'
alias zshs='source ~/.zshrc'
alias lg='lazygit'
alias vi='nvim'
alias vim='nvim'
alias dev='cd ~/dev'
alias vimcd='cd ~/.config/nvim'
alias dfcd='cd ~/dev/dotfiles'

chpwd  # run once on shell start, this is good for activating venv when creating new tmux pane, for example

# dotfiles scripts (ws, ...)
export PATH="$HOME/dev/dotfiles/bin:$PATH"

export EDITOR=nvim
bindkey -e
export VISUAL=nvim

# Startup profiling, the way the old config did it: `zsht` reports where the
# time goes. Kept because it is how the 1.1s -> 42ms startup was found.
alias zsht='time ZSH_DEBUGRC=1 zsh -i -c exit'

alias tmuxc='nvim ~/.tmux.conf'
alias vimc='nvim ~/.config/nvim/init.lua'
alias tmp='cd ~/dev/tmp'
alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"
alias python=python3

# Bundle id of an app, for karabiner/hammerspoon rules.
getid() { osascript -e "id of app \"$1\""; }

# --- machine-local overrides -------------------------------------------------
# Anything work-specific, private or host-specific lives here and not in this
# repo, which is public. See .zshrc.local.example. Loaded last so it wins.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

# Added by jcode installer
export PATH="/Users/tom/.local/bin:$PATH"
