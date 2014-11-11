if globpath(&rtp, "plugin/fugitive.vim") != ""
  nmap <leader>gs :Gstatus<cr>
  nmap <leader>gp :Dispatch git push<cr>
endif
