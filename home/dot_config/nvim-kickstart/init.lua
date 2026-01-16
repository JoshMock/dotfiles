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
vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { silent = true })
vim.keymap.set("n", "<C-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
vim.keymap.set("n", "<C-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
vim.keymap.set("n", "<C-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
vim.keymap.set("n", "<C-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true })

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

-- [[ Util functions ]]
--- Tries to detect a JS project's preferred formatter by parsing package.json
local detect_js_formatter = function(bufnr)
  local root = MiniMisc.find_root(bufnr, { "package.json" })
  local pkg = root .. "/package.json"

  -- detect if it has a fixer configured
  local handle = io.popen("jq -r '.scripts[\"lint:fix\"]' " .. pkg, "r")
  if not handle then
    handle = io.popen("jq -r '.scripts.lint' " .. pkg, "r")
    if not handle then
      return nil
    end
  end
  local output = handle:read("*all")
  handle:close()

  local cmd = vim.split(output, " ")[0]

  if cmd == nil then
    return nil
  else
    return cmd
  end
end

local pick_js_formatter = function(bufnr)
  local formatter = detect_js_formatter(bufnr)
  if formatter == "ts-standard" then
    return { "ts-standard", lsp_format = "fallback" }
  elseif formatter == "eslint" then
    return { "eslint_d", lsp_format = "fallback" }
  end
end

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
vim.opt.rtp:prepend(lazypath)

-- [[ install plugins ]]
require("lazy").setup({
  -- LSP things
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell.with({
            filetypes = { "markdown", "text", "norg", "neorg" },
          }),
          -- TODO: enable dynamically using detect_js_formatter
          require("none-ls.formatting.jq"),
          null_ls.builtins.code_actions.ts_node_action,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.diagnostics.clj_kondo,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.hover.dictionary,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      "b0o/SchemaStore.nvim",
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
            map("<leader>ch", function()
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

      local lspconfig = require("lspconfig")
      local schemastore = require("schemastore")

      local servers = {
        pyright = {},
        ts_ls = {},
        lua_ls = {},
        jsonls = {
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = schemastore.yaml.schemas(),
            },
          },
        },
        copilot = { enabled = false },
      }

      -- Ensure the servers and tools above are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { "stylua", "eslint_d", "ts-standard", "black", "isort" })
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
            lspconfig[server_name].setup(server)
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
        scope_chdir = "global",
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
      require("mini.visits").setup({})

      local misc = require("mini.misc")
      misc.setup({})
      misc.setup_auto_root({ ".git", "index.norg", "package.json", "Makefile" })

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

      -- see https://www.lua.org/pil/20.2.html for how to write Lua string pattern matching expressions
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- TODO: implement a quicklist that shows all of these matches
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- TODO: implement my own highlighter patterns instead of hijacking
          console_log = { pattern = "console%.log", group = "@comment.note" },
          console_warn = { pattern = "console%.warn", group = "@comment.warning" },
          console_error = { pattern = "console%.error", group = "@comment.error" },
        },
      })

      vim.keymap.set("n", "<leader>va", function()
        MiniVisits.add_label()
      end, { desc = "Add visit label" })
      vim.keymap.set("n", "<leader>vr", function()
        MiniVisits.remove_label()
      end, { desc = "Remove visit label" })
      vim.keymap.set("n", "<leader>vp", function()
        MiniVisits.select_path()
      end, { desc = "Select visit path" })
      vim.keymap.set("n", "<leader>vl", function()
        MiniVisits.select_label("", "")
      end, { desc = "Select visit label (all)" })
      vim.keymap.set("n", "<leader>vL", function()
        MiniVisits.select_label()
      end, { desc = "Select visit label (cwd)" })
      vim.keymap.set("n", "<leader>gd", function()
        MiniDiff.toggle_overlay()
      end, { desc = "Toggle Git diff" })
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
      toggle = {
        enabled = true,
        map = vim.keymap.set,
        which_key = true,
        notify = true,
        icon = {
          enabled = " ",
          disabled = " ",
        },
        color = {
          enabled = "green",
          disabled = "yellow",
        },
        wk_desc = {
          enabled = "Disable ",
          disabled = "Enable ",
        },
      },
      words = { enabled = true },
      zen = { enabled = true },
    },
    config = function()
      Snacks.toggle.diagnostics():map("<leader>ud")
      Snacks.toggle.inlay_hints():map("<leader>ui")
      Snacks.toggle.words():map("<leader>uw")
      Snacks.toggle.zen():map("<leader>uz")
    end,
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
        desc = "Select [S]cratch Buffer",
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
          require("which-key").show({ global = true })
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
        { "<leader>v", group = "visits" },
        { "<leader>x", group = "trouble" },
        { "<leader>u", group = "ui toggles" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  -- coding utils
  "NMAC427/guess-indent.nvim",
  "terryma/vim-expand-region",
  "tpope/vim-surround",

  -- neorg
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/Documents/notes-work",
                clients = "~/Documents/notes-work/clients",
              },
              default_workspace = "clients",
            },
          },
          ["core.export"] = {},
          ["external.interim-ls"] = {
            config = {
              completion_provider = {
                enable = true,
                documentation = true,
                categories = false,
              },
            },
          },
        },
      })
    end,
  },
  {
    "benlubas/neorg-interim-ls",
    ft = { "norg", "neorg" },
    lazy = true,
    dependencies = {
      "nvim-neorg/neorg",
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    config = function()
      require("nvim-treesitter.configs").setup({
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
      })

      -- code folding
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  { "aaronik/treewalker.nvim" },

  -- code-folding
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      pauseFoldsOnSearch = false,
    },
    init = function() end,
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
    config = function()
      require("conform").setup({
        notify_on_error = false,
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          elseif vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = "fallback",
            }
          end
        end,
        formatters = {
          ["ts-standard"] = {
            command = "ts-standard",
            args = { "--fix", "--stdin" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = pick_js_formatter,
          typescript = pick_js_formatter,
        },
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })

      vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle<cr>", { desc = "Toggle autoformat (global)" })
      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle!<cr>", { desc = "Toggle autoformat (buffer)" })
    end,
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
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },

      sources = {
        default = { "lsp", "buffer", "path" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
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

  -- LLM
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-y>",
        },
      },
      panel = { enabled = true },
    },
  },
  {
    "dlants/magenta.nvim",
    lazy = false,
    build = "npm ci",
    opts = {
      profiles = {
        -- available models found via curl
        -- see https://aider.chat/docs/llms/github.html#discover-available-models
        -- oauth token found in ~/.config/github-copilot/
        {
          name = "claude-sonnet-4",
          provider = "copilot",
          model = "claude-sonnet-4",
          fastModel = "o3-mini",
        },
        {
          name = "claude-3-7-sonnet",
          provider = "copilot",
          model = "claude-3-7-sonnet-latest",
          fastModel = "o3-mini",
        },
        {
          name = "gpt-4-1",
          provider = "copilot",
          model = "gpt-4.1-2025-04-14",
          fastModel = "o3-mini",
        },
      },
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
