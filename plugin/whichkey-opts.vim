if globpath(&rtp, "autoload/which_key.vim") == "" | finish | endif

" call which_key#register(',', 'g:which_key_map')
call which_key#register('<Space>', 'g:which_key_map')
call which_key#register('<CR>', 'g:which_key_cr')

set timeoutlen=100
let g:which_key_timeout = 0

" Map for leader
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <space> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <space> :<c-u>WhichKeyVisual '<Space>'<CR>

" Map for <g>
" messes with gf, meh
" nnoremap <silent> g :<c-u>WhichKey 'g'<CR>
" vnoremap <silent> g :<c-u>WhichKeyVisual 'g'<CR>

" Default is  →
let g:which_key_sep = '›'

" Flush out the margins to the left-right
let g:which_key_floating_opts = {}
let g:which_key_disable_default_offset = 1

" Open in current window
" let g:which_key_floating_relative_win = 1

" Exit
let g:which_key_exit = ['<C-[>', '<Esc>']

" Make it more compact
let g:which_key_hspace = 2

" Let 'gg' work
let g:which_key_fallback_to_native_key = 1

" Vertical mode
let g:which_key_vertical = 0

" Folders first
let g:which_key_group_dicts = 'start'
