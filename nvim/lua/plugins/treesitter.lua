lazy_plugins[#lazy_plugins + 1] = {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require'nvim-treesitter.configs'.setup {
            -- A list of parser names
            ensure_installed = {
                -- mandatory
                "c", "lua", "vim", "vimdoc", "query",
                "cpp", "cmake", "glsl"
            },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            }
        }
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false
        vim.opt.foldnestmax = 1
        vim.opt.foldminlines = 1
        vim.opt.fillchars = "fold: "
        vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
    end
}
