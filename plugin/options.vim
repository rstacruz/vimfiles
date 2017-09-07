runtime! plugin/sensible.vim
runtime! plugin/opinion.vim

if !has('gui_running')
  set t_Co=256
endif
set wig+=vendor,log,logs
set wig+=node_modules
set spellfile=~/.vim/spell/en.utf-8.add

" No status bar
if $VIM_MINIMAL != ''
  set laststatus=0
endif

" TODO: evaluate if this is ok
set nonumber
