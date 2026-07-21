# Herdr Configuration Design

## Goal

Add Herdr to the cross-platform chezmoi setup with a small keymap that preserves tmux muscle memory. Herdr supplements tmux; it does not replace tmux, its configuration, or its aliases.

## Managed Configuration

Add `home/dot_config/herdr/config.toml`. Chezmoi will install it as `~/.config/herdr/config.toml` on macOS and Arch Linux.

The keymap will use `ctrl+b` as its prefix and retain the useful bindings from `kunchenguid/dotfiles`:

| Action | Binding |
| --- | --- |
| Focus pane left/down/up/right | `prefix+h/j/k/l` |
| Split horizontally | `prefix+double_quote` |
| Split vertically | `prefix+percent` |
| Create tab | `prefix+c` |
| Close tab | `prefix+ampersand` |
| Open workspace picker | `prefix+w` |
| Open goto picker | `prefix+g` |
| Enter copy mode | `prefix+[` |

Copy mode intentionally differs from the referenced config's `prefix+y`. The selected binding matches tmux and Herdr's current default. Copy mode's internal keys remain Herdr defaults because they are not configurable.

The Agent panel will set `agent_panel_sort = "spaces"`, retaining the explicit grouping behavior from the referenced config.

No direct, prefix-free bindings or broader key overrides will be added. This keeps the configuration small and avoids conflicts with shells, editors, Ghostty, and tmux.

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
