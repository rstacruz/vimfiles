if executable('ag')
  " https://github.com/junegunn/fzf.vim/issues/121#issuecomment-209534405
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

" --exact means 'mobihe' will *not* match 'mobile_helper'. You need to type
" 'mobi he' instead.
let $FZF_DEFAULT_OPTS = '--border --reverse --preview-window=up:8'

" pacman -S highlight
if executable('highlight')
  let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --preview "highlight -O ansi --force {}"'
else
  let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --preview "head -n100 {}" --reverse'
endif

" Overrides
" See :help fzf-vim-advanced-customization
" Press ? to enable preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \  <bang>0 ? fzf#vim#with_preview('up:60%')
  \          : fzf#vim#with_preview('right:40%:hidden', '?'),
  \  <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \  <bang>0 ? fzf#vim#with_preview('up:60%')
  \          : fzf#vim#with_preview('right:40%', '?'),
  \  <bang>0)
