"scriptencoding utf-8

function! s:DefineBundles()
  call vundle#rc(expand(s:bundle_path))

  Plugin 'gmarik/vundle'

  Plugin 'jiangmiao/simple-javascript-indenter'
  Plugin 'align'
  Plugin 'tpope/vim-surround'
  Plugin 'tomasr/molokai'
  Plugin 'mattn/emmet-vim'

  return
endfunction

set nobackup
set noundofile
set directory-=.
set directory^=~/vimfiles/tmp//
set number
set hidden
set colorcolumn=100,+0
set encoding=utf-8
set showcmd
set showmatch
set laststatus=2
set statusline=%m#%n\ %<%f\ %y\ %q%([%H%R%W]%)%={%{v:register}}\ '0x%B'\ [%{&ff},%{strlen(&fenc)?&fenc:'-'}%{&bomb?'+BOM':''}]\ %-20.(%l/%L,%c%V%)%P
set cursorline
set wildmode=list:longest,full
set clipboard^=unnamed
if has('unnamedplus')
  set clipboard^=unnamedplus
endif
set timeout timeoutlen=500 ttimeoutlen=-1
set formatoptions+=mB
set nrformats=hex
set virtualedit=block
set backspace=indent,eol,start
set tags+=./tags;
set autochdir

" Tab
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smarttab
set list
set listchars=tab:>-,trail:-,nbsp:%

" Indent
set autoindent
set cinoptions+=g0,j1,J1

" Search
set hlsearch | nohlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" For Japanese
set ambiwidth=double
set display+=lastline

" Color
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter,BufRead * match IdeographicSpace /　/
augroup END

if has('multi_byte_ime')
  autocmd ColorScheme * highlight default CursorIM guifg=NONE guibg=Red
endif

colorscheme desert
"let b:dot_alt = has('win32') ? '_' : '.'
"execute 'source' fnameescape(fnamemodify(expand('$MYVIMRC'), ':p:h') . '/' .
"      \b:dot_alt . 'vimrc.color')

" Fold
augroup vimrc
  autocmd BufReadPre * setlocal foldmethod=indent
  autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Custom key mapping
"" Cancel highlight search
nnoremap <silent> <Esc><Esc> :<C-U>nohlsearch<CR>

"" Additional undo revision
inoremap <CR> <C-G>u<CR>
inoremap <C-J> <C-G>u<C-J>
inoremap <BS> <C-G>u<BS>
inoremap <C-H> <C-G>u<C-H>
inoremap <Del> <C-G>u<Del>
inoremap <C-T> <C-G>u<C-T>
inoremap <C-D> <C-G>u<C-D>
inoremap <C-W> <C-G>u<C-W>
inoremap <C-U> <C-G>u<C-U>

inoremap <M-;> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <M-:> <C-R>=strftime("%H:%M:%S")<CR>

cnoremap <C-A> <Home>
cnoremap <C-U> <C-E><C-U>

" grep-quickfix
if has ('quickfix')
  autocmd QuickFixCmdPost *grep* cwindow
endif

" Plugin
let s:std_plugin_path = '~/.vim'
let s:alt_plugin_path = '$HOME/vimfiles'

"" NeoBundle
let s:bundle_path =
      \(isdirectory(expand(s:std_plugin_path)) ? s:std_plugin_path
      \                                        : s:alt_plugin_path)
      \. '/bundle'

if has('vim_starting') && executable('git')
  filetype off

  if isdirectory(expand(s:bundle_path))
    execute 'set runtimepath+=' . fnameescape(s:bundle_path . '/vundle/')
    call s:DefineBundles()
  endif
endif

"" Align
let g:Align_xstrlen=3

"" emmet-vim
"let g:user_emmet_leader_key='<C-Z>'

filetype plugin indent on
syntax on

source $VIMRUNTIME/macros/matchit.vim

" vim:set ts=2 sts=2 sw=2:

