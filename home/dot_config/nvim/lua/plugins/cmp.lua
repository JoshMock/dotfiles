return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        compat = { "conjure" },
      },
    },
  },
  "saghen/blink.compat",
  {
    "PaterJason/cmp-conjure",
    dependencies = { "saghen/blink.cmp" },
  },
}
