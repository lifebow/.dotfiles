#!/usr/bin/env zsh

export MANWIDTH=999

export EDITOR="nano"
export PAGER="bat"
export VISUAL="nano"
export SUDO_EDITOR="nano"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export HOMEBREW_UPGRADE_GREEDY=1

if [[ "$TERM" == "xterm-ghostty" ]] && ! infocmp -x "$TERM" >/dev/null 2>&1; then
  export TERM="xterm-256color"
fi

export GOENV="$XDG_CONFIG_HOME/go/env"
export GOPATH="$HOME/.go-workspace"
export GOBIN="$GOPATH/bin"
case ":$PATH:" in
  *":$GOBIN:"*) ;;
  *) export PATH="$GOBIN:$PATH" ;;
esac

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
