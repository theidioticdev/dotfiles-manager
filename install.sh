#!/bin/bash
set -euo pipefail

PREFIX="${PREFIX:-$HOME/.local}"

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "warning: ~/.local/bin is not in your PATH"
fi

echo "installing theidioticdev's dotfiles-manager..."

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

git clone https://github.com/theidioticdev/dotfiles-manager "$TMP/repo"

install -Dm755 "$TMP/repo/dotfiles-manager"   "$PREFIX/bin/dotfiles-manager"
install -Dm644 "$TMP/repo/dotfiles-manager.1" "$PREFIX/share/man/man1/dotfiles-manager.1"

echo "done! run 'dotfiles-manager -h' for help"
