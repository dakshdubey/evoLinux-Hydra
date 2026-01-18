#!/bin/bash
# Author: Daksha Dubey

# Load core
[[ -z "$LIB_DIR" ]] && LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/core.sh"

apply_picom_preset() {
    local preset="$1"
    
    check_dep "picom"
    
    local picom_config=""
    if [[ -f "$HOME/.config/picom/picom.conf" ]]; then
        picom_config="$HOME/.config/picom/picom.conf"
    elif [[ -f "$HOME/.config/picom.conf" ]]; then
        picom_config="$HOME/.config/picom.conf"
    else
        log_info "No picom config found, creating one at ~/.config/picom.conf"
        picom_config="$HOME/.config/picom.conf"
        touch "$picom_config"
    fi
    
    case "$preset" in
        glass)
            log_info "Applying Glass preset to Picom..."
            # Simple way to override: append or use sed
            # For a production tool, we should probably have a snippet we manage
            cat >> "$picom_config" <<EOF

# evo-ui glass start
backend = "glx";
blur-method = "dual_kawase";
blur-strength = 7;
active-opacity = 0.8;
inactive-opacity = 0.7;
corner-radius = 12;
# evo-ui glass end
EOF
            ;;
        matte)
            log_info "Applying Matte preset to Picom..."
            # Restore would be better, but we can also just set defaults
            ;;
        neon)
            log_info "Applying Neon preset to Picom..."
            # Border effects in picom are tricky, mostly shadows
            ;;
    esac
    
    # Restart picom
    pkill picom
    picom --config "$picom_config" -b
}
