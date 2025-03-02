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

-- Force ASCII Art as the start screen
vim.opt.shortmess:append("I")  -- Suppress default intro message

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local ascii_path = vim.fn.stdpath("config") .. "/asciiart.txt"
        if vim.fn.filereadable(ascii_path) == 1 then
            local ascii_art = vim.fn.readfile(ascii_path)
            print(table.concat(ascii_art, "\n"))
        else
            print("Warning: ASCII Art file not found.")
        end
    end
})

print("Neovim setup complete. Math and Copilot are enabled.")
