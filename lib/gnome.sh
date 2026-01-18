#!/bin/bash
# Author: Daksha Dubey

# Load core
[[ -z "$LIB_DIR" ]] && LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/core.sh"

apply_gnome_preset() {
    local preset="$1"
    
    check_dep "gsettings"
    
    case "$preset" in
        glass)
            log_info "Applying Glass preset to GNOME..."
            # Check for Blur my Shell extension
            if ! gnome-extensions list | grep -q "blur-my-shell"; then
                log_warn "GNOME Glassmorphism requires 'Blur my Shell' extension."
                if confirm "Would you like to try enabling it (if installed)?"; then
                    gnome-extensions enable blur-my-shell@aunetx || log_error "Failed to enable extension."
                fi
            fi
            
            # Application of glass settings
            gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur-radius 30
            gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur-radius 30
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
            ;;
        matte)
            log_info "Applying Matte preset to GNOME..."
            gsettings set org.gnome.desktop.interface color-scheme 'default'
            gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur-radius 0
            ;;
        neon)
            log_info "Applying Neon preset to GNOME..."
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
            # Neon usually involves accented borders, which is harder in GNOME without themes
            # We can at least set a dark high-contrast mode if available
            ;;
    esac
}
