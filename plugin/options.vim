runtime! plugin/sensible.vim
runtime! plugin/opinion.vim

if !has('gui_running')
  set t_Co=256
endif
set wig+=vendor,log,logs
set wig+=node_modules
set spellfile=~/.vim/spell/en.utf-8.add
