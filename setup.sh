#!/usr/bin/env bash

# Cross-platform dotfiles setup script
# Works on macOS and Arch Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        print_info "Detected macOS"
    elif [[ -f /etc/arch-release ]]; then
        OS="arch"
        print_info "Detected Arch Linux"
    else
        print_error "Unsupported operating system"
        exit 1
    fi
}

# Install packages based on OS
install_packages() {
    print_info "Installing packages for $OS..."
    
    case $OS in
        "macos")
            # Check if Homebrew is installed
            if ! command -v brew &> /dev/null; then
                print_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            
            # Install packages from Brewfile
            if [[ -f "provision/mac/Brewfile" ]]; then
                print_info "Installing Homebrew packages..."
                brew bundle --file=provision/mac/Brewfile
            fi
            
            # Clean and organize dock
            if command -v dockutil &> /dev/null; then
                print_info "Cleaning and organizing dock..."
                dockutil --remove all --no-restart
                
                # Development Tools
                dockutil --add /Applications/Cursor.app --no-restart
                dockutil --add "/Applications/Visual Studio Code.app" --no-restart
                dockutil --add /Applications/Ghostty.app --no-restart
                dockutil --add /Applications/Hyper.app --no-restart
                
                # Spacer
                dockutil --add '' --type spacer --section apps --no-restart
                
                # Productivity
                dockutil --add /Applications/Notion.app --no-restart
                dockutil --add /Applications/Obsidian.app --no-restart
                dockutil --add /Applications/Todoist.app --no-restart
                dockutil --add /Applications/Slack.app --no-restart
                dockutil --add "/System/Applications/Passwords.app" --no-restart
                dockutil --add "/System/Applications/System Settings.app" --no-restart
                
                # Spacer
                dockutil --add '' --type spacer --section apps --no-restart
                
                # Entertainment/Communication
                dockutil --add /Applications/Spotify.app --no-restart
                dockutil --add "/Applications/Google Chrome.app" --no-restart
                dockutil --add /Applications/WhatsApp.app --no-restart
                dockutil --add /Applications/Telegram.app
                
                print_success "Dock organized with categorized apps"
            fi
            ;;
            
        "arch")
            print_info "Installing Arch Linux packages..."
            
            # Update package database
            sudo pacman -Syu --noconfirm
            
            # Install essential packages
            sudo pacman -S --needed --noconfirm \
                fish \
                neovim \
                tmux \
                fzf \
                the_silver_searcher \
                git \
                tig \
                wget \
                nodejs \
                npm \
                python \
                python-pip \
                starship \
                base-devel \
                mise \
                zoxide \
                atuin
            
            # Install yay (AUR helper) if not present
            if ! command -v yay &> /dev/null; then
                print_info "Installing yay AUR helper..."
                cd /tmp
                git clone https://aur.archlinux.org/yay.git
                cd yay
                makepkg -si --noconfirm
                cd -
            fi
            
            # Install AUR packages
            yay -S --needed --noconfirm \
                ghostty-bin || print_warning "ghostty-bin not available in AUR"
            ;;
    esac
    
    print_success "Package installation completed"
}

# Install version managers and runtimes
install_version_managers() {
    print_info "Installing version managers..."
    
    
    # # Install pnpm if not present
    # if ! command -v pnpm &> /dev/null; then
    #     print_info "Installing pnpm..."
    #     curl -fsSL https://get.pnpm.io/install.sh | sh -
    # fi
    
    # # Install bun if not present
    # if ! command -v bun &> /dev/null; then
    #     print_info "Installing bun..."
    #     curl -fsSL https://bun.sh/install | bash
    # fi
    
    print_success "Version managers installed"
}

# Create symbolic links
create_symlinks() {
    print_info "Creating symbolic links..."
    
    # Fish shell config
    mkdir -p ~/.config/fish
    ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish
    ln -sf ~/dotfiles/.alias ~/.alias
    
    # LazyVim setup
    mkdir -p ~/.config/nvim
    ln -sf ~/dotfiles/nvim/* ~/.config/nvim/
    
    # Ghostty config
    mkdir -p ~/.config/ghostty
    ln -sf ~/dotfiles/config.ghostty ~/.config/ghostty/config
    
    # Starship config
    mkdir -p ~/.config
    ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
    
    # tmux config
    ln -sf ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local
    
    # Git config (if exists)
    if [[ -f ~/dotfiles/.gitconfig ]]; then
        ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
    fi
    
    
    # Additional Arch Linux configurations can be added here if needed
    
    print_success "Symbolic links created"
}

# Setup Claude Code configurations
setup_claude() {
    print_info "Setting up Claude Code configurations..."

    # Create Claude directories
    mkdir -p ~/.claude/commands/sc

    # Copy all Claude configuration files from dotfiles
    # (Using cp instead of ln for Claude Code security requirements)
    cd ~/dotfiles
    cp -f claude/*.md ~/.claude/
    cp -f claude/*.json ~/.claude/
    cp -f claude/*.sh ~/.claude/
    cp -f claude/commands/sc/*.md ~/.claude/commands/sc/

    # Make statusline script executable
    chmod +x ~/.claude/statusline-command.sh

    print_success "Claude Code configurations copied"
}

# Update Claude configurations only (useful for development)
update_claude() {
    print_info "Updating Claude Code configurations..."
    setup_claude
    print_success "Claude Code configurations updated"
}

# Install Fisher plugin manager and plugins
setup_fish_plugins() {
    print_info "Installing Fisher plugin manager and plugins..."
    
    # Install Fisher - download and install in one command
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

    # Install done plugin for notifications
    fish -c "fisher install franciscolourenco/done"
    
    print_success "Fisher and plugins installed"
}

# Initialize and setup tmux configuration
setup_tmux() {
    print_info "Setting up tmux configuration..."
    
    # Initialize and update git submodules
    git submodule init
    git submodule update
    
    # Create symlink to the main tmux config from the submodule
    ln -sf ~/dotfiles/.tmux/.tmux.conf ~/.tmux.conf
    
    print_success "Tmux configuration setup completed"
}

# Set default shell to fish
setup_shell() {
    if ! grep -q "$(which fish)" /etc/shells; then
        print_info "Adding fish to /etc/shells..."
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    
    if [[ "$SHELL" != "$(which fish)" ]]; then
        print_info "Setting fish as default shell..."
        chsh -s "$(which fish)"
        print_warning "Please log out and log back in for shell change to take effect"
    fi
    
    print_success "Shell configuration completed"
}

# Main execution
main() {
    # Check for update-claude flag
    if [[ "$1" == "update-claude" ]] || [[ "$1" == "--update-claude" ]]; then
        cd "$(dirname "$0")"
        update_claude
        return 0
    fi

    print_info "Starting dotfiles setup..."

    # Change to dotfiles directory
    cd "$(dirname "$0")"

    detect_os
    install_packages
    install_version_managers
    create_symlinks
    setup_claude
    setup_tmux
    setup_fish_plugins
    setup_shell

    print_success "Dotfiles setup completed successfully!"
    print_info "Please restart your terminal or run: source ~/.config/fish/config.fish"
}

# Run main function
main "$@"