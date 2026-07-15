return {
	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
	},
	{
		-- detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- high-performance color highlighter
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		'ThePrimeagen/vim-be-good',
	},
	{
		'Shatur/neovim-session-manager',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
		local config = require('session_manager.config')
		require('session_manager').setup({
		  autoload_mode = config.AutoloadMode.Disabled,
		  autosave_last_session = true,
		})
		end,
	},
	{
	  'mbbill/undotree',
	  config = function()
		vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })
	  end,
	},
{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow"
	}
}
