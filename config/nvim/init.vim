" Python support for Neovim
runtime! python_setup.vim

" vim-plug setup
call plug#begin('~/.config/nvim/plugged')

" vim utilities
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/SimpylFold'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-peekaboo'

" display and colorschemes
Plug 'luochen1990/rainbow'
Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plug 'nanotech/jellybeans.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/vilight.vim'
Plug 'vim-scripts/CSApprox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" code syntax and language-specific tools
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/vim-jsx-improve', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': ['html'] }
Plug 'tpope/vim-fireplace', { 'for': ['clojure'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

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
Plug 'Raimondi/delimitMate'
Plug 'tomtom/tcomment_vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'

" autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

" snippet plugins
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'epilande/vim-react-snippets', { 'for': ['javascript', 'javascript.jsx'] }

call plug#end()

" set display, colorscheme, etc.
source ~/.config/nvim/display.vim

" set up all key mappings
source ~/.config/nvim/mappings.vim

" configuration for plugins
source ~/.config/nvim/plugin-settings.vim

" Enable folding
set foldmethod=syntax

" prevents security exploits dealing with modelines in files
set modelines=0

" expands tabs to 4 spaces, etc
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap

" Indentation rules
set smartindent
set cindent

" Case-insensitive filename completion in Neovim
set wildignorecase

"Auto-completion menu
set wildmode=list:longest

" Switch between buffers without saving
set hidden

" If searching all lowercase, search case-insensitive.
" If any characters are uppercase, search case-sensitive.
set ignorecase
set smartcase

" %s/foo/bar/ will assume %s/foo/bar/g 
set gdefault

" Highlight results as you search
set showmatch
set hlsearch

" preview text substitution live as you type
set inccommand=split

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
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory^=$HOME/.config/nvim/swapfiles//

" because apparently *.md is also a Modula-2 file, which I'm never going to edit
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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
