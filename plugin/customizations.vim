scriptencoding utf-8
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

"
" Save typos
" http://blog.sanctum.geek.nz/vim-command-typos/
"

if has("user_commands")
  command! -bang -nargs=? -complete=file E e<bang> <args>
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif

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

"
" Useful for creating color schemes
"

nmap <Leader>SS :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

"
" Embiggen
"

command! Big call <SID>embiggen()

function! s:embiggen()
  set guifont=Monaco:h20
  set fullscreen
  Goyo 80
endfunction

"
" Opinion extensions
"

set tabstop=2
set foldnestmax=3        " don't overfold
set fillchars=fold:·     " improve appearance of folds
set list
set listchars=tab:·\ ,trail:—,nbsp:␣,extends:>,precedes:<
set showbreak=↪

if has('nvim')
  " Show search/replace results incrementally
  set inccommand=nosplit
endif
