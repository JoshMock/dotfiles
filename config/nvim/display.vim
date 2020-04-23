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

" airline customizations
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

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

" fzf floating window
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,2'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(90)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" shorter "Hit ENTER" message size
set shortmess+=c

" Random stuff from http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
set showmode
set visualbell
set cursorline

"Show command in bottom right portion of the screen
set showcmd
