return {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    opts = {
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        ensure_installed = {
            "c", "lua", "vim", "vimdoc", "query",
            "cpp", "cmake", "glsl", "cuda",
            "vim", "regex", "lua", "bash", "markdown", "markdown_inline", -- noice.nvim
        },
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            use_languagetree = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        }
    },
    -- config = function() 
    --     vim.opt.foldenable = false
    --     vim.opt.foldmethod = "expr"
    --     vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    --     vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
        -- vim.opt.foldnestmax = 1
        -- vim.opt.foldminlines = 1
        -- vim.opt.fillchars = "fold: "
    -- end
}
