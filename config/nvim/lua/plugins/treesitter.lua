return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
        local parsers = {
            'bash',
            'c',
            'diff',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'cpp',
            'python',
            'cmake',
            'sql',
            'rust',
            'regex',
            'java',
            'json',
            'yaml',
            'gitignore',
        }
        local installed = require('nvim-treesitter')
        local to_install = vim.tbl_filter(function(p)
            return not vim.tbl_contains(installed, p)
        end, parsers)

        if #to_install > 0 then
            require('nvim-treesitter').install(to_install)
        end

        -- treesitter for everything
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language then return end
                if not vim.treesitter.language.add(language) then return end
                vim.treesitter.start(buf, language)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- override indentation for c/cpp with cindent AFTER treesitter
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'cpp', 'c' },
            callback = function()
                vim.bo.cindent = true
                vim.bo.indentexpr = ''
                vim.opt_local.cinoptions = 'N+s'
            end,
        })
    end,
}
