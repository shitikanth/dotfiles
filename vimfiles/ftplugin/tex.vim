
" latex-suite {{{
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
" }}}

