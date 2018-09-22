let g:toggle_key_map = {}

let g:which_key_map = {}
let g:which_key_map.a = { 'name': '+apps ' }
let g:which_key_map.a.v = { 'name': '+vim ' }
let g:which_key_map.b = { 'name': '+buffer ' }
let g:which_key_map.f = { 'name': '+file ' }
let g:which_key_map.f.e = { 'name': '+customize ' }
let g:which_key_map.e = { 'name': '+errors ' }
let g:which_key_map.g = { 'name': '+git ' }
let g:which_key_map.h = { 'name': '+help ' }
let g:which_key_map.m = { 'name': '+major ' }
let g:which_key_map.m.j = { 'name': '+javascript ' }
let g:which_key_map.m.m = { 'name': '+markdown ' }
let g:which_key_map.p = { 'name': '+project ' }
let g:which_key_map.t = { 'name': '+terminal ' }
let g:which_key_map.T = { 'name': '+theme ' }
let g:which_key_map['.'] = { 'name': '+easymotion ' }

"
" App
"

let g:which_key_map.a.l = ['LanguageClient_contextMenu()', 'language-client:menu']
nnoremap <leader>al call :LanguageClient_contextMenu()<CR>

let g:which_key_map.a.j = ['MyJournal', 'custom:open-journal']
nnoremap <leader>al :MyJournal<CR>

let g:which_key_map.a.s = ['ShowSyntaxStack', 'syntax:show-syntax-stack']
nnoremap <Leader>as :ShowSyntaxStack<CR>

let g:which_key_map.a.n = ['noh', 'noh']
nnoremap <Leader>an :noh<CR>

let g:which_key_map.a.v.r = ['source %', 'reload-file']
nnoremap <Leader>avr :source %<CR>

if exists(':terminal')
  let g:which_key_map.a.r = ['OpenRangerSplit', 'ranger']
  nnoremap <Leader>ar :OpenRangerSplit<CR>
endif

"
" Error
"

if exists(':ALEFix')
  let g:which_key_map.e.f = ['ALEFix', 'fix']
  nmap <Leader>ef <Plug>(ale_fix)

  let g:toggle_key_map.e = { 'name': '+errors' }
  let g:toggle_key_map.e.f = ['ALEToggleFixOnSave', 'toggle-fix-on-save']
  nnoremap =oef :ALEToggleFixOnSave<CR>

  let g:which_key_map.e.F = ['ALEFixSuggest', 'suggest-fixer']
  nnoremap <Leader>eF :ALEFixSuggest<CR>

  let g:which_key_map.e.v = ['ALEDetail', 'show-details']
  nnoremap <Leader>ev :ALEDetail<CR>

  let g:which_key_map.e.n = ['ALENextWrap', 'next-error']
  nnoremap <Leader>en :ALENextWrap<CR>

  let g:which_key_map.e.p = ['ALEPreviousWrap', 'previous-error']
  nnoremap <Leader>ep :ALEPreviousWrap<CR>

  let g:which_key_map.e.N = ['ALEPreviousWrap', 'previous-error']
  nnoremap <Leader>eN :ALEPreviousWrap<CR>

  let g:which_key_map.e.c = ['ALEResetBuffer', 'clear-errors']
  nnoremap <Leader>ec :ALEResetBuffer<CR>
endif

"
" Customize
"

let g:which_key_map.f.e.d = ['cd ~/.config/nvim | e init.vim', 'edit-vimrc']
nnoremap <leader>fed :cd ~/.config/nvim;<CR>:e ~/.config/nvim/init.vim<CR>

let g:which_key_map.f.e.k = ['e ~/.vim/after/plugin/key-bindings.vim', 'edit-key-bindings']
nnoremap <leader>fek :e ~/.vim/after/plugin/key-bindings.vim<CR>

let g:which_key_map.f.e.l = ['e ~/.vim/after/plugin/leader.vim', 'edit-leader-bindings']
nnoremap <leader>fel :e ~/.vim/after/plugin/leader.vim<CR>

let g:which_key_map.f.e.c = ['e ~/.vim/plugin/commands.vim', 'edit-commands']
nnoremap <leader>fec :e ~/.vim/plugin/commands.vim<CR>

let g:which_key_map.f.e.o = ['e ~/.vim/after/plugin/options.vim', 'edit-vim-options']
nnoremap <leader>feo :e ~/.vim/after/plugin/options.vim<CR>

let g:which_key_map.f.e.p = ['e ~/.vim/plugin/plugins/', 'edit-plugin-config']
nnoremap <leader>fep :e ~/.vim/plugin/plugins/<CR>

"
" Buffer
"

let g:which_key_map.b.n = [ 'bnext', 'next' ]
nnoremap <leader>bn :bnext<CR>

