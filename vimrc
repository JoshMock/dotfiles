" Pathogen settings to auto-load new plugins (http://www.vim.org/scripts/script.php?script_id=2332)
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"Enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

" turn off vi compatibility
set nocompatible

" prevents security exploits dealing with modelines in files
set modelines=0

" expands tabs to 4 spaces, etc
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation rules
set autoindent
set smartindent

" UTF-8 text encoding by default
set encoding=utf-8

" Show TextMate-like whitespace chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬

" Random stuff from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
set scrolloff=3
set showmode
set visualbell
set cursorline
set ttyfast
set backspace=indent,eol,start

" Auto cd to current file's directory
" autocmd BufEnter * lcd %:p:h
set autochdir

" More useful command-line-like tab completion
set wildmenu

"Auto-completion menu
set wildmode=list:longest

"Show command in bottom right portion of the screen
set showcmd

" Display current cursor position in lower right corner
set ruler

" Switch between buffers without saving
set hidden

" Always show status line
set laststatus=2

" Remap leader key from \ to ,
let mapleader = ","

" Remaps / search key to use standard regex instead of vim regex
nnoremap / /\v
vnoremap / /\v

" If searching all lowercase, search case-insensitive.
" If any characters are uppercase, search case-sensitive.
set ignorecase
set smartcase

" %s/foo/bar/ will assume %s/foo/bar/g 
set gdefault

" Highlight results as you search
set incsearch
set showmatch
set hlsearch

" Clear a search by typing ,<space>
nnoremap <leader><space> :noh<cr>

" Turn on line numbers by typing ,num
nnoremap <leader>num :set number<cr>
nnoremap <leader>rnum :set relativenumber<cr>
nnoremap <leader>nonum :set nonumber<cr>:set norelativenumber<cr>

" Remaps % to tab to navigate matching brackets
nnoremap <tab> %
vnoremap <tab> %

" Line-wrapping options
set wrap
set textwidth=79
set formatoptions=qrn1

" Use <leader>H to toggle highlighting lines over 80 chars
nnoremap <leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
    if !exists('w:longlinehl')
        let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
        echo "Long lines highlighted"
    else
        call matchdelete(w:longlinehl)
        unl w:longlinehl
        echo "Long lines unhighlighted"
    endif
endfunction

" Disables arrow keys in normal mode to enforce use of hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Remap F1 to Esc to avoid accidentally opening help docs
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Remap jj to do same thing as <ESC> when in insert mode
inoremap jj <ESC>

" set guifont=Inconsolata:h16 "http://www.levien.com/type/myfonts/inconsolata.html
" set guifont=Droid\ Sans\ Mono:h14 "http://damieng.com/blog/2008/05/26/envy-code-r-preview-7-coding-font-released
set guifont=Source\ Code\ Pro:h14 "http://blogs.adobe.com/typblography/2012/09/source-code-pro.html

" Set linespacing
set linespace=5

" Sets color scheme for MacVim to jellybeans (https://github.com/nanotech/jellybeans.vim)
if has("gui_running")
    colorscheme jellybeans
else
    colorscheme vilight
endif

" NERDTree (https://github.com/scrooloose/nerdtree)
let NERDTreeIgnore=['\.pyc$']

" NERDTree leader shortcuts for some of my often-used paths
nnoremap <leader>npy :NERDTree python<cr>
nnoremap <leader>nph :NERDTree php<cr>
nnoremap <leader>na :NERDTree api<cr>

" ,nt toggles NERDTree open/closed
nnoremap <leader>nt :NERDTreeToggle<cr>

" Automatically fold code based on indents
set foldmethod=indent

" Settings for Indent Guides plugin (https://github.com/nathanaelkane/vim-indent-guides)
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Crontab uses tmp files to edit, so backup rules must change. (See
" .bash_profile for $VIM_CRONTAB alias stuff.)
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" Remap ,d to close current buffer
nnoremap <leader>d :bd<cr>

" Remap ,D to force close current buffer
nnoremap <leader>D :bd!<cr>

" Remap ,w to switch splits
nnoremap <leader>w <C-w>w<cr>

" Tagbar setting
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8/bin/ctags'
nnoremap <leader>tbo :TagbarOpen<cr>
nnoremap <leader>tbc :TagbarClose<cr>

" Set SuperTab options for Python files
au FileType python set omnifunc=pythoncomplete#Complete
set completeopt=menuone,longest,preview

" SuperTab integration with Vim's OmniComplete
let g:SuperTabDefaultCompletionType = "context"

" Tidy JSON - http://lumberjaph.net/perl/2009/02/17/tidify-a-json-in-vim.html 
map <leader>jt  <Esc>:%!python -m json.tool<CR>

" inoremap <M-o> <Esc>o
" inoremap <C-j> <Down>

" Rules for vim-ragtag
let g:ragtag_global_maps = 1

" Make the 0 key go to first non-whitespace char
" TODO: wrap in conditional so it toggles between first non-whitespace char and column 0
nnoremap 0 ^
vnoremap 0 ^

" <leader>o/O adds a blank line above or below current line
map <leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
map <leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>

" <leader>p/P delete a line above or below (only if blank)
map <leader>p m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
map <leader>P m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" Hide MacVim's GUI task bar on load
if has("gui_running")
    set guioptions=egmrt
endif

" Leader shortcut to replace 4 spaces with a tab
vnoremap <leader>st :s/    /\t/<CR>

" Leader shortcut to replace a tab with 4 spaces
vnoremap <leader>ts :s/\t/    /<CR>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=128

" speed up Vim some
set ttyfast
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

"matchit.vim settings
source $VIMRUNTIME/macros/matchit.vim

"vim-powerline settings
let g:Powerline_symbols = "unicode"

" Sass (.scss) file highlighting
au BufRead,BufNewFile *.scss set filetype=scss

" backup and swap rules
set noswapfile
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" Set custom snipmate snippets directory
let g:snippets_dir = '~/.vim/snippets/'
