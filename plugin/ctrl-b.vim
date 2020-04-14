" Tmux refugee pack
" =================

if !has('nvim')
  finish
endif

" New terminal
nnoremap <C-b><C-s> :new<CR><Esc><C-w>r:term<CR>
nnoremap <C-b><C-v> :vnew<CR><Esc><C-w>r:term<CR>
nnoremap <C-b><C-t> :tabnew<CR><Esc>:term<CR>
nnoremap <C-b>c     :tabnew<CR><Esc>:term<CR>

" New terminal (in terminal)
tnoremap <C-b><C-s> <C-\><C-n>:new<CR><Esc><C-w>r:term<CR>
tnoremap <C-b><C-v> <C-\><C-n>:vnew<CR><Esc><C-w>r:term<CR>
tnoremap <C-b><C-t> <C-\><C-n>:tabnew<CR><Esc>:term<CR>
tnoremap <C-b>c     <C-\><C-n>:tabnew<CR><Esc>:term<CR>

" Kill
nnoremap <C-b><C-x> :bwipeout!<CR>
tnoremap <C-b><C-x> <C-\><C-n>:bwipeout!<CR>

" Next tab
nnoremap <C-b><C-n> gt
tnoremap <C-b><C-n> <C-\><C-n><Esc>gt

" Rotate
nnoremap <C-b><C-o> <C-w>w
tnoremap <C-b><C-o> <C-\><C-n><C-w>w

" Arrows
nnoremap <C-b><C-j> <C-w>j
nnoremap <C-b><C-k> <C-w>k
nnoremap <C-b><C-h> <C-w>h
nnoremap <C-b><C-l> <C-w>l
nnoremap <C-b>J <C-w>J
nnoremap <C-b>K <C-w>K
nnoremap <C-b>H <C-w>H
nnoremap <C-b>L <C-w>L

" Arrows (in terminal)
tnoremap <C-b><C-j> <C-\><C-n><C-w>j
tnoremap <C-b><C-k> <C-\><C-n><C-w>k
tnoremap <C-b><C-h> <C-\><C-n><C-w>h
tnoremap <C-b><C-l> <C-\><C-n><C-w>l
tnoremap <C-b>J <C-\><C-n><C-w>J
tnoremap <C-b>K <C-\><C-n><C-w>K
tnoremap <C-b>H <C-\><C-n><C-w>H
tnoremap <C-b>L <C-\><C-n><C-w>L

" Make ctrl-w commands work inside terminals
tnoremap <C-w><C-j> <C-\><C-n><C-w>j
tnoremap <C-w><C-k> <C-\><C-n><C-w>k
tnoremap <C-w><C-h> <C-\><C-n><C-w>h
tnoremap <C-w><C-l> <C-\><C-n><C-w>l
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>J <C-\><C-n><C-w>J
tnoremap <C-w>K <C-\><C-n><C-w>K
tnoremap <C-w>H <C-\><C-n><C-w>H
tnoremap <C-w>L <C-\><C-n><C-w>L

augroup CtrlB
  au!
  au WinEnter term://* startinsert
  au TermOpen,TermEnter * startinsert
  " au TermEnter term://*/bin/fish set statusline=Terminal
augroup END

augroup TermRename
  au!
  au TermEnter term://*/bin/fish exe 'file Shell\ (' . b:terminal_job_id . ')'
augroup END
