return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local colors = {
            blue    = '#89b4fa',
            green   = '#a6e3a1',
            purple  = '#cba4f7',
            cyan    = '#89dceb',
            red1    = '#f38ba8',
            red2    = '#eba0ac',
            yellow  = '#f9e2af',
            fg      = '#cdd6f4',
            bg      = '#1e1e2e',
            gray1   = '#6c7086',
            gray2   = '#181825',
            gray3   = '#313244',
        }
        local mocha_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
                b = { fg = colors.fg, bg = colors.gray3 },
                c = { fg = colors.fg, bg = colors.gray2 },
            },
            command  = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
            insert   = { a = { fg = colors.bg, bg = colors.blue,   gui = 'bold' } },
            visual   = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
            terminal = { a = { fg = colors.bg, bg = colors.cyan,   gui = 'bold' } },
            replace  = { a = { fg = colors.bg, bg = colors.red1,   gui = 'bold' } },
            inactive = {
                a = { fg = colors.gray1, bg = colors.bg,    gui = 'bold' },
                b = { fg = colors.gray1, bg = colors.bg },
                c = { fg = colors.gray1, bg = colors.gray2 },
            },
        }
        local hide_in_width = function()
            return vim.fn.winwidth(0) > 100
        end
        local is_cpp = function()
            local ft = vim.bo.filetype
            return ft == 'cpp' or ft == 'c'
        end
        local mode = {
            'mode',
            fmt = function(str)
                if hide_in_width() then
                    return ' ' .. str
                else
                    return ' ' .. str:sub(1, 1)
                end
            end,
        }
        local filename = {
            'filename',
            file_status = true,
            path = 1,
        }
        local diagnostics = {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = false,
            update_in_insert = false,
            always_visible = false,
            cond = hide_in_width,
        }
        local diff = {
            'diff',
            colored = false,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            cond = hide_in_width,
        }
        local cmake_generate = {
            function() return ' F6' end,
            cond = is_cpp,
            color = { fg = colors.yellow },
        }
        local cmake_build = {
            function() return '󱌣 F7' end,
            cond = is_cpp,
            color = { fg = colors.blue },
        }
        local cmake_run = {
            function() return ' F5' end,
            cond = is_cpp,
            color = { fg = colors.green },
        }
        local cmake_debug = {
            function() return '󰃤 F4' end,
            cond = is_cpp,
            color = { fg = colors.red1 },
        }
        local cmake_target = {
            function() return '󰆣 F8' end,
            cond = is_cpp,
            color = { fg = colors.purple },
        }
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = mocha_theme,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                disabled_filetypes = { 'alpha' },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { 'branch' },
                lualine_c = { filename, cmake_generate, cmake_build, cmake_run, cmake_debug, cmake_target },
                lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
                lualine_y = { 'location' },
                lualine_z = { 'progress' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { { 'location', padding = 0 } },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { 'fugitive' },
        }
    end,
}
