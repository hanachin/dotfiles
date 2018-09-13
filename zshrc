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
if [ -d /Applications/Postgres.app ]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/9.5/bin:$PATH"
  export PGHOST=localhost
fi
if [ -d /Applications/calibre.app ]; then
  export PATH=$PATH:~/Applications/calibre.app/Contents/MacOS
fi

## home bin
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
export PATH=$HOME/bin:$PATH

# variables
export EDITOR='emacs -nw'
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
alias l='ls'
alias gt='git'
alias emacs='emacs -nw'
alias a='git add'
# alias b='git branch'
alias d='git diff'
alias dc='git diff --cached'
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

# rbenv
if which brew > /dev/null; then
  export RBENV_ROOT=/usr/local/var/rbenv
fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ -x ~/.rbenv/bin/rbenv ]; then eval "$(~/.rbenv/bin/rbenv init -)"; fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# tmuxinator
source ~/.bin/tmuxinator.zsh

# direnv
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# TODO: mono
if which brew > /dev/null; then
  export MONO_GAC_PREFIX="/usr/local"
fi

# Java
if [ -d /Library/Java/JavaVirtualMachines ]; then
  export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home'
fi

# Android
if which brew > /dev/null; then
  export ANDROID_HOME=/usr/local/opt/android-sdk
fi

# nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

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

yo() {
  local message=$(cat -)
  local room=($(nidobata rooms | peco | sed 's#/# #'))
  if read -q "?Post to $room[1]/$room[2] (y/n) ? "; then
    echo
    nidobata post --pre $room[1] $room[2] $message
  else
    echo
  fi
}

# less
export LESS='-R'
export LESSOPEN='| src-hilite-lesspipe.sh %s'

export LANG="ja_JP.UTF-8"

alias gsed=sed

export GOBY_ROOT=$GOPATH/src/github.com/goby-lang/goby

export PATH="$HOME/.yarn/bin:$PATH"

if [ -d /usr/local/opt/mysql@5.6/bin ]; then
  export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
fi

if [ -d /Applications/FirefoxESR.app/Contents/MacOS ]; then
  export SLIMERJSLAUNCHER=/Applications/FirefoxESR.app/Contents/MacOS/firefox
fi

if [ -d /usr/local/opt/qt/bin ]; then
  export PATH="/usr/local/opt/qt/bin:$PATH"
fi

if [ -d ~/google-cloud-sdk ]; then
  export PATH=$PATH:~/google-cloud-sdk/bin
fi

# opam
if [ -d ~/local/bin ]; then
  export PATH=$PATH:~/local/bin
fi

# ESP32
if [ -d ~/esp/xtensa-esp32-elf/ ]; then
  export PATH=$PATH:~/esp/xtensa-esp32-elf/bin
fi

if [ -d ~/esp/esp-idf ]; then
  export IDF_PATH=~/esp/esp-idf
fi
