# chezmoi Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate this dotfiles repo to chezmoi as the single setup entrypoint while preserving `~/dotfiles` muscle memory.

**Architecture:** Use `.chezmoiroot` to keep repo docs and assets at the root while `home/` contains chezmoi's `$HOME` mirror. Convert managed dotfiles to native chezmoi encoded names and move provisioning from `setup.sh` into `run_once_*` scripts.

**Tech Stack:** chezmoi, POSIX shell, Homebrew, pacman/yay, Fish, tmux, LazyVim.

## Global Constraints

- Support macOS and Arch Linux.
- `chezmoi init rodrimaia/dotfiles --apply` is the setup entrypoint.
- Preserve `~/dotfiles` by creating it as a symlink to chezmoi's source directory.
- Do not keep duplicate canonical copies of managed dotfiles at repo root.

---

### Task 1: Source Layout

**Files:**
- Create: `.chezmoiroot`
- Create: `home/dot_alias`
- Create: `home/dot_config/fish/config.fish`
- Create: `home/dot_config/ghostty/config`
- Create: `home/dot_config/nvim/`
- Create: `home/dot_config/starship.toml`
- Create: `home/dot_tmux.conf.local`
- Create: `home/dot_zshrc.local`

- [x] Move managed dotfiles into `home/` using chezmoi's native target-path mirror.
- [x] Remove old canonical root copies.
- [x] Keep repo-level docs, provisioning, scripts, and wallpaper assets outside `home/`.

### Task 2: Provisioning Scripts

**Files:**
- Create: `home/run_once_before_00-install-packages.sh.tmpl`
- Create: `home/run_once_after_00-setup-tools.sh.tmpl`

- [x] Move package installation into a before-apply script.
- [x] Include chezmoi in managed package lists for ongoing installs.
- [x] Load Homebrew shellenv after installing Homebrew so `brew bundle` works on fresh macOS machines.
- [x] Move tmux, Fisher, Claude config, shell, dock setup, and `~/dotfiles` symlink into an after-apply script.
- [x] Use chezmoi template data for OS branching and source directory lookup.

### Task 3: Path Cleanup

**Files:**
- Modify: `home/dot_alias`
- Modify: `home/dot_config/fish/config.fish`
- Modify: `home/dot_zshrc.local`

- [x] Replace managed-file references to `~/dotfiles/.alias` with `~/.alias`.
- [x] Replace Neovim config edit aliases with `~/.config/nvim/init.lua`.
- [x] Make `.env` sourcing in zsh local config conditional.

### Task 4: Documentation

**Files:**
- Modify: `README.md`
- Modify: `AGENTS.md`

- [x] Document chezmoi as the setup entrypoint.
- [x] Document the `home/` source-state root.
- [x] Document the `~/dotfiles` symlink behavior.

### Task 5: Verification

**Files:**
- Verify: all changed files

- [x] Run shell syntax checks for provisioning scripts after rendering templates if possible.
- [x] Run chezmoi verification/diff commands if chezmoi is installed.
- [ ] Review `git diff` and confirm only intended files changed.
