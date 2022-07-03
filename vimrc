"scriptencoding utf-8
" vi: ts=2 sts=2 sw=2

let $LANG = "en"

function! s:DefineBundles()
  call vundle#rc(expand(s:bundle_path))

  Plugin 'gmarik/vundle'

  Plugin 'jiangmiao/simple-javascript-indenter'
  Plugin 'align'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-abolish'
  Plugin 'tomasr/molokai'
  Plugin 'mattn/emmet-vim'

  return
endfunction

set nobackup
set noundofile
set nofixeol
set directory-=.
set directory^=~/vimfiles/swap//
set number
set hidden
set colorcolumn=100,+0
set encoding=utf-8
set showcmd
set showmatch
set laststatus=2
set statusline=%m#%n\ %<%f\ %y\ %q%([%H%R%W]%)%={%{v:register}}\ '0x%B'\ [%{&ff}%{&eol?'':',noeol'},%{strlen(&fenc)?&fenc:'-'}%{&bomb?'+BOM':''}]\ %-20.(%l/%LL,\ %vC%)%P
set cursorline
set wildmenu
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
set history=1000
"set autochdir
"let mapleader = "\<SPACE>"
let mapleader = ","

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
"nnoremap / /\v
"nnoremap ? ?\v
"cnoremap %s/ %s/\v
"cnoremap %s; %s;\v
"nnoremap <leader>s :s/\v
"nnoremap <leader>ms :%s/\v
"vnoremap <leader>s :s/\v

" For Japanese
set ambiwidth=double
set display+=lastline

" Color
" Ref: https://vim-jp.org/vim-users-jp/2009/07/12/Hack-40.html
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter,BufRead * match IdeographicSpace /　/
augroup END

" Highlight non-printable character
" Ref: https://stackoverflow.com/questions/16987362/how-to-get-vim-to-highlight-non-ascii-characters
" Example: Alt+Enter -> 0x8D
"highlight nonascii guibg=Red ctermbg=1 term=standout
"au VimEnter,WinEnter,BufRead * syntax match nonascii "[^\u0000-\u00FF]"

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
" Cancel highlight search
nnoremap <silent> <Esc><Esc> :<C-U>nohlsearch<CR>
nnoremap <silent> <F2> :Lexplore<CR>
nnoremap <silent> <leader>e :Explore<CR>
let g:netrw_liststyle = 3
"nnoremap <F5> :buffers<CR>:b<Space>
nnoremap <leader>l :ls<CR>:b<Space>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
" Delete a buffer without losing the split window.
" Ref: https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window/26719470
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Additional undo revision
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

" Gnu Readline like shortcuts
cnoremap <C-A> <Home>
" Ref: https://unix.stackexchange.com/questions/408980/delete-to-end-of-command-line-in-vim
" Another solution: https://stackoverflow.com/questions/26310401/in-vim-command-line-mode-how-to-kill-the-line-from-the-current-cursor-position
cnoremap <C-K> <C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>
cnoremap <F5> <C-E><C-U>cd %:p:h<CR>

" Search for selected text, forwards or backwards.
" Ref: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" git commit message editor
" Ref: https://qiita.com/ak60414/items/b21b8f9ab976b0edd6ab
autocmd BufReadPre */.git/COMMIT_EDITMSG,*/.git/TAG_EDITMSG,*/.git/git-rebase-todo
  \ setlocal fileencoding=utf-8

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
