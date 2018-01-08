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

" Show TextMate-like whitespace chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬

" Makes eol/tab chars not get ugly highlighting
hi NonText guibg=bg guifg=#111111

" turn on rainbow plugin
let g:rainbow_active = 1

" airline customizations
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" fancy colorscheme support in tmux
set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

" fzf status line display
function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" shorter "Hit ENTER" message size
set shortmess+=c

" Random stuff from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
set showmode
set visualbell
set cursorline

"Show command in bottom right portion of the screen
set showcmd
