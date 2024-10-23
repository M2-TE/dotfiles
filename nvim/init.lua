require("config.remaps")
require("config.options")
require("config.lazy")

-- load last session
-- require("persistence").load({ last = true })
-- session loading kinda breaks nvim-tree, so toggle it once
-- require("nvim-tree.api").tree.toggle()

-- testing stuff
vim.keymap.set({"n", "x", "o"}, "x",  "<Plug>(leap-forward)")
vim.keymap.set({"n", "x", "o"}, "X",  "<Plug>(leap-backward)")
