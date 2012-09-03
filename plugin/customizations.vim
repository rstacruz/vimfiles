" == Typos ===================================================================

command! W execute 'w'
command! Wq execute 'wq'
command! WQ execute 'wq'

" == Autoreload vimrc ========================================================
" Auto-reload .vimrc when it's saved.
" http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload

autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc.vim source %

" == Console pasting =========================================================
" Allow ^V in the console.

if !has("gui_running")
  vmap <C-c> "+y

  vmap <C-v> "+p
  imap <C-v> <Esc>"+pi
end

" == Number toggle ===========================================================
" Toggle numbers using ^N.

if !exists('g:loaded_numbertoggle')
  function! g:ToggleNuMode()
    if (&rnu == 1)
      set nu
      highlight LineNr gui=none term=none
    else
      set rnu
      highlight LineNr gui=reverse term=reverse
    endif
  endfunction

  nnoremap <C-n> :call g:ToggleNuMode()<Cr>
endif

" == Sudo write ==============================================================
" Sudo write when you forgot to `sudo vim`
" http://www.commandlinefu.com/commands/view/1204/save-a-file-you-edited-in-vim-without-the-needed-permissions

com! -nargs=* Sudow w !sudo tee >/dev/null %
cmap w!! %!sudo tee > /dev/null %

" == Make up/down movement behave better on wrapped lines ====================
" http://vimbits.com/bits/25

nnoremap j gj
nnoremap k gk

" == MacVim: Three-finger swipe ==============================================

map <SwipeLeft> :bprev<CR>
map <SwipeRight> :bnext<CR>

" == Visible tabs ============================================================
" That's an NBSP

set list
set listchars=tab:┆\ ,extends:…,precedes:…

" == Auto-use \v on regex ====================================================
" Just press / on normal mode

nnoremap / /\v

" == Tag select ==============================================================
" Find definition of a class using TClassName<Enter>

nnoremap T :tjump 

" == Noh =====================================================================

nnoremap <F2> :noh<Cr>
inoremap <F2> <Esc>:noh<Cr>i

" == Nicer vert splits =======================================================

set fillchars=vert:│    " that's a vertical box-drawing character
set fillchars="vert: "
