# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **cross-platform** personal dotfiles repository supporting both **macOS** and **Arch Linux**. The setup uses modern terminal tooling with Ghostty, Fish shell, and Starship prompt, with a single command setup for either platform.

## Key Architecture

### Cross-Platform Setup
- **Setup script**: `./setup.sh` - Detects OS and installs everything automatically
- **Supported platforms**: macOS (Homebrew) and Arch Linux (pacman/yay)

### Terminal Stack
- **Terminal emulator**: Ghostty (configured in `config.ghostty`)
- **Shell**: Fish (configured in `config.fish`)  
- **Prompt**: Starship
- **Theme**: Snazzy with custom color palette

### Development Environment
- **Editors**: Neovim with LazyVim (primary) + Cursor (AI-powered)
- **Version managers**: mise, pnpm, bun
- **Package managers**: 
  - macOS: Homebrew
  - Arch Linux: pacman + yay (AUR)
- **Terminal multiplexer**: tmux with tmuxinator

### Key Configuration Files
- `setup.sh` - **Main setup script** - detects OS and installs everything
- `config.fish` - Fish shell with environment variables and cross-platform paths
- `config.ghostty` - Terminal emulator theme and settings
- `starship.toml` - Starship prompt configuration with custom styling
- `.alias` - Platform-organized aliases (universal, macOS-specific, Linux-specific)
- LazyVim configuration (installed automatically via setup.sh)
- `provision/mac/Brewfile` - macOS Homebrew packages

## Setup Commands

### **Installation**
```bash
# Single command setup - detects OS automatically
./setup.sh
```

This script will:
- Detect macOS vs Arch Linux
- Install all necessary packages
- Set up version managers (mise, pnpm, bun)
- Install LazyVim starter configuration for Neovim
- Create all symbolic links
- Initialize tmux configuration submodule (gpakosz/.tmux)
- Install Fisher plugin manager and z directory jumping tool
- Configure Fish as default shell
- Clean and organize macOS dock with categorized apps (macOS only)

## Platform-Specific Features

### macOS
- Homebrew package management via `provision/mac/Brewfile`
- macOS-specific aliases (`brewup`, `brewclean`)
- Automated dock organization with `dockutil`:
  - **Development Tools**: Cursor, VSCode, Ghostty, Hyper
  - **Productivity**: Notion, Obsidian, Todoist, Slack, Passwords, System Settings
  - **Entertainment/Communication**: Spotify, Chrome, WhatsApp, Telegram
  - Categories separated by spacers for better organization

### Arch Linux  
- pacman + yay package management
- Linux-specific aliases (arch utilities, xclip, etc.)

## Development Workflow Aliases

### Universal Aliases (All Platforms)
- **Git**: `gst`, `gaa`, `gcmsg`, `gco`, `gd`, `gdc`
- **Package managers**: `yr`, `yrd`, `nr`, `ni`, `nis`, `nisd` 
- **Tmux**: `tn`, `mux`, `txs`, `txo`, `txn`
- **Editing**: `v`, `vf`, `valias`, `vrc`

### Platform-Specific Aliases
- **macOS**: `brewup`, `brewclean`
- **Linux**: `y` (yay), `ys`, `arch_update_all`, `setclip`, `getclip`

## Path Configuration

Fish shell configured with cross-platform paths:
- **Homebrew** (macOS): `/opt/homebrew/bin`, `/opt/homebrew/sbin`
- **Package managers**: pnpm, bun, asdf shims
- **Local binaries**: `~/.local/bin`

## Claude Code Integration

- Claude CLI aliased to `/Users/rodrigo/.claude/local/claude` 
- Editor preference: `nvim` via `$EDITOR`
- Single setup command: `./setup.sh` for new machine provisioning