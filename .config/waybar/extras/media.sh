#!/bin/bash

# Spotify Waybar Module Script - Simple version with scroll controls
# Dependencies: playerctl

get_spotify_info() {
    # Check if Spotify is running
    if ! pgrep -x "spotify" > /dev/null; then
        echo '{"text": "No Spotify", "tooltip": "Spotify not running"}'
        return
    fi

    # Get player status
    status=$(playerctl -p spotify status 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo '{"text": "No Spotify", "tooltip": "Spotify not running"}'
        return
    fi

    # Get track info
    title=$(playerctl -p spotify metadata title 2>/dev/null)
    artist=$(playerctl -p spotify metadata artist 2>/dev/null)
    album=$(playerctl -p spotify metadata album 2>/dev/null)

    # Handle empty metadata
    if [ -z "$title" ] || [ -z "$artist" ]; then
        echo '{"text": "No Track", "tooltip": "No track playing"}'
        return
    fi

    # Truncate long titles/artists for display
    if [ ${#title} -gt 30 ]; then
        display_title="${title:0:27}..."
    else
        display_title="$title"
    fi

    if [ ${#artist} -gt 25 ]; then
        display_artist="${artist:0:22}..."
    else
        display_artist="$artist"
    fi

    # Create display text based on status
    if [ "$status" = "Playing" ]; then
        icon="♪"
    elif [ "$status" = "Paused" ]; then
        icon="⏸"
    else
        icon="⏹"
    fi

    display_text="$icon $display_artist - $display_title"

    # Create tooltip with full track info
    tooltip="$artist - $title"
    if [ ! -z "$album" ]; then
        tooltip="$tooltip\nAlbum: $album"
    fi
    tooltip="$tooltip\nStatus: $status"

    # Output JSON
    echo "{\"text\": \"$display_text\", \"tooltip\": \"$tooltip\"}"
}

# Handle events
case "$1" in
    "toggle")
        playerctl -p spotify play-pause
        ;;
    "next")
        playerctl -p spotify next
        ;;
    "prev")
        playerctl -p spotify previous
        ;;
    *)
        get_spotify_info
        ;;
esac
