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
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" ale configs
nnoremap <silent> gd :ALEGoToDefinition<cr>

" vim-slime configs
let g:slime_target = "kitty"
