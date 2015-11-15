if globpath(&rtp, "plugin/fastunite.vim") == "" | finish | endif

let g:fastunite_default_options = {}
call extend(g:fastunite_default_options, {
  \   'direction': 'botright',
  \   'prompt_direction': 'top',
  \   'winheight': 10
  \ })
