" Vim syntax file
" Language: Ledgerdown (http://github.com/rstacruz/ledgerdown)
" Maintainer: Rico Sta. Cruz
" URL: http://github.com/rstacruz/ledgerdown

if exists("b:current_syntax")
  finish
endif

" An account-to-account transfer. ("Cash to Rent:")
syn match ldTransfer /.\+:/ contained

" Just an amount.
syn match ldAmount /-\?[\d,]*\.*\d*\*\?/ contained

" Prefix amount; can include a currency.
syn match ldPreAmount /^[^:;=]*-\?[\d,]*\.*\d*[^:;=]*/ contained contains=ldAmount

" Transaction. ("500: Cash to Rent: September")
syn region ldTransaction start="^[^:;]*-\?\d*\.*\d*" end="$" contains=ldPreAmount,ldTransfer
syn match ldNote /^;.*/
syn match ldInline /^\s\+.*/ contains=ldAmount
syn match ldDateHeading /^.\+:$/

" Identifier, NonText, Comment
hi def link ldDateHeading Statement
hi def link ldPreAmount Number
hi def link ldAmount Number
hi def link ldNote Comment
hi def link ldTransfer Operator
hi def link ldInline Comment
hi def link ldTransaction String

let b:current_syntax = "ledgerdown"
