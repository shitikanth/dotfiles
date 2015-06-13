"Basic settings {{{

set nocompatible
let mapleader=","

"Tab behaviour
set sw=4
set tabstop=4
set expandtab

"Backspace behaviour
set backspace=indent,eol,start

set nobackup
set noswapfile

set mouse=a
set incsearch
set showmatch
set hlsearch
set hidden
set history=1000
set undolevels=1000

set timeout
set timeoutlen=300

set foldenable
set foldmethod=marker

"Turn on syntax highlighting, auto-indentation
filetype plugin on
syntax on
set smartindent
set autoindent
filetype indent on

"disable search highlights
set nohls

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
" {{{ Intermediate

"Better command-line completion
set wildmenu
"set wildmode=list:longest
set showcmd
set showmode
set ls=2
set wildignore=*.swp,*.bak,*.pyc,*.o,*.log,*.out,
               \*.pdf,*.aux,*.dvi,*.pdfsync,*.synctex,
               \.git/*,**/.git/*,_darcs/*,**/_darcs/*,**/.metadata/*

"Interactive shell
set shellcmdflag=-ic
"Automatically read files changed on disk
set autoread

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

" shortcuts {{{
nmap <leader>ev ;e $MYVIMRC<CR>zi
nmap <leader>lv ;so $MYVIMRC<CR>zi
nmap <silent> <leader>lcd ;cd %:h<CR>
nmap <silent> <leader>s :set spell!<CRo
" allow normal use of "," by pressing it twice
nnoremap ,, ,
" swap ; and : for fast access to command-line
nnoremap ; :
nnoremap : ;
vmap ; :
vmap Q gq
nmap Q gqap
" nnoremap j gj
" nnoremap k gk
ca Q q
ca WQ wq
ca Wq wq

" refresh folds with <Space>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Close current buffer
map <leader>bd ;bunload<cr>
" Close all the buffers
map <leader>ba ;1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn ;tabnew<cr>
map <leader>to ;tabonly<cr>
map <leader>tc ;tabclose<cr>
map <leader>tm ;tabmove<space>

" clear highlighted search
nmap <silent> <leader>/ ;nohlsearch<CR>

" shortcut for switching between source/header files
map <leader>a ;A<cr>
" }}}
" filetype specific settings
autocmd filetype c,cpp setl foldmethod=syntax
" clean whitespace before save
autocmd fileType c,cpp,java,php,tex,haskell,python,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd filetype tex,html,haskell,ruby setl sw=2
autocmd FileType lhaskell setlocal formatoptions+=ro
" good indentation in C++
autocmd filetype c,cpp setl cino=(0,
autocmd filetype c,cpp set formatoptions-=ro

" mark whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" spell checking

" }}}
" Plugin specific settings {{{
" eventually move most of these to ftplugin

" latex-suite
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_CompileRule_pdf =
"   \'pdflatex -synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'latexmk -pdf $*'
let g:Tex_ViewRule_pdf = 'Skim'
"let g:Tex_ViewRule_pdf =
"   \'/Applications/Skim.app/Contents/SharedSupport/displayline %l %f'
"let g:Tex_TreatMacViewerAsUNIX = 1
"let g:Tex_ViewRule_pdf =
"   \'SumatraPDF -reuse-instance -inverse-search
"   \"gvim --servername LaTeX -c \":RemoteOpen +\%l \%f\" --remote-silent"'
let g:Tex_IgnoredWarnings ='
   \"Underfull\n".
   \"Overfull\n".
   \"specifier changed to\n".
   \"You have requested\n".
   \"Missing number, treated as zero.\n".
   \"There were undefined references\n".
   \"Citation %.%# undefined\n".'

let g:Tex_FoldedEnvironments =
   \"proof,prop,lem,cor,verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage"

let g:Tex_FoldedSections=
   \"part,chapter,bibliography,section,subsection,subsubsection,paragraph"

" Ultisnips


" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> "
   \. g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsListTrigger="<c-l>"
"

" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Haskell
" let g:haddock_browser="firefox"
" let g:haddock_docdir="/usr/share/doc/ghc/html/"

noremap <Leader>g :GhcModType<CR>

"if has("gui_running")
"  let g:haskell_conceal_wide = 1
"end

" syntastic

let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers = ['gcc']
let g:syntastic_tex_checkers    = ['chktex']
let g:syntastic_haskell_checkers =['hlint']
noremap <silent> <Leader>e :Errors<CR>
noremap <Leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" c.vim cvim


" omnicppcomplete

" shortcut to generate ctags
set ofu=syntaxcomplete#Complete
noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=~/.vim/tags/cpp

" NERDTree
let g:NERDTreeDirArrows=0

" NERDCommenter
let NERDSpaceDelims=1

" YouCompleteMe ycm youcompleteme
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-Space>'

" Neco-ghc neco-ghc
let g:necoghc_enable_detailed_browse = 1

" Command-t command-t commandt
let g:CommandTFileScanner = 'find'
let g:CommandTTraverseSCM = 'pwd'
let g:CommandTMaxCachedDirectories = 3
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
map <leader>d :r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>
" underline
map <leader>ul yyp<c-v>$r
" }}}
"set Font and Color scheme {{{

set t_Co=256
if has("gui_running")
  colo bclear
  if has("gui_gtk2")
    set guifont=Inconsolata\ 10
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  elseif has("gui_macvim")
    set guifont=Inconsolata:h15
  endif
else
  colo distinguished
endif

" }}}
