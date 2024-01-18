#!/bin/bash

DOTFILEDIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
dotfiles=$(ls -1 -A $DOTFILEDIR | grep -v -e .git -e bootstrap 2>/dev/null)

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
  brew install fish vim oh-my-posh node
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Ensure that fish and vim are installed under Linux
  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
  curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg >/dev/null
  sudo apt-get update && DEBIAN_FRONTEND=noninteractive \
    sudo -E apt-get -y install --no-install-recommends fish vim
  # and oh-my-posh
  if ! [ -x "$(command -v oh-my-posh)" ]; then
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh && sudo chmod +x /usr/local/bin/oh-my-posh
  fi
fi

# Check if the package is already installed
installed=$(npm list -g --depth=0 @githubnext/github-copilot-cli 2>/dev/null)

# Install the package if it's not installed
if [[ -z "$installed" ]]; then
  npm install -g @githubnext/github-copilot-cli
fi
