set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
set -g fish_user_paths "$CHECKOUT/bin" $fish_user_paths
set -g fish_user_paths "$HOME/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/node@18/bin" $fish_user_paths
set -x DOCKER_HOST "unix://$HOME/.orbstack/run/docker.sock"
oh-my-posh init fish --config ~/.config/poshtheme.omp.json | source

# pnpm
set -gx PNPM_HOME "/Users/marcus/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

alias ls='ls -exa'
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias gg='github-copilot-cli what-the-shell'
