"
" Allow ^V in the console
"

if !has("gui_running")
  vmap <C-c> "+y
  vmap <C-v> "+p
  imap <C-v> <Esc>"+pi
end

"
" Remove the one-second escape key delay
" http://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay
"

set timeout timeoutlen=1000 ttimeoutlen=100

"
" List characters
"

set list
set listchars=tab:┆\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

"
" Save typos
"

command! W execute 'w'
command! Wq execute 'wq'
command! WQ execute 'wq'

"
" Up and down on wrapped lines
" http://vimbits.com/bits/25
"

nnoremap j gj
nnoremap k gk

"
" Nicer vert splits
" that's a vertical box-drawing character
"

set fillchars=vert:│    
set fillchars="vert: "


"
" :Hardwrap    -  turns on hardwrapping
" :Nohardwrap  -  turns it off
"

command! Hardwrap set fo=want tw=80 nowrap
command! Nohardwrap set fo=croq wrap linebreak nolist

"
" Fix slow Ruby editing
" http://stackoverflow.com/questions/22949067/macvim-quite-slow-when-syntax-is-set-to-ruby
"

autocmd Filetype ruby setlocal foldmethod=manual
