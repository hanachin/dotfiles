# Ubuntu
if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*; do
    echo ". $file"
    . $file
  done
fi

# rbenv(homebrew)
if [ -d /usr/local/var/rbenv ]; then
  export RBENV_ROOT=/usr/local/var/rbenv
else
  if [ "Darwin" = `uname -s` ]; then
    echo "install rbenv by following command"
    echo "brew install rbenv ruby-build"
  fi
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

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

# rails
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"

# rake
alias raket='RAILS_ENV=test rake'
alias raked='RAILS_ENV=development rake'
alias rakep='RAILS_ENV=production rake'

### Added by the Heroku Toolbelt
if [ -d /usr/local/heroku ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
else
  echo "install heroku toolbelt from here"
  echo "https://toolbelt.heroku.com/"
fi

# editor
export EDITOR=emacs
