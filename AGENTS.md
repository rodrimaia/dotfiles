# AGENTS.md

This file provides universal guidance for assistants working in this repository.

## Repository Overview

This is a **cross-platform** personal dotfiles repository supporting both **macOS** and **Arch Linux**. Dotfiles and provisioning are managed through chezmoi, with Ghostty, Fish shell, and Starship prompt as the terminal stack.

## Key Architecture

### Cross-Platform Setup
- **Entry point**: `chezmoi init rodrimaia/dotfiles --apply` - Detects OS and installs everything automatically through chezmoi scripts
- **Supported platforms**: macOS (Homebrew) and Arch Linux (pacman/yay)
- **Source layout**: `.chezmoiroot` points to `home/`, which mirrors `$HOME`
- **Convenience path**: the post-apply script creates `~/dotfiles` as a symlink to chezmoi's source directory

### Terminal Stack
- **Terminal emulator**: Ghostty (configured in `home/dot_config/ghostty/config`)
- **Shell**: Fish (configured in `home/dot_config/fish/config.fish`)
- **Prompt**: Starship
- **Theme**: Snazzy with custom color palette

### Development Environment
- **Editor**: Neovim with LazyVim
- **Version managers**: mise, pnpm, bun
- **Package managers**:
  - macOS: Homebrew
  - Arch Linux: pacman + yay (AUR)
- **Terminal multiplexer**: tmux

### Key Configuration Files
- `.chezmoiroot` - points chezmoi at `home/`
- `home/run_once_before_00-install-packages.sh.tmpl` - OS package installation
- `home/run_once_after_00-setup-tools.sh.tmpl` - tmux, Fisher, Claude config, Fish shell, dock setup, and `~/dotfiles` symlink
- `home/dot_config/fish/config.fish` - Fish shell with environment variables and cross-platform paths
- `home/dot_config/ghostty/config` - Terminal emulator theme and settings
- `home/dot_config/starship.toml` - Starship prompt configuration with custom styling
- `home/dot_alias` - Platform-organized aliases (universal, macOS-specific, Linux-specific)
- `home/dot_config/nvim/` - LazyVim configuration
- `provision/mac/Brewfile` - macOS Homebrew packages

## Setup Commands

### **Installation**
```bash
# Single command setup - detects OS automatically
chezmoi init rodrimaia/dotfiles --apply
```

The chezmoi apply will:
- Detect macOS vs Arch Linux
- Install all necessary packages
- Set up version managers (mise, pnpm, bun)
- Apply LazyVim configuration for Neovim
- Create `~/dotfiles` as a symlink to the chezmoi source directory
- Initialize tmux configuration submodule (gpakosz/.tmux)
- Install Fisher plugin manager and Fish plugins
- Configure Fish as default shell
- Clean and organize macOS dock with categorized apps (macOS only)

## Platform-Specific Features

### macOS
- Homebrew package management via `provision/mac/Brewfile`
- macOS-specific aliases (`brewup`, `brewclean`)
- Automated dock organization with `dockutil`:
  - **Development Tools**: Ghostty
  - **Productivity**: Notion, Obsidian, Todoist, Slack, Passwords, System Settings
  - **Entertainment/Communication**: Spotify, Chrome, WhatsApp, Telegram
  - Categories separated by spacers for better organization

### Arch Linux
- pacman + yay package management
- Linux-specific aliases (Arch utilities, etc.)

## Development Workflow Aliases

### Universal Aliases (All Platforms)
- **Git**: `gst`, `gaa`, `gcmsg`, `gco`, `gd`, `gdc`
- **Package managers**: `nr`, `ni`, `nis`, `nisd`
- **Tmux**: `tn`
- **Editing**: `v`, `vf`, `valias`, `vrc`

### Platform-Specific Aliases
- **macOS**: `brewup`, `brewclean`
- **Linux**: `ys`, `arch_update_all`

## Path Configuration

Fish shell configured with cross-platform paths:
- **Homebrew** (macOS): `/opt/homebrew/bin`, `/opt/homebrew/sbin`
- **Package managers**: pnpm, bun, asdf shims
- **Local binaries**: `~/.local/bin`
