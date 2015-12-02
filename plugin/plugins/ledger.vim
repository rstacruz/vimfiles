if globpath(&rtp, "ftplugin/ledger.vim") == "" | finish | endif

nnoremap <Leader>la :%LedgerAlign<CR>
