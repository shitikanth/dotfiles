
" Haskell
" let g:haddock_browser="firefox"
" let g:haddock_docdir="/usr/share/doc/ghc/html/"

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
