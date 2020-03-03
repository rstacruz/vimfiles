" if globpath(&rtp, "plugin/test.vim") == "" | finish | endif

if has('nvim')
  let test#strategy = 'neovim'
  let test#neovim#term_position = "vert botright"
endif

" let g:test#ruby#rspec#executable = 'foreman run rspec'
" let test#enabled_runners = ["mylanguage#myrunner", "ruby#rspec"]
