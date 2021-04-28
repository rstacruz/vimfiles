" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" - `:Ag hello` to searrch
" - `alt-a alt-q` to move to quickfix
" - f3/f4 to navigate quickfix
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'alt-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" See: `:h fzf-starting-fzf-in-neovim-floating-window`

let g:fzf_preview_window = ['right:50%', 'ctrl-p']
let $BAT_THEME = 'ansi'
let $BAT_STYLE = 'plain' " no line numbers

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border=top --margin=0 --padding=1,4'
  " let $FZF_DEFAULT_OPTS .= ' --border --margin=3,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 1)
    let height = float2nr(&lines * 0.7)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height),
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Keyword'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'VertSplit'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'preview-fg': ['fg', 'Normal'],
  \ 'header':  ['fg', 'Comment'] }

