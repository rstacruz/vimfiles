if globpath(&rtp, "plugin/NERD_tree.vim") == ""
  finish
endif

" [N] <leader>pt -- open tree
nnoremap <leader>pt :NERDTreeFind<CR>

let g:NERDTreeHijackNetrw=1
let g:NERDTreeWinPos='right'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowBookmarks=0
let g:NERDTreeMouseMode=2        " click to open
let g:NERDTreeMinimalUI=1        " hide labels
let g:NERDTreeDirArrows=1

"" [N] - -- Open tree
nnoremap - :NERDTreeFind<CR>
