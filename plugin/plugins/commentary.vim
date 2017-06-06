if globpath(&rtp, "plugin/commentary.vim") == ""
  finish
endif

"" [V] /  -- Commentary: comment selection
vmap / gc
