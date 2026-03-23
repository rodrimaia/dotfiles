if status is-interactive
    # Commands to run in interactive sessions can go here
end
source ~/dotfiles/.alias

# source fish profile
if test -f ~/.fishprofile
    source ~/.fishprofile
end

set -gx EDITOR nvim
set fish_color_command green

starship init fish | source

# Initialize zoxide
zoxide init fish | source

# Initialize atuin shell history
atuin init fish | source

# Created by `pipx` on 2025-10-06 12:22:30
set PATH $PATH /Users/rodrigo/.local/bin

# Fix direnv slowness in tmux - use async mode
# Disabled done.fish plugin (moved to done.fish.disabled) as it causes 5s delays in tmux
set -g direnv_fish_mode eval_after_arrow
direnv hook fish | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
