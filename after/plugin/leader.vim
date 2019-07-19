if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != '' | finish | endif

" vim:foldmethod=marker
let g:toggle_key_map = {}
let g:which_key_map = {}

" Top-level menu {{{
let g:which_key_map.a = { 'name': '+apps ' }
let g:which_key_map.c = { 'name': '+coc ' }
let g:which_key_map.a.c = { 'name': '+cartographer ' }
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
let g:which_key_map.w = { 'name': '+window ' }
let g:which_key_map['.'] = { 'name': '+easymotion ' }

" }}}
" [a] App {{{

let g:which_key_map.a.c.f = ['lua require("cartographer").files()', 'files']
nnoremap <leader>acf :lua require("cartographer").files()<CR>

let g:which_key_map.a.c.p = ['lua require("cartographer").project()', 'project']
nnoremap <leader>acp :lua require("cartographer").project()<CR>

let g:which_key_map.a.s = ['ShowSyntaxStack', 'syntax:show-syntax-stack']
nnoremap <Leader>as :ShowSyntaxStack<CR>

let g:which_key_map.a.a = ['Ag!', 'ag:search']
nnoremap <Leader>aa :Ag!<CR>

let g:which_key_map.a.a = ['Ag!', 'ag:search']
nnoremap <Leader>aA :Ag! <C-r><C-w><CR>

let g:which_key_map.a.g = ['Goyo', 'goyo:toggle']
nnoremap <Leader>ag :Goyo<CR>

" let g:which_key_map.a.n = ['noh', 'noh']
" nnoremap <Leader>an :noh<CR>

let g:which_key_map.a.v.r = ['source %', 'reload-file']
nnoremap <Leader>avr :source %<CR>

if exists(':terminal')
  let g:which_key_map.a.r = ['ranger', 'ranger']
  nnoremap <Leader>ar :Ranger<CR>

  let g:which_key_map.a.t = ['tig', 'tig']
  nnoremap <Leader>at :new<CR><C-w>_:terminal env EDITOR="nvr -s --remote-wait" tig<CR>

  let g:which_key_map.a.n = ['nnn', 'nnn']
  nnoremap <Leader>an :new<CR><C-w>_:terminal env EDITOR="nvr -s --remote-wait" nnn<CR>
endif

" }}}
" [e] Error {{{

if exists(':ALEFix')
  let g:which_key_map.e.f = ['ALEFix', 'fix']
  nmap <Leader>ef <Plug>(ale_fix)

  let g:toggle_key_map.e = { 'name': '+errors' }
  let g:toggle_key_map.e.f = ['ALEToggleFixOnSave', 'toggle-fix-on-save']
  nnoremap =of :ALEToggleFixOnSave<CR>
  nnoremap yof :ALEToggleFixOnSave<CR>

  let g:which_key_map.e.F = ['ALEFixSuggest', 'suggest-fixer']
  nnoremap <Leader>eF :ALEFixSuggest<CR>

  let g:which_key_map.e.v = ['ALEInfo', 'show-info']
  nnoremap <Leader>ev :ALEInfo<CR>

  let g:which_key_map.e.V = ['ALEDetail', 'show-details']
  nnoremap <Leader>eV :ALEDetail<CR>

  let g:which_key_map.e.n = ['ALENextWrap', 'next-error']
  nnoremap <Leader>en :ALENextWrap<CR>

  let g:which_key_map.e.p = ['ALEPreviousWrap', 'previous-error']
  nnoremap <Leader>ep :ALEPreviousWrap<CR>

  let g:which_key_map.e.N = ['ALEPreviousWrap', 'previous-error']
  nnoremap <Leader>eN :ALEPreviousWrap<CR>

  let g:which_key_map.e.c = ['ALEResetBuffer', 'clear-errors']
  nnoremap <Leader>ec :ALEResetBuffer<CR>
endif

" }}}
" [fe] Customize {{{

let g:which_key_map.f.e.d = ['cd ~/.config/nvim | e init.vim', 'edit-vimrc']
nnoremap <leader>fed :cd ~/.config/nvim;<CR>:e ~/.config/nvim/init.vim<CR>

