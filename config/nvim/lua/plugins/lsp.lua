return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'mason-org/mason.nvim',
            ---@diagnostic disable-next-line: missing-fields
            opts = {},
        },
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gR', vim.lsp.buf.rename,        '[R]ename')
                map('gA', vim.lsp.buf.code_action,   'Code [A]ction', { 'n', 'x' })
                map('gD', vim.lsp.buf.declaration,   '[G]oto [D]eclaration')
                map('gI', vim.lsp.buf.implementation,'[G]oto [I]mplementation')
                map('gT', vim.lsp.buf.type_definition,'[G]oto [T]ype Definition')

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                    local au = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = au,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = au,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- ── Mason-managed servers ─────────────────────────────────────────────
        local servers = {
            clangd = {
                cmd = {
                    'clangd',
                    '--header-insertion=never',
                    '--header-insertion-decorators=false',
                },
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.capabilities.textDocument.synchronization.willSave = false
                    client.capabilities.textDocument.synchronization.willSaveWaitUntil = false
                end,
            },
            gopls        = {},
            pyright      = {},
            rust_analyzer= {},
            ts_ls        = {},
            ruff         = {},
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes    = { enabled = false },
                            pycodestyle = { enabled = false },
                            autopep8    = { enabled = false },
                            yapf        = { enabled = false },
                            mccabe      = { enabled = false },
                            pylsp_mypy  = { enabled = false },
                            pylsp_black = { enabled = false },
                            pylsp_isort = { enabled = false },
                        },
                    },
                },
            },
            lua_ls = {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config'
                            and (vim.uv.fs_stat(path .. '/.luarc.json')
                              or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then return end
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                '${3rd}/luv/library',
                                '${3rd}/busted/library',
                            }),
                        },
                    })
                end,
                settings = { Lua = {} },
            },
        }

        -- ── System-installed servers ──────────────────
        vim.lsp.config('neocmakelsp', {
            cmd          = { 'neocmakelsp', 'stdio' },
            filetypes    = { 'cmake' },
            root_markers = { 'CMakeLists.txt', 'CMakeCache.txt', '.git' },
        })
        vim.lsp.enable('neocmakelsp')

        vim.lsp.config('glsl_analyzer', {
            cmd          = { 'glsl_analyzer' },
            filetypes    = { 'glsl', 'vert', 'frag', 'geom', 'comp' },
            root_markers = { '.git' },
        })
        vim.lsp.enable('glsl_analyzer')

        -- ── Mason setup ───────────────────────────────────────────────────────
        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, { 'stylua' })

        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}
