if globpath(&rtp, "plugin/neomake.vim") == "" | finish | endif

autocmd! BufWritePost * Neomake
