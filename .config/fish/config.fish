set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$CHECKOUT/bin" $fish_user_paths
set -x DOCKER_DEFAULT_PLATFORM linux/amd64
oh-my-posh init fish --config ~/.config/poshtheme.omp.json | source
