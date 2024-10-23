return {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "akinsho/toggleterm.nvim",
    },
    lazy = true,
    init = function()
        local loaded = false
        local function check()
            local cwd = vim.uv.cwd()
            if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
                require("lazy").load({ plugins = { "cmake-tools.nvim" } })
                loaded = true
            end
        end
        check()
        vim.api.nvim_create_autocmd("DirChanged", {
            callback = function()
                if not loaded then
                    check()
                end
            end,
        })
    end,
    opts = {
        cmake_use_preset = false,
        cmake_regenerate_on_save = true,
        cmake_generate_options = { "-G 'ninja' -DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_directory = "build",
        cmake_soft_link_compile_commands = false,
        cmake_compile_commands_from_lsp = false,
        cmake_executor = {
            name = "toggleterm",
            opts = {
                direction = "horizontal",
                close_on_exit = false,
                auto_scroll = true,
                singleton = true,
            },
        },
        cmake_runner = {
            name = "toggleterm",
            opts = {
                direction = "horizontal",
                close_on_exit = false,
                auto_scroll = true,
                singleton = true,
            },
        },
    },
    -- keys = {},
}
