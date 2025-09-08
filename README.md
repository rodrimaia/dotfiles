# dotfiles

Cross-platform personal dotfiles for **macOS** and **Arch Linux** development environments.

## Quick Setup

```bash
# Clone the repository
git clone https://github.com/rodrimaia/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Single command setup (detects OS automatically)
./setup.sh
```

## What's Included

### Terminal Stack
- **Terminal**: [Ghostty](https://github.com/ghostty/ghostty) with Snazzy theme
- **Shell**: [Fish](https://fishshell.com/) with extensive aliases
- **Prompt**: [Starship](https://starship.rs/)
- **Multiplexer**: tmux with tmuxinator session management
- **Navigation**: [z](https://github.com/jethrokuan/z) for Fish-native directory jumping (via Fisher)

### Development Tools
- **Editors**: Neovim with LazyVim (primary) + Cursor (AI-powered)
- **Version Managers**: mise, pnpm, bun
- **Search**: fzf, the_silver_searcher (ag)
- **Git**: tig terminal interface + extensive aliases

### Cross-Platform Support

**macOS:**
- Homebrew package management
- Automatic Brewfile installation
- Dock setup with organized app categories

**Arch Linux:**
- pacman + yay (AUR) package management  
- Linux-specific utilities and aliases


## Key Features

- **Single command setup** - `./setup.sh` does everything
- **OS detection** - automatically configures for macOS or Arch Linux
- **Platform-specific aliases** - organized by universal, macOS, and Linux
- **Modern terminal experience** - Ghostty + Fish + Starship
- **Development workflow** - extensive git, npm/yarn, and tmux shortcuts
- **macOS dock organization** - automated dock setup with categorized apps

## File Structure

```
dotfiles/
├── setup.sh              # Main cross-platform setup script
├── config.fish           # Fish shell configuration  
├── config.ghostty        # Terminal emulator settings
├── starship.toml         # Starship prompt configuration
├── .alias                # Platform-organized aliases
├── nvim/                 # LazyVim configuration
│   ├── init.lua          # Main entry point
│   ├── lua/config/       # Core LazyVim configuration
│   └── lua/plugins/      # Custom plugin configurations
├── provision/mac/        # macOS-specific provisioning
└── wallpapers & scripts  # Wallpaper assets and utilities
```

---

*A love story between terminals and productivity* ❤️