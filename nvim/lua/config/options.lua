-- use spaces for tabs and whatnot
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- round indent to sw compatible
vim.opt.expandtab = true

-- other stuff
vim.opt.number = true -- line numbering
vim.opt.fillchars = { eob = " " }

-- enable 24-bit colour
vim.opt.termguicolors = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- hide bottom status bar
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

-- disable some providers (taken from nvchad)
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- experiments
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"

-- cursor position styling
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
