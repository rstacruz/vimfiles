if globpath(&rtp, "plugin/unite-cmdmatch.vim") == "" | finish | endif

cm <c-o> <Plug>(unite_cmdmatch_complete)
