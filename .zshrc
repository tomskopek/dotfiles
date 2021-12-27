# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="nebirhos"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


bindkey '^ ' autosuggest-accept

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vi='nvim'
alias vim='nvim'

alias zshc="vim ~/.zshrc"
alias zshs="source ~/.zshrc"
alias tmuxc="vim ~/.tmux.conf"
alias gitc="vim ~/.gitconfig"
alias vimc="vim ~/.config/nvim/tom"
alias vimcd="cd ~/.config/nvim/tom"

alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"

alias dev='cd ~/dev'
alias tmp='cd ~/dev/tmp'
alias dotfiles='cd ~/dev/dotfiles'

# ---------- javascript stuff ---------
alias pkj='vim package.json'
alias ys='yarn start'

# --- TopHouse
alias th='cd ~/dev/tophouse/'
alias tmo='cd ~/dev/tophouse/packages/mobile/'
alias ios='cd ~/dev/tophouse/packages/mobile/ios/'
alias and='cd ~/dev/tophouse/packages/mobile/android/'
alias tse='cd ~/dev/tophouse/packages/server/'
alias tdb='cd ~/dev/tophouse/packages/database/'
alias tcr='cd ~/dev/tophouse/packages/cron/'
alias tsh='cd ~/dev/tophouse/packages/shared/'
alias twe='cd ~/dev/tophouse/packages/web/'
alias yss='yarn server start'
alias yms='yarn mobile start'
alias yws='yarn web start'

case "$OSTYPE" in
  darwin*)
    source "${ZDOTDIR:-${HOME}}/.zshrc-mac"
  ;;
  linux*)
    source "${ZDOTDIR:-${HOME}}/.zshrc-ubuntu"
  ;;
esac

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# ------------- nvm ---------------------
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ------------- fzf ---------------------

# set rtp+=/usr/local/opt/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------- pyenv -------------------
eval "$(pyenv init -)"

# ------------- askpass
export SUDO_ASKPASS=/usr/bin/ssh-askpass

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
