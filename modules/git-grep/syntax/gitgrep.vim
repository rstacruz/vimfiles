if exists('b:current_syntax') | finish | endif

syntax match GitgrepFile /^[^ ].*/
syntax match GitGrepLineNr /^ \+\d\+:/
syntax match GitGrepError /^\(!\|fatal:\) .*/

highlight default link GitgrepFile Title
highlight default link GitgrepLineNr LineNr
highlight default link GitgrepError Error

let b:current_syntax = 'gitgrep'
