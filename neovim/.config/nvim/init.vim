" Python support for Neovim
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let g:ale_completion_enabled = 1

" vim-plug setup
call plug#begin($HOME.'/.config/nvim/plugged')

" vim utilities
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-sensible'
Plug 'tmhedberg/SimpylFold'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-peekaboo'

" display and colorschemes
Plug 'luochen1990/rainbow'
Plug 'arcticicestudio/nord-vim'

" code syntax and language-specific tools
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

" source control
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" file and project management
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'Alok/notational-fzf-vim'

" code modification tools
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'

call plug#end()

" set display, colorscheme, etc.
source $HOME/.config/nvim/display.vim

" set up all key mappings
source $HOME/.config/nvim/mappings.vim

" configuration for plugins
source $HOME/.config/nvim/plugin-settings.vim

" Enable folding
set foldmethod=syntax

" prevents security exploits dealing with modelines in files
set modelines=0

" expands tabs to 2 spaces, etc
set tabstop=2
set shiftwidth=2
set shiftround
set softtabstop=2
set expandtab
set nowrap

" Indentation rules
set smartindent
set cindent

"Auto-completion menu
set wildmode=list:longest

" set `hidden` for all buffer types except netrw buffers
set nohidden
augroup netrw_buf_hidden_fix
    autocmd!

    " Set all non-netrw buffers to bufhidden=hide
    autocmd BufWinEnter *
                \  if &ft != 'netrw'
                \|     set bufhidden=hide
                \| endif

augroup end

" If searching all lowercase, search case-insensitive.
" If any characters are uppercase, search case-sensitive.
set ignorecase
set smartcase
set infercase " smart autocomplete casing
set wildignorecase " Case-insensitive filename completion in Neovim

" %s/foo/bar/ will assume %s/foo/bar/g 
set gdefault

" Highlight results as you search
set showmatch
set hlsearch

" preview text substitution live as you type
set inccommand=nosplit

" Line-wrapping options
set wrap
set textwidth=80
set formatoptions+=rn1lt

" set external formatter to par
set formatprg=par\ -w80

" Crontab uses tmp files to edit, so backup rules must change. (See
" .bash_profile for $VIM_CRONTAB alias stuff.)
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" backup and swap rules
set backup
set writebackup
set backupdir=$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory^=$HOME/.config/nvim/swapfiles//
set updatetime=300

" because apparently *.md is also a Modula-2 file, which I'm never going to edit
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"
" .pcss is CSS for PostCSS
autocmd BufNewFile,BufReadPost *.pcss set filetype=css

" Ignore hidden directories/files
set wildignore+=*/node_modules/*
set wildignore+=.git
set wildignore+=*.pyc

" `gf` will open JS file paths that don't end in .js (a la CommonJS/ES6 modules)
set suffixesadd+=.js

" persist undo across file closures
set undodir=$HOME/.config/nvim/undodir
set undofile

" enable mouse scrolling
set mouse=a

" drop netrw/vim-vinegar buffer upon navigating away
autocmd FileType netrw setl bufhidden=delete

" never hide left gutter (prevents jumpiness with linter errors)
set signcolumn=yes
