if globpath(&rtp, "plugin/fugitive.vim") == ""
  finish
endif

nmap <leader>gs :Gstatus<cr>
nmap <leader>gp :Dispatch git push<cr>
