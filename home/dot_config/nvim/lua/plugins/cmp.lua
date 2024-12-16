return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        compat = { "rg", "kitty", "git", "conjure" },
      },
    },
  },
  "saghen/blink.compat",
  {
    "lukas-reineke/cmp-rg",
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "garyhurtz/cmp_kitty",
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "petertriho/cmp-git",
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "PaterJason/cmp-conjure",
    dependencies = { "saghen/blink.cmp" },
  },
}
