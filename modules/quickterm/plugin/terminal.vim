" Open a terminal in a split window
command! Quickterm :call quickterm#open()

if has('nvim')
  au TermClose *Quickterm* bwipe!
endif
