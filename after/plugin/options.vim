" Startinsert on git
if $GIT_AUTHOR_DATE != '' | startinsert | endif

if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != '' | finish | endif

if !has('gui_running')
  set t_Co=256
endif

" Wildignore
set wig+=vendor,log,logs
set wig+=node_modules

" Spelling
set spellfile=~/.vim/spell/en.utf-8.add

" No line numbers by default (=on to enable)
set nonumber

" hide the scroll position
set noruler

" Remove the one-second escape key delay
" http://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay
set timeout timeoutlen=200 ttimeoutlen=10

" minimal status bar for small windows
if $MINIMAL_PROMPT != ''
  set laststatus=0
endif

" minimal status
set laststatus=0

" Autoreload when changing from disk
" https://superuser.com/a/1090762
set autoread
au CursorHold * checktime

" Use old regex engine
set re=1
