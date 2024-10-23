return {
    "williamboman/mason-lspconfig.nvim",
    enabled = true,
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        ensure_installed = {
            "lua_ls", "clangd", "cmake"
        }
    },
}
