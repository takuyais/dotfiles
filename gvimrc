scriptencoding utf-8

try
  set background=dark
  "let g:molokai_original = 1
  colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

set lines=40 columns=120
set guioptions-=T
set guioptions-=m

if has('win32')
  set guifont=Consolas:h9
  set guifontwide=MS_Gothic:h9:cSHIFTJIS
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

" vim:set ts=2 sts=2 sw=2:

