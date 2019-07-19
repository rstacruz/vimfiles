if executable('ag')
  " https://github.com/junegunn/fzf.vim/issues/121#issuecomment-209534405
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

let $FZF_DEFAULT_OPTS = '--border --reverse --preview-window=up:8'

" pacman -S highlight
if executable('highlight')
  let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --preview "highlight -O ansi --force {}"'
else
  let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --preview "head -n100 {}" --reverse'
endif
