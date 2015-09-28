augroup javascript_shortcuts
  au!
  au FileType javascript call <SID>set_js_shortcuts()
augroup END

function! s:set_js_shortcuts()
  inoremap <buffer> @. this.

  imap <buffer> fn<CR> function () {<CR>
  imap <buffer> =><CR> => {<CR>
  imap <buffer> -><CR> () => {<CR>

  imap <buffer> clog( console.log(
  imap <buffer> cerr( console.error(
  imap <buffer> cer( console.error(
  imap <buffer> gebid( document.getElementById(
  imap <buffer> rcc( React.createClass(
  imap <buffer> rcc<CR> React.createClass({<CR>
endfunction
