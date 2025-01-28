if status is-interactive
    # Commands to run in interactive sessions can go here
end
source ~/dotfiles/.alias
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -q PATH; or set PATH ''
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

set -gx EDITOR nvim

# pnpm
set -gx PNPM_HOME /Users/rodrigo/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Created by `pipx` on 2024-01-20 19:25:00
set PATH $PATH /Users/rodrigo/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# source /opt/homebrew/opt/asdf/libexec/asdf.fish
source ~/.asdf/asdf.fish

# fish_add_path -m $HOME/.asdf/shims

starship init fish | source
