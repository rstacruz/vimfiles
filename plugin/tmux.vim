" Repeat last command in the next tmux pane.
" Open a tmux pane and type your test command (eg, `npm test`), then use
" <leader>r to repeat the command in that pane.
nnoremap <Leader>r :call <SID>TmuxRepeat()<CR>

function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
  redraw!
endfunction

inoremap <C-s> <Esc>:w<CR>:call <SID>TmuxRepeat()<CR>a
noremap  <C-s> :w<CR>:call <SID>TmuxRepeat()<CR>
