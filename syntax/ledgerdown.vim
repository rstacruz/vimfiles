" Vim syntax file
" Language:	Ledgerdown (http://github.com/rstacruz/ledgerdown)
" Maintainer:	Rico
" URL:		https://github.com/davidoc/taskpaper.vim
" Last Change:  2012-03-07

if exists("b:current_syntax")
  finish
endif

syn match ldTransfer /.\+:/ contained
syn match ldAmount /-\?\d*\.*\d*\*\?/ contained
syn match ldPreAmount /^-\?\d*\.*\d*/ contained contains=ldAmount
syn region ldTransaction start="^-\?\d*\.*\d*" end="$" contains=ldPreAmount,ldTransfer
syn match ldNote /^\s\+;.*/
syn match ldInline /^\s\+.*/ contains=ldAmount
syn match ldProject /^.\+:$/

" Identifier, NonText, Comment
hi def link ldProject Statement
hi def link ldAmount Number
hi def link ldNote Comment
hi def link ldTransfer Operator
hi def link ldInline Comment
hi def link ldTransaction String

let b:current_syntax = "ledgerdown"
