" folding rules
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
call JavaScriptFold()
setl fen

" Ale rules
let b:ale_fixers = ['eslint', 'tsserver']
let b:ale_linters = ['eslint', 'tsserver']
