if globpath(&rtp, "ftplugin/ledger.vim") == "" | finish | endif

nnoremap <Leader>lA :%LedgerAlign<CR>
nnoremap <Leader>la vip:LedgerAlign<CR>
