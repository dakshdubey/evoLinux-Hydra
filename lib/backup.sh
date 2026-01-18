#!/bin/bash
# Author: Daksha Dubey

# Load core if not loaded
[[ -z "$LIB_DIR" ]] && LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/core.sh"

BACKUP_ROOT="$HOME/.config/evo-ui/backups"

create_backup() {
    local label="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="$BACKUP_ROOT/${timestamp}_${label}"
    
    log_info "Creating backup in $backup_dir..."
    mkdir -p "$backup_dir"
    
    # List of files to backup based on DE
    local files_to_backup=()
    
    case "$(detect_desktop)" in
        gnome)
            # GNOME settings are in dconf, we'll export them
            dconf dump / > "$backup_dir/gnome_settings.dconf"
            ;;
        kde)
            files_to_backup+=("$HOME/.config/kdeglobals")
            files_to_backup+=("$HOME/.config/plasmarc")
            files_to_backup+=("$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc")
            ;;
        hyprland)
            files_to_backup+=("$HOME/.config/hypr/hyprland.conf")
            ;;
    esac
    
    # Generic backups
    files_to_backup+=("$HOME/.config/picom.conf")
    files_to_backup+=("$HOME/.config/picom/picom.conf")
    
    for f in "${files_to_backup[@]}"; do
        if [[ -f "$f" ]]; then
            cp -r "$f" "$backup_dir/"
        fi
    done
    
    echo "$backup_dir" > "$BACKUP_ROOT/latest"
    log_success "Backup created."
}

restore_backup() {
    local backup_dir=""
    
    if [[ -z "$1" ]]; then
        if [[ -f "$BACKUP_ROOT/latest" ]]; then
            backup_dir=$(cat "$BACKUP_ROOT/latest")
        else
            die "No backup found and no directory specified."
        fi
    else
        backup_dir="$1"
    fi
    
    if [[ ! -d "$backup_dir" ]]; then
        die "Backup directory $backup_dir does not exist."
    fi
    
    log_info "Restoring from $backup_dir..."
    
    # Restore dconf for GNOME
    if [[ -f "$backup_dir/gnome_settings.dconf" ]]; then
        dconf load / < "$backup_dir/gnome_settings.dconf"
    fi
    
    # Restore files
    for f in "$backup_dir"/*; do
        filename=$(basename "$f")
        if [[ "$filename" == "gnome_settings.dconf" ]]; then continue; fi
        
        # Determine target path (this is a bit tricky, we'll try to match standard paths)
        case "$filename" in
            kdeglobals|plasmarc|plasma-org.kde.plasma.desktop-appletsrc)
                cp "$f" "$HOME/.config/$filename"
                ;;
            hyprland.conf)
                cp "$f" "$HOME/.config/hypr/hyprland.conf"
                ;;
            picom.conf)
                if [[ -d "$HOME/.config/picom" ]]; then
                    cp "$f" "$HOME/.config/picom/picom.conf"
                fi
                cp "$f" "$HOME/.config/picom.conf"
                ;;
        esac
    done
    
    log_success "Restore complete. You may need to restart your session or shell."
}
