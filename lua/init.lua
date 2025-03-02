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

-- Force synchronous loading of plugins
require("lazy").setup(require("plugins"), { defaults = { lazy = false } })

-- Load core settings
require("settings")

-- Load custom theme
local theme_path = vim.fn.stdpath("config") .. "/lua/themes/based_theme.lua"
if vim.fn.filereadable(theme_path) == 1 then
    require("lush").apply(require("themes.based_theme"))
else
    print("Warning: based_theme.lua not found. Using default theme.")
end

-- Load math-related config only if math support is enabled
local math_config = vim.fn.stdpath("config") .. "/lua/math.lua"
if vim.fn.filereadable(math_config) == 1 then
    require("math")
end