let g:which_key_map.b.d = [ 'bdelete', 'close' ]
nnoremap <leader>bd :bdelete<CR>

let g:which_key_map.b.D = [ 'bdelete!', 'force-close' ]
nnoremap <leader>bD :bdelete!<CR>

let g:which_key_map.b.p = [ 'bdelete!', 'previous' ]
nnoremap <leader>bp :bprev<CR>

if exists(':Buffers')
  let g:which_key_map.b.b = [ 'Buffers', 'list-buffers' ]
  nnoremap <leader>bb :Buffers<CR>

  let g:which_key_map.b.h = [ 'History', 'show-history' ]
  nnoremap <leader>bh :History<CR>
endif

"
" Project
"

if exists(':NERDTree')
  let g:which_key_map.p.t = [ 'Gcd | NERDTree', 'tree']
  nnoremap <leader>pt :Gcd<CR>:NERDTree<CR>
endif

if exists(':SClose')
  let g:which_key_map.p.P = [ 'SSave!', 'save-project']
  nnoremap <leader>pP :SSave!<CR>

  let g:which_key_map.p.p = [ 'SClose', 'switch-to-project']
  nnoremap <leader>pp :SClose<CR>
endif

if exists(':Tag')
  let g:which_key_map.p.s = [ 'Tag', 'find-symbol' ]
  nnoremap <leader>ps :Tag<CR>

  let g:which_key_map.p.f = [ 'FZF', 'find-file' ]
  nnoremap <leader>pf :FZF<cr>

  let g:which_key_map.p.F = [ 'GFiles?', 'find-file-from-status' ]
  nnoremap <leader>pF :GFiles?<CR>
endif

" nnoremap <Leader>pr :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>

"
" Terminal
"
"
if exists(':terminal')
  let g:which_key_map["'"] = [ 'split | terminal', 'open-terminal-split' ]
  nnoremap <Leader>' <C-w>n:terminal<CR>

  let g:which_key_map.t.s = [ 'split | terminal', 'open-terminal-split' ]
  nnoremap <Leader>ts <C-w>n:terminal<CR>

  let g:which_key_map.t.v = [ 'vsplit | terminal', 'open-terminal-vsplit' ]
  nnoremap <Leader>tv <C-w>v<C-w>l:terminal<CR>

  let g:which_key_map.t.t = [ 'tabnew | terminal', 'open-terminal-tab' ]
  nnoremap <Leader>tt :tabnew<CR>:terminal<CR>

  let g:which_key_map.t['.'] = [ 'terminal', 'open-terminal-here' ]
  nnoremap <Leader>t. :terminal<CR>
endif

"
" Git
"

if exists(':GFiles')
  let g:which_key_map.g.S = [ 'GFiles?', 'pick-file-from-status' ]
  nnoremap <leader>gS :GFiles?<CR>
endif

if 1 " exists(':Gstatus')
  let g:which_key_map.g.d = [ 'Gdiff', 'diff' ]
  nnoremap <leader>gd :Gdiff<cr>

  let g:which_key_map.g.b = [ 'Gblame', 'blame' ]
  nnoremap <leader>gb :Gblame<cr>

  let g:which_key_map.g.s = [ 'Gstatus', 'status' ]
  nnoremap <leader>gs :Gstatus<CR>

  let g:which_key_map.g.c = [ 'Gcommit', 'commit' ]
  nnoremap <leader>gc :Gcommit<CR>

  let g:which_key_map.g.A = [ 'Gcommit --amend', 'commit-amend' ]
  nnoremap <leader>gc :Gcommit --amend<CR>
endif

"
" Theme
"

let g:which_key_map.T.c = [ 'color', 'change-color-scheme' ]
nnoremap <leader>Tc :color<space>

let g:which_key_map.T.a = [ 'AirlineTheme', 'change-airline-scheme' ]
nnoremap <leader>Ta :AirlineTheme<space>

let g:which_key_map.T.o = [ 'ThemeOverrides', 'run-theme-overrides' ]
nnoremap <leader>To :ThemeOverrides<CR>

let g:which_key_map.T.d = [ 'Dark', 'dark-mode' ]
nnoremap <leader>Td :Dark<CR>

let g:which_key_map.T.l = [ 'Light', 'light-mode' ]
nnoremap <leader>Tl :Light<CR>

"
" Help
"

let g:which_key_map.h.k = [ 'Usage', 'open-keybindings-cheatsheet']
nnoremap <silent> <leader>hk :Usage<CR>

"
" Files
"

if exists(':Files')
  let g:which_key_map.f.f = ['Files', 'find-file']
  nnoremap <leader>ff :Files<CR>
endif

"
" Misc
"

