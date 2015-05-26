if globpath(&rtp, "plugin/emmet.vim") == ""
  finish
endif

imap <C-e> <C-y>,
