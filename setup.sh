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
                base-devel
            
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
    
    # Install mise if not present
    if ! command -v mise &> /dev/null; then
        print_info "Installing mise..."
        curl https://mise.run | sh
    fi
    
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
    
    # Neovim config
    mkdir -p ~/.config/nvim
    ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim
    
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

# Install Fisher plugin manager and plugins
setup_fish_plugins() {
    print_info "Installing Fisher plugin manager and plugins..."
    
    # Install Fisher
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source"
    
    # Install Fisher permanently
    fish -c "fisher install jorgebucaran/fisher"
    
    # Install z directory jumping tool
    fish -c "fisher install jethrokuan/z"
    
    print_success "Fisher and plugins installed"
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
    print_info "Starting dotfiles setup..."
    
    # Change to dotfiles directory
    cd "$(dirname "$0")"
    
    detect_os
    install_packages
    install_version_managers
    create_symlinks
    setup_fish_plugins
    setup_shell
    
    print_success "Dotfiles setup completed successfully!"
    print_info "Please restart your terminal or run: source ~/.config/fish/config.fish"
}

# Run main function
main "$@"