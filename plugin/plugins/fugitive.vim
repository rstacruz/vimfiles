if globpath(&rtp, "plugin/fugitive.vim") == ""
  finish
endif

"" [N] <leader>gs -- Fugitive: git status
"" [N] <leader>gb -- Fugitive: git blame
"" [Fugitive] D -- Fugitive: diff
"" [Fugitive] dv -- Fugitive: diff vertically
"" [Fugitive] cc -- Fugitive: commit
"" [Fugitive] ca -- Fugitive: commit amend
"" [Fugitive] cA -- Fugitive: commit amend no message
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
