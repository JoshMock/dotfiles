vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })
vim.keymap.set("v", "<C-v>", "<Plug>(expand_region_shrink)", { desc = "Shrink selection" })

return {
  { "terryma/vim-expand-region" },
}
