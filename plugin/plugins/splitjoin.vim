"" [N] gJ -- Go: join multiline statement (like J) [splitjoin]
"" [N] gS -- Go: split multiline statement [splitjoin]

if globpath(&rtp, "plugin/splitjoin.vim") != ""
  nmap gJ :SplitjoinJoin<cr>
  nmap gS :SplitjoinSplit<cr>
endif
