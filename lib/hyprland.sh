#!/bin/bash
# Author: Daksha Dubey

# Load core
[[ -z "$LIB_DIR" ]] && LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/core.sh"

EVO_HYPR_CONFIG="$HOME/.config/hypr/evo-ui.conf"

apply_hyprland_preset() {
    local preset="$1"
    
    log_info "Applying $preset preset to Hyprland..."
    
    case "$preset" in
        glass)
            cat > "$EVO_HYPR_CONFIG" <<EOF
decoration {
    rounding = 15
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
    }
    active_opacity = 0.8
    inactive_opacity = 0.7
}
EOF
            ;;
        matte)
            cat > "$EVO_HYPR_CONFIG" <<EOF
decoration {
    rounding = 5
    blur {
        enabled = false
    }
    active_opacity = 1.0
    inactive_opacity = 1.0
}
EOF
            ;;
        neon)
            cat > "$EVO_HYPR_CONFIG" <<EOF
general {
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
}
decoration {
    drop_shadow = true
    shadow_range = 15
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}
EOF
            ;;
    esac
    
    # Check if the include exists in hyprland.conf
    if ! grep -q "source = $EVO_HYPR_CONFIG" "$HOME/.config/hypr/hyprland.conf"; then
        log_warn "Adding include to hyprland.conf..."
        echo "source = $EVO_HYPR_CONFIG" >> "$HOME/.config/hypr/hyprland.conf"
    fi
}
