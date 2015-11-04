fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/functions $fpath)

# autoload
autoload -Uz compinit

# autoload my funcs
autoload -Uz gpi
autoload -Uz growl
autoload -Uz p
autoload -Uz promptori

# setopt
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# PATH

## OSX Apps
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-darwin
export PATH=$PATH:~/Applications/calibre.app/Contents/MacOS

## home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

# variables
export EDITOR=emacs
export GOPATH=$HOME

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
alias a='git add'
alias b='git branch'
alias d='git diff'
alias dc='git diff --cached'
alias ds='git diff --staged'
alias atom='open -a Atom'
alias be='bundle exec'
alias c='git commit'
alias ci='git commit'
alias co='git checkout'
alias cot='open -a CotEditor'
alias e='ghq list -p | p cd'
alias g=git
alias ga='git add'
alias gb='git branch'
alias gci='git commit'
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

alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"
alias -g RET="RAILS_ENV=test"

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# tmuxinator
source ~/.bin/tmuxinator.zsh

# direnv
eval "$(direnv hook zsh)"

# boot2docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/sei/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
