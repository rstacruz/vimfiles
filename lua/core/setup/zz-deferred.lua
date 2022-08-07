local function setup_check_highlight()
  -- Expermental: show syntax group under cursor
  vim.cmd([[
    nnoremap <leader>,h :CheckHighlightUnderCursor<cr>
    com! CheckHighlightUnderCursor echo {l,c,n ->
            \ '' . l . ':' . c . ': '
            \ . 'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
            \ .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
            \ .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
            \ }(line("."), col("."), "name")
  ]])
end

local function setup()
  setup_check_highlight()
end

return { setup = setup }