let g:which_key_map.f.e.k = ['e ~/.vim/after/plugin/key-bindings.vim', 'edit-key-bindings']
nnoremap <leader>fek :e ~/.vim/after/plugin/key-bindings.vim<CR>

let g:which_key_map.f.e.t = ['e ~/.vim/plugin/theme.vim', 'edit-theme-overrides']
nnoremap <leader>fet :e ~/.vim/plugin/theme.vim<CR>

let g:which_key_map.f.e.l = ['e ~/.vim/after/plugin/leader.vim', 'edit-leader-bindings']
nnoremap <leader>fel :e ~/.vim/after/plugin/leader.vim<CR>

let g:which_key_map.f.e.c = ['e ~/.vim/plugin/commands.vim', 'edit-commands']
nnoremap <leader>fec :e ~/.vim/plugin/commands.vim<CR>

let g:which_key_map.f.e.o = ['e ~/.vim/after/plugin/options.vim', 'edit-vim-options']
nnoremap <leader>feo :e ~/.vim/after/plugin/options.vim<CR>

let g:which_key_map.f.e.p = ['e ~/.vim/plugin/plugins/', 'edit-plugin-config']
nnoremap <leader>fep :e ~/.vim/plugin/plugins/<CR>

" }}}
" [b] Buffer {{{

let g:which_key_map.b.n = [ 'bnext', 'next' ]
nnoremap <leader>bn :bnext<CR>

let g:which_key_map.b.N = [ 'bnext!', 'next!' ]
nnoremap <leader>bN :bnext!<CR>

let g:which_key_map.b.d = [ 'bdelete', 'close' ]
nnoremap <leader>bd :bdelete<CR>

let g:which_key_map.b.D = [ 'bdelete!', 'force-close' ]
nnoremap <leader>bD :bdelete!<CR>

let g:which_key_map.b.x = [ 'bdelete', 'close' ]
nnoremap <leader>bx :bdelete<CR>

let g:which_key_map.b.X = [ 'bdelete!', 'force-close' ]
nnoremap <leader>bX :bdelete!<CR>

let g:which_key_map.b['!'] = [ 'Bonly', 'close-others' ]
nnoremap <leader>b! :Bonly<CR>

let g:which_key_map.b.p = [ 'bprev', 'previous' ]
nnoremap <leader>bp :bprev<CR>

let g:which_key_map.b.t = [ 'b term://', 'open-previous-terminal' ]
nnoremap <leader>bt :b term://<CR>a

if exists(':Buffers')
  let g:which_key_map.b.b = [ 'Buffers', 'list-buffers' ]
  nnoremap <leader>bb :Buffers<CR>

  let g:which_key_map.b.h = [ 'History', 'show-history' ]
  nnoremap <leader>bh :History<CR>
endif

" }}}
" [p] Project {{{

if exists(':NERDTree')
  let g:which_key_map.p.t = [ 'Gcd | NERDTree', 'tree']
  nnoremap <leader>pt :Gcd<CR>:NERDTree<CR>

  " btw, use `-` instead
  let g:which_key_map.p.T = [ 'Gcd | NERDTreeFind', 'tree-find']
  nnoremap <leader>pT :Gcd<CR>:NERDTreeFind<CR>
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

  let g:which_key_map.p.f = [ 'GFiles', 'find-file' ]
  nnoremap <leader>pf :GFiles<cr>

  let g:which_key_map.p.F = [ 'GFiles?', 'find-file-from-status' ]
  nnoremap <leader>pF :GFiles?<CR>
endif

" nnoremap <Leader>pr :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>

