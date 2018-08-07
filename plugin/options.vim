runtime! plugin/sensible.vim
runtime! plugin/opinion.vim

if !has('gui_running')
  set t_Co=256
endif
set wig+=vendor,log,logs
set wig+=node_modules
set spellfile=~/.vim/spell/en.utf-8.add

" No status bar for git
if $VIM_MINIMAL != '' || $GIT_DIR != ''
  set laststatus=0
endif

if $GIT_DIR != ''
  startinsert
endif

" No line numbers by default (=on to enable)
set nonumber

" Remove the one-second escape key delay
" http://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay
set timeout timeoutlen=500 ttimeoutlen=10

if exists('g:gui_oni')
  set laststatus=0
endif
