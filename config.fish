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
