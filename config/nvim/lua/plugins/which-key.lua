return {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
        local wk = require("which-key")
        wk.setup({
            delay = 300,
            win = {
                border = {
                    { '┌', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '┐', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '┘', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '└', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                },
            },
        })
        wk.add({
            { "<leader>s", group = "Split" },
            { "<leader>t", group = "Tabs" },
            { "<leader>l", group = "Looks" },
            { "<leader>f", group = "Telescope" },
            { "<leader>c", group = "CMake" },
            { "<leader>d", group = "DAP" },
        })
    end,
}
