# Herdr Configuration Design

## Goal

Add Herdr to the cross-platform chezmoi setup with a small keymap that preserves tmux muscle memory. Herdr supplements tmux; it does not replace tmux, its configuration, or its aliases.

## Managed Configuration

Add `home/dot_config/herdr/config.toml`. Chezmoi will install it as `~/.config/herdr/config.toml` on macOS and Arch Linux.

The keymap will use `ctrl+a`, matching the Oh My Tmux secondary prefix, and retain useful bindings from `kunchenguid/dotfiles` and Oh My Tmux:

| Action | Binding |
| --- | --- |
| Focus pane left/down/up/right | `prefix+h/j/k/l` |
| Split horizontally | `prefix+double_quote`, `prefix+minus` |
| Split vertically | `prefix+percent`, `prefix+shift+minus` |
| Create tab | `prefix+c` |
| Rename tab | `prefix+shift+t`, `prefix+comma` |
| Previous/next tab | `prefix+p/n`, `prefix+ctrl+h/l` |
| Jump to tab 1-9 | `prefix+1..9` |
| Close tab | `prefix+ampersand` |
| Cycle/last pane | `prefix+o`, `prefix+semicolon` |
| Close pane | `prefix+x` |
| Zoom pane | `prefix+z`, `prefix+plus` |
| Enter resize mode | `prefix+r` |
| Open workspace picker | `prefix+w` |
| Open goto picker | `prefix+g` |
| Enter copy mode | `prefix+[`, `prefix+enter` |
| Detach | `prefix+q`, `prefix+d` |

Copy mode intentionally differs from the referenced config's `prefix+y`. The selected binding matches tmux and Herdr's current default. Copy mode's internal keys remain Herdr defaults because they are not configurable.

The Agent panel will set `agent_panel_sort = "spaces"`, retaining the explicit grouping behavior from the referenced config.

All bindings remain prefix-based. This avoids conflicts with shells, editors, Ghostty, and tmux.

## Installation

On macOS, add the official Homebrew formula to `provision/mac/Brewfile`:

```ruby
brew "herdr"
```

On Arch Linux, add `herdr-bin` to the existing `yay` provisioning in `home/run_once_before_00-install-packages.sh.tmpl`. The binary AUR package avoids compiling Herdr from source during machine setup.

The existing tmux packages, bootstrap logic, configuration, and `tn` alias remain unchanged.

## Documentation

Update `README.md` to:

- List Herdr as the agent multiplexer alongside tmux.
- Include `home/dot_config/herdr/` in the chezmoi source layout.
- Mention the tmux-style Herdr keymap where terminal tooling is described.

## Verification

Verify the change by:

1. Parsing the new file as TOML.
2. Confirming chezmoi maps it to `~/.config/herdr/config.toml`.
3. Checking that macOS and Arch provisioning declare `herdr` and `herdr-bin`, respectively.
4. Asking an installed Herdr binary to load or reload the configuration when available.
5. Reviewing the final diff to ensure tmux behavior remains untouched.

## Out Of Scope

- Replacing or removing tmux.
- Adding direct `ctrl+alt` bindings.
- Adding Herdr plugins, custom commands, themes, notifications, or worktree settings.
- Changing shell aliases or automatically launching Herdr.
