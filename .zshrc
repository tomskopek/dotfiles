# Profiling startup time
if [[ -n "$ZSH_DEBUGRC" ]]; then # credit: https://gist.github.com/elalemanyo/cb3395af64ac23df2e0c3ded8bd63b2f
  zmodload zsh/zprof
fi

export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"
# ZSH_THEME="nebirhos"

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

bindkey '^ ' autosuggest-accept

alias zsht='time ZSH_DEBUGRC=1 zsh -i -c exit'

alias todos='vim ~/Documents/todo.md'

alias vi='nvim'
alias vim='nvim'

alias zshc="vim ~/.zshrc"
alias zshs="source ~/.zshrc"
alias tmuxc="vim ~/.tmux.conf"
alias gitc="vim ~/.gitconfig"
alias vimc="vim ~/.config/nvim/lua/settings.lua"
alias hsc="vim ~/.hammerspoon/init.lua"
alias vimcd="cd ~/.config/nvim/"
alias localgitc="vim .git/info/exclude"
alias lg="lazygit"


alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"

alias dev='cd ~/dev'
alias tmp='cd ~/dev/tmp'
alias dotfiles='cd ~/dev/dotfiles'

# ---------- keyboard -----
getid() {
  osascript -e "id of app \"$1\""
}

# ---------- javascript stuff ---------
alias pkj='vim package.json'
alias ys='yarn start'

# --- Python
alias python=python3

# --- TopHouse
alias th='cd ~/dev/tophouse/'
alias tmo='cd ~/dev/tophouse/packages/mobile/'
alias ios='cd ~/dev/tophouse/packages/mobile/ios/'
alias and='cd ~/dev/tophouse/packages/mobile/android/'
alias tse='cd ~/dev/tophouse/packages/server/'
alias tdb='cd ~/dev/tophouse/packages/database/'
alias tcr='cd ~/dev/tophouse/packages/cron/'
alias tsh='cd ~/dev/tophouse/packages/shared/'
alias tbs='cd ~/dev/tophouse/packages/backend-shared/'
alias tfs='cd ~/dev/tophouse/packages/frontend-shared/'
alias twe='cd ~/dev/tophouse/packages/web/'
alias yss='yarn server dev'
alias yms='yarn mobile start'
alias yws='yarn web dev'
alias ymot='yarn mobile test --watch --testRegex '
alias yset='yarn server test --watch --testRegex '
alias ydbt='yarn database test --watch --testRegex '
alias ycrt='yarn cron test --watch --testRegex '
alias ysht='yarn shared test --watch --testRegex '
alias ywet='yarn web test --watch --testRegex '
alias ybst='yarn backend-shared test --watch --testRegex '

alias iosurl='f() { npx uri-scheme open $1 --ios };f'
alias andurl='f() { npx uri-scheme open $1 --android };f'

# --- django
alias mpt='f() { ./manage.py test $1 };f'

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

# ------------- fzf ---------------------

set rtp+=/usr/local/opt/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------- askpass
#export SUDO_ASKPASS=/usr/bin/ssh-askpass

# ------------- utf (necessary for fastlane)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


source /Users/tom/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

lazy_chruby() {
  source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
  source /opt/homebrew/opt/chruby/share/chruby/auto.sh
  chruby ruby-3.1.1
}
alias chruby=lazy_chruby

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tom/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tom/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tom/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tom/google-cloud-sdk/completion.zsh.inc'; fi

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/opt/homebrew/bin/micromamba';
export MAMBA_ROOT_PREFIX='/Users/tom/.local/share/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# django
alias removemigration="git status | grep migrations/ | awk '{print $NF}'"

alias alertme='printf \\a; sleep 0.1; printf \\a; sleep 0.1; printf \\a; sleep 0.1; printf \\a; sleep 0.1; printf \\a'

IPDB_CONFIG=~/dev/dotfiles/setup.cfg

export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
eval "$(/Users/tom/.local/bin/mise activate zsh)"

# End of profiling zsh
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
