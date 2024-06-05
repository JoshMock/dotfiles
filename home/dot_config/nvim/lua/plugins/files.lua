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
        windows = {
          preview = true,
          width_focus = 40,
          width_preview = 40,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
