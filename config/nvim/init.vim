" Vundle setup
filetype off
set rtp+=~/.config/nvim/bundle/vundle/
call vundle#begin()
call vundle#rc('~/.config/nvim/bundle/')
Plugin 'VundleVim/Vundle.vim'

" Python support for Neovim
runtime! python_setup.vim

" vim utilities
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'qpkorr/vim-bufkill'
Plugin 'tpope/vim-sensible'
Plugin 'easymotion/vim-easymotion'
Plugin 'tmhedberg/SimpylFold'

" display and colorschemes
Plugin 'luochen1990/rainbow'
Plugin 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/vilight.vim'
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-airline/vim-airline'

" code syntax and language-specific tools
Plugin 'sheerun/vim-polyglot'
Plugin 'neoclide/vim-jsx-improve'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'vim-scripts/HTML-AutoCloseTag'
Plugin 'tpope/vim-fireplace'
Plugin 'ternjs/tern_for_vim'
Plugin 'moll/vim-node'

" source control
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

" file and project management
Plugin 'airblade/vim-rooter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-vinegar'

" code modification tools
Plugin 'Raimondi/delimitMate'
Plugin 'tomtom/tcomment_vim'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'benekastah/neomake'

" autocompletion
Plugin 'Shougo/deoplete.nvim'
Plugin 'carlitux/deoplete-ternjs'

" snippet plugins
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'epilande/vim-es2015-snippets'
Plugin 'epilande/vim-react-snippets'


call vundle#end()

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

" Line-wrapping options
set wrap
set textwidth=80
set formatoptions+=rn1l

" Crontab uses tmp files to edit, so backup rules must change. (See
" .bash_profile for $VIM_CRONTAB alias stuff.)
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" backup and swap rules
set noswapfile
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" because apparently *.md is also a Modula-2 file, which I'm never going to edit
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Ignore hidden directories/files
set wildignore+=*/node_modules/*
set wildignore+=.git
set wildignore+=*.pyc

" `gf` will open JS file paths that don't end in .js (a la CommonJS/ES6 modules)
set suffixesadd+=.js
