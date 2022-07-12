" JSX syntax in .js files
let g:jsx_ext_required = 0

" vim-rooter config
let g:rooter_patterns = ['.git/']

" notational-fzf-vim stuff
let g:nv_main_directory = '~/Desktop/notes'
let g:nv_search_paths = ['~/Desktop/notes']
let g:nv_default_extension = '.md'
let g:nv_create_note_window = 'edit'

" nvim-cmp and LSP config
set completeopt=menu,menuone
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
      end
    end, { "i", "s" }),
    },
    sources = cmp.config.sources(
      {{ name = 'nvim_lsp' }, { name = 'vsnip' }},
      {{ name = 'buffer' }},
      {{ name = 'neorg' }}
    )
  })

  -- Use buffer source for `/`
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
      {{ name = 'path' }},
      {{ name = 'cmdline' }}
    )
  })

  -- use LSP for autocompletion
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- LSP set up key-mappings
  local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end

  -- set up LSP servers
  local nvim_lsp = require('lspconfig')
  local servers = { 'bashls', 'clojure_lsp', 'eslint', 'html', 'jsonls', 'pylsp', 'rust_analyzer', 'terraform_lsp', 'tsserver' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
EOF

" vim-slime configs
let g:slime_target = "kitty"

" Treesitter
lua << EOF
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "norg", "norg_meta", "norg_table", "bash", "clojure", "comment", "css", "dockerfile", "hcl", "html", "javascript", "jsdoc", "json", "lua", "python", "regex", "rust", "scss", "supercollider", "toml", "tsx", "typescript", "vim", "yaml" },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true,
    },
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" neorg
lua << EOF
require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/Desktop/notes"
                }
            }
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = '<Leader>n'
            }
        },
        ["core.norg.qol.toc"] = {
        },
    },
}
EOF
