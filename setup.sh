#!/bin/sh
set -e

echo "checking for a clean neovim environment..."

# already exists kill

if [ -d "$HOME/.config/nvim" ]; then
  echo "Error: ~/.config/nvim already exists. Please run your delete script first to remove the existing configuration."
  exit 1
fi

echo "proceeding with a clean install..."

# create directories 

mkdir -p ~/.config/nvim/lua/themes
mkdir -p ~/.local/share/nvim/lazy


##################################
# create configuration files
##################################


# 1. init.lua: bootstrap lazy.nvim synchronously, then load settings and apply the theme.
cat << 'EOF' > ~/.config/nvim/init.lua
-- Bootstrap lazy.nvim so that plugins are loaded synchronously
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- force load synchronously
require("lazy").setup(require("plugins"), { defaults = { lazy = false } })

-- load settings and based_theme
require("settings")
require("lush").apply(require("themes.based_theme"))
EOF
echo "Created init.lua"

# 2. settings.lua: basic settings
cat << 'EOF' > ~/.config/nvim/lua/settings.lua
-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

-- leader: space
vim.g.mapleader = " "

-- LSP and autocompletion
local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "rust_analyzer", "clangd", "pyright", "ts_ls", "html", "cssls" }
})

local servers = { "rust_analyzer", "clangd", "pyright", "ts_ls", "html", "cssls" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = cmp_capabilities
  })
end

-- nvim-tree configuration
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  filters = {
    custom = { ".git", "node_modules", ".cache" }
  },
  git = {
    enable = true,
    ignore = false,
  },
})

-- Bind <leader>e (Space + e) to toggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
EOF
echo "created settings.lua"

# 3. plugins.lua
cat << 'EOF' > ~/.config/nvim/lua/plugins.lua
return {
  -- browser with icons (nvim-tree)
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- treesitter support
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP configuration and autocompletion
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },

  -- github integration
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- based theme nvim port dep
  { "rktjmp/lush.nvim" },

  -- nicer interface
  { "nvim-lualine/lualine.nvim" }
}
EOF
echo "created plugins.lua"

###################################################
# install and copy based_theme.lua from repo root
###################################################

cp ./based_theme.lua ~/.config/nvim/lua/themes/based_theme.lua
echo "Copied based_theme.lua to Neovim theme directory."

#####################################
# install and config lazy.nvim 
#####################################
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "Installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
else
    echo "lazy.nvim already installed, skipping..."
fi

#####################################
# global dep message 
#####################################
echo "make sure nodejs, npm, unzip, ripgrep and fd is installed. repo offers these commands for arch and gentoo otherwise on you chief"

#####################################
# headless nvim plugins install
#####################################
echo "Installing Neovim plugins..."
nvim --headless "+Lazy sync" +qall

echo "gz king go nuts"
