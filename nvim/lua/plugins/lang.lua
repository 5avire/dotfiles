return {
  -- GLSL LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        glsl_analyzer = {},
        clangd = {
          capabilities = { documentFormattingProvider = false },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--fallback-style=llvm",
          },
        },
      },
    },
  },
  -- GLSL syntax highlighting
  {
    "tikhomirov/vim-glsl",
    ft = { "glsl", "vert", "frag", "geom", "tesc", "tese", "comp" },
  },
}
