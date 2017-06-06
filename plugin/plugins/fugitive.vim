if globpath(&rtp, "plugin/fugitive.vim") == ""
  finish
endif

"" [N] <leader>gs -- Fugitive: git status
"" [N] <leader>gb -- Fugitive: git blame
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
