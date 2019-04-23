if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != '' | finish | endif

"
" Toggles fix_on_save for the current buffer
"

command! ALEToggleFixOnSave call <SID>ale_toggle_fix_on_save()

function! s:ale_toggle_fix_on_save()
  if exists('b:ale_fix_on_save') && b:ale_fix_on_save == '0'
    let b:ale_fix_on_save=1
  else
    let b:ale_fix_on_save=0
  endif
  echo "b:ale_fix_on_save = " . b:ale_fix_on_save
endfunction

"
" Show syntax stack on cursor
"

command! ShowSyntaxStack :call <SID>show_syntax_stack()

function! s:show_syntax_stack()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

"
" Helps convert CSSnext/PostCSS syntax into Sass
"

command! CssToScss call s:CssToScss()
function! s:CssToScss()
  set gdefault

  " `--xyz: {` => `@mixin xyz() {`
  silent! %s/  --\(.*\): {$/@mixin \1 {

  " `--xyz: abc` => `$xyz: abc;`
  silent! %s/  --\(.*\): \(.*\)$/  \$\1: \2

  " `var(--xxx)` => `$xxx`
  silent! %s/var(--\([^)]*\))/\$\1

  " `@media (--xxx)` => `@media #{$xxx}`
  silent! %s/@media (--\([^)]*\))/@media #{\$\1}

  " `@custom-media`
  silent! %s/@custom-media --\([^)]*\) (width > \(.*\));/\$\1: "min-width: #{\2 + .1px}";
  silent! %s/@custom-media --\([^)]*\) (width < \(.*\));/\$\1: "max-width: #{\2 - .1px}";
  silent! %s/@custom-media --\([^)]*\) (\(.*\));/\$\1: "\2";

  " `@apply --xxx;` => `@include xxx;`
  silent! %s/@apply --/@include /

  " color mods
  silent! %s/color-mod(\([^ ]\+\) alpha(-\(\d\+\)%))/fade-out(\1, .\2)
  silent! %s/color-mod(\([^ ]\+\) alpha(+\(\d\+\)%))/fade-in(\1, .\2)
  silent! %s/color-mod(\([^ ]\+\) alpha(\(\d\+\)%))/change-color(\1, $alpha: .\2)
  silent! %s/color-mod(\([^ ]\+\) lightness(-\(\d\+\)%))/darken(\1, .\2)
  silent! %s/color-mod(\([^ ]\+\) lightness(+\(\d\+\)%))/lighten(\1, .\2)
  silent! %s/color-mod(\([^ ]\+\) lightenss(\(\d\+\)%))/change-color(\1, $lightness: .\2)

  " highlight things that should be edited
  let @/=":root\\|color-mod\\|--\\|@custom-media"
endfunction

"
" Converts an indented Markdown code block into code fences.
"

command! MarkdownCodify call s:MarkdownCodify()
function! s:MarkdownCodify()
  !$HOME/.vim/scripts/markdown-codify
endfunction

command! Gcd exec 'cd' fnameescape(fnamemodify(finddir('.git', escape(expand('%:p:h'), ' ') . ';'), ':h'))

"
" Prompt the user to run something in the terminal.
" Use this as an alternative to `:term`
"

function! s:TerminalPrompt()
  call inputsave()
  let command = input('Enter command: ')
  call inputrestore()
  new
  exec "term " . command
endfunction

command! TerminalPrompt call s:TerminalPrompt()

function! s:TerminalPromptSplit()
  call inputsave()
  let command = input('Enter command: ')
  call inputrestore()
  new
  exec "term " . command
endfunction

command! TerminalPromptSplit call s:TerminalPromptSplit()
