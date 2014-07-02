# Ubuntu
if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*; do
    echo ". $file"
    . $file
  done
fi

source /opt/boxen/env.sh
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

# MacApp editors
alias atom='open -a Atom'
alias cot='open -a CotEditor'

# symlink to subl
if [ ! -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ] && [ "Darwin" = `uname -s` ]; then
  echo "install sublime text 3 from here"
  echo "http://www.sublimetext.com/3"
fi

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

# bundler
alias be='bundle exec'

# rails
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"

# rake
alias raket='RAILS_ENV=test rake'
alias raked='RAILS_ENV=development rake'
alias rakep='RAILS_ENV=production rake'

# editor
export EDITOR=emacs
export DOCKER_HOST=tcp://localhost:4243

# rspec_api_documentation
alias rspec-doc='rspec --format RspecApiDocumentation::ApiFormatter'

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# node
if [ -d $HOME/node_modules/.bin ]; then
  export PATH=$HOME/node_modules/.bin:$PATH
fi

# go
export PATH=$PATH:/opt/boxen/homebrew/opt/go/libexec/bin
export GOPATH=$HOME

# ghq + peco
# http://r7kamura.github.io/2014/06/21/ghq.html
p() { peco | while read LINE; do $@ $LINE; done }
alias e='ghq list -p | p cd'
