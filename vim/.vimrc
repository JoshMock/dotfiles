" Vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

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
Plugin 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }

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
Plugin 'scrooloose/syntastic'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'


call vundle#end()

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
set nocompatible

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

" Show TextMate-like whitespace chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬

" shorter "Hit ENTER" message size
set shortmess+=c

" Random stuff from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
set showmode
set visualbell
set cursorline
set ttyfast

" Case-insensitive filename completion in Neovim
set wildignorecase

"Auto-completion menu
set wildmode=list:longest

"Show command in bottom right portion of the screen
set showcmd

" Switch between buffers without saving
set hidden

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
set showmatch
set hlsearch

" Clear a search by typing <space>k
nnoremap <leader>k :noh<cr>

" Turn on line numbers by typing <space>num
nnoremap <leader>num :set number<cr>
nnoremap <leader>rnum :set relativenumber<cr>
nnoremap <leader>nonum :set nonumber<cr>:set norelativenumber<cr>

" Remaps % to tab to navigate matching brackets
nnoremap <tab> %
vnoremap <tab> %

" Line-wrapping options
set wrap
set textwidth=80
set formatoptions+=rn1l

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
set background=dark
colorscheme solarflare
" Makes eol/tab chars not get ugly highlighting
hi NonText guibg=bg guifg=#111111

" Hide files in netrw file tree based on .gitignore rules
" let g:netrw_list_hide = netrw_gitignore#Hide() . '\.git$'

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
nnoremap <leader>d :BD<cr>

" Remap <leader>D to force-close current buffer
nnoremap <leader>D :bd!<cr>

" Remap <leader>w to switch splits
nnoremap <leader>w <C-w>w<cr>

" Make the 0 key go to first non-whitespace char
" TODO: wrap in conditional so it toggles between first non-whitespace char and column 0
nnoremap 0 ^
vnoremap 0 ^

" <leader>o/O adds a blank line above or below current line
map <leader>o :set paste<CR>m`o<Esc>``:set nopaste<CR>
map <leader>O :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Hide MacVim's GUI task bar on load
set guioptions=egmrt

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

" Change default YouCompleteMe diagnostic key command to maintain preexisting <leader>d setting
let g:ycm_key_detailed_diagnostics = '<leader>yd'

" Only redraw screen after a macro has completed (performance boost!)
set lazyredraw

" because apparently *.md is also a Modula-2 file, which I'm never going to edit
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Trying to train myself out of using tabs vs buffers
map <leader>] :bnext<CR>
map <leader>[ :bprevious<CR>

" Ignore hidden directories/files
set wildignore+=*/node_modules/*
set wildignore+=.git
set wildignore+=*.pyc

" JSX syntax in .js files
let g:jsx_ext_required = 0

" Syntastic settings
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_scss_checkers = ['sass_lint']
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

" javascript-libraries-syntax.vim settings
let g:used_javascript_libs = 'underscore,backbone,react,flux,jasmine,chai'

" fzf settings
nmap <leader>t :GFiles<CR>
nmap <leader>b :Buffers<CR>
function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" `gf` will open JS file paths that don't end in .js (a la CommonJS/ES6 modules)
set suffixesadd+=.js

" turn on rainbow plugin
let g:rainbow_active = 1

" easytags options
let g:easytags_async = 1

" jsdoc settings
let g:jsdoc_allow_input_prompt = 1

" turn off Tern's scratch window
set completeopt-=preview

" sideways.vim shortcuts
nnoremap <leader>sl :SidewaysLeft<cr>
nnoremap <leader>sr :SidewaysRight<cr>

" airline customizations
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" fancy colorscheme support in tmux
set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

" tmux send-key shortcuts
nmap <leader>nt :!tmux send-keys -t right 'npm test' C-m<CR><CR>

" shorcuts for working with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p
