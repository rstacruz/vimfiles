" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line
set ttimeoutlen=20 " for escape
set timeoutlen=400 " for tab combos
set laststatus=1 " no statusbar if there's only one window

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber nocursorline
  au TermOpen * startinsert
endif

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
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber isfname+=32
  au FileType yaml setlocal foldmethod=indent
  " isfname: Allow spaces in filenames to 'gf' inside taskpaper files
  " Allow spaces in filenames to 'gf' inside taskpaper files
  au FileType taskpaper setlocal isfname+=32,[,],' ts=2 nowrap foldmethod=indent
  au! BufRead,BufNewFile *.ttxt setfiletype taskpaper
  " Allow auto-completion of beancount accounts (eg, Assets:Bank-Stuff)
  au! BufRead,BufNewFile *.beancount setlocal iskeyword+=-,58
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

" Markdown tools
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

if exists('g:GuiLoaded')
  set guifont=JuliaMono:h13
  GuiTabline 0
  colorscheme tokyonight
  LightlineTheme tokyonight
endif

" https://github.com/qvacua/vimr/wiki
if has('gui_vimr')
  colorscheme paper
  LightlineTheme paper
  set background=light
endif

function! LightPaper()
  colorscheme paper
  LightlineTheme paper
  set background=light
endfunction

command! LightPaper call LightPaper()

function! DarkTokyo()
  colorscheme tokyonight
  LightlineTheme tokyonight
endfunction

command! DarkTokyo call DarkTokyo()

" Abbreviations
iabbrev "::md" —
" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line
set ttimeoutlen=20 " for escape
set timeoutlen=400 " for tab combos

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber nocursorline
  au TermOpen * startinsert
endif

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
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber
  au FileType yaml setlocal foldmethod=indent
  " Allow spaces in filenames to 'gf' inside taskpaper files
  au FileType taskpaper setlocal isfname+=32,[,],' ts=2 nowrap
  au! BufRead,BufNewFile *.ttxt setfiletype taskpaper
  " Allow auto-completion of beancount accounts (eg, Assets:Bank-Stuff)
  au! BufRead,BufNewFile *.beancount setlocal iskeyword+=-,58
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

" Markdown tools
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

if exists('g:GuiLoaded')
  set guifont=JuliaMono:h13
  GuiTabline 0
  colorscheme tokyonight
  LightlineTheme tokyonight
endif

" Typo corrections
augroup abbreviations
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> conts const
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classname className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classNmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classnmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> improt import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> porps props

  au FileType javascript,typescript,typescriptreact iabbrev <buffer> Xf export function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> Im import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> Co const
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> Re return
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> iM  import
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> cN  className
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> fN  function
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> cL  class
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> cO  const
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> eL  else
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> eI  else if
  " au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> cLo console.log

  au FileType ruby iabbrev <buffer> aA attr_accessor
  au FileType ruby iabbrev <buffer> aR attr_reader
  au FileType ruby iabbrev <buffer> aW attr_writer
  au FileType ruby iabbrev <buffer> cL class
  au FileType ruby iabbrev <buffer> dS describe
  au FileType ruby iabbrev <buffer> eX extend
  au FileType ruby iabbrev <buffer> eXs extends
  au FileType ruby iabbrev <buffer> fS # frozen_string_literal: trun
  au FileType ruby iabbrev <buffer> iN include
  au FileType ruby iabbrev <buffer> mO module
  au FileType ruby iabbrev <buffer> rE return

  au FileType css,scss iabbrev <buffer> bA  border-radius:
  au FileType css,scss iabbrev <buffer> dB  display: block;
  au FileType css,scss iabbrev <buffer> dF  display: flex;
  au FileType css,scss iabbrev <buffer> dI  display: inline;
  au FileType css,scss iabbrev <buffer> diB display: inline-block;
  au FileType css,scss iabbrev <buffer> fB  font-weight: bold;
  au FileType css,scss iabbrev <buffer> fI  font-style: italic;
  au FileType css,scss iabbrev <buffer> hE  height:
  au FileType css,scss iabbrev <buffer> lH  line-height:
  au FileType css,scss iabbrev <buffer> mA  margin:
  au FileType css,scss iabbrev <buffer> mB  margin-bottom:
  au FileType css,scss iabbrev <buffer> mL  margin-left:
  au FileType css,scss iabbrev <buffer> mR  margin-right:
  au FileType css,scss iabbrev <buffer> mT  margin-top:
  au FileType css,scss iabbrev <buffer> oP  opacity:
  au FileType css,scss iabbrev <buffer> pA  padding:
  au FileType css,scss iabbrev <buffer> pB  padding-bottom:
  au FileType css,scss iabbrev <buffer> pL  padding-left:
  au FileType css,scss iabbrev <buffer> poA position: absolute;
  au FileType css,scss iabbrev <buffer> poF position: fixed;
  au FileType css,scss iabbrev <buffer> poR position: relative;
  au FileType css,scss iabbrev <buffer> pR  padding-right:
  au FileType css,scss iabbrev <buffer> pT  padding-top:
  au FileType css,scss iabbrev <buffer> wI  width:

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

" Neovide
if exists('g:neovide')
  let g:neovide_cursor_animation_length=0.04
  set guifont=Iosevka:h20
end

" Box drawing characters
inoremap ^%( ·
inoremap ^%: ●
inoremap ^%) ○
" j l u y .    ┌ ┬ ┐
" m n e i o  │ ├ ┼ ┤ ─
" k h , . .    └ ┴ ┘
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
