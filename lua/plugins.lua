return {
    -- File browser with icons
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  
    -- Treesitter for better syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  
    -- LSP configuration and autocompletion
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },
  
    -- Git integration
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
  
    -- Based theme Neovim port dependency
    { "rktjmp/lush.nvim" },
  
    -- Nicer interface
    { "nvim-lualine/lualine.nvim" },
  
    -- LaTeX Support (Only if enabled in setup)
    {
      "lervag/vimtex",
      cond = function() return vim.fn.isdirectory(vim.fn.stdpath("config") .. "/math-templates") == 1 end,
      config = function()
        vim.g.vimtex_view_method = "zathura"  -- Set PDF viewer
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 0
      end
    },
  
    -- GitHub Copilot (Only if enabled in setup)
    {
      "github/copilot.vim",
      cond = function() return vim.fn.executable("gh") == 1 and os.getenv("COPILOT_ENABLED") == "1" end,
    }
  }
  