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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vim='nvim'
alias mux='tmuxinator'

alias zshconfig="vim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias vimdir="cd ~/.vim/"
alias tmuxconfig="vim ~/.tmux.conf"
alias gitconfig="vim ~/.gitconfig"
alias pryconfig="vim ~/.pryrc"

alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"

alias dev='cd ~/dev'
alias pdev='cd ~/dev/personal'
alias dotfiles='cd ~/dev/personal/dotfiles'

# ---------- zappi stuff --------------

alias zdev='cd ~/dev/zappi'
alias zc='cd ~/dev/zappi/zappi.client; source activate q14'
alias zs='cd ~/dev/zappi/zappistore.app'
alias dc='cd ~/dev/zappi/data-collector.app'
alias ff='cd ~/dev/zappi/fluid.framework'
alias io='cd ~/dev/zappi/insight-out.engine'
alias se='cd ~/dev/zappi/stats_apps.engine'
alias mod='cd ~/dev/zappi/measure_data'
alias rjw='rake jobs:work_single'
alias rqs='rake quattro:server'
alias rs='rails s'
alias rc='rails c'
alias yf='yarn fluid'
alias rrs='rake resque:scheduler'
alias rss='bundle exec rake server:start'
alias rrw="bundle exec rake resque:work QUEUE='*'"
alias fs='foreman start'
alias ys='yarn start'
# quattro evaluat_on_inspect = true
export QUATTRO_INSPECT="true"

# ------------ lane stuff ---------------
alias ldev='cd ~/dev/lane-next/'
alias lmob='cd ~/dev/lane-next/lane-mobile'
alias ios='cd ~/dev/lane-next/lane-mobile/ios'
alias and='cd ~/dev/lane-next/lane-mobile/android'

# ------------ path stuff ---------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export MYSQL_PATH=/usr/local/Cellar/mysql@5.6
export PATH="$MYSQL_PATH:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# source activate q12
export PATH=/anaconda/bin:$PATH

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
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

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# -i: ignore case
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden -i --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden -i --follow --glob "!.git/*"'
#
#
# export APP_ENV="staging"
export APP_ENV="development"
export NODE_ENV="development"
