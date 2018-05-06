if globpath(&rtp, "plugin/NERD_tree.vim") == ""
  finish
endif

" [N] <leader>0 -- open tree
" [N] <leader>pt -- open tree
nnoremap <leader>0 :NERDTreeFind<CR>
nnoremap <leader>pt :NERDTree<CR>

let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinPos='right'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowBookmarks=0
let g:NERDTreeMouseMode=2        " click to open
let g:NERDTreeMinimalUI=1        " hide labels
let g:NERDTreeDirArrows=1
