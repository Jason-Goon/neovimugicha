#!/bin/sh
set -e

# Ensure we're in the home directory
cd "$HOME"

GITHUB_REPO="https://github.com/Jason-Goon/neovimugicha.git"
BRANCH="master"

CONFIG_DIR="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy"
MATH_TEMPLATE_DIR="$CONFIG_DIR/math-templates"
THEME_PATH="$CONFIG_DIR/lua/themes"

echo "                                                                                                "
echo " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗██╗   ██╗ ██████╗ ██╗ ██████╗██╗  ██╗ █████╗ "
echo " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║██║   ██║██╔════╝ ██║██╔════╝██║  ██║██╔══██╗"
echo " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║██║   ██║██║  ███╗██║██║     ███████║███████║"
echo " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║██║   ██║██║   ██║██║██║     ██╔══██║██╔══██║"
echo " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║╚██████╗██║  ██║██║  ██║"
echo " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝"
echo "                                                                                                "

echo "Checking for a clean Neovim environment..."
if [ -d "$CONFIG_DIR" ]; then
    echo "Error: $CONFIG_DIR already exists. Please remove the existing configuration first."
    exit 1
fi

echo "Proceeding with a clean install..."

# Create necessary directories
mkdir -p "$CONFIG_DIR/lua/themes"
mkdir -p "$LAZY_DIR"

# Clone Neovim configuration into a temporary folder
echo "Cloning Neovim configuration from GitHub..."
git clone --depth=1 --branch "$BRANCH" "$GITHUB_REPO" "$HOME/neovimugicha"

# Copy configuration files into ~/.config/nvim/
echo "Copying configuration files into place..."
cp -r "$HOME/neovimugicha/lua/"* "$CONFIG_DIR/lua/"
cp "$HOME/neovimugicha/lua/init.lua" "$CONFIG_DIR/init.lua"
cp -r "$HOME/neovimugicha/math-templates" "$MATH_TEMPLATE_DIR"

# Copy ASCII Art to config
echo "Copying ASCII Art..."
cp "$HOME/neovimugicha/asciiart.txt" "$CONFIG_DIR/asciiart.txt"
echo "✓ ASCII Art copied successfully."

echo "✓ Configuration files copied successfully."

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
    echo "⚠ Warning: The following dependencies are missing: $MISSING_PACKAGES"
    echo "Please install them manually before running Neovim."
else
    echo "✓ All necessary dependencies are installed."
fi

# Install lazy.nvim if not present
LAZY_PATH="$LAZY_DIR/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "Installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
    echo "✓ lazy.nvim installed."
else
    echo "✓ lazy.nvim already installed, skipping..."
fi

# Install Neovim plugins
echo "Installing Neovim plugins..."
nvim --headless "+Lazy sync" +qall
echo "✓ Neovim plugins installed successfully."

echo "──────────────────────────────────────────────────────────"
echo "Installation complete. Launch Neovim and start coding!"
echo "──────────────────────────────────────────────────────────"
