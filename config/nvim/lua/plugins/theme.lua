return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,

        opts = {
            theme = "wave",

            background = {
                dark = "wave",
                light = "lotus",
            },

            transparent = false,
            terminalColors = true,

            commentStyle = { italic = true },
            keywordStyle = { italic = false },

            overrides = function(c)
                local ui = c.theme.ui
                local syn = c.theme.syn
                local diag = c.theme.diag

                return {
                    -- Base
                    Normal = { bg = ui.bg },
                    NormalNC = { bg = ui.bg },

                    -- No panel backgrounds
                    NormalFloat = { bg = "NONE" },
                    FloatBorder = {
                        fg = ui.fg_dim,
                        bg = "NONE",
                    },

                    SignColumn = { bg = "NONE" },
                    FoldColumn = { bg = "NONE" },
                    EndOfBuffer = { fg = ui.bg },

                    -- Cursor
                    CursorLine = { bg = ui.bg_p1 },
                    CursorLineSign = { bg = ui.bg_p1 },

                    CursorLineNr = {
                        fg = syn.fun,
                        bg = ui.bg_p1,
                        bold = true,
                    },

                    -- Selection
                    Visual = { bg = ui.bg_p2 },

                    Search = {
                        fg = ui.fg,
                        bg = ui.bg_p2,
                    },

                    IncSearch = {
                        fg = ui.bg,
                        bg = syn.fun,
                    },

                    -- Line numbers
                    LineNr = {
                        fg = ui.fg_dim,
                        bg = "NONE",
                    },

                    -- Diagnostics
                    DiagnosticError = { fg = diag.error },
                    DiagnosticWarn = { fg = diag.warning },
                    DiagnosticInfo = { fg = diag.info },
                    DiagnosticHint = { fg = diag.hint },

                    -- Snacks Explorer
                    SnacksExplorerNormal = { bg = "NONE" },
                    SnacksExplorerNormalNC = { bg = "NONE" },

                    -- Bufferline
                    BufferLineFill = { bg = "NONE" },
                    BufferLineBackground = { bg = "NONE" },
                    BufferLineBufferVisible = { bg = "NONE" },
                    BufferLineBufferSelected = {
                        bg = "NONE",
                        fg = ui.fg,
                        bold = true,
                    },

                    BufferLineSeparator = {
                        fg = "NONE",
                        bg = "NONE",
                    },

                    BufferLineSeparatorSelected = {
                        fg = "NONE",
                        bg = "NONE",
                    },

                    BufferLineIndicatorSelected = {
                        fg = syn.fun,
                        bg = "NONE",
                    },

                    -- Telescope
                    TelescopeNormal = { bg = "NONE" },
                    TelescopeResultsNormal = { bg = "NONE" },
                    TelescopePreviewNormal = { bg = "NONE" },

                    TelescopeBorder = {
                        fg = ui.fg_dim,
                        bg = "NONE",
                    },

                    TelescopePromptNormal = {
                        bg = "NONE",
                    },

                    TelescopePromptBorder = {
                        fg = ui.fg_dim,
                        bg = "NONE",
                    },
                }
            end,
        },

        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
}
