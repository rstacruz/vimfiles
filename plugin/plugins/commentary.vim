if globpath(&rtp, "plugin/commentary.vim") == ""
  finish
endif

vmap / gc
