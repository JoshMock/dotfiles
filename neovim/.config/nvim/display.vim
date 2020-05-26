if (has("termguicolors"))
  set termguicolors
endif

" Set color scheme
set background=dark
colorscheme nord

" Show TextMate-like whitespace chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬

" Makes eol/tab chars not get ugly highlighting
hi NonText guifg=#444444

" turn on rainbow plugin
let g:rainbow_active = 1

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
