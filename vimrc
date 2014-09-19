" Vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" load my bundles from Github
" to install or update all bundles do :BundleInstall
Bundle 'vim-scripts/ack.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sickill/vim-pasta'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'sheerun/vim-polyglot'
" color schemes
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Bundle 'nanotech/jellybeans.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/vilight.vim'

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
set ttyscroll=3
set backspace=indent,eol,start

" Auto cd to current file's directory
autocmd BufEnter * lcd %:p:h

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

" Remap leader key from \ to space bar
let mapleader = "\<Space>"

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
" set guifont=Inconsolata\ for\ Powerline:h17 "https://github.com/Lokaltog/powerline-fonts
" set guifont=Droid\ Sans\ Mono:h14 "http://damieng.com/blog/2008/05/26/envy-code-r-preview-7-coding-font-released
" set guifont=Source\ Code\ Pro:h14 "http://blogs.adobe.com/typblography/2012/09/source-code-pro.html
set guifont=Sauce\ Code\ Powerline:h15 "http://blogs.adobe.com/typblography/2012/09/source-code-pro.html
" set guifont=Hermit:h15 "http://pcaro.es/p/hermit/
" set guifont=CosmicSansNeueMono:h18 "http://openfontlibrary.org/en/font/cosmic-sans-neue-mono

" Set linespacing
set linespace=5

" Set color scheme
if has("gui_running")
    colorscheme freshcut
else
    colorscheme vilight
endif

" Makes eol/tab chars not get ugly highlighting with colour-schemes bundle
hi NonText guibg=bg guifg=#444444

" NERDTree (https://github.com/scrooloose/nerdtree)
let NERDTreeIgnore=['\.pyc$', '^\.git$', '^node_modules$', '^\.sass-cache$']
let NERDTreeShowHidden=1

" NERDTree leader shortcuts for some of my often-used paths
nnoremap <leader>npy :NERDTree ~/Code/App/<cr>

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

" backup and swap rules
set noswapfile
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" Have new buffers open in tabs
set switchbuf+=usetab,newtab

" Change default YouCompleteMe diagnostic key command to maintain preexisting <leader>d setting
let g:ycm_key_detailed_diagnostics = '<leader>yd'

" Only redraw screen after a macro has completed (performance boost!)
set lazyredraw

" Directory for custom snippets
let g:UltiSnipsSnippetDirectories=["my_snippets"]

" Snippet insert with Cmd-J and Shift-Cmd-J
let g:UltiSnipsExpandTrigger="<D-j>"
let g:UltiSnipsJumpForwardTrigger = "<D-j>"
let g:UltiSnipsJumpBackwardTrigger = "<s-D-j>"

" Save/restore editing session using Fn-F2 and Fn-F3
map <F2> :mksession! ~/vim_session <cr> "
map <F3> :source ~/vim_session <cr>
