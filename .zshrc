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
typeset -U path PATH
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
if (( $+commands[ghq] )); then
  gf() {
    local dir
    dir=$(ghq list > /dev/null | fzf) &&
      cd $(ghq root)/$dir
  }
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  unfunction "$0"
  eval "$(pyenv init - --no-rehash)"
  eval "$(pyenv virtualenv-init -)"
  $0 "$@"
}

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
goenv() {
  unfunction "$0"
  export GOPATH=$HOME/.go
  export PATH="$GOPATH/bin:$PATH"
  eval "$(goenv init - --no-rehash)"
  $0 "$@"
}

# fnm
if (( $+commands[fnm] )); then
  eval "$(fnm env)"
fi

# rust
if (( $+commands[rustc] )); then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# tools
if (( $+commands[broot] )); then
  source $HOME/.config/broot/launcher/bash/br
fi
if (( $+commands[htop] )); then
  alias top=htop
fi
if (( $+commands[lsd] )); then
  alias ls=lsd
fi
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# wsl
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH="/mnt/c/Program\ Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin:$PATH"
fi
