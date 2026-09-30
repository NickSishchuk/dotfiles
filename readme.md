# Dotfiles for Hyprland on Arch Linux

[![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)

Dotfiles setup with a hardcoded Everforest theme and a small set of useful scripts.

<img src="demo/2.png" width="600"/>

Quick info:
- [bin](bin) - all scripts live here, it is added to path in uwsm config
- [install](install/install) - main installation script
- [pkgs.txt](install/pkgs.txt) - packages to be installed
- [setup-applications](install/setup-applications) - hides some annoying applications from launcher
- [setup-by-hardware](install/setup-by-hardware) - sets up monitors, keybindings, hypr enviroments
- [setup-config](install/setup-config) - copies full config into ~/.config
- [setup-nvidia](install/setup-nvidia) - nvidia specific setup
- [setup-system](install/setup-system) - ufw, pacman.conf, triggers nvidia-setup if on nvidia gpu, git, ly login manager (if exists), enables gcr agent for ssh, disables systemd-networkd-wait-online.service that causes extremly long boot time
- [setup-theme](install/setup-theme) - theming setup and symlinks

## Table of Contents

- [Features](#features)
- [Installation](#installation)
  - [Before you start (fresh Arch install)](#before-you-start-fresh-arch-install)
  - [Automatic installer](#automatic-installer)
  - [Manual installation](#manual-installation)
- [Keybinds](#keybinds)
- [Theming & Customization](#theming--customization)
  - [Customizing Configs](#customizing-configs)
- [Credits](#credits)

---

## Features

- **Everforest Theme** - Hardcoded Everforest theme with the Omarchy waybar style, plus a wallpaper picker (Waypaper) and cycler for your own backgrounds
- **Utility Scripts** - System update checker/updater, power profile switching, monitor brightness control (DDC/CI or brightnessctl), night light & idle toggles, wallpaper cycling, and a searchable keybindings cheat-sheet — most are wired into Walker/Elephant menus
- **Application Configs** - Configs for Alacritty, Waybar, Walker, Elephant, and more

---

## Installation

### Before you start (fresh Arch install)

If you're starting from a completely blank machine:
1. Boot the Arch ISO and run `archinstall`.
2. Pick the **Hyprland** profile, and make sure **git** is included in your package selection — it's required to bootstrap the installer below.
3. Finish `archinstall` and reboot.
4. Log in (a plain TTY login is fine, you don't need to be inside Hyprland yet) and run the [automatic installer](#automatic-installer) command below.
5. Once it finishes, reboot and pick **"Hyprland (uwsm managed)"** in your login manager (sddm/gdm/ly) — this is required for the `bin/` scripts to be in `PATH` and for things to actually work.

Monitor auto-detection works best if you're already inside a Hyprland session when you run the installer (it needs `hyprctl`). If you install from a bare TTY like above, it'll just keep the default monitor config and tell you how to re-run detection once you've logged into Hyprland for the first time.

### Automatic installer

```bash
curl -fsSL https://raw.githubusercontent.com/NickSishchuk/dotfiles/master/setup.sh | bash
```

**⚠️ Important Notes:**
- This is specifically for **Arch Linux with Hyprland**
- I've tested the installer on both fresh installs and configured desktops, but ideally you should **know what you're doing**, make sure to backup manually just in case
- Everything that will be changed is backed up first

**What the installer does:**

<details>
<summary><b>Backup</b></summary>

- Backs up everything that will be changed ([backup script](install/lib/backup.sh))
  - Files in `~/.config`
  - `pacman.conf`
  - Ly display manager configuration (if installed)
  - Everything else that gets modified
- Creates a backup folder in your Home directory with:
  - A text file listing all changed files
  - Commands to quickly revert everything
  - A [rollback script](install/lib/rollback.sh) for easy restoration
</details>

<details>
<summary><b>Package Installation</b></summary>

- Installs [packages](install/pkgs.txt) from official repos and AUR
</details>

<details>
<summary><b>Hardware Detection</b></summary>

The installer [detects your hardware](install/setup-by-hardware):
- **Laptop/Desktop** - Uses brightnessctl or ddcutil respectively, applies proper Hyprland keybinding profiles
- **Monitor Configuration** - Checks your monitor's highest resolution and refresh rate with `hyprctl monitors` and creates appropriate `monitors.conf` (only works if Hyprland is already running when you install — otherwise it keeps the default and can be re-run later)
- **Nvidia GPUs** - Detects Nvidia cards and applies [Nvidia-specific setup](install/setup-nvidia) with proper Hyprland env configs
</details>

<details>
<summary><b>Configuration & Theming</b></summary>

- Replaces configuration files in `~/.config` with the [config](config) directory contents
- Sets up the Everforest theme via [theme setup](install/setup-theme)
- Some files live in the [default](default) directory - these are git synced and will get overwritten with updates
</details>

<details>
<summary><b>Scripts</b></summary>

A small collection of scripts, mainly used with Walker & Elephant. If installing manually make sure to add the scripts folder to path:
- **System** - Update checker & one-shot updater, power profile switching
- **Display** - Monitor brightness control, night light toggle, idle/lock status toggle
- **Wallpaper** - Cycle through your backgrounds
- **Walker/Elephant helpers** - Keybindings cheat-sheet, app/service restart helpers
- Most scripts are accessible interactively through Walker or Elephant
</details>

<details>
<summary><b>System Configuration</b></summary>

- [System setup](install/setup-system) configures:
  - Git configuration
  - Ly display manager (if installed)
  - Pacman configuration
  - UFW firewall
</details>

### Manual installation

You can manually use the dotfiles without the installer:
1. Clone the repository
2. Copy desired configs from `config/` to `~/.config/` (some configs live in [default](default) directory. Also everything relies on the scripts folder being in path)
3. Copy scripts from `bin/` to your preferred location (make sure it's on your `PATH`)
4. You can use some install scripts for partial setup if you want — e.g. `install/setup-theme` for just the theme symlinks, or `install/setup-by-hardware` for keybindings/monitor detection

---

## Keybinds
Just press SUPER + ALT + Space -> keybindings - all bindings nicely sorted here

**Apps & windows:**
- SUPER + Q = Open terminal
- SUPER + B = Open browser
- SUPER + E = Open file manager
- SUPER + W = Close window
- SUPER + SHIFT + W = Quit app and all its windows
- SUPER + F = Fullscreen
- SUPER + M = Maximize
- SUPER + T = Toggle floating
- SUPER + arrows = Move focus
- SUPER + SHIFT + arrows = Resize active window
- SUPER + ALT + arrows = Swap window
- ALT + Tab = Cycle windows

**Workspaces:**
- SUPER + [0-9] = Switch to workspace
- SUPER + SHIFT + [0-9] = Move window to workspace
- SUPER + Tab / SUPER + SHIFT + Tab = Next/previous workspace
- SUPER + CTRL + Down = Jump to next empty workspace

**Walker & Elephant:**
- SUPER + R = Open Walker (app launcher)
- SUPER + ALT + Space = Main menu
- SUPER + Escape = System menu (lock/suspend/restart/shutdown)
- SUPER + V = Clipboard history
- SUPER + Print = Screenshot menu
- Print = Screenshot region to clipboard
- `ctrl + x` inside any Walker submenu = go back

**Wallpaper & theming:**
- SUPER + CTRL + W = Open Waypaper (pick a wallpaper)
- Next wallpaper (from the main menu) = cycle your own backgrounds

**Display & media:**
- Brightness Up/Down keys = Adjust monitor brightness
- Volume Up/Down/Mute keys = Adjust volume
- Media Play/Pause/Next/Prev keys = Control playback
- SUPER + CTRL + N = Toggle night light

Some binds differ slightly between the laptop and desktop keybinding profiles (auto-selected by the installer) — check `menu-keybindings` on your machine for the exact list.

---

## Theming & Customization

Theming is hardcoded to Everforest with the Omarchy waybar style - no theme switcher, no dynamic theming. Use "Next wallpaper" (or Waypaper) to cycle/pick between your own backgrounds in [themes/everforest/backgrounds](themes/everforest/backgrounds).

### Customizing Configs

- You can modify everything in [config](config) easily, it is not git synced and will not get overwritten
- Configs in [default](default) are git synced and will get overwritten with updates

---

## Credits

This is a heavily trimmed-down, minimalistic fork of [mkbula/dotfiles](https://github.com/mkbula/dotfiles) — check out the original for the full-featured version this is based on.
