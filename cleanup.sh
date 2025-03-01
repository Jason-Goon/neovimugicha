#!/bin/sh
set -e

echo "Deleting existing Neovim configuration..."

# delete neovim config directory if it exists
if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    echo "deleted ~/.config/nvim"
else
    echo "no Neovim config directory found at ~/.config/nvim"
fi

# delete lazy.nvim if it exists
if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    rm -rf "$HOME/.local/share/nvim/lazy/lazy.nvim"
    echo "deleted lazy.nvim plugin at ~/.local/share/nvim/lazy/lazy.nvim"
else
    echo "no lazy.nvim installation found."
fi

echo "you have succesfully uninstalled neovimugicha"
