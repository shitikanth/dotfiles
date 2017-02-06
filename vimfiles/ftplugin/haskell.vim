
" Haskell

" List of plugins used for Haskell and their functions
"   1. ghc-mod  : display type information, errors/warnings
"   2. neco-ghc : auto-completion
"   3. vim2hs   : syntax highlighting, hpaste, unicode conceals

noremap <Leader>g :GhcModType<CR>

let g:ycm_semantic_triggers = {'haskell' : ['.']}

setlocal omnifunc=necoghc#omnifunc

function! haskell#FindImportPosition()
  let save_cursor = getpos(".")
  let line1 = search('\%1c\(\<import\>\|\<module\>\|{-# OPTIONS\|{-# LANGUAGE\)','b')
  " jump over possible multiline statements
  let line2 = search('^\(\s*\|\S.*\)$','')
  call setpos('.', save_cursor)
  " insert position is after statement, before any following declarations
  return ( line2 > line1 ? line2-1 : line1 )
endfunction

" limitation: this overwrites register 0
nnoremap <buffer> <leader>h k/import<CR>"0d$:call append(haskell#FindImportPosition(),@0)<CR>

setlocal iskeyword=@,48-57,_,'

" automatically keep the tags file up to date
" NOTE: Disabling because makes file save slow. Generate tags manually!
" au BufWritePost *.hs            silent !init-tags %
" au BufWritePost *.hsc           silent !init-tags %

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
