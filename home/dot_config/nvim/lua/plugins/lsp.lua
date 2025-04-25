return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      codelens = { enabled = false },
      servers = {
        bashls = { mason = false },
      },
    },
  },
}
