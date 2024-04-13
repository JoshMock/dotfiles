return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
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
                work = "~/Documents/notes-work/neorg",
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
