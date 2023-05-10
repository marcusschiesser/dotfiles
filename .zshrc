alias ll="ls -lach"

eval "$(oh-my-posh init zsh --config ~/.config/poshtheme.omp.json)"

autoload -Uz compinit
compinit

# Function to source all files in a directory
source_files_in_directory() {
    local dir="$1"

    if [ -d "$dir" ]; then
        for x in "${dir}"/*(DN); do
            source "$x"
        done
    fi
}

# Load additional zsh configs
source_files_in_directory "${HOME}/.config/zsh"
source_files_in_directory "${HOME}/zsh.d"
