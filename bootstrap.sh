#!/bin/bash

DOTFILEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
dotfiles=$(ls -1 -A $DOTFILEDIR | grep -v -e .git -e bootstrap 2> /dev/null)

if [[ $dotfiles ]]; then
  echo "Symlinking dotfiles..."

  for dotfile in $dotfiles; do
    echo "$dotfile"
    ln -fs $DOTFILEDIR/$dotfile $HOME/$dotfile
  done

  echo "All set!"

else
  echo "You don't have anything in '$DOTFILEDIR'"
fi

if [ "$(uname)" == "Darwin" ]; then
  # Nushell MacOS hack
  ln -s $DOTFILEDIR/.config/nushell "$HOME/Library/Application Support"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Ensure that fish is installed under Linux
  apt-get update && export DEBIAN_FRONTEND=noninteractive \
      && apt-get -y install --no-install-recommends fish
fi


