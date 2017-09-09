if globpath(&rtp, "plugin/splitjoin.vim") == "" | finish | endif

"" [N] gJ -- Splitjoin: join multiline statement (like J)
"" [N] gS -- Splitjoin: split multiline statement
nmap gJ :SplitjoinJoin<cr>
nmap gS :SplitjoinSplit<cr>
