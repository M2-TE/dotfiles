vim.pack.add({
    -- deps
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git" }, -- statusline, neo-tree, bufferline
    { src = "https://github.com/nvim-lua/plenary.nvim.git" }, -- neo-tree, cmake-tools
    { src = "https://github.com/MunifTanjim/nui.nvim.git" }, -- neo-tree

    -- lsp
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    -- file browser
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim.git", version = vim.version.range("3.*") },
    -- statusline
    { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
    -- buffer tabs
    { src = "https://github.com/akinsho/bufferline.nvim.git" },
    { src = "https://github.com/famiu/bufdelete.nvim.git" },
    -- commenting
    { src = "https://github.com/tpope/vim-commentary.git" },
    -- inline terminal
    { src = "https://github.com/akinsho/toggleterm.nvim.git" }, -- cmake-tools
    -- cmake
    { src = "https://github.com/Civitasv/cmake-tools.nvim.git" },
}, { load = true })

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
vim.keymap.set("n", "<C-e>", "<Cmd>Neotree toggle<CR>")
require("neo-tree").setup({
})

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

require("cmake-tools").setup({
    cmake_build_directory = "build",
    working_directory = "/home/jan/repos/chad_vis",
    cmake_compile_commands_options = {
        action = "soft_link",
    },
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
