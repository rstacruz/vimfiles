if globpath(&rtp, "plugin/test.vim") == "" | finish | endif

let test#ruby#rspec#executable = 'spring rspec'

nnoremap <Leader>TT :w<CR>:TestFile -strategy=vimux<CR>
nnoremap <Leader>TN :w<CR>:TestNearest -strategy=vimux<CR>
imap <C-s> <Esc><Leader>TT
nmap <C-s> <Leader>TT
