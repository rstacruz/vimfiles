" vim:fdm=marker:foldmarker={{{,}}}

" Basic custo {{{
" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line
set ttimeoutlen=20 " for escape
set timeoutlen=400 " for tab combos
set laststatus=1 " no statusbar if there's only one window
let &fcs='eob: ' " hide tildes (https://github.com/neovim/neovim/issues/2067#issuecomment-398283872)
" }}}

" Terminal customisations {{{
if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber nocursorline
  au TermOpen * startinsert
endif
" }}}

" Filetype customisations {{{
augroup customisations
  au FileType gitcommit,pullrequest,gitrebase startinsert
  au FileType gitcommit,pullrequest,gitrebase setlocal nonumber norelativenumber nowrap
  if $GIT_EXEC_PATH != ''
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:wq<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :wq<cr>
  else
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:w<cr>:bwipeout!<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :w<cr>:bwipeout!<cr>
  end
  au FileType gitcommit setlocal statusline=──\ Git\ commit\ message\ ──
  au FileType pullrequest setlocal statusline=──\ Git\ pull\ request\ ──
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber isfname+=32 conceallevel=2
  au FileType yaml setlocal foldmethod=indent
  " isfname: Allow spaces in filenames to 'gf' inside taskpaper files
  " Allow spaces in filenames to 'gf' inside taskpaper files
  au FileType taskpaper setlocal isfname+=32,[,],' ts=2 nowrap foldmethod=indent
  au! BufRead,BufNewFile *.ttxt setfiletype taskpaper
  " Allow auto-completion of beancount accounts (eg, Assets:Bank-Stuff)
  au! BufRead,BufNewFile *.beancount setlocal iskeyword+=-,58

  " treesitter-based folding where supported
  au FileType typescript,typescriptreact,javascript,javascriptreact,css,json,markdown setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
augroup END

" No status when editing Git commit messages
if $GIT_EXEC_PATH != ''
  set laststatus=0
endif

" No line numbers on git status
au FileType fugitive setlocal nonumber norelativenumber

" Close terminal
if has('nvim')
  au TermClose *tig* silent bwipe!
endif

set linebreak  " lbr: break on words
" }}}

" Markdown tools {{{
function! MkdnRemoveAnnotations()
  silent! %s/^###\n\n//
  silent! %s/^<!-- {.*\n\n//
endfunction

" In the rstacruz/til blog
function! MkdnConvertFigures()
  silent! %s#<figure class='cover'>\n\(.*\)\n</figure>#<Figure cover>\r\1\r</Figure>#g
  silent! %s#<figure class='table'>\n\(.*\)\n</figure>#<Figure table>\r\1\r</Figure>#g
endfunction

" Like 'gf' but creates a file if it's not there
function! OpenOrCreateFile(...)
  let fname=expand('%:h') . '/' . expand('<cfile>')
  let cmd=(a:0 == '' ? 'e' : 'split')
  silent! exec cmd . ' ' . fname
endfunction
" }}}

" Gui: neovim-qt {{{
if exists('g:GuiLoaded')
  " set guifont=JuliaMono:h13
  " set guifont=JetBrains\ Mono:h14:w60
  GuiFont! Iosevka:h13.5:w57
  GuiTabline 0
  GuiLinespace -3
  colorscheme dracula
  " also: paper, iceberg, challenger_deep, github
endif
" }}}

" Gui: Neovide {{{
if exists('g:neovide')
  let g:neovide_cursor_animation_length=0.04
  set guifont=Iosevka:h20
  colorscheme challenger_deep
  set background=dark
end
" }}}

" Gui: vimr {{{
" https://github.com/qvacua/vimr/wiki
if has('gui_vimr')
  colorscheme github
  set background=light
endif
" }}}

" disable by default
if exists(':GitGutterDisable')
  GitGutterDisable
endif

" iabbrev: Typo corrections {{{
augroup abbreviations_typos
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> conts const
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classname className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classNmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classnmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> improt import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> porps props

  au FileType javascript,typescript,typescriptreact iabbrev <buffer> iM  import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eF  export function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> cN  className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> fN  function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> aF  async function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> sJ  style jsx
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> cL  console.log
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> uI  require('util').inspect
augroup END
" }}}

" iabbrev: symbols ⌘ ⌦ {{{
augroup abbreviations_symbols
  au FileType text,markdown,c iabbrev <buffer> sfT ⇧
  au FileType text,markdown,c iabbrev <buffer> taB ↹
  au FileType text,markdown,c iabbrev <buffer> ftB ⇥
  au FileType text,markdown,c iabbrev <buffer> btB ⇤
  au FileType text,markdown,c iabbrev <buffer> ctL ⌃
  au FileType text,markdown,c iabbrev <buffer> opT ⌥
  au FileType text,markdown,c iabbrev <buffer> cmD ⌘
  au FileType text,markdown,c iabbrev <buffer> spC ␣
  au FileType text,markdown,c iabbrev <buffer> bkS ⌫
  au FileType text,markdown,c iabbrev <buffer> enT ↵
  au FileType text,markdown,c iabbrev <buffer> esC ⎋
  au FileType text,markdown,c iabbrev <buffer> deL ⌦
  " http://xahlee.info/comp/unicode_computing_symbols.html
  " https://hub.espanso.org/packages/mac-symbols/

  "	♔ ♕ ♖ ♗ ♘ ♙ ◇ · ♚ ♛ ♜ ♝ ♞ ♟ ◆
  au FileType text,markdown,taskpaper iabbrev <buffer> bK ♚ 
  au FileType text,markdown,taskpaper iabbrev <buffer> bQ ♛
  au FileType text,markdown,taskpaper iabbrev <buffer> bR ♜
  au FileType text,markdown,taskpaper iabbrev <buffer> bN ♞
  au FileType text,markdown,taskpaper iabbrev <buffer> bB ♝
  au FileType text,markdown,taskpaper iabbrev <buffer> bP ♟
  au FileType text,markdown,taskpaper iabbrev <buffer> wK ♔
  au FileType text,markdown,taskpaper iabbrev <buffer> wQ ♕
  au FileType text,markdown,taskpaper iabbrev <buffer> wR ♖
  au FileType text,markdown,taskpaper iabbrev <buffer> wN ♘
  au FileType text,markdown,taskpaper iabbrev <buffer> wB ♗
  au FileType text,markdown,taskpaper iabbrev <buffer> wP ♙
augroup END
" }}}

" inoremap: Box drawing chars {{{
inoremap ^%( ·
inoremap ^%: ●
inoremap ^%) ○
inoremap ^$< ┌
inoremap ^$= ┬
inoremap ^$> ┐
inoremap ^$( ├
inoremap ^$: ┼
inoremap ^$) ┤
inoremap ^$* └
inoremap ^$- ┴
inoremap ^$+ ┘
inoremap ^$} ─
inoremap ^${ │
inoremap ^%< ╭
inoremap ^%> ╮
inoremap ^%* ╰
inoremap ^%+ ╯
" }}}

" Theme overrides {{{
function s:add_theme_overrides()
  " if &background ==# 'dark' | ... | endif
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi EndOfBuffer ctermbg=none
  hi! link FloatermBorder VertSplit
endfunction

autocmd ColorScheme * call s:add_theme_overrides()
" }}}

" :Z {{{
autocmd User ZChangedDirBang tabonly
autocmd User ZChangedDirBang StartifyReset
" }}}

