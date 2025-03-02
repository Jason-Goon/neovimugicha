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

-- Leader key
vim.g.mapleader = " "

-- LSP and autocompletion
local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason setup
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

-- Nvim-tree setup
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

-- Quick command to toggle Copilot
vim.api.nvim_set_keymap("n", "<leader>co", ":Copilot toggle<CR>", { noremap = true, silent = true })

-- Function to copy LaTeX templates
local function create_project(project_type, name)
  local root = vim.fn.stdpath("config") .. "/math-templates/"
  local dest = vim.fn.expand("~/Documents/" .. project_type .. "/" .. name)

  os.execute("mkdir -p " .. dest)
  os.execute("cp " .. root .. "* " .. dest)

  print("Created " .. project_type .. " project: " .. dest)
end

-- Commands to create different project types
vim.api.nvim_create_user_command("NewMathProject", function(args)
  create_project("math", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewNotes", function(args)
  create_project("notes", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewAssignment", function(args)
  create_project("assignments", args.args)
end, { nargs = 1 })
