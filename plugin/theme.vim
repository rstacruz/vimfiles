"
" Common
"

let g:airline_theme='solarized'

"
" Console
"

if !has("gui_running")
  set background=light
  color elflord
  hi VertSplit cterm=none ctermbg=none
  hi NonText ctermfg=11
endif

"
" Macvim
"

if has("gui_running") && (has("gui_macvim") || has("gui_vimr"))
  set transparency=0
  set guioptions=
  set guioptions+=g " gray menu items
  set guioptions+=m " menu bar
  set guioptions+=e " nice gui tabs

  color Tomorrow-Night

  " set guifont=Envy\ Code\ R\ for\ Powerline:h13 noantialias linespace=0
  set guifont=InputMonoNarrow:h12 linespace=3
  let g:airline_theme='base16'
  " set guifont=Monaco:h12 linespace=0
  " set guifont=Inconsolata:h14 linespace=0
  " set guifont=Menlo:h12 linespace=0
  " set guifont=Ubuntu\ Mono:h14 linespace=0
  " set guifont=Droid\ Sans\ Mono:h10 linespace=1
endif

