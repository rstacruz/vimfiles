if globpath(&rtp, "plugin/fzf.vim") == "" | finish | endif

nnoremap  <C-p> :FZF<cr>
