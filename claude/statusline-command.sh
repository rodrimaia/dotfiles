#!/bin/bash

# StatusLine command that mimics Starship prompt configuration
# Based on the user's ~/.config/starship.toml

# Read input JSON from stdin
input=$(cat)

# Extract current directory from input
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')

# Function to get truncated directory path
get_directory() {
    local dir="$1"
    local home_replaced="${dir/#$HOME/~}"
    
    # Check if we're in a git repository
    if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local repo_root=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
        local repo_name=$(basename "$repo_root")
        local relative_path=$(realpath --relative-to="$repo_root" "$dir" 2>/dev/null || echo ".")
        
        if [ "$relative_path" = "." ]; then
            printf "\033[1;36m%s\033[0m " "$repo_name"
        else
            # Truncate long paths
            local truncated_path="$relative_path"
            local path_parts=(${relative_path//\// })
            if [ ${#path_parts[@]} -gt 2 ]; then
                truncated_path="…/${path_parts[-2]}/${path_parts[-1]}"
            fi
            printf "\033[1;36m%s\033[0m\033[0m%s\033[0m " "$repo_name" "$truncated_path"
        fi
    else
        # Not in a git repo, show normal truncated path
        local path_parts=(${home_replaced//\// })
        if [ ${#path_parts[@]} -gt 2 ]; then
            local truncated="…/${path_parts[-2]}/${path_parts[-1]}"
            printf "%s " "$truncated"
        else
            printf "%s " "$home_replaced"
        fi
    fi
}

# Function to get git branch
get_git_branch() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            printf "\033[1m%s\033[0m " "$branch"
        fi
    fi
}

# Function to get git status symbols
get_git_status() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local status=""
        local git_status_output=$(git status --porcelain 2>/dev/null)
        
        # Check for various git states
        if echo "$git_status_output" | grep -q "^??"; then
            status="${status}?"
        fi
        if echo "$git_status_output" | grep -q "^ M\|^AM\|^MM\|^ T"; then
            status="${status}!"
        fi
        if echo "$git_status_output" | grep -q "^M\|^A\|^D\|^R\|^C"; then
            status="${status}+"
        fi
        if echo "$git_status_output" | grep -q "^R"; then
            status="${status}»"
        fi
        if echo "$git_status_output" | grep -q "^D\|^ D"; then
            status="${status}✘"
        fi
        if git stash list | grep -q .; then
            status="${status}$"
        fi
        
        # Check for ahead/behind
        local ahead_behind=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
        if [ $? -eq 0 ]; then
            local behind=$(echo "$ahead_behind" | cut -f1)
            local ahead=$(echo "$ahead_behind" | cut -f2)
            
            if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
                status="${status}⇕⇡${ahead}⇣${behind}"
            elif [ "$ahead" -gt 0 ]; then
                status="${status}⇡${ahead}"
            elif [ "$behind" -gt 0 ]; then
                status="${status}⇣${behind}"
            fi
        fi
        
        if [ -n "$status" ]; then
            printf "\033[1;31m%s\033[0m" "$status"
        fi
    fi
}

# Build the status line
directory_part=$(get_directory "$current_dir")
git_branch_part=$(get_git_branch)
git_status_part=$(get_git_status)

# Output the status line (mimicking starship format but in a single line)
printf "[%s%s%s]" "$directory_part" "$git_branch_part" "$git_status_part"