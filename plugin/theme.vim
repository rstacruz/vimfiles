"
" Console
"

if !has("gui_running")
  set background=light
  if has("gui")
    color ir_black+
  endif
endif

"
" Macvim
"

if has("gui_running") && has("gui_macvim")
  set transparency=0
  set guioptions=gmt
  color Tomorrow-Night

  " set guifont=Envy\ Code\ R\ for\ Powerline:h13 noantialias linespace=0
  set guifont=InputMonoNarrow:h12 linespace=3
  " set guifont=Monaco:h12 linespace=0
  " set guifont=Inconsolata:h14 linespace=0
  " set guifont=Menlo:h12 linespace=0
  " set guifont=Ubuntu\ Mono:h14 linespace=0
  " set guifont=Droid\ Sans\ Mono:h10 linespace=1
endif

