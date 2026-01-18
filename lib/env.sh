#!/bin/bash
# Author: Daksha Dubey

detect_desktop() {
    if [[ -n "$XDG_CURRENT_DESKTOP" ]]; then
        case "${XDG_CURRENT_DESKTOP,,}" in
            *gnome*)  echo "gnome" ;;
            *kde*|*plasma*) echo "kde" ;;
            *hyprland*) echo "hyprland" ;;
            *) echo "unknown" ;;
        esac
    else
        # Fallback for some window managers
        if pgrep -x "hyprland" > /dev/null; then
            echo "hyprland"
        elif pgrep -x "gnome-shell" > /dev/null; then
            echo "gnome"
        elif pgrep -x "plasmashell" > /dev/null; then
            echo "kde"
        else
            echo "unknown"
        fi
    fi
}

detect_session() {
    if [[ -n "$XDG_SESSION_TYPE" ]]; then
        echo "${XDG_SESSION_TYPE,,}"
    else
        # Fallback
        if [[ -n "$DISPLAY" ]] && [[ -z "$WAYLAND_DISPLAY" ]]; then
            echo "x11"
        elif [[ -n "$WAYLAND_DISPLAY" ]]; then
            echo "wayland"
        else
            echo "unknown"
        fi
    fi
}

get_env_info() {
    DESKTOP=$(detect_desktop)
    SESSION=$(detect_session)
    
    echo "Desktop: $DESKTOP"
    echo "Session: $SESSION"
}
