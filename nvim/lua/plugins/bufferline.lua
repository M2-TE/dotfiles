return {
    "akinsho/bufferline.nvim",
    enabled = true,
    opts = {
        options = {
            mode = "buffer",
            close_command = "bdelete! %d",
            right_mouse_command = "buffer %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = "bdelete! %d",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    highlight = "Directory",
                    separator = true,
                }
            },
            color_icons = true,
            separator_style = "slope", -- slant, slope, thick, thin
        }
    }
}
