if status is-interactive
    # Commands to run in interactive sessions can go here
end
source ~/dotfiles/.alias

# source fish profile
if test -f ~/.fishprofile
    source ~/.fishprofile
end

set -gx EDITOR nvim

starship init fish | source

alias claude="/Users/rodrigo/.claude/local/claude"
