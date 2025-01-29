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

function dotenv
    # Check if file exists and is provided
    if test (count $argv) -eq 0
        echo "Usage: dotenv <path-to-env-file>"
        return 1
    end
    
    if not test -f "$argv[1]"
        echo "File not found: $argv[1]"
        return 1
    end

    while read -l line
        # Skip empty lines and comments
        if string match -rq '^\s*$|^\s*#' -- $line
            continue
        end
        
        # Extract key and value
        set -l key (string match -r '^\s*([^=]+?)\s*=' $line)[2]
        set -l value (string match -r '^\s*[^=]+?\s*=\s*(.+?)\s*$' $line)[2]
        
        # Remove quotes if present
        if string match -rq '^".*"$|^'"'"'.*'"'"'$' -- $value
            set value (string sub -s 2 -e -1 -- $value)
        end
        
        if test -n "$key" -a -n "$value"
            set -gx $key $value
        end
    end < $argv[1]
end

# Load environment variables from ~/.env
if test -f "$HOME/.env"
    dotenv "$HOME/.env"
end
