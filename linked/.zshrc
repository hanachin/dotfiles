# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# [TODO] - save history in Dropbox directory
HISTFILE=~/.zsh_history
SAVEHIST=600000
HISTSIZE=600000

# tmuxinator
source ~/.bin/tmuxinator.zsh

eval "$(direnv hook zsh)"
