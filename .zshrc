alias ll="ls -lach"

eval "$(oh-my-posh init zsh --config ~/.config/poshtheme.omp.json)"

autoload -Uz compinit
compinit

# Load additional zsh configs
if [ -d $HOME/.config/zsh ]; then
    cd $HOME/.config/zsh
    # Taken from https://unix.stackexchange.com/a/504718/94685
    for x in *(DN); do
        source $x
    done
    cd
fi
