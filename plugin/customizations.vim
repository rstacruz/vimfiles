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
" Fix slow Ruby editing
" http://stackoverflow.com/questions/22949067/macvim-quite-slow-when-syntax-is-set-to-ruby
"

autocmd Filetype ruby setlocal foldmethod=manual

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

  " Start insert mode automatically on terminal open
  " augroup custom_term
  "   autocmd!
	autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal buflisted
	" autocmd TermOpen * setlocal bufhidden=hide
  " augroup END
endif
