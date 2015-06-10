augroup javascript_shortcuts
  au!
  au FileType javascript call <SID>set_js_shortcuts()
augroup END

function! s:set_js_shortcuts()
  inoremap <buffer> @. this.

  imap <buffer> fn( function (
  imap <buffer> fn() function ()
  imap <buffer> fn(){ function () {
  imap <buffer> fn()[ function () {
  imap <buffer> fn()<Space>{ function () {
  imap <buffer> fn()<Space>[ function () {

  imap <buffer> fn<Space>( function (
  imap <buffer> fn<Space>() function ()
  imap <buffer> fn<Space>(){ function () {
  imap <buffer> fn<Space>()[ function () {
  imap <buffer> fn<Space>()<Space>{ function () {
  imap <buffer> fn<Space>()<Space>[ function () {

  imap <buffer> fn9 function (
  imap <buffer> fn90 function ()
  imap <buffer> fn90{ function () {
  imap <buffer> fn90[ function () {
  imap <buffer> fn90<Space>{ function () {
  imap <buffer> fn90<Space>[ function () {
  imap <buffer> function90[ function () {
  imap <buffer> function90<Space>[ function () {

  imap <buffer> fn<Space>9 function (
  imap <buffer> fn<Space>90 function ()
  imap <buffer> fn<Space>90{ function () {
  imap <buffer> fn<Space>90[ function () {
  imap <buffer> fn<Space>90<Space>{ function () {
  imap <buffer> fn<Space>90<Space>[ function () {
endfunction
