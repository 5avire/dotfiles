return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>e",  function() Snacks.explorer() end, desc = "Toggle File Explorer" },
    { "<leader>ft", function() Snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end, desc = "Terminal (cwd)" },
    { "<c-/>",      function() Snacks.terminal.focus(nil, { cwd = vim.fn.getcwd() }) end, desc = "Terminal", mode = { "n", "t" } },
    { "<c-_>",      function() Snacks.terminal.focus(nil, { cwd = vim.fn.getcwd() }) end, desc = "which_key_ignore", mode = { "n", "t" } },
  },
  opts = {
    explorer = {
      enabled = true,
      win = {
        position = "left",
        width = 20,
      },
    },
    terminal = {
      enabled = true,
      win = {
        position = "bottom",
        height = 0.2,
      },
    },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
