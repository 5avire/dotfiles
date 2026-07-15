return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[                                                                                        ]],
      [[                                                                                      ▄▄]],
      [[██     ██ ▄▄▄▄▄ ▄▄     ▄▄▄▄  ▄▄▄  ▄▄   ▄▄ ▄▄▄▄▄       ▄█████  ▄▄▄  ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄  ██]],
      [[██ ▄█▄ ██ ██▄▄  ██    ██▀▀▀ ██▀██ ██▀▄▀██ ██▄▄        ▀▀▀▄▄▄ ██▀██ ██▄██ ██▄██ ▀███▀  ██]],
      [[ ▀██▀██▀  ██▄▄▄ ██▄▄▄ ▀████ ▀███▀ ██   ██ ██▄▄▄  ▄    █████▀ ██▀██  ▀█▀   ▀█▀    █    ▄▄]],
      [[                                                ▀                                       ]],
      [[]],
      [[]],
      [[]],
    }

    dashboard.section.buttons.val = {
      dashboard.button('n', '  New file',        '<cmd>ene <BAR> startinsert<CR>'),
      dashboard.button('f', '󰈞  Find file',       '<cmd>Telescope find_files<CR>'),
      dashboard.button('g', '󰮗  Find by grep',    '<cmd>Telescope live_grep<CR>'),
      dashboard.button('l', '󰒲  Lazy',            '<cmd>Lazy<CR>'),
      dashboard.button('s', '󰦛  Last session',   '<cmd>SessionManager load_last_session<CR>'),
      dashboard.button('q', '󰈆  Quit Neovim',     '<cmd>qa<CR>'),
    }

    dashboard.section.footer.opts.hl = 'Comment'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    alpha.setup(dashboard.opts)
  end,
}
