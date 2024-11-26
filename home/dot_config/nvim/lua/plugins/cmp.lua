return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      table.insert(opts.sources, { name = "rg" })
      table.insert(opts.sources, { name = "kitty" })
      table.insert(opts.sources, { name = "git" })
      table.insert(opts.sources, { name = "conjure" })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "lukas-reineke/cmp-rg",
    dependencies = { "nvim-cmp" },
  },
  {
    "garyhurtz/cmp_kitty",
    dependencies = { "nvim-cmp" },
  },
  {
    "petertriho/cmp-git",
    dependencies = { "nvim-cmp" },
  },
  {
    "PaterJason/cmp-conjure",
    dependencies = { "nvim-cmp" },
  },
}
