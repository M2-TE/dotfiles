lazy_plugins[#lazy_plugins + 1] = {
    'romgrk/barbar.nvim',
    dependencies = {
        --'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        -- lazy.nvim will automatically call setupfor you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        -- Move to previous/next
        map('n', '<C-h>', '<Cmd>BufferPrevious<CR>', opts)
        map('n', '<C-l>', '<Cmd>BufferNext<CR>', opts)
        -- Re-order to previous/next
        map('n', '<A-h>', '<Cmd>BufferMovePrevious<CR>', opts)
        map('n', '<A-l>', '<Cmd>BufferMoveNext<CR>', opts)
        -- Pin/unpin buffer
        map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
        -- Close buffer
        map('n', '<C-c>', '<Cmd>BufferClose<CR>', opts)
        -- Magic buffer-picking mode
        map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
    end
}
