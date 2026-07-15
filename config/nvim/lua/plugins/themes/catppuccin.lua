return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
        local catppuccin = require('catppuccin')

        local function apply()
            catppuccin.setup({
                flavour = 'auto',
                background = {
                    light = 'latte',
                    dark  = 'mocha',
                },
                transparent_background = vim.g.transparent,
                float = {
                    transparent = vim.g.transparent,
                    solid       = false,
                },
                term_colors  = false,
                dim_inactive = {
                    enabled    = false,
                    shade      = 'dark',
                    percentage = 0.15,
                },
                no_italic    = false,
                no_bold      = false,
                no_underline = false,
                styles = {
                    comments   = { 'italic' },
                    conditionals = { 'italic' },
                    loops      = {},
                    functions  = {},
                    keywords   = {},
                    strings    = {},
                    variables  = {},
                    numbers    = {},
                    booleans   = {},
                    properties = {},
                    types      = {},
                    operators  = {},
                },
                lsp_styles = {
                    virtual_text = {
                        errors      = { 'italic' },
                        hints       = { 'italic' },
                        warnings    = { 'italic' },
                        information = { 'italic' },
                        ok          = { 'italic' },
                    },
                    underlines = {
                        errors      = { 'underline' },
                        hints       = { 'underline' },
                        warnings    = { 'underline' },
                        information = { 'underline' },
                        ok          = { 'underline' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                color_overrides = {},
                custom_highlights = function(colors)
                    return {
                        -- Line numbers
                        LineNr         = { fg = '#4a4a6a' },   -- absolute line number
                        LineNrAbove    = { fg = '#4a4a6a' },
                        LineNrBelow    = { fg = '#4a4a6a' },
                        CursorLineNr   = { fg = '#cdd6f4', style = { 'bold' } }, -- current line, bright

                        -- Indent lines (ibl / indent-blankline)
                        IblIndent      = { fg = '#313244' },   -- indent guides
                        IblScope       = { fg = '#585b70' },   -- current scope line, slightly brighter

                        -- Float/popup borders
                        FloatBorder    = { fg = '#6c7086' },   -- softer border
                        NormalFloat    = { bg = 'NONE' },      -- transparent float bg
                    }
                end,
                default_integrations = true,
                auto_integrations    = false,
                integrations = {
                    cmp      = true,
                    gitsigns = true,
                    nvimtree = true,
                    notify   = false,
                    mini     = {
                        enabled         = true,
                        indentscope_color = '',
                    },
                },
            })
        end

        apply()
        vim.cmd.colorscheme('catppuccin')

        function ToggleTransparency()
            vim.g.transparent = not vim.g.transparent
            apply()
            vim.cmd.colorscheme('catppuccin')
        end

        vim.keymap.set('n', '<leader>lb', ToggleTransparency, { desc = 'Toggle transparency' })
    end,
}
