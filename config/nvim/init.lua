require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

vim.g.transparent = true
require('lazy').setup({
    require 'plugins.alpha',
    require 'plugins.which-key',
    require 'plugins.bufferline',
    require 'plugins.lualine',
    require 'plugins.treesitter',
    require 'plugins.telescope',
    require 'plugins.autocompletion',
    require 'plugins.lsp',
    require 'plugins.gitsigns',
    require 'plugins.blankline',
    require 'plugins.misc',
    require 'plugins.dap',
    require 'plugins.snacks',
    require 'plugins.cmaketools',
    require 'plugins.vim-tmux-navigation',
    require 'plugins.themes.catppuccin',
})
