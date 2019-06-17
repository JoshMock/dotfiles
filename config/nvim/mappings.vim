" Remap leader key from \ to space bar
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Remaps / search key to use standard regex instead of vim regex
nnoremap / /\v
vnoremap / /\v

" Clear a search by typing <space>k
nnoremap <leader>k :noh<cr>

" Turn on line numbers by typing <space>num
nnoremap <leader>num :set number<cr>
nnoremap <leader>rnum :set relativenumber<cr>
nnoremap <leader>nonum :set nonumber<cr>:set norelativenumber<cr>

" Remaps % to tab to navigate matching brackets
nnoremap <tab> %
vnoremap <tab> %

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
nnoremap <up> :Files<cr>
nnoremap <down> <nop>
nnoremap <left> :bprevious<cr>
nnoremap <right> :bnext<cr>
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

" Remap <leader>d to close current buffer
nnoremap <leader>d :BD<cr>

" Remap <leader>D to force-close current buffer
nnoremap <leader>D :bd!<cr>

" Make the 0 key go to first non-whitespace char
" TODO: wrap in conditional so it toggles between first non-whitespace char and column 0
nnoremap 0 ^
vnoremap 0 ^

" <leader>o/O adds a blank line above or below current line
map <leader>o m`o<Esc>``
map <leader>O m`O<Esc>``

" Leader shortcut to replace 4 spaces with a tab
vnoremap <leader>st :s/    /\t/<CR>

" Leader shortcut to replace a tab with 4 spaces
vnoremap <leader>ts :s/\t/    /<CR>

" fzf settings
nmap <leader>t :GFiles<CR>
nmap <leader>b :Buffers<CR>

" I don't remember what this is for
tnoremap <Esc> <C-\><C-n>

" sideways.vim shortcuts
nnoremap <leader>sl :SidewaysLeft<cr>
nnoremap <leader>sr :SidewaysRight<cr>

" tmux send-key shortcuts
" nt = `npm test`
nmap <leader>nt :!tmux send-keys -t right 'npm test' C-m<CR><CR>
" lc = last-run command
nmap <leader>lc :!tmux send-keys -t right up enter<CR><CR>

" shorcuts for working with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p

" write on <leader>w
nnoremap <leader>w :w<CR><CR>

" vim-expand-region setings (hitting vvv incrementally expands selection)
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" shortcut for notational-style note panel
nnoremap <leader>nv :NV<cr>

map <leader>x :AirlineToggle<cr> :NeomakeDisable

vnoremap <leader>e :'<,'>Eval<cr>
nnoremap <leader>e :%Eval<cr>

" Tabularize shortcuts
nnoremap <leader>= :Tabularize /^[^=]*\zs=/l1c1l0<cr>
vnoremap <leader>= :Tabularize /^[^=]*\zs=/l1c1l0<cr>