" }}}
" ['] Terminal {{{
"
if exists(':terminal')
  let g:which_key_map["'"] = [ 'split | terminal', 'open-terminal-split' ]
  nnoremap <Leader>' :TerminalPromptSplit<CR>

  let g:which_key_map.t.s = [ 'split | terminal', 'open-terminal-split' ]
  nnoremap <Leader>ts :TerminalPromptSplit<CR>

  let g:which_key_map.t.n = [ 'split | terminal', 'open-terminal-split' ]
  nnoremap <Leader>tn :TerminalPromptSplit<CR>

  let g:which_key_map.t.v = [ 'vsplit | terminal', 'open-terminal-vsplit' ]
  nnoremap <Leader>tv <C-w>v<C-w>l:TerminalPrompt<CR>

  let g:which_key_map.t.t = [ 'tabnew | terminal', 'open-terminal-tab' ]
  nnoremap <Leader>tt :tabnew<CR>:TerminalPrompt<CR>

  " let g:which_key_map.t['.'] = [ 'terminal', 'open-terminal-here' ]
  " nnoremap <Leader>t. :TerminalPrompt<CR>
endif

" }}}
" [g] Git {{{

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
  nnoremap <leader>gc :Gcommit -v<CR>

  let g:which_key_map.g.A = [ 'Gcommit --amend', 'commit-amend' ]
  nnoremap <leader>gA :Gcommit --amend -v<CR>
endif

" }}}
" [T] Theme {{{

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

" }}}
" [h] Help {{{

let g:which_key_map.h.k = [ 'Usage', 'open-keybindings-cheatsheet']
nnoremap <silent> <leader>hk :Usage<CR>

" }}}
" [f] Files {{{

if exists(':Files')
  let g:which_key_map.f.f = ['Files', 'find-file']
  nnoremap <leader>ff :Files<CR>
endif

let g:which_key_map.f.y = ['ShowFilePath', 'show-file-path']
nnoremap <leader>fy :ShowFilePath<CR>

let g:which_key_map.f.s = ['w', 'save']
nnoremap <leader>fs :w<CR>

let g:which_key_map.f.S = ['w suda://%', 'save-using-sudo']
nnoremap <leader>fS :w suda://%<CR>

" }}}
" [.] EasyMotion {{{

if globpath(&rtp, "plugin/EasyMotion.vim") != ""
  let g:which_key_map['.'].p = ['<Plug>(easymotion-bd-w)', 'find-word']
  nmap <leader>.p <Plug>(easymotion-bd-w)
  let g:which_key_map['.'].w = ['<Plug>(easymotion-bd-w)', 'find-word']
  nmap <leader>.w <Plug>(easymotion-bd-w)
  let g:which_key_map['.'].e = ['<Plug>(easymotion-bd-e)', 'find-word-end']
  nmap <leader>.e <Plug>(easymotion-bd-e)
  let g:which_key_map['.'].f = ['<Plug>(easymotion-bd-f)', 'find-char']
  nmap <leader>.f <Plug>(easymotion-bd-f)
  " let g:which_key_map['.'].j = ['<Plug>(easymotion-j)', 'line:down']
  " nmap <leader>.j <Plug>(easymotion-j)
  " let g:which_key_map['.'].k = ['<Plug>(easymotion-k)', 'line:up']
  " nmap <leader>.k <Plug>(easymotion-k)
  " let g:which_key_map['.'].w = ['<Plug>(easymotion-w)', 'word:next']
  " nmap <leader>.w <Plug>(easymotion-w)
  " let g:which_key_map['.'].W = ['<Plug>(easymotion-W)', 'word:prev']
  " nmap <leader>.W <Plug>(easymotion-W)
  " let g:which_key_map['.'].b = ['<Plug>(easymotion-b)', 'b']
  " nmap <leader>.b <Plug>(easymotion-b)
  " let g:which_key_map['.'].B = ['<Plug>(easymotion-B)', 'B']
  " nmap <leader>.B <Plug>(easymotion-b)
  " let g:which_key_map['.'].e = ['<Plug>(easymotion-e)', 'end-of-word']
  " nmap <leader>.e <Plug>(easymotion-e)
  " let g:which_key_map['.'].E = ['<Plug>(easymotion-E)', 'end-of-word:skip-symbols']
  " nmap <leader>.E <Plug>(easymotion-E)
  " let g:which_key_map['.'].f = ['<Plug>(easymotion-f)', 'character:next']
  " nmap <leader>.f <Plug>(easymotion-f)
  " let g:which_key_map['.'].F = ['<Plug>(easymotion-F)', 'character:prev']
  " nmap <leader>.F <Plug>(easymotion-F)
  " let g:which_key_map['.'].n = ['<Plug>(easymotion-n)', 'search-match:next']
  " nmap <leader>.n <Plug>(easymotion-n)
  " let g:which_key_map['.'].N = ['<Plug>(easymotion-N)', 'search-match:prev']
  " nmap <leader>.N <Plug>(easymotion-N)
  " let g:which_key_map['.'].s = ['<Plug>(easymotion-s)', 'search']
  " nmap <leader>.s <Plug>(easymotion-s)
  " let g:which_key_map['.'].g = { 'name': 'g' }
  " let g:which_key_map['.'].g.e = ['<Plug>(easymotion-ge)', 'ge']
  " nmap <leader>.ge <Plug>(easymotion-ge)
  " let g:which_key_map['.'].g.E = ['<Plug>(easymotion-gE)', 'gE']
  " nmap <leader>.gE <Plug>(easymotion-gE)
  vmap <leader>. <Plug>(easymotion-prefix)
