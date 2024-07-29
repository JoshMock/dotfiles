return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = { engine = "nvim-cmp" },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/Documents/notes-work",
              },
              default_workspace = "work",
            },
          },
          ["core.export"] = {},
        },
      })
    end,
  },
}