if globpath(&rtp, "plugin/EasyMotion.vim") != ""
  let g:which_key_map['.'].j = ['<Plug>(easymotion-j)', 'line:down']
  nmap <leader>.j <Plug>(easymotion-j)
  let g:which_key_map['.'].k = ['<Plug>(easymotion-k)', 'line:up']
  nmap <leader>.k <Plug>(easymotion-k)
  let g:which_key_map['.'].w = ['<Plug>(easymotion-w)', 'word:next']
  nmap <leader>.w <Plug>(easymotion-w)
  let g:which_key_map['.'].W = ['<Plug>(easymotion-W)', 'word:prev']
  nmap <leader>.W <Plug>(easymotion-W)
  let g:which_key_map['.'].b = ['<Plug>(easymotion-b)', 'b']
  nmap <leader>.b <Plug>(easymotion-b)
  let g:which_key_map['.'].B = ['<Plug>(easymotion-B)', 'B']
  nmap <leader>.B <Plug>(easymotion-b)
  let g:which_key_map['.'].e = ['<Plug>(easymotion-e)', 'end-of-word']
  nmap <leader>.e <Plug>(easymotion-e)
  let g:which_key_map['.'].E = ['<Plug>(easymotion-E)', 'end-of-word:skip-symbols']
  nmap <leader>.E <Plug>(easymotion-E)
  let g:which_key_map['.'].f = ['<Plug>(easymotion-f)', 'character:next']
  nmap <leader>.f <Plug>(easymotion-f)
  let g:which_key_map['.'].F = ['<Plug>(easymotion-F)', 'character:prev']
  nmap <leader>.F <Plug>(easymotion-F)
  let g:which_key_map['.'].n = ['<Plug>(easymotion-n)', 'search-match:next']
  nmap <leader>.n <Plug>(easymotion-n)
  let g:which_key_map['.'].N = ['<Plug>(easymotion-N)', 'search-match:prev']
  nmap <leader>.N <Plug>(easymotion-N)
  let g:which_key_map['.'].s = ['<Plug>(easymotion-s)', 'search']
  nmap <leader>.s <Plug>(easymotion-s)
  let g:which_key_map['.'].g = { 'name': 'g' }
  let g:which_key_map['.'].g.e = ['<Plug>(easymotion-ge)', 'ge']
  nmap <leader>.ge <Plug>(easymotion-ge)
  let g:which_key_map['.'].g.E = ['<Plug>(easymotion-gE)', 'gE']
  nmap <leader>.gE <Plug>(easymotion-gE)
  vmap <leader>. <Plug>(easymotion-prefix)
endif

"
" JavaScirpt
"

if exists(':ImportJSWord')
  let g:which_key_map.m.j.w = ['ImportJSWord', 'import-js:import-word']
  nnoremap <leader>mjw :ImportJSWord<CR>

  let g:which_key_map.m.j.f = ['ImportJSFix', 'import-js:fix-this-file']
  nnoremap <leader>mjf :ImportJSFix<CR>

  let g:which_key_map.m.j.g = ['ImportJSGoto', 'import-js:goto-module-on-cursor']
  nnoremap <leader>mjg :ImportJSGoto<CR>
endif

if exists(':TableFormat')
  let g:which_key_map.m.m.f = ['TableFormat', 'format-table']
  nnoremap <leader>mmf :TableFormat<CR>
endif

if exists(':Toc')
  let g:which_key_map.m.m.t = ['Toc', 'update-toc']
  nnoremap <leader>mmt :Toc<CR>
endif

if exists(':LivedownPreview')
  let g:which_key_map.m.m.v = ['LivedownPreview', 'livedown-preview']
  nnoremap <leader>mmv :LivedownPreview<CR>

  let g:which_key_map.m.m.V = ['LivedownKill', 'livedown-kill']
  nnoremap <leader>mmV :LivedownKill<CR>
endif

if exists(':Ag')
  let g:which_key_map['/'] = [ 'Ag', 'grep' ]
  nnoremap <leader>/ :Ag<CR>

  nnoremap <leader>* :Ag <C-r><C-w><CR>
  vnoremap <leader>* y:Ag <C-r>"<C-b><CR>
endif

"
" Done
"

if exists(':WhichKey')
  call which_key#register('=', 'g:toggle_key_map')
  call which_key#register(' ', 'g:which_key_map')
  call which_key#register(',', 'g:which_key_map')
end

if exists(':WhichKey')
  " Unbind `,,` which does something I forgot.
  " Map it before unmapping to supress a warning
  nmap ,, <CR>
  nunmap ,,

  " space will open a menu immediately
  nnoremap <silent> <leader> :WhichKey ','<CR>

  " , will only open a menu after a delay
  nnoremap <silent> <space> :WhichKey ','<CR>
  vnoremap <silent> <leader> :WhichKeyVisual '<space>'<CR>
end
