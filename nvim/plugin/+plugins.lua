vim.pack.add({
    -- deps
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git" }, -- needed by: statusline, neo-tree, bufferline
    { src = "https://github.com/nvim-lua/plenary.nvim.git" }, -- needed by: neo-tree, cmake-tools
    { src = "https://github.com/MunifTanjim/nui.nvim.git" }, -- needed by: neo-tree

    -- lsp
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    -- file browser
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim.git", version = vim.version.range("3.*") },
    -- statusline
    { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
    -- buffer tabs
    { src = "https://github.com/akinsho/bufferline.nvim.git" },
    -- commenting
    { src = "https://github.com/tpope/vim-commentary.git" },
    -- inline terminal
    { src = "https://github.com/akinsho/toggleterm.nvim.git" }, -- needed by: cmake-tools
}, { confirm = false, load = false })
vim.pack.add({
    -- deps
    { src = "https://github.com/famiu/bufdelete.nvim.git" }, -- needed by: bufferline (indirectly)
}, { confirm = false, load = true })

-- lsp
require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
        },
    },
    sources = { default = { "lsp", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
})

-- file browser
require("neo-tree.command").execute({ toggle = true }) -- should open with neo-tree visible
vim.keymap.set("n", "<C-e>", function()
    require("neo-tree.command").execute({ toggle = true })
end)

-- statusline
require("lualine").setup({
    options = {
        theme = "codedark",
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        globalstatus = true,
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diagnostics"},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {"lsp_status", "progress"},
        lualine_z = {"location"}
    },
    disabled_filetypes = {
        "neo-tree",
    },
})

-- buffer tabs
local bufferline = require("bufferline")
bufferline.setup({
    options = {
        mode = "buffer",
        close_command = "Bdelete! %d",
        right_mouse_command = "buffer %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = "Bdelete! %d",
        offsets = {{
            separator = false,
            filetype = "neo-tree",
            text = function()
                return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
            end,
            highlight = "NeoTreeNormal",
        }},
        color_icons = true,
        style_preset = bufferline.style_preset.no_italic,
        separator_style = "thin", -- slant, slope, thick, thin
        indicator = {
            -- icon = "> ",
            style = "none"
        },
        tab_size = 8,
        max_name_length = 18,
        show_close_icon = true,
        show_buffer_close_icons = true,
    }
})

-- inline terminal
require("toggleterm").setup({
    open_mapping = "<C-j>"
})

-- cmake
vim.api.nvim_create_autocmd({ "DirChanged" }, {
    callback = function()
        -- check if directory contains a CMakeLists.txt
        local cwd = vim.loop.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
            -- immediately load with vim.pack
            vim.pack.add({
                "https://github.com/Civitasv/cmake-tools.nvim.git"
            }, { confirm = false, load = true })
            -- set up paths (generate options and build dir dont work)
            require("cmake-tools").setup({
                cmake_use_preset = false,
                cmake_generate_options = { "-G Ninja" },
                cmake_build_directory = "build",
                cmake_executor = {
                    name = "toggleterm",
                    opts = {
                        direction = "horizontal",
                    },
                },
                cmake_runner = {
                    name = "toggleterm",
                    opts = {
                        direction = "horizontal",
                    },
                },
            })
            -- since build dir opt doesnt work, set it manually
            vim.cmd("CMakeSelectBuildDir " .. cwd .. "/build")
        end
    end,
})
