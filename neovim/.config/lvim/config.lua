-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "onedarker"

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- hack to get vim-fugitive to work correctly
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- re-enable wrapping
vim.opt.wrap = true

-- close netrw buffer when selecting a file
vim.g.netrw_fastbrowse = 0

-- keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<left>"] = ":BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<right>"] = ":BufferLineCycleNext<cr>"
lvim.keys.visual_mode["v"] = "<Plug>(expand_region_expand)"
lvim.keys.visual_mode["<C-v>"] = "<Plug>(expand_region_shrink)"

lvim.builtin.which_key.mappings["o"] = { "m`o<esc>``", "Empty line below" }
lvim.builtin.which_key.mappings["O"] = { "m`O<esc>``", "Empty line above" }
lvim.builtin.which_key.mappings["n"] = {
  name = "+Line numbers",
  r = { "<cmd>set relativenumber!<cr>", "Toggle relative line numbers" },
  n = { "<cmd>set number!<cr>", "Toggle absolute line numbers" },
  o = { "<cmd>set nonumber<cr> <cmd>set norelativenumber<cr>", "Turn off line numbers" },
}
lvim.builtin.which_key.mappings["k"] = { "<cmd>noh<cr>", "No highlight" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  t = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
  h = { "<cmd>ToggleTerm size=8 direction=horizontal<cr>", "Horizontal terminal" },
  v = { "<cmd>ToggleTerm size=100 direction=vertical<cr>", "Horizontal terminal" },
}

-- unmap arrow keys
lvim.keys.normal_mode["<up>"] = "<nop>"
lvim.keys.normal_mode["<down>"] = "<nop>"
lvim.keys.insert_mode["<up>"] = "<nop>"
lvim.keys.insert_mode["<down>"] = "<nop>"
lvim.keys.insert_mode["<left>"] = "<nop>"
lvim.keys.insert_mode["<right>"] = "<nop>"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
lvim.keys.insert_mode["jj"] = "<esc>"

-- map escape in terminal to go to normal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

-- alpha
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- bufferline
lvim.builtin.bufferline.options.show_tab_indicators = false
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.close_command = 'Bdelete! %d'

-- terminal
lvim.builtin.terminal.active = true

-- nvim-tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.project.patterns = { ".git" }
lvim.builtin.project.show_hidden = true
lvim.builtin.project.silent_chdir = true

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "hcl",
  "java",
  "javascript",
  "json",
  "jsonnet",
  "lua",
  "markdown",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}
lvim.builtin.treesitter.highlight.enable = true

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "tpope/vim-surround" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-vinegar' },
  { 'junegunn/vim-peekaboo' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'Alok/notational-fzf-vim' },
  { 'terryma/vim-expand-region' },
}

-- notational-fzf-vim setup

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { name = "terraform_fmt", filetypes = { "tf", "terraform" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  { name = "codespell" },
  { name = "luacheck" },
  { name = "shellcheck" },
  { name = "yamllint" },
  { name = "zsh" },
}
