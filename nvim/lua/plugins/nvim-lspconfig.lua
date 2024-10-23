return {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("lspconfig").lua_ls.setup{}
        require("lspconfig").clangd.setup{}
        require("lspconfig").cmake.setup{}
    end
}
