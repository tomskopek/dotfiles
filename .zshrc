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
alias vim='nvim'
alias mux='tmuxinator'

alias zshc="vim ~/.zshrc"
alias zshs="source ~/.zshrc"
alias vimc="vim ~/.vimrc"
alias vimdir="cd ~/.vim/"
alias tmuxc="vim ~/.tmux.conf"
alias gitc="vim ~/.gitconfig"
alias pryc="vim ~/.pryrc"

alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"

alias dev='cd ~/dev'
alias pdev='cd ~/dev/personal'
alias dotfiles='cd ~/dev/personal/dotfiles'

# ---------- docker -------------------
alias nukedocker='docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -aq) && docker system prune'

# ---------- javascript stuff ---------
alias pkj='vim package.json'

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
alias lne='cd ~/dev/lane/lane-next/'
alias lmo='cd ~/dev/lane/lane-next/packages/lane-mobile'
alias lwe='cd ~/dev/lane/lane-next/packages/lane-web'
alias lse='cd ~/dev/lane/lane-next/packages/lane-server'
alias lin='cd ~/dev/lane/lane-next/packages/lane-infrastructure'
alias lsh='cd ~/dev/lane/lane-next/packages/lane-shared'
alias lim='cd ~/dev/lane/lane-next/packages/import'
alias ios='cd ~/dev/lane/lane-next/packages/lane-mobile/ios'
alias and='cd ~/dev/lane/lane-next/packages/lane-mobile/android'

alias yms='yarn workspace lane-mobile start'
alias yss='yarn workspace lane-server start'
# alias yss='yarn workspace lane-server dev:start'
alias yws='yarn workspace lane-web start'

alias nukeenv='rm -rf node_modules; rm -rf packages/lane-mobile/node_modules; lerna bootstrap && lerna link'
alias lers='lerna clean && lerna bootstrap && lerna link'

export APP_ENV="local"
export NODE_ENV="local"
export DISABLE_KAFKA=true
export APP_URL="http://192.168.2.84:5000"
export LINEAR_API_KEY="Fp2Bo1eqRM7r4aHB6EAsEV5Hjj2wl1w03XovYgXP"
# export HUSKY_SKIP_HOOKS="true"

# ------------ dwtd stuff ---------------
alias dse='cd ~/dev/personal/dwtd/dwtd_server/'
alias drn='cd ~/dev/personal/dwtd/dwtd_react_native/'
alias dsh='cd ~/dev/personal/dwtd/dwtd_shared/'
alias dwe='cd ~/dev/personal/dwtd/dwtd_web/'

# ------------ line3 stuff ---------------
alias line3='cd ~/dev/line3/'
alias lwe='cd ~/dev/line3/line3_web/'
alias lse='cd ~/dev/line3/line3_server/'

# ------------ path stuff ---------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export MYSQL_PATH=/usr/local/Cellar/mysql@5.6
export PATH="$MYSQL_PATH:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/Users/tom/Library/Python/2.7/bin:$PATH"

# source activate q12
export PATH=/anaconda/bin:$PATH

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# --- android ---
# mac
export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
# ubuntu
#export ANDROID_HOME=$HOME/Android/sdk
#export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-openj9-amd64/jre

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
# export FZF_DEFAULT_COMMAND='rg --files --hidden -i --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden -i --follow --glob "!.git/*"'
#
#

