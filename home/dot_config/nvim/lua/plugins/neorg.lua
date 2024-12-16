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
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/Documents/notes-work",
              },
              default_workspace = "work",
            },
          },
          ["core.export"] = {},
          ["external.interim-ls"] = {
            config = {
              completion_provider = {
                enable = true,
                documentation = true,
                categories = false,
              },
            },
          },
        },
      })
    end,
  },
  {
    "benlubas/neorg-interim-ls",
    ft = { "norg", "neorg" },
    lazy = true,
  },
}
