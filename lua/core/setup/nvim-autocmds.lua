local function setup()
  local augroup = require("core.utils").augroup

  augroup("MyCustomisations", function(autocmd)
    -- Cursorline on insert mode
    autocmd("InsertEnter", "*", "set cursorline")
    autocmd("InsertLeave", "*", "set nocursorline")

    -- No line numbers, insert mode, etc
    autocmd("TermOpen", "*", "setlocal nonumber norelativenumber nocursorline")
    autocmd("TermOpen", "*", "startinsert")
    autocmd("FileType", "markdown,spectre_panel,neo-tree", "setlocal nonumber")

    -- Git: close on ctrl-s
    autocmd("FileType", "gitcommit,NeogitCommitMessage", "startinsert")
    autocmd("FileType", "gitcommit,NeogitCommitMessage", [[inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
    autocmd("FileType", "gitcommit,NeogitCommitMessage", [[nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])

    -- Neogit: make `-` easier to hit, and cancel out the global - keymap
    autocmd("FileType", "NeogitPopup", [[nnoremap <buffer> , -]])
    autocmd("FileType", "NeogitPopup", [[nnoremap <buffer> - -]])

    -- Markdown stuff
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> :star: ⭐]])
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> -- —]])
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> -> →]])
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +co ``<left>]]) -- [co]de
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +cd ```<cr>```<home><up><end>]]) -- [c]o[d]e block

    autocmd("Colorscheme", "*", function()
      require("core.lib.theme").apply_overrides()
    end)
  end)
end

return { setup = setup }
