return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      patterns = { ".git", "index.norg", "package.json", ">Code", "!.worktrees" },
      scope_chdir = "win",
    },
  },
}
