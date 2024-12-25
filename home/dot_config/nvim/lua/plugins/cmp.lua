return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        compat = { "rg", "kitty", "conjure" },
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
    "PaterJason/cmp-conjure",
    dependencies = { "saghen/blink.cmp" },
  },
}
