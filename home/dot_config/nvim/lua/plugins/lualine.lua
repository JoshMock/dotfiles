return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {
          function()
            local cwd = vim.loop.cwd()
            cwd = cwd:gsub("%/home/joshmock/", "")
            cwd = cwd:gsub("%Code/", "")
            return cwd
          end,
        },
      },
    },
  },
}
