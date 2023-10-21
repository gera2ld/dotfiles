" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936 fileformat=unix
set nowritebackup
set number
set visualbell t_vb=    " remove visual bell, must be reset in _gvimrc
set cmdheight=2
set updatetime=300
set shortmess+=c
set virtualedit=all
set tabstop=2 shiftwidth=2 expandtab
set list
set diffopt+=iwhite     " ignore white space on diff
" Disable code folding by Vim, use Coc instead
" set foldmethod=syntax
au FileType make setl noexpandtab

au BufNewFile,BufRead *.ejs set filetype=html

se undofile
if has('win32')
  se dir=$TEMP//
  se undodir=$TEMP//
  se mp=mingw32-make
  ru delmenu.vim
  ru menu.vim

  " Set shell to PowerShell
  if executable('pwsh')
    set shell=pwsh
  else
    set shell=powershell
  endif
  set shellquote= shellpipe=\| shellxquote=
  set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
  set shellredir=\|\ Out-File\ -Encoding\ UTF8
else
  se dir=/tmp//
  se undodir=/tmp//
endif

if has('nvim-0.7')
  set laststatus=3
endif

if !exists('g:vscode')
  ru lib/plug.vim
  ru lib/mappings.vim
  if !$VIM_DISABLE_COC_NVIM
    ru lib/coc.vim
  endif
endif

if filereadable(glob("~/.vimrc.local"))
  so ~/.vimrc.local
endif

" vim:sw=2:sts=2:fdm=marker:
