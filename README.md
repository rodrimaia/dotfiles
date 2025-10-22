# dotfiles

> Cross-platform personal dotfiles for modern development environments

![macOS](https://img.shields.io/badge/macOS-supported-blue)
![Arch Linux](https://img.shields.io/badge/Arch%20Linux-supported-blue)
![Shell](https://img.shields.io/badge/shell-Fish-green)
![Terminal](https://img.shields.io/badge/terminal-Ghostty-orange)

## Table of Contents

- [Quick Start](#quick-start)
- [What You Get](#what-you-get)
- [Requirements](#requirements)
- [Installation](#installation)
- [Post-Installation](#post-installation)
- [Common Aliases](#common-aliases)
- [File Structure](#file-structure)
- [Updating](#updating)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/rodrimaia/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Single command setup (detects OS automatically)
./setup.sh
```

## What You Get

### Terminal Stack

- **Terminal Emulator**: [Ghostty](https://github.com/ghostty/ghostty) - Modern GPU-accelerated terminal with Snazzy theme
- **Shell**: [Fish](https://fishshell.com/) - User-friendly shell with extensive aliases and completions
- **Prompt**: [Starship](https://starship.rs/) - Fast, customizable cross-shell prompt
- **Multiplexer**: tmux with tmuxinator - Persistent terminal sessions with easy management
- **Directory Navigation**: [z](https://github.com/jethrokuan/z) - Fish-native smart directory jumping (via Fisher)

### Development Environment

- **Primary Editor**: Neovim with [LazyVim](https://www.lazyvim.org/) - Modern IDE-like Neovim configuration
- **AI Assistant**: [Claude Code](https://claude.com/code) - Integrated CLI for AI-powered development
- **Secondary Editor**: [Cursor](https://cursor.sh/) - AI-powered code editor
- **Version Managers**:
  - [mise](https://mise.jdx.dev/) - Universal version manager
  - pnpm - Fast, disk space efficient package manager
  - bun - All-in-one JavaScript runtime & toolkit
- **Search & Navigation**:
  - [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
  - [the_silver_searcher (ag)](https://github.com/ggreer/the_silver_searcher) - Fast code searching
- **Git Tools**:
  - [tig](https://jonas.github.io/tig/) - Terminal interface for Git
  - Extensive git aliases for common workflows

### Platform-Specific Features

#### macOS
- **Package Manager**: Homebrew with automatic Brewfile installation
- **Dock Management**: Automated dock organization with categorized apps:
  - **Development**: Cursor, VSCode, Ghostty, Hyper
  - **Productivity**: Notion, Obsidian, Todoist, Slack, Passwords, System Settings
  - **Entertainment/Communication**: Spotify, Chrome, WhatsApp, Telegram
- **macOS Aliases**: `brewup`, `brewclean`, and more

#### Arch Linux
- **Package Managers**: pacman + yay (AUR helper)
- **Linux Utilities**: xclip integration, Arch-specific aliases
- **Linux Aliases**: `arch_update_all`, clipboard management, and more

## Requirements

### macOS
- macOS (tested on recent versions)
- Internet connection
- Administrator privileges

### Arch Linux
- Arch Linux (or Arch-based distribution)
- Internet connection
- sudo privileges

## Installation

The `setup.sh` script handles everything automatically:

1. **OS Detection** - Identifies macOS or Arch Linux
2. **Package Installation** - Installs all required packages via Homebrew (macOS) or pacman/yay (Linux)
3. **Shell Configuration** - Sets up Fish as default shell
4. **Plugin Management** - Installs Fisher plugin manager for Fish
5. **Version Managers** - Configures mise, pnpm, and bun
6. **Editor Setup** - Installs LazyVim starter configuration for Neovim
7. **Symbolic Links** - Creates symlinks for all configuration files
8. **tmux Configuration** - Initializes gpakosz/.tmux submodule
9. **Claude Code Integration** - Copies Claude configurations to `~/.claude/`
10. **macOS Dock Setup** (macOS only) - Organizes dock with categorized applications

### What Gets Installed

**Development Tools**:
- Git, tig, lazygit
- Neovim, Cursor
- tmux, tmuxinator
- fzf, the_silver_searcher, ripgrep
- bat, eza, dust (modern CLI replacements)

**Languages & Runtimes**:
- Node.js (via mise)
- Python (via mise)
- Go (via mise)

**Shell & Terminal**:
- Fish shell
- Starship prompt
- Ghostty terminal
- Fisher plugin manager
- z directory jumper

**macOS Specific**:
- All packages from `provision/mac/Brewfile`
- dockutil for dock management

**Arch Linux Specific**:
- Base development packages
- AUR helper (yay)

## Post-Installation

After running `./setup.sh`:

1. **Restart your terminal** or run:
   ```bash
   exec fish
   ```

2. **Install additional language versions** (optional):
   ```bash
   # Example: Install Node.js 20
   mise install node@20
   mise use -g node@20
   ```

3. **Customize your setup**:
   - Edit `config.fish` for Fish shell customizations
   - Edit `starship.toml` for prompt customizations
   - Edit `config.ghostty` for terminal appearance
   - Edit `.alias` for custom aliases

4. **Create tmux sessions**:
   ```bash
   tmuxinator new my-project
   ```

## Common Aliases

### Universal (All Platforms)

**Git**:
```bash
gst      # git status
gaa      # git add --all
gcmsg    # git commit -m
gco      # git checkout
gd       # git diff
gdc      # git diff --cached
gp       # git push
gl       # git pull
```

**Package Managers**:
```bash
yr       # yarn run
yrd      # yarn run dev
nr       # npm run
ni       # npm install
nis      # npm install --save
nisd     # npm install --save-dev
```

**tmux**:
```bash
tn       # tmux new-session
mux      # tmuxinator
txs      # tmux list-sessions
txo      # tmux kill-session -t
txn      # tmux new -s
```

**Editing**:
```bash
v        # nvim
vf       # nvim with fzf file picker
valias   # edit aliases file
vrc      # edit Fish config
```

### macOS Specific

```bash
brewup      # Update Homebrew and all packages
brewclean   # Cleanup Homebrew cache and old versions
```

### Linux Specific

```bash
y                   # yay (AUR helper)
ys                  # yay -S (install package)
arch_update_all     # Full system update (pacman + yay)
setclip             # Copy to clipboard (xclip)
getclip             # Paste from clipboard (xclip)
```

## File Structure

```
dotfiles/
├── setup.sh                    # Main cross-platform setup script
├── config.fish                 # Fish shell configuration with env vars
├── config.ghostty              # Ghostty terminal emulator settings
├── starship.toml               # Starship prompt configuration
├── .alias                      # Platform-organized aliases
├── .tmux.conf                  # tmux configuration (gpakosz theme)
├── nvim/                       # Neovim LazyVim configuration
│   ├── init.lua                # Main entry point
│   ├── lua/
│   │   ├── config/             # Core LazyVim settings
│   │   │   ├── autocmds.lua    # Auto commands
│   │   │   ├── keymaps.lua     # Key mappings
│   │   │   ├── lazy.lua        # Lazy plugin manager setup
│   │   │   └── options.lua     # Vim options
│   │   └── plugins/            # Custom plugin configurations
│   │       └── *.lua           # Individual plugin configs
├── provision/
│   └── mac/
│       ├── Brewfile            # macOS Homebrew packages
│       └── setup-dock.sh       # macOS dock organization script
├── wallpapers/                 # Wallpaper assets
└── scripts/                    # Utility scripts
```

## Updating

### Update Dotfiles Repository
```bash
cd ~/dotfiles
git pull origin main
./setup.sh  # Re-run to apply new changes
```

### Update Claude Code Configurations
After editing Claude-related files in the repository:
```bash
update-claude  # or ./setup.sh update-claude
```

### Update Packages

**macOS**:
```bash
brewup  # Updates Homebrew and all packages
```

**Arch Linux**:
```bash
arch_update_all  # Updates pacman and AUR packages
```

### Update Neovim Plugins
```bash
# Inside Neovim
:Lazy update
```

## Customization

### Adding New Aliases

Edit `.alias` and add your aliases in the appropriate section:
```bash
# Universal aliases (all platforms)
# macOS-only aliases
# Linux-only aliases
```

Then reload Fish:
```bash
source ~/.config/fish/config.fish
```

### Modifying the Prompt

Edit `starship.toml` to customize your prompt. See [Starship documentation](https://starship.rs/config/) for options.

### Changing Theme Colors

Edit `config.ghostty` to modify terminal colors. Current theme is Snazzy with custom palette.

### Adding Fish Plugins

```bash
fisher install <plugin-name>
```

### Extending Neovim

Add new plugin configurations in `nvim/lua/plugins/`. LazyVim will automatically load them.

## Troubleshooting

### Fish not set as default shell

Run manually:
```bash
chsh -s $(which fish)
```

### Symbolic links not created

Re-run setup with force flag:
```bash
./setup.sh --force
```

### Homebrew installation fails (macOS)

Ensure Xcode Command Line Tools are installed:
```bash
xcode-select --install
```

### yay not working (Arch Linux)

Reinstall yay:
```bash
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Ghostty not available

Ghostty may need to be installed separately depending on your platform. Check [Ghostty releases](https://github.com/ghostty-org/ghostty) for installation instructions.

### Neovim plugins not loading

Try rebuilding the plugin cache:
```bash
nvim --headless "+Lazy! sync" +qa
```

### Claude Code integration not working

Update Claude configurations:
```bash
./setup.sh update-claude
```

---

**Built with** 💙 **for productive terminal workflows**
