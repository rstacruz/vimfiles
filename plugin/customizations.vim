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
nnoremap ,Z zMzvzz
" Isolate current fold, and unfold its siblings
nnoremap ,V zMzvzazOzz

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
nnoremap <silent> <Space> :set foldenable<CR>@=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" == Highlight spaces ========================================================
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" == Improve CtrlP performance ===============================================
" http://vimbits.com/bits/378

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpeg|jpg|png|gif|mo|po" .
    \ ")|" .
    \ "^(\\./)?(" .
    \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/|.*/\.gitkeep" .
    \ ")'"

let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps

if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/.*/*' | " .
    \ ctrlp_filter_greps
endif

" let g:ctrlp_user_command = my_ctrlp_user_command
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', my_ctrlp_git_command]
  \ },
  \ 'fallback': my_ctrlp_user_command
  \ }

" == Escape key ==============================================================
" Remove the one-second escape key delay
" http://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay

set timeout timeoutlen=1000 ttimeoutlen=100

" == Auto cursorline =========================================================

autocmd InsertLeave * se nocursorline
autocmd InsertEnter * se cursorline

" == Cursor changes in tmux ==================================================
" Use a bar-shaped cursor for insert mode, even through tmux.
" https://github.com/sjl/vitality.vim/issues/3
" http://pastebin.com/ZtEfsmcD

set showcmd
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
