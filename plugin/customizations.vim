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

" == Writeroom, kind of ======================================================

command! Focus set wrap linebreak nolist noruler nonumber laststatus=1

" For soft-wrapping
command! Wrap set wrap linebreak nolist
command! Nowrap set nowrap

" For hard-wrapping
command! Hardwrap set fo=want tw=80
command! Nohardwrap set fo=croq

" == Focus on current fold ===================================================

" Isolate current fold
nnoremap ,z zMzvzz
" Isolate current fold, and unfold its siblings
nnoremap ,Z zMzvzazOzz

" == Better commandline editing ==============================================
" http://vimbits.com/bits/30

cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" == Folding =================================================================

" In normal mode, press Space to toggle the current fold open/closed. If the
" cursor is not in a fold, move to the right (the default behavior). In
" addition, with the manual fold method, you can create a fold by visually
" selecting some lines, then pressing Space.
" (za = toggle fold, zA = toggle recursively)
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf

" == Highlight spaces ========================================================
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
