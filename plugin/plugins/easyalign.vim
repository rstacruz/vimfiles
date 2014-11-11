if globpath(&rtp, "plugin/easy_align.vim") != ""
  vmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)
endif
