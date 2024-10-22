return {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true,
        },
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            cursorline = true,
            preserve_window_proportions = true,
            width = {
                min = 20,
                max = -1,
                padding = 1,
            },
        },
        renderer = {
            group_empty = true,
            root_folder_label = false,
            highlight_git = true,
            indent_markers = { enable = true },
        },
        filters = {
            dotfiles = true,
        },
    },
    keys = {
        { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" }
    },
}
