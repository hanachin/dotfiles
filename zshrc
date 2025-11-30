if which brew > /dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
elif [ -d /usr/share/zsh/site-functions ]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
fi
fpath=($HOME/.zsh/functions $fpath)

# autoload
autoload -Uz compinit

# autoload my funcs
autoload -Uz gpi
autoload -Uz p
autoload -Uz promptori

# setopt
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# variables
export EDITOR='emacs -nw'

# zshparam
HISTFILE=~/.zsh_history
SAVEHIST=600000
HISTSIZE=600000

# keybind
bindkey -e

# exec
compinit
promptori

# aliases
alias l='ls'
alias gt='git'
alias emacs='emacs -nw'
alias a='git add'
# alias b='git branch'
alias d='docker'
alias dc='docker-compose'
alias ds='git diff --staged'
alias atom='open -a /Applications/Atom.app/Contents/MacOS/Atom'
alias b='bundle'
alias be='bundle exec'
alias c='git commit'
alias ci='git commit -S'
alias co='git checkout'
alias cot='open -a CotEditor'
alias e='ghq list -p | p cd'
alias g=git
alias ga='git add'
alias gb='git branch'
alias gci='git commit -S'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gme='gem'
alias gs='git status'
alias re='rbenv exec'
alias raked='RAILS_ENV=development bundle exec rake'
alias rakep='RAILS_ENV=production bundle exec rake'
alias raket='RAILS_ENV=test bundle exec rake'
alias s='git status'
alias ti='tig'

alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"
alias -g RET="RAILS_ENV=test"

# direnv
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# zplug
if [ -d /usr/local/opt/zplug ]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh
fi

if which zplug > /dev/null; then
  zplug "b4b4r07/enhancd", use:init.sh

  if ! zplug check; then
     zplug install
  fi

  zplug load
fi

# less
export LESS='-R'
export LESSOPEN='| src-hilite-lesspipe.sh %s'
export LANG="ja_JP.UTF-8"
export GPG_TTY=$(tty)

if [ -n "$(uname -a | grep Nix)" ]; then
  export GPG_TTY="$(tty)"
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
