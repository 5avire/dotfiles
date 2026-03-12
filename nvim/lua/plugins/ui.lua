return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.width = 15
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.direction = "horizontal"
      opts.size = 5
      opts.persist_size = false
    end,
  },
}
