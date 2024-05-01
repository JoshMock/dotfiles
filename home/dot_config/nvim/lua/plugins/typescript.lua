return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        tsstandard = {
          command = "ts-standard",
          args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
          stdin = true,
          async = true,
          cwd = require("conform.util").root_file({ "tsconfig.json" }),
        },
      },
      formatters_by_ft = {
        typescript = { "tsstandard" },
        javascript = { "tsstandard" },
      },
    },
  },
}
