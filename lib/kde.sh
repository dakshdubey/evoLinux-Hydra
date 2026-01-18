#!/bin/bash
# Author: Daksha Dubey

# Load core
[[ -z "$LIB_DIR" ]] && LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/core.sh"

apply_kde_preset() {
    local preset="$1"
    
    check_dep "kwriteconfig5"
    
    case "$preset" in
        glass)
            log_info "Applying Glass preset to KDE Plasma..."
            kwriteconfig5 --file kdeglobals --group General --key WidgetStyle "Breeze"
            kwriteconfig5 --file kdeglobals --group KScreen --key Opacity 0.8
            # KDE blur is often managed via desktop effects
            ;;
        matte)
            log_info "Applying Matte preset to KDE Plasma..."
            kwriteconfig5 --file kdeglobals --group KScreen --key Opacity 1.0
            ;;
        neon)
            log_info "Applying Neon preset to KDE Plasma..."
            # Placeholder for neon colors
            ;;
    esac
    
    # Reload Plasma settings
    dbus-send --session --dest=org.kde.plasmashell --type=method_call /MainApplication org.kde.KWin.reconfigure || true
}
