if globpath(&rtp, "ftplugin/ledger.vim") == "" | finish | endif

nnoremap <silent> <Leader>lA :%LedgerAlign<CR>
nnoremap <silent> <Leader>la vip:LedgerAlign<CR>
nnoremap <silent> <Leader>lc :call ledger#transaction_state_set(line('.'), '*')<CR>
nnoremap <silent> <Leader>lp :call ledger#transaction_state_set(line('.'), '!')<CR>

let g:ledger_fold_blanks=1
