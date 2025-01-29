set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
set -g fish_user_paths "$CHECKOUT/bin" $fish_user_paths
set -g fish_user_paths "$HOME/bin" $fish_user_paths
set -g fish_user_paths "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin" $fish_user_paths
# set -x DOCKER_HOST "unix://$HOME/.orbstack/run/docker.sock"
set -x DOCKER_HOST "unix://$HOME/.docker/run/docker.sock"
oh-my-posh init fish --config ~/.config/poshtheme.omp.json | source

# pnpm
set -gx PNPM_HOME "/Users/marcus/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

alias ls='ls -exa'
alias gg='github-copilot-cli what-the-shell'

# Created by `pipx` on 2024-01-18 06:39:02
set PATH $PATH /Users/marcus/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

source $__fish_config_dir/secrets.fish

function dotenv
    set -gx (cat $argv | string split = | string trim)
end
