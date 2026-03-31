vim.pack.add({
    -- deps
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- needed by: statusline, neo-tree, bufferline
    { src = "https://github.com/nvim-lua/plenary.nvim" }, -- needed by: neo-tree, cmake-tools
    { src = "https://github.com/MunifTanjim/nui.nvim" }, -- needed by: neo-tree

    -- lsp
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
    { src = "https://github.com/saghen/blink.download" }, -- needed by blink.pairs

    -- editor panes
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3.*") },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/akinsho/bufferline.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },

    -- misc
    { src = "https://github.com/tpope/vim-commentary" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/navarasu/onedark.nvim" },

}, { confirm = false, load = false })
vim.pack.add({
    -- cleanly delete buffers
    { src = "https://github.com/famiu/bufdelete.nvim" }, -- needed by: bufferline (indirectly)
    { src = "https://github.com/Civitasv/cmake-tools.nvim" },
}, { confirm = false, load = true })

-- lsp
require("mason").setup({
})
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
require("blink.pairs").setup({
})

-- editor panes
require("bufferline").setup({
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
        style_preset = require("bufferline").style_preset.no_italic,
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
require("toggleterm").setup({
    open_mapping = "<C-j>"
})
require("neo-tree").setup({
    window = {
        width = 30,
    },
    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
                if node.type == "file" or node.type == "terminal" then
                    local success, web_devicons = pcall(require, "nvim-web-devicons")
                    local name = node.type == "terminal" and "terminal" or node.name
                    if success then
                        local devicon, hl = web_devicons.get_icon(name)
                        icon.text = devicon or icon.text
                        icon.highlight = hl or icon.highlight
                    end
                end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
            use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
        },
        modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "", -- or "✚"
                modified = "", -- or ""
                deleted = "✖", -- this can only be used in the git_status source
                renamed = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "", -- 
                unstaged = "󰄱",
                staged = "",
                conflict = "",
            },
        },
    },
    filesystem = {
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_ignored = true, -- hide files that are ignored by other gitignore-like files
            ignore_files = {
            },
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
            },
            hide_by_pattern = { -- uses glob style patterns
            },
            always_show = { -- remains visible even if other settings would normally hide it
            },
            always_show_by_pattern = { -- uses glob style patterns
            },
        },
        follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
    },
    buffers = {
        follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
        mappings = {
            ["d"] = "buffer_delete",
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["o"] = {
            "show_help",
            nowait = false,
            config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
        },
        },
    },
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
                hl.blend = 100
                vim.api.nvim_set_hl(0, 'Cursor', hl)
                vim.opt.guicursor:append('a:Cursor/lCursor')
            end
        },
        {
            event = "neo_tree_buffer_leave",
            handler = function()
                local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
                hl.blend = 0
                vim.api.nvim_set_hl(0, 'Cursor', hl)
                vim.opt.guicursor:remove('a:Cursor/lCursor')
            end
        },
    }
})

-- misc
require("gitsigns").setup({
})
require("cmake-tools").setup({
    cmake_generate_options = { 
        "-G Ninja",
        "-D CMAKE_EXPORT_COMPILE_COMMANDS=1",
        "-D CMAKE_BUILD_TYPE=Release",
        "-D CMAKE_C_COMPILER=clang",
        "-D CMAKE_CXX_COMPILER=clang++",
        "-D CMAKE_CXX_FLAGS='-stdlib=libc++'",
        "-D CMAKE_EXE_LINKER_FLAGS='-stdlib=libc++ -lc++abi'",
    },
    cmake_build_directory = "build",
    cmake_compile_commands_options = {
        action = "lsp",
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
require("onedark").setup({
    style = "darker",
})
require("onedark").load()

-- pretend netrw is already loaded
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- keybinds
vim.g.mapleader = " " -- leader key (spacebar)
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-e>", function()
    require("neo-tree.command").execute({ toggle = true })
end)

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>") -- ??

