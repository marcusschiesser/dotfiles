# Check if the github-copilot-cli command is available
if command -v github-copilot-cli >/dev/null 2>&1; then
    eval "$(github-copilot-cli alias -- "$0")"
fi
