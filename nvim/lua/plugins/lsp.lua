return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          capabilities = {
            documentFormattingProvider = false,
          },
        },
        pyright = {
          capabilities = {
            documentFormattingProvider = false,
          },
        },
      },
    },
  },
}
