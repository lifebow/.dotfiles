# Dotfiles

Personal dotfiles for a `zsh`-based terminal environment. The setup is managed
with GNU `stow`, so each top-level package directory is symlinked into `$HOME`.

## Requirements

- `git`
- `zsh`
- GNU `stow`
- `curl`
- `unzip`
- A Nerd Font, recommended for prompt and CLI icons.

## Install Dependencies

macOS:

```sh
brew install git zsh stow curl unzip
brew install --cask font-jetbrains-mono-nerd-font
```

Debian/Ubuntu:

```sh
sudo apt update
sudo apt install git zsh stow curl unzip
```

Set `zsh` as your login shell:

```sh
chsh -s "$(command -v zsh)"
```

If you use Homebrew `zsh` on macOS and `chsh` rejects it, add it to
`/etc/shells` first:

```sh
grep -qx "$(command -v zsh)" /etc/shells || command -v zsh | sudo tee -a /etc/shells
```

## Install Dotfiles

```sh
git -C "$HOME" clone git@github.com:lifebow/.dotfiles.git .dotfiles
cd "$HOME/.dotfiles"
stow */
```

Install only selected packages:

```sh
stow zsh starship git npm
```

If the repository is not under `$HOME`, pass the target explicitly:

```sh
stow -t "$HOME" zsh
```

Reload the shell:

```sh
exec zsh
```

## Update

```sh
cd "$HOME/.dotfiles"
git pull
stow */
zinit update
exec zsh
```

## Uninstall

```sh
cd "$HOME/.dotfiles"
stow -D */
```

Switch back to another login shell if needed:

```sh
chsh -s /bin/zsh
```

## More Information

See [DETAILS.md](DETAILS.md) for package notes, zsh layout, bootstrapped tools,
and troubleshooting.

## Credit

- [vokhactri/.dotfiles](https://github.com/vokhactri/.dotfiles)
- [Machfiles](https://github.com/ChristianChiarulli/Machfiles/)
- [zsh_unplugged](https://github.com/mattmc3/zsh_unplugged)
- [ayanrajpoot10/dotfiles](https://github.com/ayanrajpoot10/dotfiles)
