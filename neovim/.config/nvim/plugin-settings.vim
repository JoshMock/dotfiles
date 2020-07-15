" JSX syntax in .js files
let g:jsx_ext_required = 0

" vim-rooter config
let g:rooter_patterns = ['.git/']

" notational-fzf-vim stuff
let g:nv_main_directory = '~/Desktop/notes'
let g:nv_search_paths = ['~/Desktop/notes']
let g:nv_default_extension = '.md'
let g:nv_create_note_window = 'edit'

" Deoplete rules
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" language server configs
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ale configs
let g:ale_completion_enabled = 1
