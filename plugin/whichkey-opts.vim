if globpath(&rtp, "autoload/which_key.vim") == "" | finish | endif

call which_key#register(',', 'g:which_key_map')
call which_key#register('g', 'g:which_key_g')

set timeoutlen=100

" Map for leader
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>

" Map for <g>
" messes with gf, meh
" nnoremap <silent> g :<c-u>WhichKey 'g'<CR>
" vnoremap <silent> g :<c-u>WhichKeyVisual 'g'<CR>

" Default is  →
let g:which_key_sep = '·'

" Flush out the margins to the left-right
let g:which_key_floating_opts = { 'col': '-3', 'row': '+2', 'width': '+3' }

" Exit with , (the leader key)
let g:which_key_exit = ['<C-[>', '<Esc>', ',']

" Make it more compact
let g:which_key_hspace = 2

" Let 'gg' work
let g:which_key_fallback_to_native_key = 1

" Vertical mode
let g:which_key_floating_opts = { 'col': '-3', 'row': '+2', 'width': '30' }
let g:which_key_vertical = 0
