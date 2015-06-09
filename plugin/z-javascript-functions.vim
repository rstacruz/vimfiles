augroup javascript_shortcuts
  au!
  au FileType javascript call <SID>set_js_shortcuts()
  au FileType javascript set conceallevel=2
augroup END

function! s:set_js_shortcuts()
  inoremap <buffer> @. this.

  imap <buffer> fn( function (
  imap <buffer> fn() function ()
  imap <buffer> fn(){ function () {
  imap <buffer> fn()[ function () {
  imap <buffer> fn()<Space>{ function () {
  imap <buffer> fn()<Space>[ function () {
  imap <buffer> function()[ function () {
  imap <buffer> function()<Space>[ function () {

  imap <buffer> fn<Space>( function (
  imap <buffer> fn<Space>() function ()
  imap <buffer> fn<Space>(){ function () {
  imap <buffer> fn<Space>()[ function () {
  imap <buffer> fn<Space>()<Space>{ function () {
  imap <buffer> fn<Space>()<Space>[ function () {
  imap <buffer> function<Space>()[ function () {
  imap <buffer> function<Space>()<Space>[ function () {

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
  imap <buffer> function<Space>90[ function () {
  imap <buffer> function<Space>90<Space>[ function () {
endfunction
