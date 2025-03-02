-- Bootstrap lazy.nvim synchronously
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

-- Force synchronous loading 
require("lazy").setup(require("plugins"), { defaults = { lazy = false } })

-- Load core settings
require("settings")

-- Load BASED THEME 
local theme_path = vim.fn.stdpath("config") .. "/lua/themes/based_theme.lua"
if vim.fn.filereadable(theme_path) == 1 then
    require("lush").apply(require("themes.based_theme"))
else
    print("Warning: based_theme.lua not found. Using default theme.")
end

-- Disable default message
vim.opt.shortmess:append("I")  

-- Display ASCII art on the start screen
local function show_ascii_art()
    local ascii_path = vim.fn.stdpath("config") .. "/asciiart.txt"
    if vim.fn.filereadable(ascii_path) == 1 then
        local ascii_art = vim.fn.readfile(ascii_path)
        -- Set it inside the buffer instead of printing
        vim.api.nvim_buf_set_lines(0, 0, -1, false, ascii_art)
    else
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { "⚠ ASCII Art file not found!" })
    end
end

-- Run it on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Only show if no file is opened
        if vim.fn.argc() == 0 then
            vim.cmd("enew")  -- Open empty buffer
            vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")  -- No save warnings
            show_ascii_art()
        end
    end,
})


