#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# zsh
HISTSIZE=100000
SAVEHIST=100000
unsetopt CORRECT
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# variable
export TERM=xterm-256color
export EDITOR=nvim

# alias
alias vi=nvim
alias vim=nvim
alias top=htop
alias cat=bat
alias ls=lsd
alias ll='ls -l'
alias la='ls -la'
alias gst='git status'
alias gd='git diff'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g F='| fzf'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--height 40% --reverse --ansi"

# ghq
gf() {
  local dir
  dir=$(ghq list > /dev/null | fzf) &&
    cd $(ghq root)/$dir
}
