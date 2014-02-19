#!/bin/sh
dotfiles=$(cd $(dirname $0) && pwd)
for dotfile in $dotfiles/*; do
  echo "ln -Fis $dotfile $HOME/.${dotfile##*/}"
  ln -Fis $dotfile $HOME/.${dotfile##*/}
done
if [ ! -d $HOME/.emacs.d ]; then
    mkdir $HOME/.emacs.d/
fi
echo "ln -Fis $dotfiles/emacs.d/init.el $HOME/.emacs.d/init.el"
ln -Fis $dotfiles/emacs.d/init.el $HOME/.emacs.d/init.el
