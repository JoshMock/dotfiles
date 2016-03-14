" Vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

" Python support for Neovim
if has('nvim')
  runtime! python_setup.vim
endif

" load my bundles from Github
" to install or update all bundles do :PluginInstall
Plugin 'vim-scripts/ack.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'tomtom/tcomment_vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot'
if has("nvim")
    Plugin 'Shougo/deoplete.nvim' " YouCompleteMe substitute
    Plugin 'kien/ctrlp.vim' " Command-T substitute
    Plugin 'benekastah/neomake' " syntastic (+ more!) substitute
    " wanted: neovim-compatible ultisnips substitute
else
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'wincent/Command-T'
    Plugin 'SirVer/ultisnips'
    Plugin 'scrooloose/syntastic'
endif
Plugin 'honza/vim-snippets'
Plugin 'grvcoelho/vim-javascript-snippets'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'luochen1990/rainbow'
Plugin 'marijnh/tern_for_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-vinegar'
" color schemes
Plugin 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/vilight.vim'
Plugin 'vim-scripts/CSApprox'

call vundle#end()

"Enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

" Enable folding
set foldmethod=syntax
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

" turn off vi compatibility
if !has("nvim")
    set nocompatible
endif

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

" Show TextMate-like whitespace chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬

" Random stuff from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
set scrolloff=3
set showmode
set visualbell
set cursorline
if !has("nvim")
    if has("gui_running")
        set ttyfast
    endif
endif
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

" Clear a search by typing <space>k
nnoremap <leader>k :noh<cr>

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
" set guifont=Hermit:h15 "http://pcaro.es/p/hermit/
" set guifont=CosmicSansNeueMono:h18 "http://openfontlibrary.org/en/font/cosmic-sans-neue-mono
set guifont=Hack:h14 "https://github.com/chrissimpkins/Hack

" Set linespacing
set linespace=5

" Set color scheme
colorscheme freshcut

" Makes eol/tab chars not get ugly highlighting with colour-schemes bundle
hi NonText guibg=bg guifg=#444444

" Hide files in netrw file tree based on .gitignore rules
let g:netrw_list_hide = netrw_gitignore#Hide() . '\.git$'

" Settings for Indent Guides plugin (https://github.com/nathanaelkane/vim-indent-guides)
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Crontab uses tmp files to edit, so backup rules must change. (See
" .bash_profile for $VIM_CRONTAB alias stuff.)
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" Remap <leader>d to close current buffer
nnoremap <leader>d :bd<cr>

" Remap <leader>s to close current buffer without destroying current split
nnoremap <leader>s :b#<bar>bd#<cr>

" Remap <leader>D to force-close current buffer
nnoremap <leader>D :bd!<cr>

" Remap <leader>w to switch splits
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

" Deoplete rules for neovim
if has("nvim")
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:deoplete#enable_at_startup = 1

    " tab-complete
    inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

    " <leader><Tab> for regular tab
    inoremap <Leader><Tab> <Space><Space>

    " add tern support for JS files
    autocmd FileType javascript setlocal omnifunc=tern#Complete

    " close Tern scratch window on completion
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" Only redraw screen after a macro has completed (performance boost!)
if !has("nvim")
    set lazyredraw
endif

" Directory for custom snippets
let g:UltiSnipsSnippetDirectories=["my_snippets"]

" Snippet insert with Cmd-J and Shift-Cmd-J
let g:UltiSnipsExpandTrigger="<D-j>"
let g:UltiSnipsJumpForwardTrigger = "<D-j>"
let g:UltiSnipsJumpBackwardTrigger = "<s-D-j>"

" because apparently *.md is also a Modula-2 file, which I'm never going to edit
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Trying to train myself out of using tabs vs buffers
map <leader>] :bnext<CR>
map <leader>[ :bprevious<CR>

" Ignore node_modules directory
set wildignore+=node_modules/*

" JSX syntax in .js files
let g:jsx_ext_required = 0

" List current buffers with <leader>l
map <leader>l :ls<CR>

" Syntastic settings
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Neomake settings
if has('nvim')
    autocmd! BufWritePost * Neomake
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_python_enabled_makers = ['flake8']
endif

" javascript-libraries-syntax.vim settings
let g:used_javascript_libs = 'underscore,backbone,react,flux,jasmine,chai'

" Ctrl-P/Command-T settings
if has("nvim")
    let g:ctrlp_working_path_mode = 'r'
    nmap <leader>t :CtrlPMixed<CR>
    nmap <leader>b :CtrlPBuffer<CR>
endif

" `gf` will open JS file paths that don't end in .js (a la CommonJS/ES6 modules)
set suffixesadd+=.js

" turn on rainbow plugin
let g:rainbow_active = 1

" use ag instead of ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
