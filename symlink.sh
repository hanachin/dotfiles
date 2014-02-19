#!/bin/sh
dotfiles=$(cd $(dirname $0) && pwd)
for dotfile in $dotfiles/*; do
  echo "ln -Fis $dotfile $HOME/.${dotfile##*/}"
  ln -Fis $dotfile $HOME/.${dotfile##*/}
done
echo "ln -Fis $dotfiles/emacs.d/ $HOME/.emacs.d"
ln -Fis $dotfiles/emacs.d/ $HOME/.emacs.d
