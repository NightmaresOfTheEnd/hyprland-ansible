# Arch Linux Hyprland Ansible Playbook

Automated Arch Linux desktop setup with Hyprland window manager.

## Features

- **Hardware Detection**: Automatically detects NVIDIA GPU, AMD/Intel GPU, and laptop/desktop
- **NVIDIA Support**: Conditional NVIDIA driver installation with proper Wayland configuration
- **Laptop/Desktop Awareness**: Different brightness controls and power management
- **Modern Tools**: Wofi, Waybar, Mako, Hyprlock, Hypridle
- **Clean Packages**: No personal preference bloat

## Requirements

- Fresh Arch Linux installation
- Network connection
- `ansible` installed (`pacman -S ansible`)
- Sudo privileges

## Quick Start

```bash
# Clone this repository
git clone <your-repo-url> ~/hyprland-ansible
cd ~/hyprland-ansible

# Install required Ansible collections
ansible-galaxy collection install -r requirements.yml

# Run the playbook
ansible-playbook setup.yml --ask-become-pass
```

## Structure

```
hyprland-ansible/
├── setup.yml                # Main playbook
├── inventory.yml            # Inventory file
├── ansible.cfg              # Ansible configuration
├── requirements.yml         # Ansible collections
├── group_vars/
│   └── all.yml              # Package lists and variables
└── roles/
    ├── base/                # Core system packages
    ├── aur/                 # Paru and AUR packages
    ├── hardware/            # Hardware detection
    ├── hyprland/            # Hyprland configuration
    ├── nvidia/              # NVIDIA-specific setup
    ├── themes/              # Dynamic theming system
    ├── dotfiles/            # Application configs
    ├── services/            # Systemd services
    └── zsh/                 # Shell setup
```

## Packages Installed

### Core (~40 packages)
- System: gnome-keyring, openssh, polkit-gnome, ufw
- Terminal: zsh, starship, bat, eza, fd, fzf, ripgrep, btop
- Development: git, lazygit, neovim
- Audio: pipewire stack
- Bluetooth: bluez, bluetui

### Hyprland Ecosystem (~15 packages)
- hyprland, hypridle, hyprlock, hyprpaper, hyprpicker
- xdg-desktop-portal-hyprland

### Desktop Utilities (~20 packages)
- Launcher: wofi
- Bar: waybar
- Notifications: mako
- Clipboard: wl-clipboard, cliphist
- Screenshots: grim, slurp, satty
- File Manager: thunar

### Appearance
- Cursor: Bibata-Modern-Ice
- Icons: Yaru
- Fonts: Noto, JetBrainsMono Nerd Font, Font Awesome

## Keybindings

| Key | Action |
|-----|--------|
| `Super + Return` | Terminal (ghostty) |
| `Super + E` | File manager (thunar) |
| `Super + B` | Browser (zen-browser) |
| `Super + Space` | App launcher (wofi) |
| `Super + V` | Clipboard history |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + T` | Toggle floating |
| `Super + 1-0` | Switch workspace |
| `Super + Shift + 1-0` | Move to workspace |
| `Print` | Screenshot (full) |
| `Shift + Print` | Screenshot (region) |
| `Super + Shift + L` | Lock screen |

## Customization

### Add/Remove Packages

Edit `group_vars/all.yml`:
- `base_packages`: Official repo packages
- `aur_packages`: AUR packages
- `nvidia_packages`: NVIDIA-specific packages
- `laptop_packages`: Laptop-only packages
- `desktop_packages`: Desktop-only packages

### Modify Configs

- Hyprland: `roles/hyprland/templates/`
- Applications: `roles/dotfiles/tasks/main.yml`

### Run Specific Roles

```bash
# Only install packages
ansible-playbook setup.yml --tags packages

# Only configure Hyprland
ansible-playbook setup.yml --tags hyprland

# Only NVIDIA setup
ansible-playbook setup.yml --tags nvidia
```

## Dynamic Theming

The playbook includes a dynamic theming system. Switch themes instantly!

### Available Themes
- `catppuccin`
- `everforest`
- `matte-black`
- `nord` (default)
- `osaka-jade`
- `ristretto`

### Switch Themes
```bash
theme-set catppuccin
theme-set nord
theme-set --list    # Show all themes
```

### How It Works
- Themes stored in `~/.local/share/dotfiles/themes/`
- Active theme symlinked at `~/.local/share/dotfiles/current/theme`
- Apps auto-reload when switching: Waybar, Hyprland, Mako, Ghostty, btop

### Themed Applications
| App | Theme File |
|-----|------------|
| Hyprland | `hyprland.conf` (border colors) |
| Waybar | `waybar.css` (colors) |
| Ghostty | `ghostty.conf` (terminal colors) |
| Mako | `mako.ini` (notification colors) |
| btop | `btop.theme` (system monitor) |
| Hyprlock | `hyprlock.conf` (lock screen) |

## Post-Installation

1. Reboot your system
2. Select Hyprland from your display manager
3. Run `theme-set <theme-name>` to switch themes

## Troubleshooting

### NVIDIA Issues
- Check `/etc/mkinitcpio.conf` for MODULES
- Verify `/etc/modprobe.d/nvidia.conf` exists
- Run `mkinitcpio -P` and reboot

### No Display
- Try `Ctrl+Alt+F2` for TTY
- Check `journalctl -b -p err`
- Verify Hyprland: `Hyprland --version`

### Audio Issues
- Check pipewire: `systemctl --user status pipewire`
- Restart: `systemctl --user restart pipewire pipewire-pulse wireplumber`

## License

MIT
