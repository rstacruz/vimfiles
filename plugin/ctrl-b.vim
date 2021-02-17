" Tmux refugee pack
" =================

if !has('nvim')
  finish
endif

" New terminal
nnoremap <silent> <C-b><C-s> :new<CR><Esc><C-w>r:term<CR>
nnoremap <silent> <C-b><C-v> :vnew<CR><Esc><C-w>r:term<CR>
nnoremap <silent> <C-b><C-t> :tabnew<CR><Esc>:term<CR>

" Alternatives to `c-w v` and `c-w s`
nnoremap <silent> <C-b>v :wincmd v<CR>:wincmd l<CR>
nnoremap <silent> <C-b>s :wincmd s<CR>:wincmd j<CR>
nnoremap <silent> <C-b>c :tabnew<CR>:Startify<CR>

" New terminal (in terminal)
tnoremap <silent> <C-b><C-s> <C-\><C-n>:new<CR><Esc><C-w>r:term<CR>
tnoremap <silent> <C-b><C-v> <C-\><C-n>:vnew<CR><Esc><C-w>r:term<CR>
tnoremap <silent> <C-b><C-t> <C-\><C-n>:tabnew<CR><Esc>:term<CR>
tnoremap <silent> <C-b>c     <C-\><C-n>:tabnew<CR><Esc>:Startify<CR>

" Kill
nnoremap <silent> <C-b><C-x> :bwipeout!<CR>
tnoremap <silent> <C-b><C-x> <C-\><C-n>:bwipeout!<CR>

" Next tab
nnoremap <silent> <C-b><C-n> gt
tnoremap <silent> <C-b><C-n> <C-\><C-n><Esc>gt

" Rotate
nnoremap <silent> <C-b><C-o> <C-w>w
tnoremap <silent> <C-b><C-o> <C-\><C-n><C-w>w

" Arrows
nnoremap <silent> <C-b><C-j> <C-w>j
nnoremap <silent> <C-b><C-k> <C-w>k
nnoremap <silent> <C-b><C-h> <C-w>h
nnoremap <silent> <C-b><C-l> <C-w>l
nnoremap <silent> <C-b>J <C-w>J
nnoremap <silent> <C-b>K <C-w>K
nnoremap <silent> <C-b>H <C-w>H
nnoremap <silent> <C-b>L <C-w>L

" Arrows (in terminal)
tnoremap <silent> <C-b><C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-b><C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-b><C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-b><C-l> <C-\><C-n><C-w>l
tnoremap <silent> <C-b>J <C-\><C-n><C-w>J
tnoremap <silent> <C-b>K <C-\><C-n><C-w>K
tnoremap <silent> <C-b>H <C-\><C-n><C-w>H
tnoremap <silent> <C-b>L <C-\><C-n><C-w>L

" Make ctrl-w commands work inside terminals
tnoremap <silent> <C-w><C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-w><C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-w><C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-w><C-l> <C-\><C-n><C-w>l
tnoremap <silent> <C-w>j <C-\><C-n><C-w>j
tnoremap <silent> <C-w>k <C-\><C-n><C-w>k
tnoremap <silent> <C-w>h <C-\><C-n><C-w>h
tnoremap <silent> <C-w>l <C-\><C-n><C-w>l
tnoremap <silent> <C-w>J <C-\><C-n><C-w>J
tnoremap <silent> <C-w>K <C-\><C-n><C-w>K
tnoremap <silent> <C-w>H <C-\><C-n><C-w>H
tnoremap <silent> <C-w>L <C-\><C-n><C-w>L

" Escape
tnoremap <C-b><C-e> <Esc>

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

" Just like screen
" nmap <C-a> <C-b>
" nmap <C-a><C-a> <C-a>
