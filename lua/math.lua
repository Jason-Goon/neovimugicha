-- vimtex conf
vim.g.vimtex_view_method = "zathura" 
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0

-- copy LaTeX templates to a new project folder
local function create_project(project_type, name)
    local root = vim.fn.stdpath("config") .. "/math-templates/"
    local dest = vim.fn.expand("~/Documents/" .. project_type .. "/" .. name)

    os.execute("mkdir -p " .. dest)
    os.execute("cp " .. root .. "* " .. dest)

    print("Created " .. project_type .. " project: " .. dest)
end

-- math-related projects
vim.api.nvim_create_user_command("NewMathProject", function(args)
    create_project("math", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewNotes", function(args)
    create_project("notes", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewAssignment", function(args)
    create_project("assignments", args.args)
end, { nargs = 1 })

print("Math configuration loaded successfully.")