endif

" }}}
" [mj] JavaScript {{{

if exists(':ImportJSWord')
  let g:which_key_map.m.j.w = ['ImportJSWord', 'import-js:import-word']
  nnoremap <leader>mjw :ImportJSWord<CR>

  let g:which_key_map.m.j.f = ['ImportJSFix', 'import-js:fix-this-file']
  nnoremap <leader>mjf :ImportJSFix<CR>

  let g:which_key_map.m.j.g = ['ImportJSGoto', 'import-js:goto-module-on-cursor']
  nnoremap <leader>mjg :ImportJSGoto<CR>
endif

" }}}
" [mm] Markdown {{{

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

" }}}
" [/*] Search {{{

if exists(':Ag')
  let g:which_key_map['/'] = [ 'Ag', 'grep' ]
  nnoremap <leader>/ :Ag<CR>

  nnoremap <leader>* :Ag <C-r><C-w><CR>
  vnoremap <leader>* y:Ag <C-r>"<C-b><CR>
  nnoremap <leader>& :Ag! <C-r><C-w><CR>
  vnoremap <leader>& y:Ag! <C-r>"<C-b><CR>
endif

" }}}
" Done {{{

if exists(':WhichKey')
  call which_key#register('=', 'g:toggle_key_map')
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

nnoremap <leader><Tab> :GFiles?<CR>
nnoremap <leader>,<Tab> :FZF<CR>
" }}}

" {{{
command! EightiesToggle call s:EightiesToggle()
function! s:EightiesToggle()
  if g:eighties_enabled == 1
    EightiesDisable
    echomsg "x Eighties disabled; panes will no longer auto-resize."
  else
    EightiesEnable
    EightiesResize
    echomsg "✓ Eighties enabled! panes will auto-resize."
  endif
endfunction

command! ShowFilePath call s:ShowFilePath()
function! s:ShowFilePath()
  echomsg expand("%:t") . " (" . expand("%:p") . ")"
endfunction
" }}}
"
let g:which_key_map.w.t = ['tabnew', 'new-tab']
nnoremap <leader>wt :tabnew<CR>

let g:which_key_map.w['8']= ['EightiesToggle', 'eighties:toggle']
nnoremap <leader>w8 :EightiesToggle<CR>

if exists(':CocList')
  " nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
  nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>
  nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
  nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
  nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>
  nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
  nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
  nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
  nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>
  nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
  "nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>

  " list commands available in tsserver (and others)
  nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

  " navigate?
  nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
  nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
  " nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

  " restart when tsserver gets wonky
  nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

  " view all errors
  nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

  " enable or disable extensions
  nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>

  " rename the current word in the cursor
  nmap <leader>cr  <Plug>(coc-rename)
  nmap <leader>cf  <Plug>(coc-format-selected)
  vmap <leader>cf  <Plug>(coc-format-selected)

  vmap <leader>ca  <Plug>(coc-codeaction-selected)
  nmap <leader>ca  <Plug>(coc-codeaction-selected)
endif
