" augroup numberswitch
"   au!
"   au FileType javascript,ruby,python
"     \ call <SID>set_number_switch()
" augroup END

" function! s:set_number_switch()
"   " makes symbols easier to type, no shift key needed
"   imap <buffer> 1 !
"   imap <buffer> 2 @
"   imap <buffer> 3 #
"   imap <buffer> 4 $
"   imap <buffer> 5 %
"   imap <buffer> 6 ^
"   imap <buffer> 7 &
"   imap <buffer> 8 *
"   imap <buffer> 9 (
"   imap <buffer> 0 )

"   " hold alt to get the numbers
"   inoremap <buffer> ¡ 1
"   inoremap <buffer> ™ 2
"   inoremap <buffer> £ 3
"   inoremap <buffer> ¢ 4
"   inoremap <buffer> ∞ 5
"   inoremap <buffer> § 6
"   inoremap <buffer> ¶ 7
"   inoremap <buffer> • 8
"   inoremap <buffer> ª 9
"   inoremap <buffer> º 0

"   " no shift key for curly braces
"   inoremap <buffer> [[ {
"   inoremap <buffer> ]] }
" endfunction
