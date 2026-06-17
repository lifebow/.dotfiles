# Dotfiles

Personal dotfiles for a `zsh`-based terminal environment. The setup is managed
with GNU `stow`, so each top-level package directory is symlinked into `$HOME`.

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

## Requirements

Required:

- `git`
- `zsh`
- GNU `stow`
- `curl`

Recommended:

- `unzip`, required by some binary installs, especially `fnm`.
- A Nerd Font, because `starship`, `lsd`, and `fastfetch` use icons.
- Homebrew on macOS if you want the GNU tool symlinks in `zsh/config/bin.zsh`.

## Install Dependencies

### macOS With Homebrew

```sh
brew install git zsh stow curl unzip
brew install --cask font-jetbrains-mono-nerd-font
```

If you use the Homebrew `zsh`, add it to `/etc/shells` if it is not already
listed:

```sh
grep -qx "$(command -v zsh)" /etc/shells || command -v zsh | sudo tee -a /etc/shells
```

Change your login shell to `zsh`:

```sh
chsh -s "$(command -v zsh)"
```

### Debian/Ubuntu

```sh
sudo apt update
sudo apt install git zsh stow curl unzip
chsh -s "$(command -v zsh)"
```

### Arch Linux

```sh
sudo pacman -S git zsh stow curl unzip
chsh -s "$(command -v zsh)"
```

### Fedora

```sh
sudo dnf install git zsh stow curl unzip
chsh -s "$(command -v zsh)"
```

Log out and back in after `chsh`, or open a new terminal session.

## Install Dotfiles

Clone this repository into `$HOME/.dotfiles`:

```sh
git -C "$HOME" clone git@github.com:lifebow/.dotfiles.git .dotfiles
cd "$HOME/.dotfiles"
```

Symlink every package:

```sh
stow */
```

Or install only selected packages:

```sh
stow zsh starship git npm
```

If the repository is not directly under `$HOME`, pass the target explicitly:

```sh
stow -t "$HOME" zsh
```

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

## Update

Update the repository:

```sh
cd "$HOME/.dotfiles"
git pull
stow */
exec zsh
```

Update plugins and binaries managed by `zinit`:

```sh
zinit update
```

## Uninstall

Remove symlinks for one package:

```sh
cd "$HOME/.dotfiles"
stow -D zsh
```

Remove symlinks for every stowed package:

```sh
stow -D */
```

If you changed your login shell and want to switch back to the system `zsh`:

```sh
chsh -s /bin/zsh
```

Or change it to another shell, such as `/bin/bash`.

## Troubleshooting

### `stow: command not found`

GNU `stow` is not installed. Install it with your operating system's package
manager as shown in "Install Dependencies".

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

## Credit

- [Machfiles](https://github.com/ChristianChiarulli/Machfiles/)
- [zsh_unplugged](https://github.com/mattmc3/zsh_unplugged)
- [ayanrajpoot10/dotfiles](https://github.com/ayanrajpoot10/dotfiles)
