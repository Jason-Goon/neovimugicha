#!/bin/sh
set -e

echo "Deleting existing Neovim configuration..."

# Delete Neovim config directory if it exists
if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    echo "Deleted ~/.config/nvim"
else
    echo "No Neovim config directory found at ~/.config/nvim"
fi

# Delete lazy.nvim installation
if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    rm -rf "$HOME/.local/share/nvim/lazy/lazy.nvim"
    echo "Deleted lazy.nvim plugin at ~/.local/share/nvim/lazy/lazy.nvim"
else
    echo "No lazy.nvim installation found."
fi

# Delete math templates if present
if [ -d "$HOME/.config/nvim/math-templates" ]; then
    rm -rf "$HOME/.config/nvim/math-templates"
    echo "Deleted math templates at ~/.config/nvim/math-templates"
else
    echo "No math templates found."
fi

# Remove any cached Neovim data
if [ -d "$HOME/.local/state/nvim" ]; then
    rm -rf "$HOME/.local/state/nvim"
    echo "Deleted Neovim cached state at ~/.local/state/nvim"
else
    echo "No cached Neovim state found."
fi

# Remove cloned repo (if exists)
if [ -d "$HOME/neovimugicha" ]; then
    rm -rf "$HOME/neovimugicha"
    echo "Deleted temporary cloned Neovim repo at ~/neovimugicha"
fi

echo "Neovimugicha has been successfully uninstalled."

