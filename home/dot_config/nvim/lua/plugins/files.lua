return {
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        mappings = {
          go_out = "-",
          go_in = "<cr>",
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
