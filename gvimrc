scriptencoding utf-8
" vim:set ts=2 sts=2 sw=2:

try
  set background=dark
  "let g:molokai_original = 1
  colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

set lines=40 columns=140
set guioptions-=T
set guioptions-=m

if has('win32')
  set guifont=Consolas:h11
  set guifontwide=MS_Gothic:h11:cSHIFTJIS
elseif has('unix')
  if system('uname') =~ 'Darwin'
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif
endif

" Input method
set iminsert=0
set imsearch=-1
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

if has('kaoriya')
  autocmd GUIEnter * set transparency=220
endif

"colorscheme zellner
"set guifont=Consolas:h24
"set guifontwide=MS_Gothic:h24:cSHIFTJIS
