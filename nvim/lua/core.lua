-- core keybinds
vim.g.mapleader = " " -- leader key (spacebar)
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-b>", vim.cmd.Ex) -- open netrw tree

-- set up plugin manager: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- enumerate plugins
lazy_plugins = {}
require("plugins.vim-commentary")
require("plugins.barbar")
require("plugins.treesitter")
require("plugins.telescope")
-- load plugins
require("lazy").setup(lazy_plugins)
