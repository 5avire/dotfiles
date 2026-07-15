return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
    { "<leader>ds", function() require("dap").step_over() end, desc = "DAP Step Over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
    { "<leader>do", function() require("dap").step_out() end, desc = "DAP Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
    { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP Repl" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "DAP Terminate" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
      automatic_installation = true,
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      commented = false,
      virt_text_pos = "inline",
      all_frames = true,
    })

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      -- cmake-tools will inject its own entry here at runtime via CMakeDebug
      -- this one is the manual fallback
    }

    -- C shares the same config as C++
    dap.configurations.c = dap.configurations.cpp

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_disconnect["dapui_config"] = function() dapui.close() end
  end,
}
