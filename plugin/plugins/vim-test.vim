if globpath(&rtp, "plugin/test.vim") == "" | finish | endif

let test#ruby#rspec#executable = 'spring rspec'
let test#strategy = 'neovim'

nnoremap <Leader>TT :w<CR>:TestFile<CR>
nnoremap <Leader>TN :w<CR>:TestNearest<CR>
imap <C-s> <Esc><Leader>TT
nmap <C-s> <Leader>TT
