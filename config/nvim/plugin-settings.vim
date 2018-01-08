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

" Neomake settings
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['flake8']

" javascript-libraries-syntax.vim settings
let g:used_javascript_libs = 'underscore,backbone,react,flux,jasmine,chai'

" easytags options
let g:easytags_async = 1

" jsdoc settings
let g:jsdoc_allow_input_prompt = 1

" turn off Tern's scratch window
set completeopt-=preview

" UltiSnips config
let g:UltiSnipsSnippetsDir="~/.config/nvim/my_snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:UltiSnipsExpandTrigger="<c-j>"

" Deoplete rules
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Settings for Indent Guides plugin
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
