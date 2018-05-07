if globpath(&rtp, "plugin/fugitive.vim") == ""
  finish
endif

"" [N] <leader>gs -- Fugitive: git status
"" [N] <leader>gb -- Fugitive: git blame
"" [N] <leader>gd -- Fugitive: git diff
"" [Fugitive] D -- Fugitive: diff
"" [Fugitive] dv -- Fugitive: diff vertically
"" [Fugitive] cc -- Fugitive: commit
"" [Fugitive] ca -- Fugitive: commit amend
"" [Fugitive] cA -- Fugitive: commit amend no message
nmap <leader>gs :Gstatus<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gb :Gblame<cr>
