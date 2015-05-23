# Homebrew
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# autoload

autoload -Uz colors
autoload -Uz compinit

# setopt
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# PATH

## OSX Apps
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-darwin

## home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

## node
if [ -d $HOME/node_modules/.bin ]; then
  export PATH=$HOME/node_modules/.bin:$PATH
fi

# variables
export EDITOR=emacs
export GOPATH=$HOME

# zshparam
HISTFILE=~/.zsh_history
SAVEHIST=600000
HISTSIZE=600000

# exec
colors
compinit

# aliases
alias a='git add'
alias b='git branch'
alias d='git diff'
alias dc='git diff --cached'
alias atom='open -a Atom'
alias be='bundle exec'
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

# functions
## ghq + peco
## http://r7kamura.github.io/2014/06/21/ghq.html
p() { peco | while read LINE; do $@ $LINE; done }

## ghs + peco
## http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a
function gpi () {
  [ "$#" -eq 0 ] && echo "Usage : gpi QUERY" && return 1
  ghs "$@" | peco | awk '{print $1}' | ghq import
}

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# tmuxinator
source ~/.bin/tmuxinator.zsh

# direnv
eval "$(direnv hook zsh)"
