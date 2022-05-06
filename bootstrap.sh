#!/bin/bash

DOTFILEDIR="$HOME/dotfiles"
dotfiles=$(ls -1 -A $DOTFILEDIR | grep -v -e .git -e bootstrap 2> /dev/null)

if [[ $dotfiles ]]; then
  echo "Symlinking dotfiles..."

  for dotfile in $dotfiles; do
    echo "$dotfile"
    ln -s $DOTFILEDIR/$dotfile $HOME/$dotfile
  done

  echo "All set!"

else
  echo "You don't have anything in '$DOTFILEDIR'"
fi
