#!/bin/bash

info=$(hyprctl activewindow -j 2>/dev/null)
[ -z "$info" ] && exit 0

pid=$(echo "$info" | jq -r '.pid')
class=$(echo "$info" | jq -r '.class' | tr '[:upper:]' '[:lower:]')
[ -z "$pid" ] || [ "$pid" = "null" ] && exit 0

cli_tools=(nvim htop btop lazygit lf ranger yazi tmux)

find_cli() {
  for child in $(pgrep -P "$1"); do
    cmd=$(ps -p "$child" -o comm=)
    if [[ " ${cli_tools[*]} " =~ " $cmd " ]]; then
      sub=$(find_cli "$child")
      echo "${sub:-$cmd}"
      return
    else
      sub=$(find_cli "$child")
      [ -n "$sub" ] && echo "$sub" && return
    fi
  done
}

cli_app=$(find_cli "$pid")
app="${cli_app:-$class}"

declare -A icon_map=(
  [firefox]="" [code]="" [alacritty]="" [kitty]="󰄛" [foot]=""
  [nvim]="" [htop]="" [btop]="" [lazygit]=""
  [lf]="" [ranger]="" [yazi]="" [tmux]="" [zen]="󰈹"
)

icon="${icon_map[$app]:-}"

# Capitalize
name="$(tr '[:upper:]' '[:lower:]' <<< "${app:0:1}")${app:1}"
name="$(echo "$name" | sed 's/.*/\u&/')"

echo "$icon $name"

