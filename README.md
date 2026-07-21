# dotfiles

Cross-platform personal dotfiles for **macOS** and **Arch Linux** development environments, managed by [chezmoi](https://www.chezmoi.io/).

## Quick Setup

```bash
# Install chezmoi, clone this repo, and apply it
chezmoi init rodrimaia/dotfiles --apply
```

The first apply provisions the machine with chezmoi scripts, then creates `~/dotfiles` as a symlink to the chezmoi source directory so existing muscle memory still works.

## What's Included

### Terminal Stack
- **Terminal**: [Ghostty](https://github.com/ghostty/ghostty) with Snazzy theme
- **Shell**: [Fish](https://fishshell.com/) with extensive aliases
- **Prompt**: [Starship](https://starship.rs/)
- **Multiplexer**: tmux
- **Agent multiplexer**: [Herdr](https://herdr.dev/) with tmux-style prefix keys
- **Navigation**: [zoxide](https://github.com/ajeetdsouza/zoxide) for directory jumping

### Development Tools
- **Editor**: Neovim with the official LazyVim starter
- **Version Managers**: mise, pnpm, bun
- **Search**: fzf, the_silver_searcher (ag)
- **Git**: tig terminal interface + extensive aliases
- **AI tooling**: Claude Code, OpenCode, and [RTK](https://github.com/rtk-ai/rtk) with automatic command rewriting

### Cross-Platform Support

**macOS:**
- Homebrew package management
- Automatic Brewfile installation
- Dock setup with organized app categories

**Arch Linux:**
- pacman + yay (AUR) package management  
- Linux-specific utilities and aliases


## Key Features

- **Single command setup** - `chezmoi init rodrimaia/dotfiles --apply` does everything
- **OS detection** - automatically configures for macOS or Arch Linux
- **chezmoi-managed config** - applies dotfiles directly into `~` and `~/.config`
- **Platform-specific aliases** - organized by universal, macOS, and Linux
- **Modern terminal experience** - Ghostty + Fish + Starship + tmux-style Herdr keys
- **Development workflow** - extensive git, npm, and tmux shortcuts
- **macOS dock organization** - automated dock setup with categorized apps

## File Structure

```
dotfiles/
├── .chezmoiroot          # Points chezmoi at home/ as the source-state root
├── home/                 # chezmoi source-state mirror of $HOME
│   ├── dot_alias         # ~/.alias
│   ├── dot_config/fish/  # ~/.config/fish
│   ├── dot_config/ghostty/ # ~/.config/ghostty
│   ├── dot_config/herdr/ # ~/.config/herdr
│   ├── dot_config/starship.toml # ~/.config/starship.toml
│   └── run_once_*.tmpl   # one-time provisioning scripts
└── provision/mac/        # macOS-specific provisioning
```

---

*A love story between terminals and productivity* ❤️
