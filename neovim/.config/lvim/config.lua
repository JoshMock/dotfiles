-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- hack to get vim-fugitive to work correctly

-- reenable wrapping
vim.opt.wrap = true

-- close netrw buffer when selecting a file
vim.g.netrw_fastbrowse = 0

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

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
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

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

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "onedarker"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.bufferline.options.show_tab_indicators = false
lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.close_command = 'Bdelete! %d'
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.project.patterns = { ".git" }
lvim.builtin.project.show_hidden = true
lvim.builtin.project.silent_chdir = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server) return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
vim.g.nv_search_paths = { '~/Desktop/notes/' } -- notational-fzf-vim required config

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

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
