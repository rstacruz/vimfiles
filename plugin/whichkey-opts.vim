if globpath(&rtp, "autoload/which_key.vim") == "" | finish | endif

call which_key#register(',', 'g:which_key_map')
call which_key#register('g', 'g:which_key_g')

set timeoutlen=50

nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>

" Default is  →
let g:which_key_sep = '·'

" Flush out the margins to the left-right
let g:which_key_floating_opts = { 'col': '-3', 'row': '+2', 'width': '+3' }

" Exit with , (the leader key)
let g:which_key_exit = ['\<C-[>', '\<Esc>', ',']

" Make it more compact
let g:which_key_hspace = 2
