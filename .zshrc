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
setopt NO_BEEP

# variable
export COLORTERM=24bit
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim
export LESS='-qR'
export GHQ_ROOT=${HOME}/.ghq

# alias
alias ll='ls -l'
alias la='ls -la'
alias gst='git status'
alias gd='git diff'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

# nvim
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  alias vi=nvim
  alias vim=nvim
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if (( $+commands[fzf] )); then
  alias -g F='| fzf'
  export FZF_DEFAULT_COMMAND="fd --type file --color=always"
  export FZF_DEFAULT_OPTS="--height 40% --reverse --ansi"
fi

# ghq
gf() {
  local dir
  dir=$(ghq list > /dev/null | fzf) &&
    cd $(ghq root)/$dir
}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
fi

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
if (( $+commands[goenv] )); then
  eval "$(goenv init -)"
fi

# fnm
if (( $+commands[fnm] )); then
  eval "$(fnm env)"
fi

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# tools
if (( $+commands[htop] )); then
  alias top=htop
fi
if (( $+commands[lsd] )); then
  alias ls=lsd
fi
