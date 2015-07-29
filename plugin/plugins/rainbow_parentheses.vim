if globpath(&rtp, "plugin/rainbow_parentheses.vim") == "" | finish | endif

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
