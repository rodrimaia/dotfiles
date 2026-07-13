# chezmoi Source Directory Layout

## Sources

- [chezmoi Quick start](https://www.chezmoi.io/quick-start/)
- [chezmoi Setup](https://www.chezmoi.io/user-guide/setup/)
- [chezmoi Concepts](https://www.chezmoi.io/reference/concepts/)
- [chezmoi Source state attributes](https://www.chezmoi.io/reference/source-state-attributes/)
- [chezmoi Manage different types of file](https://www.chezmoi.io/user-guide/manage-different-types-of-file/)
- [chezmoi Customize your source directory](https://www.chezmoi.io/user-guide/advanced/customize-your-source-directory/)
- [chezmoi .chezmoiroot reference](https://www.chezmoi.io/reference/special-files/chezmoiroot/)

## Key Findings

- chezmoi's natural source layout is a mirror of the target destination directory, usually the user's home directory. The source directory defaults to `~/.local/share/chezmoi`, and each managed target has a corresponding entry there.
- The default repo root is also the source-state root. Running `chezmoi add ~/.bashrc` produces `~/.local/share/chezmoi/dot_bashrc`, and `chezmoi apply` maps that back to `~/.bashrc`.
- Source names encode target metadata through prefixes and suffixes. `dot_` maps to a leading dot, `private_` sets private permissions, `executable_` sets executable permissions, `symlink_` creates a symlink, and `.tmpl` marks a template.
- Directories are represented as directories in source state. Nested config paths therefore follow the target path, for example `private_dot_config/private_Code/User/symlink_settings.json.tmpl` maps to `~/.config/Code/User/settings.json`.
- If the repo root is too crowded, chezmoi officially supports moving the source-state root into a subdirectory with `.chezmoiroot`. For example, `.chezmoiroot` containing `home` makes chezmoi read `home/dot_gitconfig` as the source for `~/.gitconfig`.
- Nesting by tool outside the target-path mirror is not the convention for directly managed files. chezmoi supports arbitrary repo organization around the source state only when those files are ignored or when `.chezmoiroot` points to the actual source-state subtree. Directly managed files must live at the source path that maps to their target path.

## Natural Structure

Without `.chezmoiroot`, the source directory itself is the home-directory mirror:

```text
~/.local/share/chezmoi/
  dot_bashrc                    -> ~/.bashrc
  dot_gitconfig                 -> ~/.gitconfig
  dot_ssh/
    authorized_keys.tmpl        -> ~/.ssh/authorized_keys
  private_dot_config/
    fish/
      config.fish               -> ~/.config/fish/config.fish
```

With `.chezmoiroot`, the repo can contain other files while `home/` remains the source-state mirror:

```text
~/.local/share/chezmoi/
  .chezmoiroot                  # contains: home
  README.md
  docs/
  home/
    dot_gitconfig               -> ~/.gitconfig
    private_dot_config/
      nvim/
        init.lua                -> ~/.config/nvim/init.lua
```

## File Naming Examples

Home-directory dotfiles:

```text
dot_bashrc                      -> ~/.bashrc
dot_zshrc.tmpl                  -> ~/.zshrc, rendered as a template
private_dot_ssh/config          -> ~/.ssh/config with private permissions
executable_dot_local/bin/tool   -> ~/.local/bin/tool with executable permissions
```

Config-directory files:

```text
private_dot_config/fish/config.fish
  -> ~/.config/fish/config.fish

private_dot_config/Code/User/symlink_settings.json.tmpl
  -> ~/.config/Code/User/settings.json as a symlink target template

dot_kube/private_config
  -> ~/.kube/config with private permissions
```

## Tool-Based Nesting

Tool-based grouping such as this is not the direct source-state convention:

```text
fish/config.fish
nvim/init.lua
git/gitconfig
```

chezmoi maps source paths to target paths. Unless a custom source root or ignore rules are involved, `fish/config.fish` maps naturally to `~/fish/config.fish`, not `~/.config/fish/config.fish`. The supported convention is to nest by the target path:

```text
private_dot_config/fish/config.fish
private_dot_config/nvim/init.lua
dot_gitconfig
```

For repo-level organization, use `.chezmoiroot` to put the target-path mirror under a subdirectory such as `home/`, and keep unrelated docs/scripts outside that source root.
