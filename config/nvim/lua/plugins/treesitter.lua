return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",

    config = function()
        local ts = require("nvim-treesitter")

        -- Where parsers/queries are installed.
        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Install the parsers we want.
        ts.install({
            "bash",
            "c",
            "cpp",
            "cmake",
            "diff",
            "html",
            "java",
            "json",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "sql",
            "vim",
            "yaml",
            "gitignore",
        })

        -- Enable Treesitter + folding.
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "diff",
                "html",
                "java",
                "json",
                "lua",
                "markdown",
                "python",
                "rust",
                "sql",
                "vim",
                "yaml",
            },

            callback = function()
                -- Start Treesitter.
                vim.treesitter.start()

                -- Treesitter folding.
                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

                vim.opt.foldenable = true
                vim.opt.foldlevel = 99
                vim.opt.foldlevelstart = 99
            end,
        })

        -- C/C++ indentation.
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp" },

            callback = function()
                vim.bo.cindent = true
                vim.bo.indentexpr = ""
                vim.opt_local.cinoptions = "N+s"
            end,
        })
    end,
}
