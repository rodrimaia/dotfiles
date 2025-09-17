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

# Configure done plugin for command notifications
set -U __done_min_cmd_duration 5000  # 5 seconds minimum
set -U __done_notify_sound 1  # Enable notification sound

starship init fish | source
