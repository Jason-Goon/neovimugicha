#!/bin/sh
set -e

GITHUB_REPO="https://github.com/Jason-Goon/neovimugicha.git"
BRANCH="master"

CONFIG_DIR="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy"
MATH_TEMPLATE_DIR="$CONFIG_DIR/math-templates"
THEME_PATH="$CONFIG_DIR/lua/themes"

echo "Checking for a clean Neovim environment..."
if [ -d "$CONFIG_DIR" ]; then
    echo "Error: $CONFIG_DIR already exists. Please remove the existing configuration first."
    exit 1
fi

echo "Proceeding with a clean install..."

# Ask user for optional features
read -p "Enable math support (LaTeX setup)? [y/N]: " enable_math
read -p "Enable GitHub Copilot support? [y/N]: " enable_copilot

# Create necessary directories
mkdir -p "$CONFIG_DIR/lua/themes"
mkdir -p "$LAZY_DIR"

# Clone Neovim configuration
echo "Cloning Neovim configuration from GitHub..."
git clone --depth=1 --branch "$BRANCH" "$GITHUB_REPO" "$HOME/neovimugicha"

# Move config files into ~/.config/nvim/
echo "Moving configuration files into place..."
mv "$HOME/neovimugicha/lua" "$CONFIG_DIR/"
mv "$HOME/neovimugicha/init.lua" "$CONFIG_DIR/init.lua"

# Setup math templates if chosen
if [ "$enable_math" = "y" ] || [ "$enable_math" = "Y" ]; then
    echo "Enabling math templates..."
    mv "$HOME/neovimugicha/math-templates" "$MATH_TEMPLATE_DIR"
else
    echo "Skipping math template setup..."
    rm -rf "$HOME/neovimugicha/math-templates"  # Remove it if user doesn't want it
fi

# Move custom theme into ~/.config/nvim/lua/themes/
echo "Ensuring based_theme.lua is in the correct location..."
mv "$CONFIG_DIR/lua/themes/based_theme.lua" "$THEME_PATH/based_theme.lua"

# Remove leftover cloned repo
rm -rf "$HOME/neovimugicha"

# Check for system dependencies
echo "Checking system dependencies..."
MISSING_PACKAGES=""
for pkg in latexmk zathura node npm unzip ripgrep fd; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
        MISSING_PACKAGES="$MISSING_PACKAGES $pkg"
    fi
done

if [ -n "$MISSING_PACKAGES" ]; then
    echo "Warning: The following dependencies are missing: $MISSING_PACKAGES"
    echo "Please install them manually before running Neovim."
fi

# Install lazy.nvim if not present
LAZY_PATH="$LAZY_DIR/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "Installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
else
    echo "lazy.nvim already installed, skipping..."
fi

# Install Neovim plugins
echo "Installing Neovim plugins..."
nvim --headless "+Lazy sync" +qall

# Setup Copilot if chosen
if [ "$enable_copilot" = "y" ] || [ "$enable_copilot" = "Y" ]; then
    echo "Checking GitHub Copilot authentication..."
    if gh auth status >/dev/null 2>&1; then
        echo "GitHub authentication detected. Copilot should work."
    else
        echo "Warning: GitHub authentication not detected."
        echo "Run 'gh auth login' to authenticate before using Copilot."
    fi
else
    echo "Skipping Copilot setup..."
fi

echo "Setup complete. Neovim is ready to use!"
