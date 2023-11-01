-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "tokyonight-night"

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- hack to get vim-fugitive to work correctly
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.conceallevel = 1

-- re-enable wrapping
-- vim.opt.wrap = true

-- close netrw buffer when selecting a file
vim.g.netrw_fastbrowse = 0
vim.g.netrw_menu = 1

-- keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<left>"] = ":BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<right>"] = ":BufferLineCycleNext<cr>"
lvim.keys.visual_mode["v"] = "<Plug>(expand_region_expand)"
lvim.keys.visual_mode["<C-v>"] = "<Plug>(expand_region_shrink)"
lvim.keys.normal_mode["-"] = ":e %:h<cr>"

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
  name = "+Trouble",
  t = { "<cmd>TroubleToggle<cr>", "Toggle" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "List references" },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }

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
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.reload_on_bufenter = true
lvim.builtin.nvimtree.setup.update_focused_file.enable = true
lvim.builtin.nvimtree.setup.update_focused_file.update_root = true

-- project patterns
table.insert(lvim.builtin.project.patterns, "=neorg")
table.insert(lvim.builtin.project.patterns, "=notes")
table.insert(lvim.builtin.project.patterns, "=notes-personal")
lvim.builtin.project.show_hidden = true

-- nvim-cmp sources
table.insert(lvim.builtin.cmp.sources, { name = "rg" })
lvim.builtin.cmp.formatting.source_names["rg"] = "(ripgrep)"
table.insert(lvim.builtin.cmp.sources, { name = "kitty" })
lvim.builtin.cmp.formatting.source_names["kitty"] = "(Kitty)"
table.insert(lvim.builtin.cmp.sources, { name = "git" })
lvim.builtin.cmp.formatting.source_names["git"] = "(Git)"

-- try to get lir a bit closer to netrw/vim-vinegar
lvim.builtin.lir.show_hidden_files = true
local lir_actions = require('lir.actions')
lvim.builtin.lir.mappings['-'] = lir_actions.up
lvim.builtin.lir.mappings['D'] = lir_actions.mkdir
lvim.builtin.lir.mappings['%'] = lir_actions.newfile

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
  "markdown_inline",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}
lvim.builtin.treesitter.highlight = {
  enable = true,
  additional_vim_regex_highlighting = { "markdown" },
}

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("trouble").setup {
        mode = "document_diagnostics",
      }
    end
  },
  { "tpope/vim-surround" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-eunuch' },
  {
    'pwntester/octo.nvim',
    cmd = "Octo",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("octo").setup()
    end
  },
  { 'junegunn/vim-peekaboo' },
  { 'terryma/vim-expand-region' },
  {
    'nvim-neorg/neorg',
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-treesitter" },
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = { engine = "nvim-cmp" }
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/Documents/notes-work/neorg",
              },
              default_workspace = "work",
            }
          },
          ["core.export"] = {},
        }
      }
    end
  },
  {
    'lukas-reineke/cmp-rg',
    dependencies = { 'nvim-cmp' }
  },
  {
    'garyhurtz/cmp_kitty',
    dependencies = { 'nvim-cmp' }
  },
  {
    'petertriho/cmp-git',
    dependencies = { 'nvim-cmp' }
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black",         filetypes = { "py" } },
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

-- autocommands
lvim.autocommands = {
  {
    "BufEnter",
    {
      pattern = { "*.md", "*.markdown", "*.norg", "*.mdx", "*.asciidoc", "*.txt" },
      command = "setlocal wrap linebreak",
    }
  },
  {
    "BufEnter",
    {
      pattern = "*.mdx",
      command = "set ft=markdown",
    }
  }
}
