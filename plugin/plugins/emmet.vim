if globpath(&rtp, "plugin/emmet.vim") == ""
  finish
endif

"" [I] <C-e> -- Emmet: expand
"" [V] <C-e> -- Emmet: expand
imap <C-e> <C-y>,
vmap <C-e> <C-y>,
