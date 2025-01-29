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

# Function to load environment variables from a file
dotenv() {
    # Check if file is provided
    if [ -z "$1" ]; then
        echo "Usage: dotenv <path-to-env-file>"
        return 1
    fi

    # Check if file exists
    if [ ! -f "$1" ]; then
        echo "File not found: $1"
        return 1
    fi

    # Export environment variables, ignoring comments and empty lines
    while IFS='=' read -r key value || [ -n "$key" ]; do
        # Skip comments and empty lines
        if [[ $key =~ ^[[:space:]]*$ ]] || [[ $key =~ ^# ]]; then
            continue
        fi
        # Remove leading/trailing whitespace and quotes
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        # Remove surrounding quotes if they exist
        value=${value%\"}
        value=${value#\"}
        # Export the variable
        export "$key=$value"
    done < "$1"
}

# Load environment variables from ~/.env
if [ -f "${HOME}/.env" ]; then
    dotenv "${HOME}/.env"
fi
