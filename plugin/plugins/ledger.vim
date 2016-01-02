if globpath(&rtp, "ftplugin/ledger.vim") == "" | finish | endif

augroup ledger
  au!
  au FileType ledger nnoremap <silent> <Leader>lA :%LedgerAlign<CR>
  au FileType ledger nnoremap <silent> <Leader>la vip:LedgerAlign<CR>
  au FileType ledger nnoremap <silent> <Leader>lc :call ledger#transaction_state_set(line('.'), '*')<CR>
  au FileType ledger nnoremap <silent> <Leader>lp :call ledger#transaction_state_set(line('.'), '!')<CR>
augroup END

let g:ledger_fold_blanks=1
