-- vim: ts=2 sts=2 sw=2 et
-- [[ Basic configs ]]

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- nerd fonts
vim.g.have_nerd_font = true

-- enable mouse mode
vim.o.mouse = "a"

-- mode is already in the status line
vim.o.showmode = false

-- sync clipboard between OS and Neovim
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- disable break indent
vim.o.breakindent = false

-- save undo history
vim.o.undofile = true

-- smart case search
vim.o.ignorecase = true
vim.o.smartcase = true

-- columns
vim.o.signcolumn = "yes"
vim.o.number = false

-- decrease update time
vim.o.updatetime = 250

-- decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- display whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions as you type
vim.o.inccommand = "split"

-- show which line your cursor is on
vim.o.cursorline = true

-- number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- deal with unsaved changes
vim.o.confirm = true

-- code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- [[ Keymaps ]]

vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uick[f]ix list" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move"<CR>')
vim.keymap.set("i", "jj", "<esc>", { desc = "Switch to normal mode" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<left>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "-", "<cmd>e %:h<cr>", { desc = "Go up directory" })
vim.keymap.set("n", "<leader>o", "m`o<esc>``", { desc = "Empty line below" })
vim.keymap.set("n", "<leader>O", "m`O<esc>``", { desc = "Empty line above" })
vim.keymap.set("n", "<leader>k", "<cmd>noh<cr>", { desc = "No highlight" })
vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", { desc = "Expand selection" })
vim.keymap.set("v", "<C-v>", "<Plug>(expand_region_shrink)", { desc = "Shrink selection" })
vim.keymap.set("n", "<leader>A", "<cmd>A<cr>", { desc = "Switch to alternate file" })
vim.keymap.set("n", "<tab>", "%", { desc = "Move to alternate bracket" })

-- [[ Autocommands ]]

local function augroup(name)
  return vim.api.nvim_create_augroup("joshmock_" .. name, { clear = true })
end

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Plugins ]]

-- [[ install lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ install plugins ]]
require("lazy").setup({
  -- LSP things
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup("lsp-attach"),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>cr", vim.lsp.buf.rename, "[R]ename")
          map("<leader>cR", require("telescope.builtin").lsp_references, "Goto [R]eferences")
          map("<leader>ci", require("telescope.builtin").lsp_implementations, "Goto [I]mplementation")
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("<leader>cO", require("telescope.builtin").lsp_document_symbols, "[O]pen Document Symbols")
          map("<leader>cW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open [W]orkspace Symbols")
          map("<leader>ct", require("telescope.builtin").lsp_type_definitions, "Goto [T]ype Definition")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
          then
            local highlight_augroup = augroup("lsp-highlight")
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = augroup("lsp-detach"),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "joshmock_lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        pyright = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { "stylua" })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- keep empty, overridden by mason-tool-installer
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
  },
  "mfussenegger/nvim-lint",
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- nvim utils
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
    config = function()
      local persistence = require("persistence")
      persistence.setup({})

      vim.keymap.set("n", "<leader>qs", function()
        persistence.load()
      end)
      vim.keymap.set("n", "<leader>qS", function()
        persistence.select()
      end)
      vim.keymap.set("n", "<leader>ql", function()
        persistence.load({ last = true })
      end)
      vim.keymap.set("n", "<leader>qd", function()
        persistence.stop()
      end)

      -- don't store git commit messages as nvim sessions
      vim.api.nvim_create_autocmd("FileType", {
        group = augroup("disable_session_persistence"),
        pattern = { "gitcommit" },
        callback = function()
          persistence.stop()
        end,
      })
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      local project = require("project_nvim")
      project.setup({
        patterns = { ".git", "index.norg", "package.json", ">Code", "!.worktrees", "!js-test" },
        scope_chdir = "win",
      })

      require("telescope").load_extension("projects")
      vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "[Find] [p]rojects" })
    end,
  },
  "tpope/vim-projectionist",
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({})
      require("mini.git").setup({})
      require("mini.diff").setup({})
      require("mini.pairs").setup({})
      require("mini.icons").setup({})
      require("mini.clue").setup({})
      require("mini.cursorword").setup({})
      require("mini.statusline").setup({})
      require("mini.tabline").setup({})
      require("mini.trailspace").setup({})

      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        header = "░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░▒▓███████▓▒░  \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n   ░▒▓██▓▒░   ░▒▓██████▓▒░░▒▓█▓▒░▒▓███████▓▒░",
        items = {
          starter.sections.recent_files(5, false),
          starter.sections.builtin_actions(),
          starter.sections.telescope(),
          function()
            local projects = {}
            for _, proj in pairs(require("project_nvim").get_recent_projects()) do
              local name = proj
              for str in string.gmatch(proj, "([^/]+)") do
                name = str
              end
              local project = {
                name = name,
                section = "Projects",
                action = function()
                  require("project_nvim.project").set_pwd(proj, "telescope")
                  require("telescope.builtin").find_files({
                    cwd = proj,
                    hidden = true,
                    mode = "insert",
                  })
                end,
              }
              table.insert(projects, project)
            end
            return projects
          end,
        },
        content_hooks = {
          starter.gen_hook.padding(10, 2),
          starter.gen_hook.aligning("center", "center"),
        },
      })

      require("mini.files").setup({
        mappings = {
          go_out = "-",
          go_in = "<cr>",
        },
        windows = {
          preview = true,
          width_focus = 40,
          width_preview = 40,
        },
      })

      require("mini.indentscope").setup({
        symbol = "│",
        try_as_border = true,
      })

      require("mini.hipatterns").setup({
        highlighers = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      gitbrowse = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 1500,
      },
      scratch = { enabled = true },
      statuscolumn = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git blame line",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse.open()
        end,
        desc = "Git browse",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit.open()
        end,
        desc = "Open lazygit",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>bD",
        function()
          Snacks.bufdelete({ force = true })
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select [S]cratch Buffer",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Show notification history",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle scratch buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select scratch buffer",
      },
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Zen mode",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>g", group = "git" },
        { "<leader>b", group = "buffer" },
        { "<leader>f", group = "find" },
        { "<leader>q", group = "session" },
        { "<leader>c", group = "code" },
      })
    end,
  },

  -- coding utils
  "b0o/SchemaStore.nvim",
  "NMAC427/guess-indent.nvim",
  "terryma/vim-expand-region",
  "tpope/vim-surround",

  -- neorg
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = true,
  },
  "benlubas/neorg-interim-ls",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "javascript",
        "markdown",
        "markdown_inline",
        "python",
        "typescript",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>f/", builtin.live_grep, { desc = "[F]ind by [/]grep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set("n", "<leader>fz", builtin.resume, { desc = "[F]ind [Z]Resume" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent Files" })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>fc", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[F]ind in Neovim [C]onfig" })
    end,
  },

  -- autoformat
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { "prettierd", stop_after_first = true },
      },
    },
  },

  -- autocompletion
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      "folke/lazydev.nvim",
    },
    opts = {
      keymap = {
        preset = "default",
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { "lsp", "path", "lazydev", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust" },

      signature = { enabled = true },
    },
  },

  -- colorscheme
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("carbonfox")
    end,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
