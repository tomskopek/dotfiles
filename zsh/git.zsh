# Git: aliases and showing the prompt's branch segment (a lite version of the oh-my-zsh style of showing the current git branch).
# Sourced by .zshrc. Everything here assumes nothing about load order except
# that it runs before PROMPT is defined.

# Useful aliases from oh-my-zsh's git plugin
alias g=git
alias gco='git checkout'
alias gst='git status'
alias gc='git commit --verbose'
alias gcp='git cherry-pick'
alias gfg='git ls-files | grep'

alias gitc='nvim ~/.gitconfig'
alias localgitc='nvim .git/info/exclude'   # per-clone ignores, untracked

# The current branch, read straight out of .git. Sets REPLY.
#
# Two things this deliberately does not do. It does not call `git`, which would
# be a fork on every prompt. And it does not check whether the tree is dirty:
# that is a full worktree scan, which measured 145ms in dev/ui and 122ms in the
# ws worktrees -- paid on every single prompt, and the reason the shell used to
# feel slow. The robbyrussell ✗ marker is what cost that.
#
# Handles a worktree, whose .git is a one-line pointer to the real gitdir, and
# a detached HEAD, which shows as a short sha.
_git_branch() {
  local dir=$PWD gitdir line
  REPLY=""
  while [[ $dir != / && -n $dir ]]; do
    [[ -e $dir/.git ]] && break
    dir=${dir:h}
  done
  [[ -e $dir/.git ]] || return 0
  gitdir=$dir/.git
  if [[ -f $gitdir ]]; then
    read -r line < $gitdir || return 0
    gitdir=${line#gitdir: }
  fi
  [[ -r $gitdir/HEAD ]] || return 0
  read -r line < $gitdir/HEAD || return 0
  if [[ $line == "ref: refs/heads/"* ]]; then
    REPLY=${line#ref: refs/heads/}
  else
    REPLY=${line[1,7]}
  fi
}

# The "git:(branch)" part of the prompt, in oh-my-zsh's robbyrussell colours.
# .zshrc interpolates $_git_prompt into PROMPT.
_git_prompt=""
_set_git_prompt() {
  local REPLY
  _git_branch
  if [[ -n $REPLY ]]; then
    _git_prompt="%F{blue}git:(%F{red}${REPLY}%F{blue})%f "
  else
    _git_prompt=""
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _set_git_prompt
