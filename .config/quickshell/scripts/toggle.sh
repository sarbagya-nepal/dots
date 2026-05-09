TARGET="$1"
STATE_FILE="$HOME/.config/quickshell/.toggle_${TARGET}"

# Create file to signal toggle
touch "$STATE_FILE"
