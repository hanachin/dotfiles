# Ubuntu
if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*; do
    echo ". $file"
    . $file
  done
fi

# autoload

autoload -Uz colors
autoload -Uz compinit

# exec
colors

# OSX Apps
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-darwin

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

# MacApp editors
alias atom='open -a Atom'
alias cot='open -a CotEditor'

# git
alias g=git
alias ga='git add'
alias gb='git branch'
alias gs='git status'
alias gco='git checkout'
alias gci='git commit'
alias gd='git diff'
alias gdc='git diff --cached'

# rbenv
alias re='rbenv exec'
alias gme='gem'

# bundler
alias be='bundle exec'

# rails
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"

# rake
alias raket='RAILS_ENV=test bundle exec rake'
alias raked='RAILS_ENV=development bundle exec rake'
alias rakep='RAILS_ENV=production bundle exec rake'

# editor
export EDITOR=emacs

# node
if [ -d $HOME/node_modules/.bin ]; then
  export PATH=$HOME/node_modules/.bin:$PATH
fi

# go
export GOPATH=$HOME

# ghq + peco
# http://r7kamura.github.io/2014/06/21/ghq.html
p() { peco | while read LINE; do $@ $LINE; done }
alias e='ghq list -p | p cd'

# ghs + peco
# http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a
function gpi () {
  [ "$#" -eq 0 ] && echo "Usage : gpi QUERY" && return 1
  ghs "$@" | peco | awk '{print $1}' | ghq import
}

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# [TODO] - save history in Dropbox directory
HISTFILE=~/.zsh_history
SAVEHIST=600000
HISTSIZE=600000

# tmuxinator
source ~/.bin/tmuxinator.zsh

eval "$(direnv hook zsh)"
