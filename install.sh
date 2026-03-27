#!/bin/bash
set -e
echo "Installing theidioticdev's dotfiles-manager..."
git clone https://github.com/theidioticdev/dotfiles-manager
cd dotfiles-manager
chmod +x dotfiles-manager
cp dotfiles-manager ~/.local/bin
echo "Done! run 'dotfiles-manager -h' for help"

