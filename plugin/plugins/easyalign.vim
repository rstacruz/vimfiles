if globpath(&rtp, "plugin/easy_align.vim") == ""
  finish
endif

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
