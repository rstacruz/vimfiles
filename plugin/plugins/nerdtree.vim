if globpath(&rtp, "plugin/NERD_tree.vim") != ""
  nnoremap <leader>N :NERDTreeFind<CR>

  let g:NERDTreeHijackNetrw=1
  let g:NERDTreeWinPos='right'
  let g:NERDTreeQuitOnOpen=1
endif
