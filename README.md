# evo-ui

**Production-Grade Advance Linux UI Customization Tool**

`evo-ui` allows you to safely and reversibly apply modern aesthetics to your Linux desktop environment. It supports GNOME, KDE Plasma, Hyprland, and general X11 environments via Picom.

---

**Author:** Daksha Dubey  
**Version:** 1.0.0  
**License:** MIT

---

## Quick Download & Install

You can download and install the latest version of `evo-ui` with a single command. 

> [!CAUTION]
> Always review scripts before piping them to your shell.

### Standard Installation
```bash
git clone https://github.com/dakshdubey/evoLinux-Hydra.git && cd evoLinux-Hydra && ./install.sh
```

### System-Wide Installation (Requires Sudo)
To make `evo-ui` available for all users on the system:
```bash
sudo git clone https://github.com/dakshdubey/evoLinux-Hydra.git /opt/evo-ui
sudo ln -sf /opt/evo-ui/bin/evo-ui /usr/local/bin/evo-ui
```

---

## Features

- **Cli-first design**: Control everything from your terminal.
- **Environment Detection**: Automatically detects your DE (GNOME, KDE, Hyprland) and session type (X11/Wayland).
- **Modern Presets**:
    - **Glass**: Glassmorphism, high transparency, high blur.
    - **Matte**: Clean, opaque, subtle shadows, rounded corners.
    - **Neon**: Vibrant colors, high contrast, glowing borders.
- **Safety First**:
    - Automatic backups of all modified configs.
    - One-command restore to return to your original setup.
    - No root required for daily usage.

## Installation

```bash
git clone https://github.com/dakshdubey/evoLinux-Hydra.git
cd evoLinux-Hydra
./install.sh
```

Ensure `~/.local/bin` is in your `PATH`.

## Usage

### Check Environment Status
```bash
evo-ui status
```

### Apply a Preset
```bash
evo-ui apply glass
```

### Restore Original Settings
```bash
evo-ui restore
```

## Supported Environments

| Desktop | Support Level | Implementation | Notes |
|---------|---------------|----------------|-------|
| GNOME | High | gsettings | Requires 'Blur my Shell' for glass. |
| KDE | Medium | kwriteconfig5 | Modifies Plasma look-and-feel. |
| Hyprland | High | config source | Uses a separate include file. |
| X11 | Medium | picom | Best for window managers like i3 or bspwm. |

## Safety and Recovery

`evo-ui` creates backups in `~/.config/evo-ui/backups/`. 

If your UI becomes unresponsive or looks broken:
1. Open a TTY (`Ctrl+Alt+F3`).
2. Run `evo-ui restore`.
3. Restart your session or reboot.

## License

MIT
