" JSX syntax in .js files
let g:jsx_ext_required = 0

" vim-rooter config
let g:rooter_patterns = ['.git/']

" UltiSnips config
let g:UltiSnipsSnippetsDir="~/.config/nvim/my_snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:UltiSnipsExpandTrigger="<c-j>"

" Settings for Indent Guides plugin
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" notational-fzf-vim stuff
let g:nv_main_directory = '~/Desktop/notes'
let g:nv_search_paths = ['~/Desktop/notes']
let g:nv_default_extension = '.md'
let g:nv_create_note_window = 'edit'

" Deoplete rules
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" language server configs
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ale configs
let g:ale_completion_enabled = 1

" vim-rest-console configs
let s:vrc_auto_format_response_patterns = {
  \ 'json': 'jq',
\}
let g:vrc_curl_opts = {
  \ '-i': '',
  \ '-s': '',
  \ '-S': '',
\}
