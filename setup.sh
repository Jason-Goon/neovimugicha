#!/bin/sh
set -e

# Ensure we're in the home directory
cd "$HOME"

GITHUB_REPO="https://github.com/Jason-Goon/neovimugicha.git"
BRANCH="master"

CONFIG_DIR="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy"
# MATH_TEMPLATE_DIR and THEME_PATH are defined here in case you need them later,
# but no additional commands are needed to move or copy math-templates.
MATH_TEMPLATE_DIR="$CONFIG_DIR/math-templates"
THEME_PATH="$CONFIG_DIR/lua/themes"

echo "Checking for a clean Neovim environment..."
if [ -d "$CONFIG_DIR" ]; then
    echo "Error: $CONFIG_DIR already exists. Please remove the existing configuration first."
    exit 1
fi

echo "Proceeding with a clean install..."

# Create ~/.config/nvim before cloning
mkdir -p "$CONFIG_DIR"

# Clone Neovim configuration into a temp directory
echo "Cloning Neovim configuration from GitHub..."
git clone --depth=1 --branch "$BRANCH" "$GITHUB_REPO" "$HOME/neovimugicha"

# Move everything into ~/.config/nvim/
echo "Moving configuration files into ~/.config/nvim/..."
mv "$HOME/neovimugicha/"* "$CONFIG_DIR/"

# Remove the temporary cloned repo
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
    echo "Warning: The following dependencies are missing:$MISSING_PACKAGES"
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

echo "Setup complete. Neovim is ready to use!"
