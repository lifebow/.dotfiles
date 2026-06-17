# Dotfiles Details

This document describes what each package and shell module in this dotfiles
repository does. For the short installation guide, see [README.md](README.md).

## Packages

Current packages:

- `zsh`: XDG-based zsh setup, plugin loading, aliases, shell options, history,
  PATH setup, and binary bootstrapping through `zinit`.
- `starship`: prompt configuration and Nerd Font symbols.
- `git`: global Git defaults.
- `fastfetch`: compact system information output.
- `npm`: npm and pnpm release-age settings.
- `containers`: containers/podman engine defaults.
- `fontconfig`: font fallback and hinting preferences.

## zsh Layout

The top-level `zsh/.zshenv` sets:

```sh
XDG_CONFIG_HOME="$HOME/.config"
XDG_BIN_HOME="$HOME/.local/bin"
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
```

This means the real `.zshrc` is symlinked to:

```text
~/.config/zsh/.zshrc
```

The top-level `~/.zshenv` only points `zsh` at this XDG-style layout.

## First zsh Startup

After stowing the `zsh` package, reload your shell:

```sh
exec zsh
```

On the first startup, `zsh/.config/zsh/zinit.zsh` clones `zinit` into:

```text
~/.local/share/zinit/zinit.git
```

`zinit` then installs shell plugins and GitHub release binaries.

Plugins:

- `zsh-brew`
- `zsh-autopair`
- `fzf-tab`
- `fast-syntax-highlighting`
- `zsh-autosuggestions`

Binaries:

- `lsd`
- `ripgrep`
- `fd`
- `uv` and `uvx`
- `bat`
- `fastfetch`
- `zoxide`
- `fnm`
- `starship`
- `fzf`

GitHub release binaries are installed under:

```text
~/.local/share/zinit/polaris/bin
```

That directory is added to `PATH` before `zinit` is loaded.

## Shell Behavior

The zsh config:

- Uses `bat`, `lsd`, `ripgrep`, `fd`, `uv`, and `fastfetch` as modern CLI
  tools.
- Installs `uv` and `uvx` for Python projects, scripts, tools, virtual
  environments, and package management.
- Uses `fd` as the default file source for `fzf`.
- Sets `EDITOR`, `VISUAL`, and `SUDO_EDITOR` to `nano`.
- Sets `PAGER` to `bat`.
- Enables shared, deduplicated history with a large history size.
- Adds `PNPM_HOME` to `PATH`.
- On macOS/Homebrew, symlinks GNU tools from Homebrew prefixes into
  `~/.local/bin` once.
- Provides a `docker()` wrapper that prefers `podman` if installed, otherwise
  falls back to the real `docker` command.

## Package Notes

### `git`

Sets `main` as the default branch, configures the global user, enables push
auto-upstream setup, tightens whitespace behavior, and rewrites `gh:` URLs to
`git@github.com:`.

### `starship`

Disables the extra prompt newline, uses `➜` as the prompt character, and
configures Nerd Font symbols for many language and tool modules.

### `fastfetch`

Shows OS, kernel, packages, shell, window manager, uptime, CPU, memory, disk,
and a custom color line.

### `npm`

Sets package release-age delays:

- npm: 7 days
- pnpm: 10080 minutes

### `containers`

Disables compose warning logs:

```toml
[engine]
compose_warning_logs = false
```

### `fontconfig`

Prefers Arial, Times New Roman, Consolas, and JoyPixels; enables light font
hinting; adds `~/.fonts`; and rejects Segoe UI Emoji.

## Troubleshooting

### `stow: command not found`

GNU `stow` is not installed. Install it with your operating system's package
manager as shown in [README.md](README.md).

### `zsh: command not found`

`zsh` is not installed, or it is not in `PATH`. Install `zsh` before stowing the
`zsh` package.

### `zinit` cannot be cloned

Check your internet connection and GitHub access. The first `exec zsh` needs to
clone:

```text
https://github.com/zdharma-continuum/zinit.git
```

If the clone fails halfway, remove the broken clone and reload:

```sh
rm -rf "$HOME/.local/share/zinit/zinit.git"
exec zsh
```

### GitHub release binaries are not installed

Make sure `curl` is installed. `zinit` uses it to find and download release
assets for tools such as `zoxide`, `fzf`, `fnm`, `starship`, `bat`, `uv`, and
`lsd`.

```sh
command -v curl
```

After installing `curl`, update `zinit` and reload:

```sh
zinit update
exec zsh
```

### `z`/`zoxide` does not work

`zoxide` is installed through `zinit` on the first shell startup. Check:

```sh
command -v zoxide
type z
```

If either is missing, make sure `zinit` cloned successfully, then run:

```sh
zinit update
exec zsh
```
