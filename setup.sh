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

# Clone Neovim configuration into a temporary folder
echo "Cloning Neovim configuration from GitHub..."
git clone --depth=1 --branch "$BRANCH" "$GITHUB_REPO" "$HOME/neovimugicha"

# Copy configuration files into ~/.config/nvim/
echo "Copying configuration files into place..."
cp -r "$HOME/neovimugicha/lua/"* "$CONFIG_DIR/lua/"
cp "$HOME/neovimugicha/lua/init.lua" "$CONFIG_DIR/init.lua"

# Copy the theme explicitly
echo "Copying based_theme.lua..."
cp "$HOME/neovimugicha/lua/themes/based_theme.lua" "$THEME_PATH/based_theme.lua"

# Modify plugins.lua safely
PLUGIN_FILE="$CONFIG_DIR/lua/plugins.lua"

# If math is enabled, add VimTeX plugin properly
if [ "$enable_math" = "y" ] || [ "$enable_math" = "Y" ]; then
    echo "Enabling math support with VimTeX..."
    sed -i '/return {/a \
    { "lervag/vimtex", config = function() vim.g.vimtex_view_method = "zathura" vim.g.vimtex_compiler_method = "latexmk" vim.g.vimtex_quickfix_mode = 0 end },' "$PLUGIN_FILE"

    # Ensure math.lua is included in init.lua
    echo 'require("math")' >> "$CONFIG_DIR/init.lua"
fi

# If Copilot is enabled, add Copilot plugin properly
if [ "$enable_copilot" = "y" ] || [ "$enable_copilot" = "Y" ]; then
    echo "Enabling Copilot support..."
    sed -i '/return {/a \
    { "github/copilot.vim" },' "$PLUGIN_FILE"

    echo "Adding Copilot toggle keybind to settings..."
    echo 'vim.api.nvim_set_keymap("n", "<leader>co", ":Copilot toggle<CR>", { noremap = true, silent = true })' >> "$CONFIG_DIR/lua/settings.lua"
fi

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

