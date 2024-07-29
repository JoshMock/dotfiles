local function test_file()
  local neotest = require("neotest")
  neotest.run.run(vim.fn.expand("%"))
end

vim.g["test#javascript#tap#file_pattern"] = "\\.test\\.ts$"

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vim-test")({
            allow_file_types = { "javascript", "typescript" },
          }),
        },
      })
    end,
    keys = {
      { "<leader>t", desc = "+testing" },
      { "<leader>tf", test_file, desc = "Run this unit test file" },
      { "<leader>to", "<cmd>Neotest output-panel<cr>", desc = "Show test output" },
      { "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Show test output" },
    },
  },
  {
    "nvim-neotest/neotest-vim-test",
    dependencies = {
      "nvim-neotest/neotest",
      "vim-test/vim-test",
    },
  },
}
