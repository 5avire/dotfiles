return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            automatic_enable = false,
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            ----------------------------------------------------------------
            -- Diagnostics
            ----------------------------------------------------------------

            vim.diagnostic.config({
                severity_sort = true,

                virtual_text = true,
                underline = true,

                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚",
                        [vim.diagnostic.severity.WARN] = "󰀪",
                        [vim.diagnostic.severity.INFO] = "󰋽",
                        [vim.diagnostic.severity.HINT] = "󰌶",
                    },
                },

                float = {
                    border = "rounded",
                    source = true,
                },

                update_in_insert = false,
            })

            ----------------------------------------------------------------
            -- Server configuration
            ----------------------------------------------------------------

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--header-insertion=never",
                    "--header-insertion-decorators=false",
                },

                on_init = function(client)
                    -- Formatting is handled separately.
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        codeLens = {
                            enable = true,
                        },

                        hint = {
                            enable = true,
                            semicolon = "Disable",
                        },
                    },
                },
            })

            vim.lsp.config("pyright", {
                settings = {
                    pyright = {
                        disableTaggedHints = true,
                    },

                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        lens = {
                            enable = true,

                            debug = {
                                enable = true,
                            },

                            implementations = {
                                enable = true,
                            },

                            references = {
                                adt = {
                                    enable = true,
                                },

                                enumVariant = {
                                    enable = true,
                                },

                                method = {
                                    enable = true,
                                },

                                trait = {
                                    enable = true,
                                },
                            },

                            run = {
                                enable = true,
                            },

                            updateTest = {
                                enable = true,
                            },
                        },
                    },
                },
            })

            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = {
                                enabled = false,
                            },

                            pycodestyle = {
                                enabled = false,
                            },

                            autopep8 = {
                                enabled = false,
                            },

                            yapf = {
                                enabled = false,
                            },

                            mccabe = {
                                enabled = false,
                            },
                        },
                    },
                },
            })

            vim.lsp.config("glsl_analyzer", {
                cmd = { "glsl_analyzer" },
                filetypes = { "glsl" },
                root_markers = { ".git" },
            })

            ----------------------------------------------------------------
            -- Enable servers
            ----------------------------------------------------------------

            vim.lsp.enable({
                "clangd",
                "lua_ls",
                "pyright",
                "ruff",
                "gopls",
                "rust_analyzer",
                "ts_ls",
                "pylsp",
                "glsl_analyzer",
            })

            ----------------------------------------------------------------
            -- LSP attach
            ----------------------------------------------------------------

            local group = vim.api.nvim_create_augroup(
                "user-lsp-attach",
                { clear = true }
            )

            vim.api.nvim_create_autocmd("LspAttach", {
                group = group,

                callback = function(event)
                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)

                    if not client then
                        return
                    end

                    local buf = event.buf

                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, {
                            buffer = buf,
                            desc = "LSP: " .. desc,
                        })
                    end

                    --------------------------------------------------------
                    -- Navigation
                    --------------------------------------------------------

                    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
                    map("n", "gt", vim.lsp.buf.type_definition, "Goto Type Definition")
                    map("n", "gr", vim.lsp.buf.references, "Goto References")

                    --------------------------------------------------------
                    -- Information
                    --------------------------------------------------------

                    map("n", "K", vim.lsp.buf.hover, "Hover")

                    --------------------------------------------------------
                    -- Actions
                    --------------------------------------------------------

                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

                    map(
                        { "n", "x" },
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        "Code Action"
                    )

                    --------------------------------------------------------
                    -- Folding
                    --
                    -- Only configure LSP folding after the client has
                    -- actually attached and confirmed support.
                    --------------------------------------------------------

                    if client:supports_method(
                        "textDocument/foldingRange",
                        buf
                    ) then
                        vim.opt_local.foldmethod = "expr"
                        vim.opt_local.foldexpr =
                            "v:lua.vim.lsp.foldexpr()"
                    end

                    --------------------------------------------------------
                    -- Inlay hints
                    --------------------------------------------------------

                    if client:supports_method(
                        "textDocument/inlayHint",
                        buf
                    ) then
                        map("n", "<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({
                                    bufnr = buf,
                                }),
                                {
                                    bufnr = buf,
                                }
                            )
                        end, "Toggle Inlay Hints")
                    end

                    --------------------------------------------------------
                    -- Document highlighting
                    --------------------------------------------------------

                    if client:supports_method(
                        "textDocument/documentHighlight",
                        buf
                    ) then
                        local highlight_group =
                            vim.api.nvim_create_augroup(
                                "lsp-document-highlight-" .. buf,
                                { clear = true }
                            )

                        vim.api.nvim_create_autocmd(
                            { "CursorHold", "CursorHoldI" },
                            {
                                buffer = buf,
                                group = highlight_group,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )

                        vim.api.nvim_create_autocmd(
                            { "CursorMoved", "CursorMovedI" },
                            {
                                buffer = buf,
                                group = highlight_group,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )
                    end
                end,
            })

            ----------------------------------------------------------------
            -- Folding defaults
            ----------------------------------------------------------------

            vim.o.foldenable = true
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
        end,
    },
}
