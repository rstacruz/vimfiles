" you can toggle folds open/closed by pressing F1. In addition, if you have
" :set foldmethod=manual, you can visually select some lines, then press F1 to
" create a fold.
noremap <F1> <C-O>za
nnoremap <F1> za
onoremap <F1> <C-C>za
vnoremap <F1> zf

" In normal mode, press Space to toggle the current fold open/closed. If the
" cursor is not in a fold, move to the right (the default behavior). In
" addition, with the manual fold method, you can create a fold by visually
" selecting some lines, then pressing Space.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
