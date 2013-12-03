" Things to do if on windows {{{

if has('win32') || has('win64')
  set shell=powershell
  set shellcmdflag=-command
  set shellpipe=>
  set shellredir=>
  set bs=2
  set shellslash
endif

"}}}
"Basic settings {{{

set nocompatible
let mapleader=","

"Tab behaviour
set sw=4
set tabstop=4
set expandtab

set nobackup
set noswapfile

set mouse=a
set incsearch
set showmatch
set hidden
set history=1000
set undolevels=1000

set foldenable
set foldmethod=marker

"Turn on syntax highlighting, auto-indentation
filetype plugin on
filetype indent on
syntax on
set smartindent
set autoindent

set ruler
set textwidth=78
set visualbell
set guioptions=m
set encoding=utf-8
"Paste after F2
set pastetoggle=<F2>

"Load plugins
execute pathogen#infect()

"}}}
" {{{ Intermediate

"Better command-line completion
set wildmenu
"set wildmode=list:longest
set showcmd
set showmode
set ls=2
set wildignore=*.swp,*.bak,*.pyc,*.o,*.pdf
"Automatically read files changed on disk
set autoread

" set comments=sl:/*,mb:\ *,elx:\ */

" allow command line editing like emacs
" cnoremap <C-A> <Home>
" cnoremap <C-B> <Left>
" cnoremap <C-E> <End>
" cnoremap <C-F> <Right>
" cnoremap <C-N> <End>
" cnoremap <C-P> <Up>
" cnoremap <ESC>b <S-Left>
" cnoremap <ESC><C-B> <S-Left>
" cnoremap <ESC>f <S-Right>
" cnoremap <ESC><C-F> <S-Right>
" cnoremap <ESC><C-H> <C-W>
" 

" spell check
autocmd filetype tex set spell
nmap <F10> ;NERDTreeFind<CR>
" shortcuts {{{
nmap <leader>ev ;e $MYVIMRC<CR>zi
nmap <leader>lv ;so $MYVIMRC<CR>zi
nmap <silent> <leader>lcd ;cd %:h<CR>
nmap <silent> <leader>s :set spell!<CRo
nnoremap ; :
vmap ; :
vmap Q gq
nmap Q gqap
nnoremap j gj
nnoremap k gk
ca Q q
ca WQ wq
ca Wq wq
" Close current buffer
map <leader>bd ;bunload<cr>
" Close all the buffers
map <leader>ba ;1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn ;tabnew<cr>
map <leader>to ;tabonly<cr>
map <leader>tc ;tabclose<cr>
map <leader>tm ;tabmove

" clear highlighted search
nmap <silent> <leader>/ ;nohlsearch<CR>

" shortcut for switching between source/header files
map <leader>a ;A<cr>
" }}}
" filetype specific settings
autocmd filetype c,cpp setl foldmethod=syntax
" clean whitespace before save
autocmd fileType c,cpp,java,php,haskell,python autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd filetype html,haskell setl sw=2

" good indentation in C++
autocmd filetype c,cpp setl cino=(0, 
autocmd filetype c,cpp set formatoptions-=ro

" mark whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" }}}
" Plugin specific settings {{{

" latex-suite
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'SumatraPDF -reuse-instance -inverse-search "gvim --servername LaTeX -c \":RemoteOpen +\%l \%f\" --remote-silent"'
set iskeyword+=:

" Ultisnips
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" Haskell
au BufEnter *.hs compiler ghc
let g:haddock_browser="firefox"
let g:haddock_docdir="/usr/share/doc/ghc/html/"

if has("gui_running")
  let g:haskell_conceal_wide = 1
end

" syntastic

" use C++-11
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers = ['gcc']

" c.vim
let g:C_CplusCFlags = '-Wall -std=c++11 -g -O0 -c'
let g:C_CplusLFlags = '-Wall -std=c++11 -g -O0'

" omnicppcomplete

" shortcut to generate ctags
set ofu=syntaxcomplete#Complete
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=~/.vim/tags/cpp

" NERDTree
let g:NERDTreeDirArrows=0

" }}}
" Awesome Macros {{{

cmap w!! w !sudo tee % >/dev/null
imap <F3> <F2><C-R>+<F2>
nmap <F3> o<F2><C-R>+<F2><Esc>
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
  write
endfunction
command! W call WriteCreatingDirs()
map <leader>i magg=G`azz
map <leader>gu ggi#ifndef 

" }}}
"set Font and Color scheme {{{

set t_Co=256
if has("gui_running")
  colo molokai
  if has("gui_gtk2")
    set guifont=Inconsolata\ 10
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
else
  colo wombat256mod
endif

" }}}


